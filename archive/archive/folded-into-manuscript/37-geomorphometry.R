#!/usr/bin/env Rscript
## Geomorphometry, and the terrain-driven wind field.
##
## Why this replaces the interpolated station surface as the spatial wind term. Wind
## over this site is made by the terrain: a 914 m relief ridge system decides where air
## accelerates, separates and stalls. Interpolating four to seven valley stations across
## 150 km cannot see any of that, and did not: the 2009 surface spanned 7.27 to 7.79 km/h
## across 50 km. The station records keep the temporal signal, at hourly resolution and
## in the flight window; the spatial signal has to come from the shape of the ground.
##
## The parent study licenses the terrain half directly. Its point-process model of
## post-outbreak conifer regeneration returns terrain ruggedness at beta = 1.3563 with an
## LR-test p of 0.001, alongside aspect, slope, TWI and a wind term at beta = -0.0662,
## p = 0.002 (Murphy et al. 2026, Table 4). Ruggedness is the strongest terrain effect it
## reports, so a study on the same landscape that omitted terrain shape would be ignoring
## its own parent's result.
##
## Everything runs at 30 m in EPSG:3153 on the DEM from 33-study-perimeter.R. Indices are
## computed over the full reprojected DEM and only then clipped to the perimeter, so a
## search radius near the boundary sees real ground rather than NA.
##
## Directional indices use the prevailing flight-window bearing from
## 36-wind-direction.R, 258.2 degrees, speed-weighted over 1 July to 15 August. That
## bearing is weakly constrained: the resultant length is about 0.19 and the between-year
## spread runs 224.5 to 293.4 degrees. The omnidirectional indices are carried alongside
## for exactly that reason, and the variable-selection stage is allowed to choose.

suppressPackageStartupMessages({library(sf); library(terra)})
ROOT  <- "02.inputs/beetle"
SA    <- file.path(ROOT, "study-area")
OUT   <- file.path(ROOT, "geomorphometry"); dir.create(OUT, showWarnings = FALSE)
## A persistent working directory, not tempdir(): SAGA writes each grid as three files
## and a truncated .sdat reads back as a GDAL block error rather than as a failure, so
## the intermediates have to survive the session to be inspected.
TMP   <- file.path(ROOT, "geomorphometry", "saga"); dir.create(TMP, recursive = TRUE, showWarnings = FALSE)
SAGA  <- "/opt/local/bin/saga_cmd"
DATA  <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
DIR   <- as.numeric(readLines(file.path(ROOT, "covariates", "wind_direction_pooled.txt")))

## Full DEM, not the clipped one: the clip happens after every index is computed.
dem <- project(rast(file.path(DATA, "terrain_environment", "Elevation.utm.tif")),
               "EPSG:3153", res = 30, method = "bilinear")
names(dem) <- "elevation"
tif <- file.path(TMP, "dem.tif"); writeRaster(dem, tif, overwrite = TRUE)
sg  <- file.path(TMP, "dem.sgrd")
system2(SAGA, c("io_gdal", "0", "-FILES", tif, "-GRIDS", sg), stdout = FALSE, stderr = FALSE)
stopifnot(file.exists(sg))
cat(sprintf("DEM %d x %d at 30 m, %.0f-%.0f m, prevailing wind from %.1f degrees\n",
            nrow(dem), ncol(dem), minmax(dem)[1], minmax(dem)[2], DIR))

o <- function(n) file.path(TMP, paste0(n, ".sgrd"))

## SAGA writes the insolation unit as "kWh/m^2" using a superscript two, and that single
## non-ASCII byte runs the UNIT line into the next one, so the header reads
## `UNIT = kWh/m^2DATAFORMAT = FLOAT` with no line break. GDAL then cannot find
## DATAFORMAT, and reading the grid fails with "Unable to read block from grid file"
## even though the .sdat is the right size and entirely correct. The header is repaired
## before the grid is read. This affects only the two ta_lighting 2 outputs, and it is
## silent: the tool reports success.
fix_sgrd <- function(n) {
  f <- file.path(TMP, paste0(n, ".sgrd"))
  if (!file.exists(f)) return(invisible(FALSE))
  h <- readLines(f, warn = FALSE)
  bad <- grepl("DATAFORMAT", h, fixed = TRUE) & grepl("UNIT", h, fixed = TRUE)
  if (!any(bad)) return(invisible(TRUE))
  ## Split the run-together line at DATAFORMAT, then drop the UNIT line entirely. UNIT
  ## is an optional descriptive field; DATAFORMAT is not, and losing it is what breaks
  ## the read. Substitutions are fixed = TRUE so no escaping is involved.
  h <- unlist(lapply(h, function(x)
    if (grepl("DATAFORMAT", x, fixed = TRUE) && grepl("UNIT", x, fixed = TRUE))
      strsplit(sub("DATAFORMAT", "\nDATAFORMAT", x, fixed = TRUE), "\n", fixed = TRUE)[[1]]
    else x))
  h <- h[!startsWith(h, "UNIT")]
  writeLines(h, f)
  cat("  repaired header:", n, "\n")
  invisible(TRUE)
}

