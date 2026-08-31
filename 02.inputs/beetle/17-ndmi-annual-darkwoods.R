#!/usr/bin/env Rscript
## Annual growing-season NDMI across Darkwoods, the wide-area basis for the
## red-stage beetle time series this manuscript needs.
##
## Why wider than the parent study. Murphy et al. (2026) mapped red stage only to
## serve a point-process model inside the 479.77 ha Mt Midgeley burn, so its rasters
## carry almost no topographic or wind variation. The refugia hypothesis of Krawchuk
## is a claim about terrain and exposure controlling where beetle attack does not
## happen, and it cannot be tested on a single burn. The extent here is the union of
## the Darkwoods Conservation Area (54,579 ha, WCL_CNSRVA_polygon.shp) and the
## existing analysis grid that holds the burn, roughly 50.8 by 52.1 km.
##
## Method follows section 2.4 of the parent paper: NDMI, and annual scenes
## differenced against the 2005 pre-disturbance baseline. Two deliberate departures,
## both recorded rather than hidden. The parent used Landsat 7 ETM+ for the outbreak
## years; the scan-line corrector has been off since May 2003 and the striping was
## read as change by an earlier build here, so Landsat 5 TM is used for 2005 to 2011.
## Landsat 8 years are placed on the ETM+ scale with Roy et al. (2016). 2012 has no
## usable sensor and is absent from the parent archive too.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf); library(terra)})

ROOT <- "02.inputs/beetle"
OUT  <- file.path(ROOT, "ndmi-darkwoods"); dir.create(OUT, showWarnings = FALSE)
DW   <- paste0("archive/1.8 GIS Data/BC Government Geodatasets/NGO Conservation Areas/",
               "WCL_CONSERVATION_AREAS_NGO_SP/WCL_CNSRVA_polygon.shp")
GRID <- file.path(ROOT, "red-stage", "dec_2005.tif")
YEARS  <- c(2005:2011, 2013, 2014, 2020)
SENSOR <- function(y) if (y >= 2013) "LC08" else "LT05"
COLL <- c(LT05 = "LANDSAT/LT05/C02/T1_L2", LC08 = "LANDSAT/LC08/C02/T1_L2")
SB <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")
ROY_I <- c(0.0003,0.0088,0.0061,0.0412,0.0254,0.0172)
ROY_S <- c(0.8474,0.8483,0.9047,0.8462,0.8937,0.9071)

dw <- st_read(DW, quiet = TRUE)
dw <- st_transform(dw[grepl("^Darkwoods", dw$PROJ_NAME), ], 32611)
bb <- st_bbox(dw); gb <- st_bbox(ext(rast(GRID)), crs = st_crs(32611))
E <- c(xmin = min(bb["xmin"], gb["xmin"]), ymin = min(bb["ymin"], gb["ymin"]),
       xmax = max(bb["xmax"], gb["xmax"]), ymax = max(bb["ymax"], gb["ymax"]))
## snap the analysis grid to whole 30 m so every year aligns cell for cell
E <- c(floor(E[1]/30)*30, floor(E[2]/30)*30, ceiling(E[3]/30)*30, ceiling(E[4]/30)*30)
g <- rast(xmin = E[1], ymin = E[2], xmax = E[3], ymax = E[4], resolution = 30,
          crs = "EPSG:32611")
cat(sprintf("extent %.0f x %.0f m, grid %d x %d = %d cells\n",
            E[3]-E[1], E[4]-E[2], nrow(g), ncol(g), ncell(g)))
writeRaster(setValues(g, 1), file.path(OUT, "analysis_grid.tif"), overwrite = TRUE,
            datatype = "INT1U", gdal = "COMPRESS=DEFLATE")

ee_Initialize(project = "murphys-deforisk", drive = FALSE)
ll <- st_bbox(st_transform(st_as_sfc(st_bbox(ext(g), crs = st_crs(32611))), 4326))
aoi <- ee$Geometry$Rectangle(list(ll[["xmin"]], ll[["ymin"]], ll[["xmax"]], ll[["ymax"]]),
                             "EPSG:4326", FALSE)

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
  ic <- ee$ImageCollection(COLL[[s]])$filterBounds(aoi)$
    filterDate(sprintf("%d-06-01", y), sprintf("%d-08-31", y))$
    filter(ee$Filter$lt("CLOUD_COVER", 60))$map(function(i) prep(i, s))
  n <- ic$size()$getInfo()
  if (n == 0) { cat(sprintf("%d no scenes\n", y)); next }
  img <- ic$median()$normalizedDifference(c("NIR","SWIR1"))$rename("NDMI")
  url <- img$getDownloadURL(list(scale = 30, region = aoi, crs = "EPSG:32611",
                                 format = "GEO_TIFF"))
  tmp <- tempfile(fileext = ".tif")
  download.file(url, tmp, quiet = TRUE, mode = "wb")
  r <- terra::resample(rast(tmp), g, method = "near"); names(r) <- sprintf("NDMI_%d", y)
  writeRaster(r, f, overwrite = TRUE, datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  cat(sprintf("%d  %s  scenes=%3d  valid=%8d (%4.1f%%)  median NDMI=%+.4f\n", y, s, n,
              sum(!is.na(values(r))), 100*sum(!is.na(values(r)))/ncell(r),
              median(values(r), na.rm = TRUE)))
}
