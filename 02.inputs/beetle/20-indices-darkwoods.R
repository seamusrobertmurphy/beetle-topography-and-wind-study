#!/usr/bin/env Rscript
## NDVI, NBR and TCW across Darkwoods for every year already held as NDMI.
##
## Why these are needed. The severity classes in 19-derive-balanced-plots.R were cut
## from the 2005-baseline NDMI drop. Training a classifier on that same drop would
## recover its own thresholds and report near-perfect accuracy that means nothing. The
## parent study faced the same issue and answered it with a separability analysis over
## four indices (Table S5); these are the three that are not NDMI, so the model has
## predictors that are not its own labels. Same collections, same masking, same Roy et
## al. (2016) harmonisation and same grid as 17-ndmi-annual-darkwoods.R.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf); library(terra)})
ROOT <- "02.inputs/beetle"
OUT  <- file.path(ROOT, "ndmi-darkwoods")
g <- rast(file.path(OUT, "analysis_grid.tif"))
YEARS  <- c(2005:2011, 2013, 2014, 2020)
SENSOR <- function(y) if (y >= 2013) "LC08" else "LT05"
COLL <- c(LT05 = "LANDSAT/LT05/C02/T1_L2", LC08 = "LANDSAT/LC08/C02/T1_L2")
SB <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")
ROY_I <- c(0.0003,0.0088,0.0061,0.0412,0.0254,0.0172)
ROY_S <- c(0.8474,0.8483,0.9047,0.8462,0.8937,0.9071)

ee_Initialize(project = "murphys-deforisk", drive = FALSE)
ll  <- st_bbox(st_transform(st_as_sfc(st_bbox(ext(g), crs = st_crs(32611))), 4326))
aoi <- ee$Geometry$Rectangle(list(ll[["xmin"]],ll[["ymin"]],ll[["xmax"]],ll[["ymax"]]),
                             "EPSG:4326", FALSE)
prep <- function(img, s) {
  b <- if (s == "LC08") paste0("SR_B", 2:7) else c(paste0("SR_B", 1:5), "SR_B7")
  m  <- img$select("QA_PIXEL")$bitwiseAnd(strtoi("11111", base = 2))$eq(0)
  sr <- img$select(b)$rename(SB)$multiply(0.0000275)$add(-0.2)$updateMask(m)
  if (s == "LC08")
    sr <- sr$multiply(ee$Image$constant(ROY_S))$add(ee$Image$constant(ROY_I))$rename(SB)
  sr
}
IDX <- list(
  NDVI = function(sr) sr$normalizedDifference(c("NIR","RED")),
  NBR  = function(sr) sr$normalizedDifference(c("NIR","SWIR2")),
  TCW  = function(sr) sr$expression(
    "0.0315*B+0.2021*G+0.3102*R+0.1594*N-0.6806*S1-0.6109*S2",
    list(B=sr$select("BLUE"),G=sr$select("GREEN"),R=sr$select("RED"),
         N=sr$select("NIR"),S1=sr$select("SWIR1"),S2=sr$select("SWIR2"))))

for (y in YEARS) for (nm in names(IDX)) {
  f <- file.path(OUT, sprintf("%s_%d.tif", tolower(nm), y))
  if (file.exists(f)) next
  s  <- SENSOR(y)
  ic <- ee$ImageCollection(COLL[[s]])$filterBounds(aoi)$
    filterDate(sprintf("%d-06-01", y), sprintf("%d-08-31", y))$
    filter(ee$Filter$lt("CLOUD_COVER", 60))$map(function(i) prep(i, s))
  if (ic$size()$getInfo() == 0) { cat(sprintf("%d %s: no scenes\n", y, nm)); next }
  img <- IDX[[nm]](ic$median())$rename(nm)
  url <- img$getDownloadURL(list(scale = 30, region = aoi, crs = "EPSG:32611",
                                 format = "GEO_TIFF"))
  tmp <- tempfile(fileext = ".tif"); download.file(url, tmp, quiet = TRUE, mode = "wb")
  r <- terra::resample(rast(tmp), g, method = "near"); names(r) <- sprintf("%s_%d", nm, y)
  writeRaster(r, f, overwrite = TRUE, datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  cat(sprintf("%d %-4s valid=%8d  median=%+.4f\n", y, nm,
              sum(!is.na(values(r))), median(values(r), na.rm = TRUE)))
}
