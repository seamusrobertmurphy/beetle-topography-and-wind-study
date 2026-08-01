#!/usr/bin/env Rscript
# ---------------------------------------------------------------------------
# Observed winter minimum air temperature near the Darkwoods Conservation Area
#
# Purpose: test one claim only. Do winter minima on this landscape reach the
# classical lethal threshold for mountain pine beetle larvae, near -40 C?
#
# Two networks are queried.
#
#   1. BC Wildfire Service hourly weather stations. This is the only regional
#      network with real vertical spread, 630 to 2,423 m.
#        stations: WFS, WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP
#        hourly:   https://www.for.gov.bc.ca/ftp/HPR/external/!publish/
#                  BCWS_DATA_MART/<year>/<year>_BCWS_WX_OBS.csv
#      Files are 100 to 210 MB per year, so each is streamed through curl and
#      filtered to the station subset and to winter dates before it touches
#      disk. Only the filtered extract is cached.
#
#   2. Environment and Climate Change Canada daily climate, OGC API at
#      api.weather.gc.ca, collections climate-stations and climate-daily.
#      Lowland context only. No ECCC station above 1,200 m within 150 km
#      reported during 1999 to 2015.
#
# Censoring trap, honoured explicitly. A large share of BCWS temperature
# sensors are clipped at exactly -20.0 C before roughly 2008. A station-winter
# whose minimum is exactly -20.0 with a pile-up of observations at that value
# is a sensor floor, not a measurement. Such rows are flagged and their
# minimum is withheld from the usable column. Nothing is silently minimised
# over censored data.
#
# Idempotent. Cached extracts under raw/ are reused; delete them or set
# REFRESH <- TRUE to re-download. Runtime on a cold cache is roughly 10
# minutes, dominated by streaming about 2.7 GB through the filter.
#
# Written for base R 4.4.1 plus jsonlite. curl and awk are called through a
# pipe because streaming a 200 MB CSV through an R text connection is far
# slower than letting curl and awk do it.
#
# Usage:  /usr/local/bin/Rscript 02.inputs/climate/fetch-station-minima.R
# ---------------------------------------------------------------------------

# ------------------------------ configuration ------------------------------

# Study area, decimal degrees. South Selkirk Mountains, southeastern BC.
STUDY_BBOX <- c(lon_min = -117.30, lat_min = 49.20,
                lon_max = -117.00, lat_max = 49.50)
CENTROID   <- c(lon = -117.15, lat = 49.35)

# Search radius for BCWS stations, kilometres from the centroid. The study
# bounding box itself contains no BCWS station, so the radius has to be wide
# enough to pick up the vertical spread of the surrounding massifs.
BCWS_RADIUS_KM <- 100

# ECCC context box, degrees. Wider than the study box because every ECCC
# station inside the study box died before the analysis window opened.
ECCC_BBOX <- c(lon_min = -117.85, lat_min = 48.90,
               lon_max = -116.45, lat_max = 49.80)

# Analysis window. A winter labelled Y runs from 1 December Y-1 to the end of
# February Y, so the file for year YEAR_MIN - 1 is also required.
YEAR_MIN <- 1999
YEAR_MAX <- 2015
WINTER_MONTHS <- c(12L, 1L, 2L)

# The sensor floor to detect. Value is exact, in degrees Celsius.
CENSOR_VALUE <- -20.0

# Isolated-spike rejection, degrees Celsius. A reading colder than both of its
# immediate neighbours by more than this is a transcription or instrument
# fault, not weather: air temperature cannot fall and recover by that much
# between adjacent hours or adjacent days. The rule exists because the ECCC
# daily archive contains an unflagged -40.0 C at NELSON NE on 7 February 2014,
# on a day whose maximum was -4.5 C and whose neighbours were -13.5 and
# -10.5 C. That single value is the only figure in either network that reaches
# the classical beetle lethal threshold, so it must not be swallowed by a
# bare min().
SPIKE_THRESHOLD_C <- 15.0

# Set TRUE to ignore the cache and re-download everything.
REFRESH <- FALSE

RETRIEVAL_DATE <- "2026-08-01"

# Endpoints.
URL_BCWS_STATIONS <- paste0(
  "https://openmaps.gov.bc.ca/geo/pub/",
  "WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP/ows",
  "?service=WFS&version=2.0.0&request=GetFeature",
  "&typeName=pub:WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP",
  "&outputFormat=application/json&srsName=EPSG:4326")
