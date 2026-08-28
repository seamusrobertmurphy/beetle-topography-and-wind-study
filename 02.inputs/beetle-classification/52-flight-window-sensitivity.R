#!/usr/bin/env Rscript
## Does the definition of the flight window change the refugia result?
##
## Why this exists. 44-epoch-wind.R accumulates every hour of each 16-day epoch, so
## ep_wind_mean is a 24-hour mean. The manuscript's own argument is that a wind term must
## be measured over the period the insect actually flies, and it levels exactly this
## criticism at annual studies. Applied one scale down, the criticism lands on this study:
## averaging across nights during which no beetle flies is the same error as averaging
## across weeks in which none does.
##
## So the window is varied and the model refitted. Four definitions, from the loosest to
## the one the biology actually names:
##
##   all24   every hour of the epoch                    what the manuscript currently uses
##   h12_17  12:00 to 17:00                             the window the Methods state
##   h11_18  11:00 to 18:00                             every hour clearing the gate >50%
##             of the time on this landscape, from 51-flight-window-climate.R
##   gate    only hours whose observed temperature fell inside 19 to 41 degrees C
##             the thermal gate itself, so the wind a flying beetle could have met
##
## `gate` is the mechanistically faithful one and is the test that matters. If the density
## by wind interaction strengthens as the window tightens onto the hours the beetle flies,
## that is evidence for the mechanism. If it weakens, that is evidence against it, and it
## will be reported as such.
##
## Writes: covariates/wind-epoch-sensitivity/epoch_wind_<def>.csv, one row per year, epoch
##         and cell-sample, and a summary of the station-level series.
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle-classification/52-flight-window-sensitivity.R

suppressPackageStartupMessages({
  library(weathercan); library(sf); library(terra); library(dplyr)
})

ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")
MM   <- file.path(ROOT, "covariates", "wind-micromet")
OUT  <- file.path(ROOT, "covariates", "wind-epoch-sensitivity")
dir.create(OUT, recursive = TRUE, showWarnings = FALSE)
NBIN <- 16L; T_GATE <- c(19, 41)

## Every predicate returns FALSE, never NA, for a record it cannot judge. `hour` carries
## NAs, and `NA >= 12` is NA, which selects an all-NA row: the accumulated sum then becomes
## NA and the whole definition reports NA while the two predicates that happened to guard
## against NA reported fine. That asymmetry is what made the first build look like a mask
## problem when it was a missing-data problem.
DEFS <- list(
  all24  = function(d) rep(TRUE, nrow(d)),
  h12_17 = function(d) !is.na(d$hour) & d$hour >= 12 & d$hour <= 17,
  h11_18 = function(d) !is.na(d$hour) & d$hour >= 11 & d$hour <= 18,
  gate   = function(d) !is.na(d$temp) & d$temp >= T_GATE[1] & d$temp <= T_GATE[2]
)

## The epoch calendar the response is built on, so the sensitivity uses the same epochs.
eps <- read.csv(file.path(ROOT, "epoch-response", "epoch_summary.csv"))
cat(sprintf("epochs: %d across %d years\n", nrow(eps), length(unique(eps$year))))

per <- st_read(file.path(SA, "study_perimeter.gpkg"), quiet = TRUE)
ctr <- st_transform(st_centroid(st_union(per)), 4326); cc <- st_coordinates(ctr)
sl  <- stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
sl  <- sl[!is.na(sl$start) & sl$start <= 2014 & !is.na(sl$end) & sl$end >= 2005, ]
ids <- unique(sl$station_id)

