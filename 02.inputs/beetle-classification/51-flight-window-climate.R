#!/usr/bin/env Rscript
## Hourly station climate through the flight season, for the flight-window figure.
##
## Why this exists. The manuscript restricts the flight window to 1 July to 15 August and
## to the hours 12:00 to 17:00, citing a thermal gate of 19 to 41 degrees C and a flight
## peak "in the early to mid afternoon" (Safranyik and Carroll 2006). Those are numbers
## from the literature applied to this landscape without ever showing the reader the
## landscape's own climate. A figure can show it: where the window sits inside the season,
## how much of the season clears the thermal gate, and whether the afternoon really is when
## it clears.
##
## The window is not fitted to these data. It comes from the bionomics and is held fixed;
## this is the check on whether it is reasonable here, and it can fail.
##
## 30-wind-hourly-metrics.R fetches June to August and keeps only summary metrics, so
## nothing on disk carries the within-season shape. This pulls May to September so the
## window has season on both sides of it, and keeps the hourly records.
##
## Writes: covariates/flight-window/hourly_climate.csv   year, date, doy, hour, temp, wind
##         covariates/flight-window/daily_climate.csv    per year and day of year
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle-classification/51-flight-window-climate.R

suppressPackageStartupMessages({
  library(sf); library(terra); library(dplyr); library(weathercan)
})

ROOT <- "02.inputs/beetle-classification"
OUT  <- file.path(ROOT, "covariates", "flight-window")
dir.create(OUT, recursive = TRUE, showWarnings = FALSE)

YEARS <- c(2005:2011, 2013, 2014)
## The flight envelope and the window the manuscript uses, stated once here so the figure
## and the methods cannot disagree.
T_MIN <- 19; T_MAX <- 41          # flight is gated between these, after Carroll et al.
T_PEAK <- c(22, 32)               # most flight occurs in this narrower band
HR <- c(12, 17)                   # the afternoon hours the window restricts to
WIN <- c("07-01", "08-15")        # the flight window itself

per <- st_read(file.path(ROOT, "study-area", "study_perimeter.gpkg"), quiet = TRUE)
ctr <- st_transform(st_centroid(st_union(per)), 4326)
cc  <- st_coordinates(ctr)
sl  <- stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
sl  <- sl[!is.na(sl$start) & sl$start <= 2014 & !is.na(sl$end) & sl$end >= 2005, ]
ids <- unique(sl$station_id)
cat(sprintf("hourly stations within 150 km overlapping 2005-2014: %d\n", length(ids)))

all <- list()
for (y in YEARS) {
  w <- try(weather_dl(station_ids = ids, interval = "hour",
                      start = sprintf("%d-05-01", y), end = sprintf("%d-09-30", y)),
           silent = TRUE)
  if (inherits(w, "try-error") || !nrow(w)) { cat(sprintf("  %d unavailable\n", y)); next }
  w <- w |>
    transmute(year = y,
              date = as.Date(date),
              doy  = as.integer(format(as.Date(date), "%j")),
              hour = as.integer(substr(time, 12, 13)),
              temp = temp,
              wind = wind_spd) |>
    filter(!is.na(temp) | !is.na(wind))
  cat(sprintf("  %d: %d hourly records, %d days\n", y, nrow(w), length(unique(w$doy))))
  all[[as.character(y)]] <- w
}
h <- bind_rows(all)
if (!nrow(h)) stop("no hourly records returned")
write.csv(h, file.path(OUT, "hourly_climate.csv"), row.names = FALSE)

## Daily summary, with the two quantities the window turns on: how warm the afternoon gets,
## and what share of afternoon hours actually sit inside the flight envelope.
d <- h |>
  group_by(year, doy) |>
  summarise(
    temp_mean = mean(temp, na.rm = TRUE),
    temp_max  = suppressWarnings(max(temp, na.rm = TRUE)),
    pm_temp   = mean(temp[hour >= HR[1] & hour <= HR[2]], na.rm = TRUE),
    pm_in_gate  = mean(temp[hour >= HR[1] & hour <= HR[2]] >= T_MIN &
                       temp[hour >= HR[1] & hour <= HR[2]] <= T_MAX, na.rm = TRUE),
    pm_in_peak  = mean(temp[hour >= HR[1] & hour <= HR[2]] >= T_PEAK[1] &
                       temp[hour >= HR[1] & hour <= HR[2]] <= T_PEAK[2], na.rm = TRUE),
    wind_mean = mean(wind, na.rm = TRUE),
    pm_wind   = mean(wind[hour >= HR[1] & hour <= HR[2]], na.rm = TRUE),
    .groups = "drop") |>
  mutate(across(where(is.numeric), ~ ifelse(is.finite(.x), .x, NA_real_)))
write.csv(d, file.path(OUT, "daily_climate.csv"), row.names = FALSE)

## The numbers the manuscript can quote about its own window, computed rather than asserted.
wdoy <- function(y) as.integer(format(as.Date(sprintf("%d-%s", y, WIN)), "%j"))
inwin <- d |> rowwise() |> mutate(inw = doy >= wdoy(year)[1] & doy <= wdoy(year)[2]) |> ungroup()
s <- inwin |> group_by(inw) |>
  summarise(days = dplyr::n(),
            pm_temp = mean(pm_temp, na.rm = TRUE),
            pm_in_gate = mean(pm_in_gate, na.rm = TRUE),
            pm_in_peak = mean(pm_in_peak, na.rm = TRUE), .groups = "drop")
cat("\nafternoon hours inside the 19-41 C flight gate:\n")
print(as.data.frame(s), row.names = FALSE, digits = 3)

## in_gate is computed BEFORE the mean that shares its name. summarise() evaluates its
## arguments in order and later ones see the columns the earlier ones created, so
## `mean(temp >= T_MIN)` written after `temp = mean(temp)` tests the single hourly mean
## and returns 0 or 1 rather than a share. The first build of this file did exactly that.
by_hour <- h |> group_by(hour) |>
  summarise(in_gate = mean(temp >= T_MIN & temp <= T_MAX, na.rm = TRUE),
            in_peak = mean(temp >= T_PEAK[1] & temp <= T_PEAK[2], na.rm = TRUE),
            wind    = mean(wind, na.rm = TRUE),
            temp    = mean(temp, na.rm = TRUE),
            .groups = "drop") |>
  filter(!is.na(hour))
write.csv(by_hour, file.path(OUT, "diurnal_climate.csv"), row.names = FALSE)
cat(sprintf("\nwarmest hour of the day: %02d:00 at %.1f C; gate cleared most often at %02d:00\n",
            by_hour$hour[which.max(by_hour$temp)], max(by_hour$temp, na.rm = TRUE),
            by_hour$hour[which.max(by_hour$in_gate)]))
cat(sprintf("wrote %s\n", OUT))