URL_BCWS_OBS_FMT <- paste0(
  "https://www.for.gov.bc.ca/ftp/HPR/external/!publish/BCWS_DATA_MART/",
  "%d/%d_BCWS_WX_OBS.csv")
URL_ECCC <- "https://api.weather.gc.ca/collections"

# Paths, resolved relative to this script so it runs from anywhere.
script_path <- local({
  a <- commandArgs(trailingOnly = FALSE)
  f <- sub("^--file=", "", a[grep("^--file=", a)])
  if (length(f)) normalizePath(f) else
    file.path(getwd(), "02.inputs/climate/fetch-station-minima.R")
})
OUT_DIR   <- dirname(script_path)
CACHE_DIR <- file.path(OUT_DIR, "raw")
OUT_CSV   <- file.path(OUT_DIR, "station-winter-minima.csv")
dir.create(CACHE_DIR, showWarnings = FALSE, recursive = TRUE)

if (!requireNamespace("jsonlite", quietly = TRUE))
  stop("jsonlite is required. install.packages('jsonlite')")

say <- function(...) cat(sprintf(...), "\n", sep = "")

# Distance in km on a local flat approximation. Good to well under a per cent
# over the tens of kilometres used here, and avoids a package dependency.
km_from <- function(lon, lat, origin = CENTROID) {
  dx <- (lon - origin[["lon"]]) * 111.320 * cos(origin[["lat"]] * pi / 180)
  dy <- (lat - origin[["lat"]]) * 111.320
  sqrt(dx * dx + dy * dy)
}

# Download to a temporary file and rename on success, so a killed or failed
# transfer can never leave a truncated cache file behind.
fetch_to_file <- function(url, dest, extra = character()) {
  tmp <- paste0(dest, ".tmp")
  on.exit(unlink(tmp), add = TRUE)
  st <- suppressWarnings(system2(
    "curl", c("-sS", "--fail", "--retry", "3", "--retry-delay", "5",
              "--max-time", "3600", extra, shQuote(url), "-o", shQuote(tmp)),
    stdout = TRUE, stderr = TRUE))
  ok <- is.null(attr(st, "status")) && file.exists(tmp) && file.size(tmp) > 0
  if (!ok) {
    say("  FAILED: %s", url)
    if (length(st)) say("  curl said: %s", paste(st, collapse = " "))
    return(FALSE)
  }
  file.rename(tmp, dest)
  TRUE
}

# ------------------------ 1. BCWS station inventory ------------------------

say("[1] BCWS station inventory")
stn_json <- file.path(CACHE_DIR, "bcws-stations.json")
if (REFRESH || !file.exists(stn_json))
  if (!fetch_to_file(URL_BCWS_STATIONS, stn_json))
    stop("BCWS station inventory unreachable; cannot proceed.")

sj <- jsonlite::fromJSON(stn_json, simplifyVector = TRUE)
bcws_all <- sj$features$properties[, c("STATION_CODE", "STATION_NAME",
                                       "LATITUDE", "LONGITUDE", "ELEVATION",
                                       "INSTALL_DATE")]
bcws_all$dist_km <- km_from(bcws_all$LONGITUDE, bcws_all$LATITUDE)
bcws <- bcws_all[!is.na(bcws_all$dist_km) & bcws_all$dist_km <= BCWS_RADIUS_KM, ]
bcws <- bcws[order(bcws$dist_km), ]
say("  %d stations province-wide, %d within %d km, elevation %d to %d m",
    nrow(bcws_all), nrow(bcws), BCWS_RADIUS_KM,
    min(bcws$ELEVATION, na.rm = TRUE), max(bcws$ELEVATION, na.rm = TRUE))

codes <- unique(as.character(bcws$STATION_CODE))

# awk filter. Field 1 is the quoted station code. The second test is a regex
# over the whole line rather than a fixed field, so a station name containing
# a comma cannot shift the date out from under it.
month_re <- paste(sprintf("%02d", WINTER_MONTHS), collapse = "|")
awk_prog <- sprintf(
  '$1 ~ /^"(%s)"$/ && $0 ~ /"[0-9][0-9][0-9][0-9](%s)[0-9][0-9][0-9][0-9]"/',
  paste(codes, collapse = "|"), month_re)

