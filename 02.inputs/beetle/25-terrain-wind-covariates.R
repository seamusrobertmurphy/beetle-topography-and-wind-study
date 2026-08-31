#!/usr/bin/env Rscript
## Topographic and wind covariates on the Darkwoods analysis grid.
##
## Terrain follows section 2.1 of the parent paper: slope, aspect decomposed into
## northness and eastness, topographic wetness index, and terrain ruggedness. Aspect is
## decomposed because 0 and 360 degrees are the same direction, and a regression fed
## raw aspect treats them as maximally different (Beers et al. 1966; Pierce et al. 2005).
##
## The DEM differs from the parent's and this is deliberate. The parent used the 1 m
## NRCan High Resolution DEM, which covers the 480 ha burn; this study spans 265,000 ha
## and no such tile set is held here. Copernicus GLO-30 is used instead, resampled to
## the 30 m analysis grid, which is the posting the parent itself settled on for
## ruggedness anyway after testing multiple resolutions.
##
## Wind is the constraint on this study, not the terrain. The Global Wind Atlas rasters
## held locally span -116.891 to -116.558 and 49.096 to 49.313 only, roughly 24 by 24 km
## around the burn, while the analysis grid is 50.8 by 52.2 km. Wind is therefore
## written where it exists and left NA elsewhere, and the covered fraction is reported
## so the refugia model's usable extent is a measured number rather than an assumption.
## A terrain-derived exposure index is computed over the whole grid as the covariate
## that does not have a hole in it.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf); library(terra)})
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "covariates"); dir.create(OUT, showWarnings = FALSE)
WIND <- "archive/1.8 GIS Data/BC Climate Data - Nasa"
g <- rast(file.path(IN, "analysis_grid.tif"))

## ---- DEM from Earth Engine --------------------------------------------------
dem_f <- file.path(OUT, "elevation.tif")
if (!file.exists(dem_f)) {
  ee_Initialize(project = "murphys-deforisk", drive = FALSE)
  ll  <- st_bbox(st_transform(st_as_sfc(st_bbox(ext(g), crs = st_crs(32611))), 4326))
  aoi <- ee$Geometry$Rectangle(list(ll[["xmin"]],ll[["ymin"]],ll[["xmax"]],ll[["ymax"]]),
                               "EPSG:4326", FALSE)
  dem <- ee$ImageCollection("COPERNICUS/DEM/GLO30")$select("DEM")$mosaic()$rename("elev")
  url <- dem$getDownloadURL(list(scale = 30, region = aoi, crs = "EPSG:32611",
                                 format = "GEO_TIFF"))
  tmp <- tempfile(fileext = ".tif"); download.file(url, tmp, quiet = TRUE, mode = "wb")
  writeRaster(terra::resample(rast(tmp), g, method = "bilinear"), dem_f,
              overwrite = TRUE, datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
}
elev <- rast(dem_f); names(elev) <- "elevation"
cat(sprintf("elevation: %.0f to %.0f m (parent reports 830 to 1744 m inside the burn)\n",
            global(elev,"min",na.rm=TRUE)[[1]], global(elev,"max",na.rm=TRUE)[[1]]))

## ---- terrain derivatives ----------------------------------------------------
tp  <- terrain(elev, v = c("slope","aspect","TRI","TPI"), unit = "radians")
nor <- cos(tp$aspect); names(nor) <- "northness"
eas <- sin(tp$aspect); names(eas) <- "eastness"
## SAGA-style topographic wetness index: ln(specific catchment area / tan(slope))
fa  <- terrain(elev, v = "flowdir")
acc <- flowAccumulation(fa)
sl0 <- tp$slope; sl0[sl0 < 0.001] <- 0.001   # pmax() is not defined on a SpatRaster
twi <- log((acc * prod(res(elev)) / res(elev)[1] + 1) / tan(sl0))
names(twi) <- "twi"
slope_deg <- tp$slope * 180 / pi; names(slope_deg) <- "slope"
names(tp$TRI) <- "tri"; names(tp$TPI) <- "tpi"

## terrain exposure: elevation of a cell relative to the mean of a 990 m neighbourhood,
## the standard stand-scale proxy for wind exposure where an atlas does not reach
expo <- elev - focal(elev, w = 33, fun = "mean", na.rm = TRUE); names(expo) <- "exposure"

## ---- Global Wind Atlas where it reaches --------------------------------------
wl <- list()
for (h in c(50, 100, 150)) {
  f <- list.files(WIND, sprintf("Wind_Atlas_%dm.*wind-speed.*tif$", h), full.names = TRUE)
  if (!length(f)) next
  w <- project(rast(f[1]), g, method = "bilinear"); names(w) <- sprintf("wind_%dm", h)
  wl[[length(wl)+1]] <- w
}
wind <- rast(wl)
cov_pc <- 100 * global(!is.na(wind[[1]]), "sum", na.rm = TRUE)[[1]] / ncell(g)
cat(sprintf("Global Wind Atlas covers %.1f%% of the analysis grid; %.1f%% is NA\n",
            cov_pc, 100 - cov_pc))

st <- c(elev, slope_deg, nor, eas, tp$TRI, tp$TPI, twi, expo, wind)
writeRaster(st, file.path(OUT, "covariates.tif"), overwrite = TRUE, datatype = "FLT4S",
            gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
cat("\ncovariate summary over the grid:\n")
print(round(as.data.frame(global(st, function(x) c(mean(x, na.rm=TRUE), sd(x, na.rm=TRUE),
      min(x, na.rm=TRUE), max(x, na.rm=TRUE)))), 3))
cat(sprintf("\nwrote %s (%d layers)\n", file.path(OUT, "covariates.tif"), nlyr(st)))
