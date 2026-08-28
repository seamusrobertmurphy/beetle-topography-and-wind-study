#!/usr/bin/env Rscript
## Terrain-resolved wind for each 16-day epoch.
##
## The same MicroMet machinery as 41-micromet-wind.R, but accumulated over the sixteen
## days that precede each epoch's imagery rather than over one flight window a year. This
## is what makes wind testable in time as well as in space: the response now has 60
## observations instead of 8, and each carries the wind of its own sixteen days.
##
## The direction-bin trick is unchanged and is what makes this affordable: the weighting
## surface Ww depends on wind direction and not on speed, so it is computed once per bin
## and each hourly observation multiplied by the surface for its own bin.

suppressPackageStartupMessages({library(weathercan); library(sf); library(terra); library(dplyr)})
ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")
MM   <- file.path(ROOT, "covariates", "wind-micromet")
OUT  <- file.path(ROOT, "covariates", "wind-epoch"); dir.create(OUT, showWarnings = FALSE)
NBIN <- 16L; CALM <- 5; WINDY <- 15

msk <- rast(file.path(SA, "perimeter_mask.tif"))
Wstack <- rast(file.path(MM, "wind_weight_by_direction.tif"))
ep <- read.csv(file.path(ROOT, "epoch-response", "epoch_summary.csv"))

ctr <- st_transform(st_sfc(st_point(c(mean(ext(msk)[1:2]), mean(ext(msk)[3:4]))),
                           crs = crs(msk)), 4326)
cc <- st_coordinates(ctr)
sl <- weathercan::stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
sl <- sl[!is.na(sl$start) & sl$start <= 2014 & !is.na(sl$end) & sl$end >= 2005, ]
ids <- unique(sl$station_id)

cells <- !is.na(values(msk))
wv <- lapply(seq_len(NBIN), function(b) values(Wstack[[b]])[cells])
put <- function(v) { r <- msk; values(r)[cells] <- v; values(r)[!cells] <- NA; r }

rows <- list()
for (i in seq_len(nrow(ep))) {
  y <- ep$year[i]; e <- ep$epoch[i]
  f <- file.path(OUT, sprintf("wind_%d_e%02d.tif", y, e))
  if (file.exists(f)) next
  w <- try(weathercan::weather_dl(station_ids = ids, interval = "hour",
             start = ep$start[i], end = ep$end[i]), silent = TRUE)
  if (inherits(w, "try-error")) { cat("no data", y, e, "\n"); next }
  h <- w |> filter(!is.na(wind_spd), !is.na(wind_dir)) |>
    mutate(th = wind_dir * 10 * pi/180,
           u = -wind_spd * sin(th), v = -wind_spd * cos(th)) |>
    group_by(time) |> summarise(u = mean(u), v = mean(v), .groups = "drop") |>
    mutate(W = sqrt(u^2 + v^2),
           theta = (atan2(-u, -v) * 180/pi) %% 360,
           bin = (round(theta / (360/NBIN)) %% NBIN) + 1L)
  if (nrow(h) < 50) { cat("too few hours", y, e, nrow(h), "\n"); next }

  acc <- rep(0, sum(cells)); ccalm <- acc; cwindy <- acc; nc <- 0
  for (b in sort(unique(h$bin))) {
    sp <- sort(h$W[h$bin == b]); ww <- wv[[b]]
    acc    <- acc + ww * sum(sp)
    ccalm  <- ccalm  + findInterval(CALM  / ww, sp)
    cwindy <- cwindy + (length(sp) - findInterval(WINDY / ww, sp))
    nc <- nc + length(sp)
  }
  s <- c(setNames(put(acc/nc), "ep_wind_mean"),
         setNames(put(ccalm/nc), "ep_wind_calm"),
         setNames(put(cwindy/nc), "ep_wind_windy"))
  writeRaster(s, f, overwrite = TRUE, datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
  rng <- minmax(s[["ep_wind_mean"]])
  rows[[length(rows)+1]] <- data.frame(year = y, epoch = e, hours = nrow(h),
    mean_kmh = round(mean(values(s[["ep_wind_mean"]]), na.rm=TRUE), 3),
    spatial_range = round(rng[2]-rng[1], 3),
    calm = round(mean(values(s[["ep_wind_calm"]]), na.rm=TRUE), 3))
  cat(sprintf("%d e%02d  %s  %4d h  mean %.2f km/h  spatial range %.2f  calm %.2f\n",
              y, e, ep$start[i], nrow(h), rows[[length(rows)]]$mean_kmh,
              rows[[length(rows)]]$spatial_range, rows[[length(rows)]]$calm))
}
sm <- do.call(rbind, rows)
write.csv(sm, file.path(OUT, "epoch_wind_summary.csv"), row.names = FALSE)
cat(sprintf("\n%d epoch wind fields; between-epoch mean ranges %.2f to %.2f km/h\n",
            nrow(sm), min(sm$mean_kmh), max(sm$mean_kmh)))
