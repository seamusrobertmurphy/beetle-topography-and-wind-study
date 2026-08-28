#!/usr/bin/env Rscript
## A 16-day Landsat cube over the study perimeter, built in Google Earth Engine.
##
## Why Earth Engine and why 16 days. The annual classification collapses a whole growing
## season into one map, which leaves eight observations in time and makes any wind test a
## comparison between summers. Landsat's repeat is 16 days, so the finest cadence the
## sensor supports is roughly ten steps per growing season, not one. Building that over
## 62,000 cells for eight years is 80 composites, which is what Earth Engine is for: the
## compositing happens on their side and only the finished epoch grids are downloaded.
##
## 06-build-cube.R already built this cadence, but sampled it at 28 plot points rather than
## over a grid. This script is that cube as rasters.
##
## Grid: EPSG:3153 at 30 m, the parent study's grid, over the perimeter from
## 33-study-perimeter.R. Epochs: fixed 16-day windows on a common calendar from 1 May, so
## every year is sampled on the same dates rather than on whatever the cloud allowed.
##
## Three traps, all recorded in project memory and all guarded here:
##   1. A GeoTIFF written from an Earth Engine integer image takes zero as nodata, so a
##      value that can legitimately be zero is silently turned into NA. NDMI is therefore
##      exported scaled by 10,000 and offset by 20,000, well away from zero, and undone
##      locally.
##   2. getDownloadURL with crsTransform and no dimensions makes Earth Engine compute over
##      the whole CRS extent and fail against the 50 MB cap. Use scale plus region.
##   3. Landsat 8 must be put on the ETM+ scale with the Roy et al. (2016) band-pass
##      coefficients before it is differenced against Landsat 5 years.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf); library(terra)})
ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")
OUT  <- file.path(ROOT, "cube-16day"); dir.create(OUT, showWarnings = FALSE)
ee_Initialize(project = "murphys-deforisk", drive = FALSE)

YEARS   <- c(2005:2011, 2013, 2014)
EPOCH_D <- 16L
DOY0    <- 121L                    # 1 May
NEPOCH  <- 9L                      # 9 x 16 days = 144 days, 1 May to 22 September
SCALE   <- 10000; OFFSET <- 20000  # keep exported integers away from zero

msk <- rast(file.path(SA, "perimeter_mask.tif"))
per <- st_transform(st_as_sf(as.polygons(ext(msk), crs = crs(msk))), 4326)
region <- sf_as_ee(per)

## Roy et al. (2016) OLI to ETM+ band-pass coefficients, as in 06-build-cube.R.
ROY_S <- c(BLUE=0.8474, GREEN=0.8483, RED=0.9047, NIR=0.8462, SWIR1=0.8937, SWIR2=0.9071)
ROY_I <- c(BLUE=0.0003, GREEN=0.0088, RED=0.0061, NIR=0.0412, SWIR1=0.0254, SWIR2=0.0172)

prep <- function(ic, bands, l8) {
  ic$map(ee_utils_pyfunc(function(im) {
    sr <- im$select(bands, c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2"))$
            multiply(0.0000275)$add(-0.2)
    if (l8) sr <- sr$multiply(ee$Image$constant(unname(ROY_S)))$
                     add(ee$Image$constant(unname(ROY_I)))
    qa <- im$select("QA_PIXEL")
    clear <- qa$bitwiseAnd(strtoi("11000", base = 2))$eq(0)
    sr$updateMask(clear)$copyProperties(im, list("system:time_start"))
  }))
}

for (y in YEARS) {
  l5 <- prep(ee$ImageCollection("LANDSAT/LT05/C02/T1_L2")$filterBounds(region),
             c("SR_B1","SR_B2","SR_B3","SR_B4","SR_B5","SR_B7"), FALSE)
  l7 <- prep(ee$ImageCollection("LANDSAT/LE07/C02/T1_L2")$filterBounds(region),
             c("SR_B1","SR_B2","SR_B3","SR_B4","SR_B5","SR_B7"), FALSE)
  l8 <- prep(ee$ImageCollection("LANDSAT/LC08/C02/T1_L2")$filterBounds(region),
             c("SR_B2","SR_B3","SR_B4","SR_B5","SR_B6","SR_B7"), TRUE)
  ## 2012 is excluded from the study; Landsat 7 is used only where it is the sole sensor
  ## and never in a year that has another, because the scan-line corrector has been off
  ## since May 2003.
  col <- if (y <= 2011) l5 else l8

  for (e in seq_len(NEPOCH)) {
    d0 <- as.Date(sprintf("%d-01-01", y)) + (DOY0 - 1) + (e - 1) * EPOCH_D
    d1 <- d0 + EPOCH_D
    f  <- file.path(OUT, sprintf("ndmi_%d_e%02d.tif", y, e))
    if (file.exists(f)) next
    im <- col$filterDate(format(d0), format(d1))$median()
    ndmi <- im$normalizedDifference(c("NIR","SWIR1"))$rename("ndmi")
    out  <- ndmi$multiply(SCALE)$add(OFFSET)$toInt32()
    url <- try(out$getDownloadURL(list(scale = 30, region = region$geometry(),
                                       crs = "EPSG:3153", format = "GEO_TIFF")), silent = TRUE)
    if (inherits(url, "try-error")) { cat("skip", y, e, "\n"); next }
    tmp <- tempfile(fileext = ".tif")
    ok <- try(download.file(url, tmp, quiet = TRUE, mode = "wb"), silent = TRUE)
    if (inherits(ok, "try-error")) { cat("download failed", y, e, "\n"); next }
    r <- try(rast(tmp), silent = TRUE)
    if (inherits(r, "try-error")) { cat("unreadable", y, e, "\n"); next }
    r <- (r - OFFSET) / SCALE
    r <- mask(resample(r, msk, method = "near"), msk)
    names(r) <- sprintf("ndmi_%d_e%02d", y, e)
    writeRaster(r, f, overwrite = TRUE, datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
    cat(sprintf("%d epoch %02d  %s to %s  valid %5.1f%%  median %.3f\n", y, e,
                format(d0), format(d1), 100*mean(!is.na(values(r))),
                median(values(r), na.rm = TRUE)))
  }
}
fs <- list.files(OUT, "\\.tif$")
cat(sprintf("\n%d epoch rasters written to %s\n", length(fs), OUT))
