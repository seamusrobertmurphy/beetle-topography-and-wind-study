#!/usr/bin/env Rscript
## The study perimeter and the analysis grid.
##
## Coordinate reference system. EPSG:3153, NAD83(CSRS) / BC Albers, at 30 m, because
## that is the parent study's grid and this paper has to be comparable to it:
## "All disturbance and covariate rasters were aligned to a common 30 m grid in
## EPSG:3153, the native resolution of the Landsat-derived dNBR and dNDMI products"
## and "The plot anchor was georeferenced with a handheld GPS receiver in EPSG:3153"
## (Murphy et al. 2026). Earlier stages of this project ran in EPSG:32611 and are
## reprojected here rather than trusted in place.
##
## Extent. The parent's site is the 2015 Mt Midgeley burn: it "spans elevations from
## 830 to 1744 m a.s.l.", and inside the 480 ha fire perimeter this DEM gives 857 to
## 1747 m, which is that statement reproduced. The present study expands beyond that
## hard boundary, because a 480 ha burn cannot carry the stand-density contrast the
## refugia mechanism runs on. It does not expand arbitrarily: the perimeter is the burn
## buffered 5 km and then cut to the elevation band the parent's site occupies, 830 to
## 1744 m, so the added ground is ecologically the same kind of ground.
##
## The cut matters. An unconstrained 1 km buffer already reaches 534 m, which is the
## Kootenay Lake surface, and a rectangle drawn around the DEM reaches 525 m. Neither
## is a site elevation, and a minimum of 525 m quoted for this study area is wrong.

suppressPackageStartupMessages({library(sf); library(terra)})
ROOT <- "02.inputs/beetle-classification"
OUT  <- file.path(ROOT, "study-area")
DATA <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
CRS_A  <- "EPSG:3153"
RES    <- 30
BUFFER <- 5000
BAND   <- c(830, 1744)
dir.create(OUT, showWarnings = FALSE, recursive = TRUE)

E  <- rast(file.path(DATA, "terrain_environment", "Elevation.utm.tif"))
dem <- project(E, CRS_A, res = RES, method = "bilinear")
burn <- st_transform(st_union(st_read(file.path(DATA, "fire_perimiter", "Fire.Perimiter.shp"),
                                      quiet = TRUE)), 3153)
cat(sprintf("DEM reprojected to %s at %d m: %.1f x %.1f km\n", CRS_A, RES,
            (xmax(dem)-xmin(dem))/1000, (ymax(dem)-ymin(dem))/1000))
v <- as.data.frame(mask(crop(dem, vect(burn)), vect(burn)), na.rm = TRUE)[, 1]
cat(sprintf("burn: %.0f ha, elevation %.0f to %.0f m (parent states 830 to 1744)\n",
            as.numeric(st_area(burn))/1e4, min(v), max(v)))

buf  <- st_buffer(burn, BUFFER)
band <- ifel(dem >= BAND[1] & dem <= BAND[2], 1, NA)
msk  <- mask(crop(band, vect(buf)), vect(buf))
names(msk) <- "perimeter"
writeRaster(msk, file.path(OUT, "perimeter_mask.tif"), overwrite = TRUE,
            datatype = "INT1U", gdal = c("COMPRESS=DEFLATE"))
per <- st_as_sf(as.polygons(msk))
st_write(per, file.path(OUT, "study_perimeter.gpkg"), delete_dsn = TRUE, quiet = TRUE)

n <- sum(!is.na(values(msk)))
cat(sprintf("perimeter: burn + %.0f km, cut to %d-%d m -> %d cells, %.0f ha, %.1fx the burn\n",
            BUFFER/1000, BAND[1], BAND[2], n, n*RES^2/1e4,
            (n*RES^2/1e4)/(as.numeric(st_area(burn))/1e4)))

## The analysis grid every downstream raster is snapped to.
grid <- mask(crop(dem, msk), msk); names(grid) <- "elevation"
writeRaster(grid, file.path(OUT, "elevation.tif"), overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
cat(sprintf("grid elevation %.0f to %.0f m, relief %.0f m\n",
            minmax(grid)[1], minmax(grid)[2], diff(minmax(grid)[1:2])))

## Alternatives, reported so the buffer is a choice with numbers attached rather than
## a default nobody examined.
cat("\nbuffer sensitivity (cut to the same elevation band):\n")
for (k in c(1, 2, 5, 8)) {
  m <- mask(crop(band, vect(st_buffer(burn, k*1000))), vect(st_buffer(burn, k*1000)))
  cat(sprintf("  %d km: %6.0f ha\n", k, sum(!is.na(values(m)))*RES^2/1e4))
}
bb <- round(st_bbox(st_transform(per, 3005)))
writeLines(paste(bb, collapse = ","), file.path(OUT, "perimeter_bbox_3005.txt"))
cat(sprintf("\nBBOX for WFS (EPSG:3005): %s\n", paste(bb, collapse = ",")))