# ---------------------- 2. BCWS hourly winter extracts ---------------------

say("[2] BCWS hourly observations, %d to %d", YEAR_MIN - 1L, YEAR_MAX)
bcws_years <- (YEAR_MIN - 1L):YEAR_MAX
failed_years <- integer(0)

for (y in bcws_years) {
  dest <- file.path(CACHE_DIR, sprintf("bcws-winter-%d.csv", y))
  if (!REFRESH && file.exists(dest)) { say("  %d cached", y); next }
  url <- sprintf(URL_BCWS_OBS_FMT, y, y)
  tmp <- paste0(dest, ".tmp")
  cmd <- sprintf("curl -sS --fail --retry 3 --retry-delay 5 --max-time 3600 %s | awk -F, %s > %s",
                 shQuote(url), shQuote(awk_prog), shQuote(tmp))
  t0 <- Sys.time()
  st <- system(cmd)
  ok <- st == 0L && file.exists(tmp) && file.size(tmp) > 0
  if (!ok) {
    unlink(tmp); failed_years <- c(failed_years, y)
    say("  %d FAILED (exit %d). Recorded, continuing.", y, st)
    next
  }
  file.rename(tmp, dest)
  say("  %d ok, %.0f s, %.1f MB extract", y,
      as.numeric(difftime(Sys.time(), t0, units = "secs")),
      file.size(dest) / 1e6)
}
if (length(failed_years))
  say("  years not retrieved: %s", paste(failed_years, collapse = ", "))

# Column order of the first five fields is stable across 1997 to 2015:
# STATION_CODE, STATION_NAME, DATE_TIME, HOURLY_PRECIPITATION,
# HOURLY_TEMPERATURE. The trailing field count varies by year, so only the
# first five are kept.
read_extract <- function(f) {
  if (!file.exists(f) || file.size(f) == 0) return(NULL)
  d <- utils::read.csv(f, header = FALSE, stringsAsFactors = FALSE,
                       fill = TRUE, na.strings = c("", "NA"))
  d <- d[, 1:5, drop = FALSE]
  names(d) <- c("station_code", "station_name", "date_time",
                "precip", "temp_c")
  d$station_code <- as.character(d$station_code)
  d$date_time    <- as.character(d$date_time)
  d$temp_c       <- suppressWarnings(as.numeric(d$temp_c))
  d$obs_year     <- as.integer(substr(d$date_time, 1, 4))
  d$obs_month    <- as.integer(substr(d$date_time, 5, 6))
  d$obs_date     <- as.Date(substr(d$date_time, 1, 8), format = "%Y%m%d")
  d[!is.na(d$temp_c) & !is.na(d$obs_month), ]
}

obs <- do.call(rbind, lapply(
  file.path(CACHE_DIR, sprintf("bcws-winter-%d.csv", bcws_years)), read_extract))
if (is.null(obs) || !nrow(obs))
  stop("No BCWS observations were retrieved. Refusing to write an empty cache.")

# December belongs to the following winter.
obs$winter_year <- ifelse(obs$obs_month == 12L, obs$obs_year + 1L, obs$obs_year)
obs <- obs[obs$winter_year >= YEAR_MIN & obs$winter_year <= YEAR_MAX, ]
say("  %s winter hourly observations in window", format(nrow(obs), big.mark = ","))

# --------------------------- 3. Station-winter summary ---------------------

eps <- 1e-6

# Isolated cold spike: colder than both immediate neighbours by more than
# SPIKE_THRESHOLD_C, with both neighbours no more than max_gap time steps
# away so that a data gap is never mistaken for a spike. Series must be
# sorted in time. `step` is the time index, hours for BCWS, days for ECCC.
mark_spikes <- function(temp, step, max_gap) {
  n <- length(temp)
  if (n < 3L) return(rep(FALSE, n))
  prev <- c(NA_real_, temp[-n]);  nxt <- c(temp[-1], NA_real_)
  gp   <- c(NA_real_, diff(step)); gn <- c(diff(step), NA_real_)
  s <- !is.na(prev) & !is.na(nxt) & gp <= max_gap & gn <= max_gap &
       temp < pmin(prev, nxt) - SPIKE_THRESHOLD_C
  s[is.na(s)] <- FALSE
  s
}

