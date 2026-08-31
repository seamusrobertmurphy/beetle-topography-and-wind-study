#!/usr/bin/env Rscript
## Wind at hourly source resolution, summarised into the windows beetle flight uses.
##
## What changed and why. 29-wind-annual-stations.R downloaded hourly ECCC observations
## and then threw almost all of that resolution away, writing one June-to-August mean
## per year. A season mean cannot represent dispersal: mountain pine beetle flies in a
## narrow midsummer window, and what matters is the wind during those days, not the
## average of ninety of them. This script keeps the hourly series and reduces it only
## at the last step, into metrics that mean something for flight.
##
## Temporal resolution of the source: hourly, `wind_spd` in km/h, from
## `weathercan::weather_dl(interval = "hour")`. Roughly 2,200 readings per station per
## season, about 22 per cent missing.
##
## Metrics, per station per year. Monthly means for June, July and August, so seasonal
## progression is retained. Then, over the flight window of 1 July to 15 August
## (Safranyik and Carroll's midsummer emergence period for the southern interior):
##   flight_mean   mean hourly wind speed, the ambient field a dispersing beetle meets
##   flight_p95    95th percentile, the transport extreme that carries long dispersal
##   flight_calm   fraction of hours below 5 km/h, when directed short-range flight and
##                 pheromone-mediated mass attack are possible rather than being blown out
##   flight_windy  fraction of hours above 15 km/h, when flight is suppressed
##
## Calm fraction is the one the refugia hypothesis predicts should matter most: a stand
## sheltered enough to hold calm air is a stand where mass attack can be coordinated.
##
## Each metric is interpolated to the 30 m analysis grid by inverse distance weighting
## through a gstat model, as in 29- and in the cffdrs method. The spatial limitation is
## unchanged and is not hidden: four to seven valley stations across 150 km produce a
## nearly flat surface within any year. These layers carry the temporal signal at high
## fidelity; terrain exposure carries the spatial one.

suppressPackageStartupMessages({library(weathercan); library(gstat); library(sf)
                                library(terra); library(dplyr)})
ROOT <- "02.inputs/beetle"
OUT  <- file.path(ROOT, "covariates", "wind-hourly"); dir.create(OUT, recursive = TRUE, showWarnings = FALSE)
g <- rast(file.path(ROOT, "ndmi-darkwoods", "analysis_grid.tif"))
YEARS <- c(2005:2011, 2013, 2014)
CALM  <- 5; WINDY <- 15

ctr <- st_transform(st_sfc(st_point(c(mean(ext(g)[1:2]), mean(ext(g)[3:4]))), crs = 32611), 4326)
cc  <- st_coordinates(ctr)
sl  <- weathercan::stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
sl  <- sl[!is.na(sl$start) & sl$start <= 2014 & !is.na(sl$end) & sl$end >= 2005, ]
ids <- unique(sl$station_id)
cat(sprintf("hourly stations within 150 km overlapping 2005-2014: %d\n", length(ids)))

idw <- function(df, col) {
  p  <- st_transform(st_as_sf(df, coords = c("lon","lat"), crs = 4326), 32611)
  xy <- cbind(as.data.frame(st_coordinates(p)), v = p[[col]])
  xy <- xy[!is.na(xy$v), ]
  if (nrow(xy) < 4) return(NULL)
  m <- gstat(formula = v ~ 1, locations = ~X + Y, data = xy, nmax = 8, set = list(idp = 2))
  terra::interpolate(g, m, xyNames = c("X","Y"))[[1]]
}

summ <- list()
for (y in YEARS) {
  w <- try(weathercan::weather_dl(station_ids = ids, interval = "hour",
             start = sprintf("%d-06-01", y), end = sprintf("%d-08-31", y)), silent = TRUE)
  if (inherits(w, "try-error") || !nrow(w)) { cat(sprintf("%d: unavailable\n", y)); next }
  w <- w |> filter(!is.na(wind_spd), !is.na(lat), !is.na(lon))
  w$mon <- as.integer(format(as.Date(w$date), "%m"))
  w$doy <- as.integer(format(as.Date(w$date), "%j"))
  fl <- as.integer(format(as.Date(sprintf("%d-07-01", y)), "%j")):
        as.integer(format(as.Date(sprintf("%d-08-15", y)), "%j"))

  st <- w |> group_by(station_id, lat, lon) |>
    summarise(hours = dplyr::n(),
      jun = mean(wind_spd[mon == 6], na.rm = TRUE),
      jul = mean(wind_spd[mon == 7], na.rm = TRUE),
      aug = mean(wind_spd[mon == 8], na.rm = TRUE),
      flight_mean  = mean(wind_spd[doy %in% fl], na.rm = TRUE),
      flight_p95   = as.numeric(quantile(wind_spd[doy %in% fl], .95, na.rm = TRUE)),
      flight_calm  = mean(wind_spd[doy %in% fl] < CALM,  na.rm = TRUE),
      flight_windy = mean(wind_spd[doy %in% fl] > WINDY, na.rm = TRUE),
      flight_hours = sum(doy %in% fl), .groups = "drop") |>
    filter(hours >= 500, flight_hours >= 200)
  if (nrow(st) < 4) { cat(sprintf("%d: only %d stations, skipped\n", y, nrow(st))); next }

  vars <- c("jun","jul","aug","flight_mean","flight_p95","flight_calm","flight_windy")
  rl <- lapply(vars, function(v) { r <- idw(st, v); if (!is.null(r)) names(r) <- v; r })
  rl <- Filter(Negate(is.null), rl)
  rs <- rast(rl)
  writeRaster(rs, file.path(OUT, sprintf("wind_metrics_%d.tif", y)), overwrite = TRUE,
              datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  s <- data.frame(year = y, stations = nrow(st), hours = sum(st$hours),
                  t(round(colMeans(st[, vars], na.rm = TRUE), 3)))
  summ[[length(summ)+1]] <- s
  cat(sprintf("%d  st %d  hrs %6d | Jun %.2f Jul %.2f Aug %.2f | flight mean %.2f p95 %.1f calm %.3f windy %.3f\n",
      y, nrow(st), sum(st$hours), s$jun, s$jul, s$aug,
      s$flight_mean, s$flight_p95, s$flight_calm, s$flight_windy))
}
tab <- do.call(rbind, summ)
write.csv(tab, file.path(OUT, "wind_hourly_summary.csv"), row.names = FALSE)
cat(sprintf("\nwrote %d yearly metric stacks to %s\n", nrow(tab), OUT))
