#!/usr/bin/env Rscript
## Prevailing wind direction in the beetle flight window.
##
## Needed because the geomorphometric wind indices are directional. SAGA's windward /
## leeward index and its wind shelter index both ask which way the wind comes from, and
## answering "we do not know, so average all eight bearings" throws away the one thing
## terrain-driven wind has that a gridded climatology does not.
##
## Direction is taken from the same ECCC hourly records 30-wind-hourly-metrics.R uses,
## over the same flight window, 1 July to 15 August. `wind_dir` is reported in tens of
## degrees, so it is multiplied by 10. Directions are averaged as unit vectors, never
## arithmetically: the mean of 350 and 10 degrees is 0, not 180.
##
## The convention that matters downstream: ECCC reports the direction the wind comes
## FROM. SAGA's DIR_CONST expects the same. No conversion is applied and this comment
## is the record that none was needed.

suppressPackageStartupMessages({library(weathercan); library(sf); library(terra); library(dplyr)})
ROOT <- "02.inputs/beetle-classification"
OUT  <- file.path(ROOT, "covariates"); dir.create(OUT, recursive = TRUE, showWarnings = FALSE)
YEARS <- c(2005:2011, 2013, 2014)

g   <- rast(file.path(ROOT, "ndmi-darkwoods", "analysis_grid.tif"))
ctr <- st_transform(st_sfc(st_point(c(mean(ext(g)[1:2]), mean(ext(g)[3:4]))), crs = 32611), 4326)
cc  <- st_coordinates(ctr)
sl  <- weathercan::stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
sl  <- sl[!is.na(sl$start) & sl$start <= 2014 & !is.na(sl$end) & sl$end >= 2005, ]
ids <- unique(sl$station_id)
cat(sprintf("hourly stations within 150 km: %d\n", length(ids)))

rows <- list()
for (y in YEARS) {
  w <- try(weathercan::weather_dl(station_ids = ids, interval = "hour",
             start = sprintf("%d-07-01", y), end = sprintf("%d-08-15", y)), silent = TRUE)
  if (inherits(w, "try-error")) { cat("no data", y, "\n"); next }
  d <- w |> filter(!is.na(wind_dir), !is.na(wind_spd), wind_spd > 0) |>
            mutate(deg = wind_dir * 10, rad = deg * pi/180)
  if (!nrow(d)) next
  ## Speed-weighted resultant, so the bearing reported is the one that carries the air,
  ## not the one that occurs most often at a dead calm.
  u <- sum(d$wind_spd * sin(d$rad)); v <- sum(d$wind_spd * cos(d$rad))
  bear <- (atan2(u, v) * 180/pi) %% 360
  R <- sqrt(u^2 + v^2) / sum(d$wind_spd)          # 0 = no prevailing direction, 1 = constant
  rows[[length(rows)+1]] <- data.frame(year = y, n_hours = nrow(d),
    n_stations = length(unique(d$station_id)), prevailing_deg = round(bear, 1),
    consistency = round(R, 3), mean_spd = round(mean(d$wind_spd), 2))
  cat(sprintf("%d  n=%5d  from %5.1f deg  R=%.3f\n", y, nrow(d), bear, R))
}
wd <- do.call(rbind, rows)

## Pooled bearing across all years, which is what a static terrain index needs.
u <- sum(wd$n_hours * sin(wd$prevailing_deg * pi/180))
v <- sum(wd$n_hours * cos(wd$prevailing_deg * pi/180))
pooled <- (atan2(u, v) * 180/pi) %% 360
attr(wd, "pooled") <- pooled
write.csv(wd, file.path(OUT, "wind_direction_flight_window.csv"), row.names = FALSE)
writeLines(sprintf("%.1f", pooled), file.path(OUT, "wind_direction_pooled.txt"))
cat(sprintf("\npooled prevailing direction, flight window: %.1f degrees (from)\n", pooled))
cat(sprintf("between-year spread: %.1f to %.1f degrees\n",
            min(wd$prevailing_deg), max(wd$prevailing_deg)))
