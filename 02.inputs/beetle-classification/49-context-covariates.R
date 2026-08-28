#!/usr/bin/env Rscript
## Unclipped covariate surfaces, for the manuscript's figures only.
##
## Why this exists. Every covariate raster the models use is masked to the study
## perimeter, and that perimeter is the burn buffered 5 km then cut to the 830 to 1744 m
## elevation band. Drawn on their own the surfaces are a ring with a hole in it, floating
## on a base map, and a reader cannot tell a study boundary from a clipping error.
##
## These surfaces fill the map instead. They are the SAME computations, not different
## ones: 37-geomorphometry.R computes every index over the full reprojected DEM and only
## clips when it assembles the stack, so its SAGA intermediates in geomorphometry/saga/
## are already unclipped and are simply read back here. The inventory is re-rasterised
## from the same polygons over the wider page.
##
## THESE ARE FOR DISPLAY ONLY. No model reads them. The study perimeter is drawn over
## them in every figure, so the ground the analysis excludes is visible as excluded.
##
## Writes:
##   study-area/geomorphometry_context.tif
##   study-area/vri_context.tif
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle-classification/49-context-covariates.R

suppressPackageStartupMessages({library(sf); library(terra)})

ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")
TMP  <- file.path(ROOT, "geomorphometry", "saga")

## The page, from the same two constants the maps use: 1:250,000 at a 66 mm panel is
## 16.5 km of ground. Keep in step with MAP_RF and MAP_PANEL in
## 01.manuscript/_shared/map-academic.R and with 48-fetch-basemap-relief.R.
RF <- 250000; PANEL_MM <- 66
W  <- RF * PANEL_MM / 1000
ASPECT <- 20190 / 15960

per <- st_read(file.path(SA, "study_perimeter.gpkg"), quiet = TRUE) |> st_transform(3153)
ctr <- as.numeric(st_coordinates(st_centroid(st_union(per))))
page <- ext(c(ctr[1] - W/2, ctr[1] + W/2, ctr[2] - W*ASPECT/2, ctr[2] + W*ASPECT/2))
grid <- rast(page, resolution = 30, crs = "EPSG:3153")
cat(sprintf("page %.2f x %.2f km at 30 m, %d x %d cells\n",
            W/1000, W*ASPECT/1000, nrow(grid), ncol(grid)))

## ---- terrain, read back unclipped from the SAGA intermediates ---------------------
WANT <- c("wind_effect", "tri", "vrm", "tpi", "twi", "valley_depth", "convergence",
          "curv_prof", "midslope_position", "height_valley_floor", "normalised_height",
          "northness", "eastness", "heat_load", "slope", "aspect",
          "solar_flight_direct", "solar_season_direct", "geomorphons")
got <- list()
for (n in WANT) {
  f <- file.path(TMP, paste0(n, ".sdat"))
  if (!file.exists(f)) { cat("  missing:", n, "\n"); next }
  r <- rast(f); crs(r) <- "EPSG:3153"
  got[[n]] <- resample(crop(r, page, extend = TRUE), grid,
                       method = if (n == "geomorphons") "near" else "bilinear")
}
## northness and eastness are derived from aspect in 37-, not written by SAGA, so they
## are derived the same way here rather than silently dropped.
if (!is.null(got$aspect)) {
  got$northness <- cos(got$aspect); got$eastness <- sin(got$aspect)
}
geo <- rast(got[!vapply(got, is.null, logical(1))])
names(geo) <- names(got)[!vapply(got, is.null, logical(1))]
cat(sprintf("terrain: %d layers, non-NA %.1f%%\n", nlyr(geo),
            100 * mean(!is.na(values(geo[[1]])))))
writeRaster(geo, file.path(SA, "geomorphometry_context.tif"), overwrite = TRUE,
            gdal = c("COMPRESS=DEFLATE", "PREDICTOR=2"))

## ---- inventory, re-rasterised over the wider page ---------------------------------
## vri_page.geojson, not vri_perimeter.geojson: the perimeter extract was fetched over
## the perimeter's own bounding box and covers only 30 per cent of the map page, so a
## panel drawn from it still looked clipped. This is the same layer and the same fields
## over the page bbox, 2,991 polygons against 1,084.
v <- st_read(file.path(SA, "vri_page.geojson"), quiet = TRUE) |> st_transform(3153)
FIELDS <- c("BASAL_AREA", "CROWN_CLOSURE", "VRI_LIVE_STEMS_PER_HA", "QUAD_DIAM_125",
            "PROJ_AGE_1", "PROJ_HEIGHT_1", "LIVE_STAND_VOLUME_125")
FIELDS <- FIELDS[FIELDS %in% names(v)]
vri <- rast(lapply(FIELDS, function(f) rasterize(vect(v), grid, field = f)))
names(vri) <- FIELDS
cat(sprintf("inventory: %d layers from %d polygons, non-NA %.1f%%\n",
            nlyr(vri), nrow(v), 100 * mean(!is.na(values(vri[[1]])))))
writeRaster(vri, file.path(SA, "vri_context.tif"), overwrite = TRUE,
            gdal = c("COMPRESS=DEFLATE", "PREDICTOR=2"))
cat("wrote geomorphometry_context.tif and vri_context.tif (display only)\n")