run <- function(lib, id, ...) {
  a <- c(lib, as.character(id), unlist(list(...)))
  r <- system2(SAGA, a, stdout = FALSE, stderr = FALSE)
  cat(sprintf("  %-18s %-3s %s\n", lib, id, ifelse(r == 0, "ok", paste("FAILED", r))))
  invisible(r)
}

## ---- wind, from the shape of the ground -------------------------------------------
## Windward/leeward index and effective air flow height at the prevailing bearing.
run("ta_morphometry", 15, "-DEM", sg, "-EFFECT", o("wind_effect"),
    "-AFH", o("wind_afh"), "-DIR_CONST", DIR, "-DIR_UNITS", 1, "-MAXDIST", 300)
## Omnidirectional exposition, 300 m search: how open a cell is to wind from anywhere.
run("ta_morphometry", 27, "-DEM", sg, "-EXPOSITION", o("wind_exposition"),
    "-MAXDIST", 0.3, "-STEP", 15)
## Winstral-style shelter: maximum upwind slope angle, at the prevailing bearing.
## Tool 29 takes -ELEVATION, not -DEM, and its -DISTANCE is in cells: 17 cells is
## 510 m, matching the 500 m radius used for openness and sky view.
run("ta_morphometry", 29, "-ELEVATION", sg, "-SHELTER", o("wind_shelter"),
    "-DIRECTION", DIR, "-UNIT", 0, "-DISTANCE", 17, "-TOLERANCE", 10)
## Openness and sky view, the two scale-free measures of exposure versus enclosure.
run("ta_lighting", 5, "-DEM", sg, "-POS", o("openness_pos"), "-NEG", o("openness_neg"),
    "-RADIUS", 500)
run("ta_lighting", 3, "-DEM", sg, "-VISIBLE", o("sky_view"), "-RADIUS", 500)

## ---- ruggedness and shape, the parent's RIX and its relatives ----------------------
run("ta_morphometry", 16, "-DEM", sg, "-TRI", o("tri"), "-RADIUS", 1)
run("ta_morphometry", 17, "-DEM", sg, "-VRM", o("vrm"), "-RADIUS", 1)
run("ta_morphometry", 18, "-DEM", sg, "-TPI", o("tpi"), "-RADIUS_MAX", 300)
run("ta_morphometry", 28, "-DEM", sg, "-TPI", o("mstpi"), "-SCALE_MIN", 1,
    "-SCALE_MAX", 8, "-SCALE_NUM", 3)
run("ta_morphometry", 1, "-ELEVATION", sg, "-RESULT", o("convergence"))
run("ta_morphometry", 0, "-ELEVATION", sg, "-SLOPE", o("slope"), "-ASPECT", o("aspect"),
    "-C_PROF", o("curv_prof"), "-C_PLAN", o("curv_plan"), "-UNIT_SLOPE", 1, "-UNIT_ASPECT", 1)
run("ta_lighting", 8, "-DEM", sg, "-GEOMORPHONS", o("geomorphons"), "-THRESHOLD", 1,
    "-RADIUS", 300)

## ---- energy: the radiation the biology actually names -----------------------------
## Three separate claims in the literature make solar radiation a first-order terrain
## variable here rather than a control.
##
## (1) Krawchuk et al. (2020) name topographic shading as their FIRST refugia mechanism
##     for mountain pine beetle: refugia could occur "in areas with cooler temperatures
##     (eg from topographic shading) that protect trees from water stress ... and more
##     vigorous tree growth and chemical defenses". Shading is a radiation quantity.
## (2) Flight is thermally gated. Safranyik and Wilson (2006) give "the estimated lower
##     and upper temperature limits for beetle flight are 19 and 41 degrees C
##     (McCambridge 1971), most beetles fly when temperatures are between 22 and 32
##     degrees C (Safranyik 1978)", and "Most beetles emerge when temperatures are above
##     20 degrees C". A slope that does not reach 19 degrees C in the flight window is
##     unreachable by flight whatever else is true of it.
## (3) The timing is specific: "most flights occur on bright sunny days, and peak flight
##     is in the early to mid afternoon (Reid 1960)".
##
## So radiation is computed twice, for two different mechanisms, rather than as one
## annual number. FLIGHT is direct and diffuse insolation over 1 July to 15 August
## restricted to 12:00-17:00, the hours the flight peak occupies. SEASON is the
## growing-season total, 1 May to 30 September over the whole day, which is the
## radiation load a tree experiences and therefore Krawchuk's water-stress pathway.
## A static heat-load index cannot separate those two, which is why it is not enough.
LAT <- mean(as.vector(ext(project(dem, "EPSG:4326")))[3:4])
run("ta_lighting", 2, "-GRD_DEM", sg, "-GRD_DIRECT", o("solar_flight_direct"),
    "-GRD_DIFFUS", o("solar_flight_diffuse"),
    "-LOCATION", 0, "-LATITUDE", LAT, "-PERIOD", 2, "-UNITS", 0,
    "-DAY", "2009-07-01", "-DAY_STOP", "2009-08-15", "-DAYS_STEP", 3,
    "-HOUR_RANGE_MIN", 12, "-HOUR_RANGE_MAX", 17, "-HOUR_STEP", 1, "-SHADOW", 1)
