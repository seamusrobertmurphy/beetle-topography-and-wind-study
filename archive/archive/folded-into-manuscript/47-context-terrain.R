#!/usr/bin/env Rscript
## An unclipped terrain surface for the manuscript's base maps.
##
## Why this exists. Every analysis raster in this study is masked to the study perimeter,
## and the perimeter is the 2015 burn buffered 5 km and then cut to the parent study's
## elevation band, 830 to 1744 m. That cut removes the summit ridge and the valley floor,
## so the perimeter is a ragged ring with a hole in the middle, and a map drawn from the
## masked rasters alone shows a blob a reader cannot interpret. On a mountain landscape
## the mountain itself is invisible.
##
## This writes the terrain the maps need underneath the data: a context DEM and a
## hillshade over the whole map page, neither of them masked.
##
## Writes:
##   study-area/dem_context.tif   elevation, EPSG:3153 at 30 m, unmasked
##   study-area/hillshade.tif     hillshade from it, azimuth 315, altitude 40
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle/47-context-terrain.R

suppressPackageStartupMessages({library(terra); library(sf)})

ROOT <- "02.inputs/beetle"
SA   <- file.path(ROOT, "study-area")
DATA <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
PAD  <- 3500      # must match MAP_PAD in 01.manuscript/_shared/map-academic.R

per <- st_read(file.path(SA, "study_perimeter.gpkg"), quiet = TRUE) |> st_transform(3153)
bb  <- st_bbox(per)
page <- ext(unname(c(bb["xmin"] - PAD, bb["xmax"] + PAD,
                     bb["ymin"] - PAD, bb["ymax"] + PAD)))

dem <- project(rast(file.path(DATA, "terrain_environment", "Elevation.utm.tif")),
               "EPSG:3153", res = 30, method = "bilinear")
dem <- crop(dem, page, extend = TRUE)
names(dem) <- "elevation"
cat(sprintf("context DEM %.1f x %.1f km, %.0f to %.0f m\n",
            (xmax(dem) - xmin(dem)) / 1000, (ymax(dem) - ymin(dem)) / 1000,
            min(values(dem), na.rm = TRUE), max(values(dem), na.rm = TRUE)))

## Hillshade at the cartographic convention: light from the north-west so relief reads as
## relief rather than inverting, and a low sun so the ridges carry.
sl  <- terrain(dem, "slope",  unit = "radians")
asp <- terrain(dem, "aspect", unit = "radians")
hs  <- shade(sl, asp, angle = 40, direction = 315)
names(hs) <- "hillshade"

writeRaster(dem, file.path(SA, "dem_context.tif"), overwrite = TRUE,
            gdal = c("COMPRESS=DEFLATE", "PREDICTOR=2"))
writeRaster(hs, file.path(SA, "hillshade.tif"), overwrite = TRUE,
            gdal = c("COMPRESS=DEFLATE", "PREDICTOR=2"))
cat("wrote dem_context.tif and hillshade.tif\n")

## What the elevation cut actually removes, reported so the manuscript can state it.
msk <- rast(file.path(SA, "perimeter_mask.tif"))
hull <- rasterize(vect(st_convex_hull(st_union(per))), dem)
d2 <- resample(dem, msk)
h2 <- resample(hull, msk)
cut <- !is.na(values(h2)) & is.na(values(msk)) & !is.na(values(d2))
v <- values(d2)[cut]
cat(sprintf("cells cut from the perimeter hull: %d, elevation %.0f to %.0f m (median %.0f)\n",
            sum(cut), min(v), max(v), median(v)))
cat(sprintf("  above the 1744 m ceiling: %.1f%%; below the 830 m floor: %.1f%%\n",
            100 * mean(v > 1744), 100 * mean(v < 830)))