summarise_group <- function(d) {
  d <- d[order(d$step), ]
  t <- d$temp_c
  sp <- mark_spikes(t, d$step, max_gap = d$max_gap[1])
  keep <- t[!sp]
  data.frame(
    n_obs                 = length(t),
    min_temp_c            = min(t),
    n_spike_rejected      = sum(sp),
    min_temp_c_despiked   = if (length(keep)) min(keep) else NA_real_,
    n_at_censor_value     = sum(abs(t - CENSOR_VALUE) < eps),
    n_just_below_censor   = sum(t < CENSOR_VALUE - eps & t >= CENSOR_VALUE - 1),
    n_below_censor        = sum(t < CENSOR_VALUE - eps),
    first_obs             = as.character(min(d$obs_date)),
    last_obs              = as.character(max(d$obs_date)),
    stringsAsFactors      = FALSE)
}

obs$step <- as.numeric(as.POSIXct(
  paste0(substr(obs$date_time, 1, 8), " ", substr(obs$date_time, 9, 10),
         ":00:00"), tz = "UTC", format = "%Y%m%d %H:%M:%S")) / 3600
obs$max_gap <- 2                       # hours, for the spike test

key <- interaction(obs$station_code, obs$winter_year, drop = TRUE)
parts <- split(obs, key)
sm <- do.call(rbind, lapply(parts, summarise_group))
ids <- do.call(rbind, lapply(parts, function(d)
  data.frame(station_code = d$station_code[1], winter_year = d$winter_year[1],
             stringsAsFactors = FALSE)))
bc <- cbind(ids, sm, row.names = NULL)

# The censoring rule, stated once and applied once.
#   censored  the winter minimum is exactly the sensor floor. The true
#             minimum is unknown and cannot be less than what is reported.
#   suspect   a pile-up sits at the floor but colder values were also
#             recorded, so the sensor was clipped part of the winter.
bc$censored_flag <- abs(bc$min_temp_c - CENSOR_VALUE) < eps &
                    bc$n_at_censor_value > 0
bc$suspect_flag  <- !bc$censored_flag & bc$n_at_censor_value > 0 &
                    bc$n_at_censor_value > pmax(3 * bc$n_just_below_censor, 5)
bc$min_temp_c_usable <- ifelse(bc$censored_flag, NA_real_,
                               bc$min_temp_c_despiked)

# Audit trail for the hourly spikes, same rule as the daily one below.
bcws_spike_log <- do.call(rbind, lapply(parts, function(d) {
  d <- d[order(d$step), ]
  s <- mark_spikes(d$temp_c, d$step, max_gap = d$max_gap[1])
  if (!any(s)) return(NULL)
  i <- which(s)
  data.frame(network = "BCWS", station_name = d$station_name[i],
             station_id = d$station_code[i],
             date = d$date_time[i], rejected_min_c = d$temp_c[i],
             prev_hour_c = d$temp_c[i - 1], next_hour_c = d$temp_c[i + 1],
             stringsAsFactors = FALSE)
}))

m <- match(bc$station_code, as.character(bcws$STATION_CODE))
out_bc <- data.frame(
  network          = "BCWS",
  station_id       = bc$station_code,
  station_name     = bcws$STATION_NAME[m],
  latitude         = bcws$LATITUDE[m],
  longitude        = bcws$LONGITUDE[m],
  elevation_m      = bcws$ELEVATION[m],
  dist_km_centroid = round(bcws$dist_km[m], 1),
  install_date     = bcws$INSTALL_DATE[m],
  winter_year      = bc$winter_year,
  winter_period    = sprintf("%s to %s", bc$first_obs, bc$last_obs),
  n_obs            = bc$n_obs,
  obs_interval     = "hourly",
  min_temp_c       = bc$min_temp_c,
  n_spike_rejected = bc$n_spike_rejected,
  n_at_minus20     = bc$n_at_censor_value,
  n_just_below_minus20 = bc$n_just_below_censor,
  n_below_minus20  = bc$n_below_censor,
  censored_flag    = bc$censored_flag,
  suspect_flag     = bc$suspect_flag,
  min_temp_c_usable = bc$min_temp_c_usable,
  stringsAsFactors = FALSE)

# ------------------------ 4. ECCC lowland daily context --------------------