run("ta_lighting", 2, "-GRD_DEM", sg, "-GRD_DIRECT", o("solar_season_direct"),
    "-GRD_TOTAL", o("solar_season_total"),
    "-LOCATION", 0, "-LATITUDE", LAT, "-PERIOD", 2, "-UNITS", 0,
    "-DAY", "2009-05-01", "-DAY_STOP", "2009-09-30", "-DAYS_STEP", 7,
    "-HOUR_RANGE_MIN", 4, "-HOUR_RANGE_MAX", 21, "-HOUR_STEP", 1, "-SHADOW", 1)

## ---- cold air, snow and the places infestation is reported to gather ----------------
## Two more statements from the same synthesis put specific landforms in the model.
## "Thick bark and deep snow will insulate beetle broods from declining ambient
## temperatures", so where cold air pools and snow lies is where broods survive winter.
## And "groups of infested trees are frequently associated with draws and gullies, edges
## of swamps or other places with wide fluctuation in the water table". Draws and gullies
## are convergent terrain, which the convergence index and topographic wetness measure,
## and relative slope position separates a valley floor from a mid-slope bench.
run("ta_morphometry", 14, "-DEM", sg, "-HO", o("height_slope_top"),
    "-HU", o("height_valley_floor"), "-NH", o("normalised_height"),
    "-SH", o("standardised_height"), "-MS", o("midslope_position"))

## ---- moisture, and the alternative explanations that must be controlled ------------
run("ta_hydrology", 15, "-DEM", sg, "-TWI", o("twi"))
## Potential annual insolation writes a grid collection rather than a grid, so the
## energy term is the McCune and Keon (2002) heat load index instead, computed below
## from slope, aspect and latitude. It is the same quantity the earlier draft used.
run("ta_channels", 7, "-ELEVATION", sg, "-VALLEY_DEPTH", o("valley_depth"))

## ---- collect ----------------------------------------------------------------------
for (n in c("solar_flight_direct","solar_flight_diffuse",
            "solar_season_direct","solar_season_total")) fix_sgrd(n)

LAY <- c("wind_effect","wind_afh","wind_exposition","wind_shelter","openness_pos",
         "openness_neg","sky_view","tri","vrm","tpi","mstpi","convergence","slope",
         "aspect","curv_prof","curv_plan","geomorphons","twi","valley_depth",
         "solar_flight_direct","solar_flight_diffuse",
         "solar_season_direct","solar_season_total",
         "height_valley_floor","normalised_height","midslope_position")
msk <- rast(file.path(SA, "perimeter_mask.tif"))
got <- character(0); st <- list()
for (n in LAY) {
  f <- file.path(TMP, paste0(n, ".sdat"))
  if (!file.exists(f)) { cat("  missing:", n, "\n"); next }
  r <- rast(f); crs(r) <- "EPSG:3153"; names(r) <- n
  st[[n]] <- mask(crop(r, msk), msk); got <- c(got, n)
}
s <- rast(st)
## Aspect is circular and unusable as a linear predictor; it enters as its components.
if ("aspect" %in% got) {
  a <- s[["aspect"]] * pi/180
  s <- c(s, setNames(cos(a), "northness"), setNames(sin(a), "eastness"))
  ## Heat load after McCune and Keon (2002) equation 3: aspect folded about the
  ## southwest-northeast axis so southwest is hottest, which is the axis that matters
  ## here because the confound this study cannot resolve is wind exposure against cold.
  lat <- mean(as.vector(ext(project(s[["aspect"]], "EPSG:4326")))[3:4]) * pi/180
  sl  <- s[["slope"]] * pi/180
  af  <- abs(pi - abs(a - (5*pi/4)))
  hl  <- exp(-1.467 + 1.582*cos(lat)*cos(sl) - 1.500*cos(af)*sin(sl)*sin(lat)
             - 0.262*sin(lat)*sin(sl) + 0.607*sin(af)*sin(sl))
  s <- c(s, setNames(hl, "heat_load"))
}
writeRaster(s, file.path(OUT, "geomorphometry.tif"), overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
cat(sprintf("\nwrote %d layers over %d cells\n", nlyr(s), sum(!is.na(values(msk)))))
d <- as.data.frame(s, na.rm = FALSE)
print(round(t(sapply(d, function(x) c(min = min(x, na.rm = TRUE),
      median = stats::median(x, na.rm = TRUE), max = max(x, na.rm = TRUE),
      pct_na = 100*mean(is.na(x))))), 3))
