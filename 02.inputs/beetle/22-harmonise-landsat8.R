#!/usr/bin/env Rscript
## Put the Landsat 8 years onto the Landsat 5 scale, empirically.
##
## The problem. The Roy et al. (2016) coefficients are applied to reflectance in
## 17- and 20-, and they are still not enough: differenced against a 2005 Landsat 5
## baseline, the two Landsat 8 years classified 52.0 and 54.2 per cent of Darkwoods as
## attacked against 13.2 to 32.4 per cent for the Landsat 5 outbreak years. Half the
## training set, 483 of 1000 plots and 151 of the 250 high-severity plots, takes its
## worst year from 2013 or 2014, so this bias is inside the labels as well as the map.
##
## The fix. Relative radiometric normalisation against stable ground. Landsat 5 ends in
## 2011 and Landsat 8 begins in 2013, so there is no overlapping year and no
## pseudo-invariant scene pair. Instead, stable forest is identified from the Landsat 5
## era alone as cells that are forested in 2005 and whose deepest NDMI drop across
## 2006-2011 stays above -0.05, then each Landsat 8 index is rescaled by a gain and
## offset that match its median and median absolute deviation over those cells to the
## 2011 image's. Stable forest should not differ between 2011 and 2013 in these indices,
## so any difference over it is instrument, not ground.
##
## What this cannot do, stated so it is not over-read: it also removes any genuine
## landscape-wide change between 2011 and 2013 that happens to fall on those cells,
## including beetle attack in 2012, the year with no usable imagery. The correction is
## therefore conservative against detecting 2012-2013 attack.
##
## Originals are preserved as <index>_<year>_l8raw.tif and the corrected raster takes
## the original filename, so 19- and 21- read the corrected series without change.

suppressPackageStartupMessages(library(terra))
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
L8   <- c(2013, 2014, 2020); L5REF <- 2011
IDX  <- c("ndmi","ndvi","nbr","tcw")
rd <- function(nm, y, raw = FALSE)
  rast(file.path(IN, sprintf("%s_%d%s.tif", nm, y, if (raw) "_l8raw" else "")))

## stable forest, defined entirely within the Landsat 5 era
base <- rd("ndmi", 2005)
forest <- base > 0.20
dmin <- min(rast(lapply(2006:2011, function(y) rd("ndmi", y) - base)))
stable <- mask(forest & (dmin > -0.05), forest, maskvalues = c(0, NA))
stable[stable == 0] <- NA
ns <- global(stable, "sum", na.rm = TRUE)[[1]]
cat(sprintf("stable forest cells: %.0f (%.1f%% of grid)\n", ns, 100*ns/ncell(base)))

for (nm in IDX) {
  ref <- values(mask(rd(nm, L5REF), stable)); ref <- ref[!is.na(ref)]
  mr <- median(ref); ar <- mad(ref)
  cat(sprintf("\n%s  reference %d over stable forest: median %+.4f  MAD %.4f\n",
              toupper(nm), L5REF, mr, ar))
  for (y in L8) {
    raw <- file.path(IN, sprintf("%s_%d_l8raw.tif", nm, y))
    cur <- file.path(IN, sprintf("%s_%d.tif", nm, y))
    if (!file.exists(raw)) file.copy(cur, raw)
    r  <- rast(raw)
    v  <- values(mask(r, stable)); v <- v[!is.na(v)]
    my <- median(v); ay <- mad(v)
    g  <- ar / ay; o <- mr - g * my
    out <- r * g + o; names(out) <- sprintf("%s_%d", toupper(nm), y)
    writeRaster(out, cur, overwrite = TRUE, datatype = "FLT4S",
                gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
    vc <- values(mask(out, stable)); vc <- vc[!is.na(vc)]
    cat(sprintf("  %d raw median %+.4f MAD %.4f -> gain %.4f offset %+.4f -> median %+.4f MAD %.4f\n",
                y, my, ay, g, o, median(vc), mad(vc)))
  }
}