say("[3] ECCC daily climate, lowland context")
ec_stn <- file.path(CACHE_DIR, "eccc-stations.json")
ec_url <- sprintf("%s/climate-stations/items?bbox=%s&limit=2000&f=json",
                  URL_ECCC, paste(ECCC_BBOX[c("lon_min", "lat_min",
                                              "lon_max", "lat_max")],
                                  collapse = ","))
out_ec <- NULL
spike_log <- NULL
if (REFRESH || !file.exists(ec_stn)) invisible(fetch_to_file(ec_url, ec_stn))

if (file.exists(ec_stn)) {
  ej <- jsonlite::fromJSON(ec_stn, simplifyVector = TRUE)
  ep <- ej$features$properties
  ep$ELEVATION <- suppressWarnings(as.numeric(ep$ELEVATION))
  ep$lon <- ej$features$geometry$coordinates |> vapply(function(z) z[1], 0)
  ep$lat <- ej$features$geometry$coordinates |> vapply(function(z) z[2], 0)
  say("  %d ECCC stations in context box, elevation %.0f to %.0f m",
      nrow(ep), min(ep$ELEVATION, na.rm = TRUE), max(ep$ELEVATION, na.rm = TRUE))

  ec_rows <- list()
  for (wy in YEAR_MIN:YEAR_MAX) {
    dest <- file.path(CACHE_DIR, sprintf("eccc-daily-%d.json", wy))
    if (REFRESH || !file.exists(dest)) {
      u <- sprintf(paste0("%s/climate-daily/items?bbox=%s",
                          "&datetime=%d-12-01%%2000:00:00/%d-02-28%%2000:00:00",
                          "&limit=10000&f=json"),
                   URL_ECCC,
                   paste(ECCC_BBOX[c("lon_min", "lat_min",
                                     "lon_max", "lat_max")], collapse = ","),
                   wy - 1L, wy)
      if (!fetch_to_file(u, dest)) { say("  winter %d not retrieved", wy); next }
    }
    dj <- try(jsonlite::fromJSON(dest, simplifyVector = TRUE), silent = TRUE)
    if (inherits(dj, "try-error") || is.null(dj$features) ||
        !length(dj$features)) next
    pp <- dj$features$properties
    pp$MIN_TEMPERATURE <- suppressWarnings(as.numeric(pp$MIN_TEMPERATURE))
    pp <- pp[!is.na(pp$MIN_TEMPERATURE), , drop = FALSE]
    if (!nrow(pp)) next
    pp$winter_year <- wy
    pp$MAX_TEMPERATURE <- suppressWarnings(as.numeric(pp$MAX_TEMPERATURE))
    ec_rows[[length(ec_rows) + 1L]] <- pp[, c("CLIMATE_IDENTIFIER",
                                              "STATION_NAME", "LOCAL_DATE",
                                              "MIN_TEMPERATURE",
                                              "MAX_TEMPERATURE",
                                              "MIN_TEMPERATURE_FLAG",
                                              "winter_year")]
  }

  if (length(ec_rows)) {
    ed <- do.call(rbind, ec_rows)
    ed$obs_date <- as.Date(substr(ed$LOCAL_DATE, 1, 10))
    ed$step <- as.numeric(ed$obs_date)
    k <- interaction(ed$CLIMATE_IDENTIFIER, ed$winter_year, drop = TRUE)
    ps <- split(ed, k)

    # Same spike rule as BCWS, on a daily step. Log every rejection with its
    # context so the decision is auditable rather than silent.
    sl <- lapply(ps, function(d) {
      d <- d[order(d$step), ]
      s <- mark_spikes(d$MIN_TEMPERATURE, d$step, max_gap = 2)
      if (!any(s)) return(NULL)
      i <- which(s)
      data.frame(network = "ECCC", station_name = d$STATION_NAME[i],
                 station_id = d$CLIMATE_IDENTIFIER[i],
                 date = as.character(d$obs_date[i]),
                 rejected_min_c = d$MIN_TEMPERATURE[i],
                 same_day_max_c = d$MAX_TEMPERATURE[i],
                 prev_day_min_c = d$MIN_TEMPERATURE[i - 1],
                 next_day_min_c = d$MIN_TEMPERATURE[i + 1],
                 qc_flag = ifelse(is.na(d$MIN_TEMPERATURE_FLAG[i]), "none",
                                  d$MIN_TEMPERATURE_FLAG[i]),
                 stringsAsFactors = FALSE)
    })
    spike_log <- do.call(rbind, sl)

    es <- do.call(rbind, lapply(ps, function(d) {
      d <- d[order(d$step), ]
      sp <- mark_spikes(d$MIN_TEMPERATURE, d$step, max_gap = 2)
      data.frame(
      climate_id   = d$CLIMATE_IDENTIFIER[1],
      station_name = d$STATION_NAME[1],
      winter_year  = d$winter_year[1],
      n_obs        = nrow(d),
      min_temp_c   = min(d$MIN_TEMPERATURE),
      n_spike_rejected = sum(sp),
      min_temp_c_despiked = if (any(!sp)) min(d$MIN_TEMPERATURE[!sp]) else NA_real_,
      n_at_minus20 = sum(abs(d$MIN_TEMPERATURE - CENSOR_VALUE) < eps),
      n_just_below_minus20 = sum(d$MIN_TEMPERATURE < CENSOR_VALUE - eps &
                                 d$MIN_TEMPERATURE >= CENSOR_VALUE - 1),
      n_below_minus20 = sum(d$MIN_TEMPERATURE < CENSOR_VALUE - eps),
      first_obs = as.character(min(d$obs_date)),
      last_obs  = as.character(max(d$obs_date)),
      stringsAsFactors = FALSE)}))
    me <- match(es$climate_id, ep$CLIMATE_IDENTIFIER)
    out_ec <- data.frame(
      network          = "ECCC",
      station_id       = es$climate_id,
      station_name     = es$station_name,
      latitude         = ep$lat[me],
      longitude        = ep$lon[me],
      elevation_m      = ep$ELEVATION[me],
      dist_km_centroid = round(km_from(ep$lon[me], ep$lat[me]), 1),
      install_date     = ep$FIRST_DATE[me],
      winter_year      = es$winter_year,
      winter_period    = sprintf("%s to %s", es$first_obs, es$last_obs),
      n_obs            = es$n_obs,
      obs_interval     = "daily",
      min_temp_c       = es$min_temp_c,
      n_spike_rejected = es$n_spike_rejected,
      n_at_minus20     = es$n_at_minus20,
      n_just_below_minus20 = es$n_just_below_minus20,
      n_below_minus20  = es$n_below_minus20,
      censored_flag    = FALSE,
      suspect_flag     = FALSE,
      min_temp_c_usable = es$min_temp_c_despiked,
      stringsAsFactors = FALSE, row.names = NULL)
    say("  %d ECCC station-winters", nrow(out_ec))
  } else {
    say("  no ECCC daily minima retrieved for the window")
  }
}

