#!/usr/bin/env Rscript
## A cached grey relief base map for the manuscript's figures.
##
## Why this exists, and why it is cached rather than fetched at render time. The maps
## need something under the data that shows the reader this is a mountain. A hillshade
## computed from the project's own DEM did that but looked wrong: the source elevation
## model is a rotated rectangle in this projection, so it left a hard diagonal edge
## across every panel, and its narrow value range made the relief flat and grey.
##
## Esri's World Shaded Relief is a purpose-built grey relief layer, which is exactly what
## a base map should be: legible, neutral, and not competing with the data drawn over it.
## It is downloaded once here and committed, so a render needs no network and every draft
## draws the identical base map. Attribution belongs in the figure caption.
##
## The extent is fixed by the target scale, not the other way round. The manuscript
## reports a representative fraction of 1:250,000 at a printed panel width of 66 mm, so
## the ground width must be 250000 * 66 mm = 16.5 km exactly. That width is set here and
## in 01.manuscript/_shared/map-academic.R, and the two must agree.
##
## Writes: study-area/basemap_relief.tif   EPSG:3153, three-band RGB
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle-classification/48-fetch-basemap-relief.R

suppressPackageStartupMessages({library(sf); library(terra); library(maptiles)})

ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")

RF <- 150000      # the representative fraction every panel reports
PANEL_MM    <- 66          # nominal printed panel width
GROUND_M    <- RF * PANEL_MM / 1000        # 9,900 m
ASPECT      <- 1.45                        # matches MAP_ASPECT in map-academic.R

per <- st_read(file.path(SA, "study_perimeter.gpkg"), quiet = TRUE) |> st_transform(3153)
ctr <- st_coordinates(st_centroid(st_union(per)))
half_w <- GROUND_M / 2
half_h <- GROUND_M * ASPECT / 2
page <- st_as_sfc(st_bbox(c(xmin = ctr[1] - half_w, xmax = ctr[1] + half_w,
                            ymin = ctr[2] - half_h, ymax = ctr[2] + half_h),
                          crs = st_crs(3153)))
cat(sprintf("page %.2f x %.2f km, centred on the perimeter; 1:%s at %d mm\n",
            2 * half_w / 1000, 2 * half_h / 1000, format(RF, big.mark = ","), PANEL_MM))

tiles <- get_tiles(page, provider = "Esri.WorldShadedRelief", zoom = 12,
                   crop = TRUE, cachedir = tempdir(), forceDownload = TRUE)
tiles <- project(tiles, "EPSG:3153", method = "bilinear")
tiles <- crop(tiles, ext(unname(st_bbox(page)[c(1, 3, 2, 4)])))
cat(sprintf("tiles: %d bands, %d x %d cells at %.0f m\n",
            nlyr(tiles), nrow(tiles), ncol(tiles), res(tiles)[1]))

## Desaturate to true grey. Esri's relief carries a tan cast, which competes with the
## viridis and magma ramps drawn over it and is not what a neutral base map should do.
## Rec. 601 luminance, written back to all three bands so it stays an RGB raster and
## geom_spatraster_rgb can still draw it.
lum <- 0.299 * tiles[[1]] + 0.587 * tiles[[2]] + 0.114 * tiles[[3]]
## Stretch the observed luminance into a light grey band. The tile's own range is narrow
## and sits high, so a fixed offset either crushes it to white or leaves it competing with
## the data; a linear stretch to [168, 252] keeps the relief readable and still clearly
## behind the viridis and magma ramps drawn over it.
r0 <- as.vector(minmax(lum))
lum <- 168 + (lum - r0[1]) * (252 - 168) / (r0[2] - r0[1])
tiles <- c(lum, lum, lum)
names(tiles) <- c("red", "green", "blue")
cat(sprintf("desaturated to grey, range %.0f to %.0f\n",
            min(values(lum), na.rm = TRUE), max(values(lum), na.rm = TRUE)))

writeRaster(tiles, file.path(SA, "basemap_relief.tif"), overwrite = TRUE,
            datatype = "INT1U", gdal = c("COMPRESS=DEFLATE", "PREDICTOR=2"))
cat("wrote", file.path(SA, "basemap_relief.tif"), "\n")
cat("Attribution required in the caption: Esri World Shaded Relief.\n")
