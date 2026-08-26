#!/usr/bin/env Rscript
## Annual growing-season wind speed by IDW from Environment and Climate Change Canada
## stations, replacing the static Global Wind Atlas climatology.
##
## Why the atlas had to go. Each Global Wind Atlas file held here is a single layer of
## 87 by 133 cells carrying one long-term mean per pixel. It has no day, week, month or
## year dimension, so the same value stood for 2006 and for 2014 and it could not
## separate an attacked cell from an unattacked one in any year. It also reached only
## 21.6 per cent of the analysis grid. Both faults are fatal for a hypothesis about
## wind and beetle dispersal across an outbreak.
##
## Method follows https://seamusrobertmurphy.quarto.pub/cffdrs/#import-climate-data:
## `weathercan::stations_search` on a radius around the site, `weathercan::weather_dl`
## for the period, aggregation to a station mean, then inverse distance weighting
## through a `gstat` model applied with `terra::interpolate`. Two departures, both
## because this is a different question from a fire-weather one. The period is the
## flight season, 1 June to 31 August, of each outbreak year rather than one season;
## and interpolation is done natively in EPSG:32611 on the analysis grid rather than
## in EPSG:3857, so the wind rasters align cell for cell with the classification.
##
## What IDW from stations can and cannot give. Station density in the Selkirks is low
## and the stations sit in valleys, so the surface carries the regional wind field and
## its year-to-year variation, not ridge-top acceleration. Terrain exposure remains the
## stand-scale covariate; this is the temporal one. The number of contributing stations
## per year is written into the output so a year fitted on very few is visible.

suppressPackageStartupMessages({library(weathercan); library(gstat); library(sf)
                                library(terra); library(dplyr)})
ROOT <- "02.inputs/beetle-classification"
OUT  <- file.path(ROOT, "covariates", "wind-annual"); dir.create(OUT, recursive = TRUE, showWarnings = FALSE)
g <- rast(file.path(ROOT, "ndmi-darkwoods", "analysis_grid.tif"))
YEARS <- c(2005:2011, 2013, 2014)

ctr <- st_transform(st_sfc(st_point(c(mean(ext(g)[1:2]), mean(ext(g)[3:4]))), crs = 32611), 4326)
cc  <- st_coordinates(ctr)
cat(sprintf("search centre %.4f N %.4f E, radius 150 km\n", cc[2], cc[1]))

st_list <- weathercan::stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
st_list <- st_list[!is.na(st_list$start) & st_list$start <= 2014 &
                   !is.na(st_list$end)   & st_list$end   >= 2005, ]
ids <- unique(st_list$station_id)
cat(sprintf("stations within 150 km overlapping 2005-2014: %d\n", length(ids)))

res <- list()
for (y in YEARS) {
  f <- file.path(OUT, sprintf("wind_%d.tif", y))
  w <- try(weathercan::weather_dl(station_ids = ids, interval = "hour",
             start = sprintf("%d-06-01", y), end = sprintf("%d-08-31", y)),
           silent = TRUE)
  if (inherits(w, "try-error")) {
    cat(sprintf("%d: download failed: %s\n", y, conditionMessage(attr(w, "condition")))); next }
  if (!nrow(w)) { cat(sprintf("%d: no rows returned\n", y)); next }
  s <- w |>
    filter(!is.na(wind_spd), !is.na(lat), !is.na(lon)) |>
    group_by(station_id, lat, lon) |>
    summarise(wind = mean(wind_spd, na.rm = TRUE), n = dplyr::n(), .groups = "drop") |>
    filter(n >= 500)   # at least ~500 hourly readings in the 92-day season
  if (nrow(s) < 4) { cat(sprintf("%d: only %d usable stations, skipped\n", y, nrow(s))); next }
  p <- st_transform(st_as_sf(s, coords = c("lon","lat"), crs = 4326), 32611)
  xy <- cbind(as.data.frame(st_coordinates(p)), wind = p$wind)
  mg <- gstat(formula = wind ~ 1, locations = ~X + Y, data = xy, nmax = 8, set = list(idp = 2))
  r  <- terra::interpolate(g, mg, xyNames = c("X","Y")); r <- r[[1]]
  names(r) <- sprintf("wind_%d", y)
  writeRaster(r, f, overwrite = TRUE, datatype = "FLT4S",
              gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  res[[length(res)+1]] <- data.frame(year = y, stations = nrow(s),
    obs = sum(s$n), mean_kmh = mean(s$wind), grid_mean = global(r,"mean",na.rm=TRUE)[[1]],
    grid_min = global(r,"min",na.rm=TRUE)[[1]], grid_max = global(r,"max",na.rm=TRUE)[[1]])
  cat(sprintf("%d  stations %2d  obs %5d  station mean %5.2f km/h  grid %5.2f (%.2f to %.2f)\n",
              y, nrow(s), sum(s$n), mean(s$wind), global(r,"mean",na.rm=TRUE)[[1]],
              global(r,"min",na.rm=TRUE)[[1]], global(r,"max",na.rm=TRUE)[[1]]))
}
tab <- do.call(rbind, res)
write.csv(tab, file.path(OUT, "wind_station_summary.csv"), row.names = FALSE)
cat(sprintf("\nwrote %d annual wind rasters to %s\n", nrow(tab), OUT))