# ------------------------------- 5. Write out ------------------------------

out <- if (is.null(out_ec)) out_bc else rbind(out_bc, out_ec)
out <- out[order(out$network, -out$elevation_m, out$winter_year), ]
if (!nrow(out)) stop("Nothing to write. Refusing to create an empty cache.")
utils::write.csv(out, OUT_CSV, row.names = FALSE, na = "")
say("[4] wrote %s, %d rows", OUT_CSV, nrow(out))

# ----------------------------- 6. Console summary --------------------------
# Every number quoted in the manuscript must come from here, not from an
# ad hoc terminal snippet.

say("")
say("--- summary, retrieval %s ---", RETRIEVAL_DATE)
b <- out[out$network == "BCWS", ]
say("BCWS station-winters: %d, over %d stations, %d to %d m",
    nrow(b), length(unique(b$station_id)),
    min(b$elevation_m), max(b$elevation_m))
silent <- bcws[!as.character(bcws$STATION_CODE) %in% b$station_id, ]
if (nrow(silent))
  say("in radius but no winter data in the window: %s",
      paste(sprintf("%s (%d m, installed %s)", silent$STATION_NAME,
                    silent$ELEVATION, substr(silent$INSTALL_DATE, 1, 10)),
            collapse = "; "))
say("censored at exactly %.1f C (minimum is the sensor floor): %d station-winters, %d stations",
    CENSOR_VALUE, sum(b$censored_flag), length(unique(b$station_id[b$censored_flag])))
say("suspect pile-up at %.1f C but colder values present: %d station-winters",
    CENSOR_VALUE, sum(b$suspect_flag))
