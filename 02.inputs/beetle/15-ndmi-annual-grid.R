#!/usr/bin/env Rscript
## Annual growing-season NDMI over the analysis grid, harmonised across sensors.
##
## This is the surface the red-stage classification is built from. The response is
## NDMI itself, not the aerial survey: the survey is retained only as a visual check
## on where high and moderate severity was reported, never as a training label.
##
## Grid: 695 x 639 at 25.11332 m in EPSG:32611, 444,105 cells, taken from the
## existing red-stage rasters so every product in this project aligns cell for cell.
## Earth Engine is asked for 30 m over the region and the result is resampled onto
## that grid locally, because crsTransform without dimensions makes Earth Engine
## compute over the whole CRS extent and fail the 50 MB cap (2026-08-19).
##
## Landsat 8 is converted onto the ETM+ scale with Roy et al. (2016) so 2013 onward
## sits on the same radiometric scale as the Landsat 5 outbreak years. 2012 is
## excluded: it is Landsat 7 only, scan-line-corrector off, and the striping was read
## as change by the earlier classifier.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf); library(terra)})

ROOT <- "02.inputs/beetle"
GRID <- file.path(ROOT, "red-stage", "dec_2005.tif")
OUT  <- file.path(ROOT, "ndmi-annual"); dir.create(OUT, showWarnings = FALSE)
YEARS <- c(2003, 2005:2011, 2013, 2014, 2020)
SENSOR <- function(y) if (y >= 2013) "LC08" else "LT05"
COLL <- c(LT05 = "LANDSAT/LT05/C02/T1_L2", LC08 = "LANDSAT/LC08/C02/T1_L2")
SB <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")
ROY_I <- c(0.0003,0.0088,0.0061,0.0412,0.0254,0.0172)
ROY_S <- c(0.8474,0.8483,0.9047,0.8462,0.8937,0.9071)

g <- rast(GRID); stopifnot(ncell(g) == 444105)
aoi <- st_as_sfc(st_bbox(ext(g), crs = st_crs(32611)))
ee_Initialize(project = "murphys-deforisk", drive = FALSE)
bb <- st_bbox(st_transform(aoi, 4326))
aoi_ee <- ee$Geometry$Rectangle(list(bb[["xmin"]], bb[["ymin"]], bb[["xmax"]], bb[["ymax"]]), "EPSG:4326", FALSE)

prep <- function(img, s) {
  b <- if (s == "LC08") paste0("SR_B", 2:7) else c(paste0("SR_B", 1:5), "SR_B7")
  m  <- img$select("QA_PIXEL")$bitwiseAnd(strtoi("11111", base = 2))$eq(0)
  sr <- img$select(b)$rename(SB)$multiply(0.0000275)$add(-0.2)$updateMask(m)
  if (s == "LC08")
    sr <- sr$multiply(ee$Image$constant(ROY_S))$add(ee$Image$constant(ROY_I))$rename(SB)
  sr
}

for (y in YEARS) {
  f <- file.path(OUT, sprintf("ndmi_%d.tif", y))
  if (file.exists(f)) { cat(sprintf("%d already present\n", y)); next }
  s  <- SENSOR(y)
  ic <- ee$ImageCollection(COLL[[s]])$filterBounds(aoi_ee)$
    filterDate(sprintf("%d-06-01", y), sprintf("%d-09-30", y))$
    filter(ee$Filter$lt("CLOUD_COVER", 60))$map(function(i) prep(i, s))
  n <- ic$size()$getInfo()
  if (n == 0) { cat(sprintf("%d no scenes\n", y)); next }
  img <- ic$median()$normalizedDifference(c("NIR","SWIR1"))$rename("NDMI")
  url <- img$getDownloadURL(list(scale = 30, region = aoi_ee,
                                 crs = "EPSG:32611", format = "GEO_TIFF"))
  tmp <- tempfile(fileext = ".tif"); download.file(url, tmp, quiet = TRUE, mode = "wb")
  r <- terra::resample(rast(tmp), g, method = "near")
  names(r) <- sprintf("NDMI_%d", y)
  writeRaster(r, f, overwrite = TRUE, datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  cat(sprintf("%d  %s  scenes=%3d  valid cells=%6d  median NDMI=%+.4f\n", y, s, n,
              sum(!is.na(values(r))), median(values(r), na.rm = TRUE)))
}
