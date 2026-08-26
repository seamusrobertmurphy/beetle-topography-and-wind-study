#!/usr/bin/env Rscript
## Red-stage classification from NDMI change, on the 444,105-cell analysis grid.
##
## What red stage is. A pine attacked in year y-1 holds red needles through year y,
## and red foliage loses the canopy water that NDMI measures. Red stage is therefore
## a one-year drop in NDMI, not a low NDMI: a permanently dry rock face is dry every
## year and never drops. Classifying the change rather than the level is what keeps
## standing site condition out, which is the confound that sank the single-date work
## (a 2003 pre-outbreak scene correlated -0.494 with plot mortality, 2026-08-20).
##
## The rule, stated before it is run so it can fail. For each consecutive pair of
## years, compute dNDMI = NDMI(y) - NDMI(y-1) over forested cells and call red stage
## where the drop is at or beyond two robust standard deviations below the median of
## a single reference year-pair, 2014 against 2013.
##
## Why one common reference rather than each year's own spread. Standardising a year
## by its own median and MAD guarantees a fixed tail: the first run of this script
## returned 5.3 to 8.4 per cent red stage in every year including 2014, three years
## after the outbreak ended, because a percentile of its own distribution is what it
## was asked for. 2014 against 2013 carries no outbreak, so its median and MAD are
## what a year of ordinary interannual noise looks like here, and every other year is
## measured against that. Outbreak years can then exceed it, or fail to.
##
## The aerial survey appears here only as a check on the finished map and never as a
## label: no cell's class depends on it. The survey is coarse, imprecise and
## polygon-generalised, which is the reason this project stopped using it as a
## response at all.

suppressPackageStartupMessages(library(terra))
ROOT <- "02.inputs/beetle-classification"
IN   <- file.path(ROOT, "ndmi-annual")
OUT  <- file.path(ROOT, "red-stage-ndmi"); dir.create(OUT, showWarnings = FALSE)
Z    <- -2

f <- sort(list.files(IN, "^ndmi_\\d{4}\\.tif$", full.names = TRUE))
yr <- as.integer(sub(".*ndmi_(\\d{4})\\.tif$", "\\1", f))
s  <- rast(f); names(s) <- paste0("y", yr)
cat(sprintf("annual NDMI layers: %s\n", paste(yr, collapse = ", ")))

## forest mask from the 2003 pre-outbreak baseline: NDMI above 0.20 is closed canopy
## here, and it is fixed at the pre-outbreak year so no later disturbance can move it
forest <- s[[which(yr == 2003)]] > 0.20
cat(sprintf("forested cells in 2003: %d of %d (%.1f%%)\n",
            global(forest, "sum", na.rm = TRUE)[[1]], ncell(s), 
            100 * global(forest, "sum", na.rm = TRUE)[[1]] / ncell(s)))

pairs <- which(diff(yr) == 1)
dnd <- function(i) mask(s[[i + 1]] - s[[i]], forest, maskvalues = c(0, NA))

## the reference pair: 2014 against 2013, outbreak over, so this is the noise floor
iref <- which(yr == 2013)
vref <- values(dnd(iref)); vref <- vref[!is.na(vref)]
md <- median(vref); ma <- mad(vref)
cat(sprintf("reference pair 2014 vs 2013: median %+.4f, MAD %.4f, threshold dNDMI %+.4f\n",
            md, ma, md + Z * ma))

res <- list()
for (i in pairs) {
  y0 <- yr[i]; y1 <- yr[i + 1]
  d  <- dnd(i)
  v  <- values(d); v <- v[!is.na(v)]
  z  <- (d - md) / ma
  red <- z <= Z
  n <- global(red, "sum", na.rm = TRUE)[[1]]
  nf <- length(v)
  writeRaster(z, file.path(OUT, sprintf("zdndmi_%d.tif", y1)), overwrite = TRUE,
              datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  ## classes written as 1 = red stage, 2 = not, so zero never means a class (2026-08-19)
  writeRaster(classify(red, cbind(c(0, 1), c(2, 1))), 
              file.path(OUT, sprintf("redstage_%d.tif", y1)), overwrite = TRUE,
              datatype = "INT1U", gdal = c("COMPRESS=DEFLATE"))
  res[[length(res) + 1]] <- data.frame(
    year = y1, baseline = y0, forested = nf, median_dndmi = median(v), ref_mad = ma,
    red_cells = n, red_pc = 100 * n / nf, red_ha = n * prod(res(s)) / 1e4)
  cat(sprintf("%d vs %d  median dNDMI %+.4f  red stage %6d cells  %5.2f%%  %8.1f ha\n",
              y1, y0, median(v), n, 100 * n / nf, n * prod(res(s)) / 1e4))
}
tab <- do.call(rbind, res)
write.csv(tab, file.path(OUT, "red_stage_area_by_year.csv"), row.names = FALSE)
cat(sprintf("\nwrote %d red-stage years to %s\n", nrow(tab), OUT))