## One fetch, cached, covering every epoch. weather_dl is the slow step and the hour
## filters are applied afterwards, so the four definitions cost one download between them.
raw <- file.path(OUT, "hourly_wind_dir.csv")
if (file.exists(raw)) {
  h <- read.csv(raw); cat(sprintf("cached: %d hourly records\n", nrow(h)))
} else {
  h <- bind_rows(lapply(sort(unique(eps$year)), function(y) {
    w <- try(weather_dl(station_ids = ids, interval = "hour",
                        start = sprintf("%d-04-15", y), end = sprintf("%d-10-15", y)),
             silent = TRUE)
    if (inherits(w, "try-error") || !nrow(w)) return(NULL)
    w |> filter(!is.na(wind_spd), !is.na(wind_dir)) |>
      transmute(year = y, date = as.Date(date), hour = as.integer(substr(time, 12, 13)),
                temp = temp, spd = wind_spd, dir = wind_dir * 10)
  }))
  write.csv(h, raw, row.names = FALSE)
  cat(sprintf("fetched: %d hourly records with direction\n", nrow(h)))
}
h$date <- as.Date(h$date)

## Vector-average the stations to one series, because averaging bearings in degrees across
## the 360/0 line is meaningless.
h <- h |>
  mutate(th = dir * pi / 180, u = -spd * sin(th), v = -spd * cos(th)) |>
  group_by(year, date, hour) |>
  summarise(u = mean(u), v = mean(v), temp = mean(temp, na.rm = TRUE), .groups = "drop") |>
  mutate(W = sqrt(u^2 + v^2),
         theta = (atan2(-u, -v) * 180 / pi) %% 360,
         bin = (round(theta / (360 / NBIN)) %% NBIN) + 1L)

## The terrain weighting, one surface per direction bin, sampled at the modelled cells.
wv <- rast(file.path(MM, "wind_weight_by_direction.tif"))
msk <- rast(file.path(SA, "perimeter_mask.tif"))
## Every bin, not just the first. A cell missing from any one direction surface makes the
## accumulated sum NA for any window whose hours happen to include that bearing, which is
## why two of the four definitions returned NA on the first build and two did not.
keep <- !is.na(values(msk))
for (b in seq_len(nlyr(wv))) keep <- keep & !is.na(values(wv[[b]]))
ww <- lapply(seq_len(nlyr(wv)), function(b) values(wv[[b]])[keep])
cat(sprintf("cells with both a mask and a weighting: %d\n", sum(keep)))

out <- list()
for (nm in names(DEFS)) {
  rows <- list()
  for (i in seq_len(nrow(eps))) {
    d <- h[h$date >= as.Date(eps$start[i]) & h$date <= as.Date(eps$end[i]), ]
    d <- d[DEFS[[nm]](d), ]
    d <- d[!is.na(d$bin) & !is.na(d$W), ]
    if (nrow(d) < 20) next
    ## The same accumulation as 44-epoch-wind.R: sum weighted speed over the hours in the
    ## window, bin by bin, then divide by the number of hours.
    acc <- rep(0, sum(keep))
    for (b in sort(unique(d$bin))) acc <- acc + ww[[b]] * sum(d$W[d$bin == b])
    v <- acc / nrow(d)
    rows[[length(rows) + 1]] <- data.frame(
      year = eps$year[i], epoch = eps$epoch[i], hours = nrow(d),
      cell_mean = mean(v), cell_sd = sd(v), station_mean = mean(d$W))
    ## The per-cell surface as well as the summary, because refitting needs the value at
    ## each modelled cell and the summary cannot supply it. Written to the same grid the
    ## epoch model table was sampled from, so the join is by coordinate.
    r <- msk; values(r) <- NA_real_; values(r)[keep] <- v
    names(r) <- "ep_wind_mean"
    writeRaster(r, file.path(OUT, sprintf("wind_%s_%d_e%02d.tif", nm, eps$year[i], eps$epoch[i])),
                overwrite = TRUE, datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
  }
  s <- bind_rows(rows)
  write.csv(s, file.path(OUT, sprintf("epoch_wind_%s.csv", nm)), row.names = FALSE)
  out[[nm]] <- s
  cat(sprintf("%-7s %2d epochs, %6d hours total, cell mean %.2f km/h, between-epoch sd %.2f\n",
              nm, nrow(s), sum(s$hours), mean(s$cell_mean), sd(s$cell_mean)))
}
saveRDS(out, file.path(OUT, "epoch_wind_by_definition.rds"))
cat("wrote", OUT, "\n")