say("censored share by winter:")
tb <- table(b$winter_year, b$censored_flag)
for (i in rownames(tb))
  say("  %s  %d of %d censored", i,
      if ("TRUE" %in% colnames(tb)) tb[i, "TRUE"] else 0L, sum(tb[i, ]))
u <- b[!is.na(b$min_temp_c_usable), ]
pre <- b$winter_year < 2008
say("censoring is concentrated before 2008: %d of %d station-winters censored before, %d of %d after",
    sum(b$censored_flag & pre), sum(pre),
    sum(b$censored_flag & !pre), sum(!pre))
say("hourly observations discarded with those station-winters: %s of %s",
    format(sum(b$n_obs[b$censored_flag]), big.mark = ","),
    format(sum(b$n_obs), big.mark = ","))
say("hourly observations reporting exactly %.1f C: %s",
    CENSOR_VALUE, format(sum(b$n_at_minus20), big.mark = ","))
say("usable BCWS station-winters: %d", nrow(u))
if (!is.null(bcws_spike_log) && nrow(bcws_spike_log)) {
  say("rejected isolated hourly cold spikes, %d:", nrow(bcws_spike_log))
  for (i in seq_len(nrow(bcws_spike_log))) {
    r <- bcws_spike_log[i, ]
    say("  %s %s: %.1f C, adjacent hours %.1f and %.1f C",
        r$station_name, r$date, r$rejected_min_c, r$prev_hour_c, r$next_hour_c)
  }
}
say("coldest usable BCWS winter minimum: %.1f C at %s (%.0f m), winter %d",
    min(u$min_temp_c_usable),
    u$station_name[which.min(u$min_temp_c_usable)],
    u$elevation_m[which.min(u$min_temp_c_usable)],
    u$winter_year[which.min(u$min_temp_c_usable)])
say("station-winters at or below -40.0 C: %d", sum(u$min_temp_c_usable <= -40))
say("station-winters at or below -35.0 C: %d", sum(u$min_temp_c_usable <= -35))
hi <- u[u$elevation_m >= 1500, ]
if (nrow(hi))
  say("stations at or above 1500 m: %d station-winters, coldest %.1f C, mean %.1f C",
      nrow(hi), min(hi$min_temp_c_usable), mean(hi$min_temp_c_usable))
say("coldest usable minimum per station:")
for (s in unique(u$station_id[order(-u$elevation_m)])) {
  v <- u[u$station_id == s, ]
  say("  %-20s %5.0f m  n=%2d winters  coldest %6.1f C  median %6.1f C",
      v$station_name[1], v$elevation_m[1], nrow(v),
      min(v$min_temp_c_usable), median(v$min_temp_c_usable))
}
e <- out[out$network == "ECCC", ]
if (nrow(e)) {
  say("ECCC lowland context: %d station-winters, %d stations, %.0f to %.0f m",
      nrow(e), length(unique(e$station_id)),
      min(e$elevation_m, na.rm = TRUE), max(e$elevation_m, na.rm = TRUE))
  say("  coldest raw %.1f C, coldest after spike rejection %.1f C",
      min(e$min_temp_c, na.rm = TRUE), min(e$min_temp_c_usable, na.rm = TRUE))
}
if (!is.null(spike_log) && nrow(spike_log)) {
  say("rejected isolated cold spikes, %d:", nrow(spike_log))
  for (i in seq_len(nrow(spike_log))) {
    r <- spike_log[i, ]
    say("  %s %s: %.1f C, same-day max %.1f C, neighbours %.1f and %.1f C, QC flag %s",
        r$station_name, r$date, r$rejected_min_c, r$same_day_max_c,
        r$prev_day_min_c, r$next_day_min_c, r$qc_flag)
  }
}
allu <- out[!is.na(out$min_temp_c_usable), ]
say("BOTH NETWORKS, station-winters reaching -40.0 C after QC: %d of %d",
    sum(allu$min_temp_c_usable <= -40), nrow(allu))
say("BOTH NETWORKS, coldest defensible winter minimum: %.1f C",
    min(allu$min_temp_c_usable))
if (length(failed_years))
  say("NOT RETRIEVED, BCWS years: %s", paste(failed_years, collapse = ", "))
say("DARKWOODS station install date: %s. It covers almost none of the window.",
    bcws$INSTALL_DATE[bcws$STATION_NAME == "DARKWOODS"][1])
