#!/usr/bin/env Rscript
## Stand-structure covariates from the Vegetation Resources Inventory.
##
## These are the variables the literature says the refugia mechanism runs through,
## and none of them was in the covariate set before now.
##
##   BASAL_AREA            Cartwright (2018) finds total basal area the strongest single
##                         predictor of refugium occurrence, refugia sitting in low
##                         basal area, and attributes it in part to wind: "Thinner stands
##                         also increase wind penetration, helping to disperse beetle
##                         pheromones and disrupt chemical communications needed to
##                         coordinate attacks."
##   CROWN_CLOSURE         the canopy density that decides whether wind reaches the bole,
##                         which is the physical step the pheromone argument turns on.
##   VRI_LIVE_STEMS_PER_HA local host density in the sense Powell and Bentz (2014) use:
##                         "higher local host density, which minimizes pheromone plume
##                         dispersion, reduces wind, and promotes successful switching to
##                         nearby hosts, positively influences outbreak propensity."
##   QUAD_DIAM_125         quadratic mean diameter over stems 12.5 cm and up, against the
##                         25 cm source-sink threshold of Carroll and Safranyik (2003):
##                         brood production is governed by stem size, not by how much
##                         host is present.
##   PROJ_AGE_1            stand age. Shore (2006): the susceptibility index "is a measure
##                         of the effects of pine age, stand density, susceptible pine
##                         basal area, and stand location (climate)".
##   PINE_BA               susceptible pine basal area, the fourth term of that index,
##                         formed as total basal area times the pine share of cover.
##
## Rasterised onto the same 30 m EPSG:32611 grid as everything else and clipped to the
## Darkwoods perimeter from 33-study-perimeter.R.

suppressPackageStartupMessages({library(sf); library(terra)})
ROOT <- "02.inputs/beetle"
SA   <- file.path(ROOT, "study-area")

v <- st_read(file.path(SA, "vri_perimeter.geojson"), quiet = TRUE)
v <- st_make_valid(v)
cat(sprintf("%d polygons, reference years %s\n", nrow(v),
            paste(range(v$REFERENCE_YEAR, na.rm = TRUE), collapse = "-")))

## Pine cover accumulated across the three species slots. VRI species codes for
## lodgepole pine start PL; PLI is the interior variety and is what occurs here.
pct <- function(cd, pc) ifelse(!is.na(cd) & grepl("^PL", cd), ifelse(is.na(pc), 0, pc), 0)
v$PinePct <- pct(v$SPECIES_CD_1, v$SPECIES_PCT_1) +
             pct(v$SPECIES_CD_2, v$SPECIES_PCT_2) +
             pct(v$SPECIES_CD_3, v$SPECIES_PCT_3)
v$PINE_BA <- v$BASAL_AREA * v$PinePct / 100

## EPSG:3153 at 30 m, the parent's grid. The perimeter mask defines it.
m <- rast(file.path(SA, "perimeter_mask.tif"))
g <- m
v <- st_transform(v, crs(m))

FLD <- c("BASAL_AREA","CROWN_CLOSURE","VRI_LIVE_STEMS_PER_HA","QUAD_DIAM_125",
         "PROJ_AGE_1","PROJ_HEIGHT_1","LIVE_STAND_VOLUME_125","PinePct","PINE_BA")

## Every field is coerced to double before rasterising and the stack is written as
## FLT4S. CROWN_CLOSURE, VRI_LIVE_STEMS_PER_HA and PROJ_AGE_1 arrive from the WFS as
## integers, and an integer raster written without an explicit NA flag stores NA as
## -2147483648, which reads back as a legitimate value: a first run reported those
## three layers at 100 per cent coverage with a mean of -4.4e+08. The same failure
## mode as the Earth Engine zero-nodata trap recorded in project memory, and just as
## silent.
for (f in FLD) v[[f]] <- as.numeric(v[[f]])
vv <- vect(v)
r <- rast(lapply(FLD, function(f) {
  x <- rasterize(vv, g, field = f); names(x) <- f; x }))
r <- mask(crop(r, m), m)
writeRaster(r, file.path(SA, "vri_covariates.tif"), overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))

## Coverage is reported, not assumed: the modelled area is whatever has a basal area,
## and the README for the old extract records 121,353 cells lost that way at 25 m.
fm <- m
nf <- sum(!is.na(values(fm)))
cat(sprintf("\ncells in perimeter: %d (%.0f ha)\n", nf, nf*0.09))
cat("coverage of those cells, per layer:\n")
for (f in FLD) {
  ok <- sum(!is.na(values(mask(r[[f]], fm))))
  cat(sprintf("  %-24s %7d  %5.1f%%\n", f, ok, 100*ok/nf))
}
cat("\nsummary over forested cells inside the perimeter:\n")
d <- as.data.frame(mask(r, fm), na.rm = FALSE)
print(round(t(sapply(d, function(x) c(min = min(x, na.rm = TRUE),
      median = stats::median(x, na.rm = TRUE), mean = mean(x, na.rm = TRUE),
      max = max(x, na.rm = TRUE)))), 1))

## Inventory vintage. VRI is a projected operational product, not a census, and its
## reference years here span 1968 to 2025. A polygon projected from a 2014 photo
## interpretation describes a stand the beetle had already worked through, so basal
## area and pine cover are post-attack for part of the outbreak window. The manuscript
## reports this rather than correcting it, because there is no unattacked vintage.
cat("\nreference year distribution:\n")
print(table(cut(v$REFERENCE_YEAR, c(-Inf, 1990, 2000, 2005, 2011, 2014, Inf),
                labels = c("<=1990","1991-2000","2001-2005","2006-2011",
                           "2012-2014",">2014"))))
