# Monthly winter climatology for the stations screened in the manuscript
#
# Purpose: the manuscript's temperature argument rested entirely on a single
# number per station-winter, the minimum. A referee assessing whether cold
# limits this insect at elevation needs the shape of the winter as well as its
# floor: how cold the average December is, how far the mean daily minimum sits
# above the absolute minimum, and how those quantities order with elevation.
# This script reduces the cached extracts to one row per station, winter and
# month so the document can draw a climograph and a time series without holding
# the 107 MB cache.
#
# It adds no new retrieval. Everything here comes from the files
# `fetch-station-minima.R` already cached under `raw/`, which cover December,
# January and February only. A full twelve-month climograph is therefore not
# derivable from this cache and is not attempted; the restriction is stated in
# the manuscript rather than hidden by plotting only what is present.
#
# Input:  raw/bcws-winter-<year>.csv   unheaded; 1 station code, 2 name,
#           3 stamp YYYYMMDDHH, 4 hourly precipitation, 5 air temperature (C).
#         raw/eccc-daily-<year>.json   GeoJSON FeatureCollection, daily.
#         station-winter-minima.csv    for station elevation and network.
# Output: station-monthly-climatology.csv
#
# Base R only. Run from this directory.

RAW <- "raw"
OUT <- "station-monthly-climatology.csv"
stopifnot(dir.exists(RAW))

meta <- utils::read.csv("station-winter-minima.csv", stringsAsFactors = FALSE)
elev <- unique(meta[, c("network", "station_id", "station_name", "elevation_m")])
elev$station_id <- as.character(elev$station_id)

# ---------------------------------------------------------------- BCWS hourly
bc <- list()
for (f in list.files(RAW, pattern = "^bcws-winter-\\d+\\.csv$", full.names = TRUE)) {
  d <- utils::read.csv(f, header = FALSE, stringsAsFactors = FALSE,
                       fill = TRUE, na.strings = c("", "NA"))[, 1:5, drop = FALSE]
  names(d) <- c("station_id", "station_name", "stamp", "precip", "temp_c")
  d$station_id <- as.character(d$station_id)
  d$temp_c <- suppressWarnings(as.numeric(d$temp_c))
  d$precip <- suppressWarnings(as.numeric(d$precip))
  # Same range screen as add-minimum-dates.R. Sub-daily spike rejection belongs
  # to the fetch and is not repeated; a monthly mean is insensitive to it and a
  # monthly absolute minimum is reported here as raw, not as the usable minimum.
  d <- d[!is.na(d$temp_c) & d$temp_c > -60 & d$temp_c < 50 & nchar(d$stamp) >= 8, ]
  if (!nrow(d)) next
  d$year  <- as.integer(substr(d$stamp, 1, 4))
  d$month <- as.integer(substr(d$stamp, 5, 6))
  d$day   <- substr(d$stamp, 1, 8)
  bc[[f]] <- d
}
bc <- do.call(rbind, bc)
bc <- bc[bc$month %in% c(12L, 1L, 2L), ]
# A winter labelled Y runs 1 December Y-1 to the end of February Y.
bc$winter_year <- ifelse(bc$month == 12L, bc$year + 1L, bc$year)

# Hourly to daily first, so "mean daily minimum" means what it says.
dkey <- paste(bc$station_id, bc$day, sep = "|")
daily <- data.frame(
  station_id  = tapply(bc$station_id,  dkey, function(x) x[1]),
  winter_year = tapply(bc$winter_year, dkey, function(x) x[1]),
  month       = tapply(bc$month,       dkey, function(x) x[1]),
  tmean = tapply(bc$temp_c, dkey, mean),
  tmin  = tapply(bc$temp_c, dkey, min),
  tmax  = tapply(bc$temp_c, dkey, max),
  precip = tapply(bc$precip, dkey, function(x) if (all(is.na(x))) NA_real_ else sum(x, na.rm = TRUE)),
  stringsAsFactors = FALSE)

mkey <- paste(daily$station_id, daily$winter_year, daily$month, sep = "|")
bcm <- data.frame(
  network     = "BCWS",
  station_id  = tapply(daily$station_id,  mkey, function(x) x[1]),
  winter_year = tapply(daily$winter_year, mkey, function(x) x[1]),
  month       = tapply(daily$month,       mkey, function(x) x[1]),
  n_days           = tapply(daily$tmean, mkey, length),
  mean_temp_c      = round(tapply(daily$tmean, mkey, mean), 2),
  mean_daily_min_c = round(tapply(daily$tmin,  mkey, mean), 2),
  mean_daily_max_c = round(tapply(daily$tmax,  mkey, mean), 2),
  min_temp_c       = round(tapply(daily$tmin,  mkey, min), 2),
  total_precip_mm  = round(tapply(daily$precip, mkey, function(x) sum(x, na.rm = TRUE)), 1),
  stringsAsFactors = FALSE)

# ----------------------------------------------------------------- ECCC daily
ec <- list()
for (f in list.files(RAW, pattern = "^eccc-daily-\\d+\\.json$", full.names = TRUE)) {
  txt <- paste(readLines(f, warn = FALSE), collapse = "")
  if (!nzchar(txt)) next
  # Minimal field extraction, so the script needs no JSON package.
  props <- regmatches(txt, gregexpr('\\{"[^{}]*"STN_ID"[^{}]*\\}', txt))[[1]]
  if (!length(props)) props <- regmatches(txt, gregexpr('"properties":\\{[^{}]*\\}', txt))[[1]]
  if (!length(props)) next
  gv <- function(s, k) {
    m <- regmatches(s, regexpr(sprintf('"%s":\\s*(null|"[^"]*"|-?[0-9.]+)', k), s))
    if (!length(m)) return(NA_character_)
    v <- sub(sprintf('"%s":\\s*', k), "", m)
    if (v == "null") return(NA_character_)
    gsub('^"|"$', "", v)
  }
  ec[[f]] <- data.frame(
    station_id = vapply(props, gv, "", "CLIMATE_IDENTIFIER"),
    year  = as.integer(vapply(props, gv, "", "LOCAL_YEAR")),
    month = as.integer(vapply(props, gv, "", "LOCAL_MONTH")),
    tmean = as.numeric(vapply(props, gv, "", "MEAN_TEMPERATURE")),
    tmin  = as.numeric(vapply(props, gv, "", "MIN_TEMPERATURE")),
    tmax  = as.numeric(vapply(props, gv, "", "MAX_TEMPERATURE")),
    precip = as.numeric(vapply(props, gv, "", "TOTAL_PRECIPITATION")),
    stringsAsFactors = FALSE, row.names = NULL)
}
ec <- do.call(rbind, ec)
ecm <- NULL
if (!is.null(ec) && nrow(ec)) {
  ec <- ec[!is.na(ec$month) & ec$month %in% c(12L, 1L, 2L) & !is.na(ec$tmin), ]
  ec$winter_year <- ifelse(ec$month == 12L, ec$year + 1L, ec$year)
  k <- paste(ec$station_id, ec$winter_year, ec$month, sep = "|")
  ecm <- data.frame(
    network     = "ECCC",
    station_id  = tapply(ec$station_id,  k, function(x) x[1]),
    winter_year = tapply(ec$winter_year, k, function(x) x[1]),
    month       = tapply(ec$month,       k, function(x) x[1]),
    n_days           = tapply(ec$tmin, k, length),
    mean_temp_c      = round(tapply(ec$tmean, k, function(x) mean(x, na.rm = TRUE)), 2),
    mean_daily_min_c = round(tapply(ec$tmin,  k, function(x) mean(x, na.rm = TRUE)), 2),
    mean_daily_max_c = round(tapply(ec$tmax,  k, function(x) mean(x, na.rm = TRUE)), 2),
    min_temp_c       = round(tapply(ec$tmin,  k, function(x) min(x, na.rm = TRUE)), 2),
    total_precip_mm  = round(tapply(ec$precip, k, function(x) sum(x, na.rm = TRUE)), 1),
    stringsAsFactors = FALSE)
}

# --------------------------------------------------- warm sensor-failure screen
# The retrieval screen inspects only the minimum, so a sensor that fails *warm*
# passes through it invisibly and contributes a spuriously mild minimum to the
# record. NORNS, the highest station in the network at 2,423 m, did exactly this
# through 2015, returning a February mean daily minimum of +30.0 C and a winter
# "minimum" of +4.6 C. The bias runs in the direction that flatters the
# conclusion that the landscape never gets cold enough, so the screen is applied
# here and its effect is reported rather than absorbed.
#
# The cut is read off the data, not assumed. Across station-months of 20 days or
# more, the 99th percentile of the mean daily minimum is +0.3 C and the highest
# credible value is +1.2 C, while the rejected months run from +10.8 to +30.1 C.
# A cut at +5 C sits inside that gap in every direction.
WARM_CUT <- 5
z <- rbind(bcm, ecm)
z$warm_fail <- !is.na(z$mean_daily_min_c) & z$mean_daily_min_c > WARM_CUT
z$short     <- z$n_days < 20
z <- merge(z, elev[, c("network", "station_id", "station_name", "elevation_m")],
           by = c("network", "station_id"), all.x = TRUE)
z <- z[!is.na(z$elevation_m), ]
z <- z[order(z$network, z$station_name, z$winter_year, z$month), ]
row.names(z) <- NULL

utils::write.csv(z, OUT, row.names = FALSE)
cat(sprintf("wrote %s: %d station-months, %d stations, winters %d to %d\n",
            OUT, nrow(z), length(unique(paste(z$network, z$station_id))),
            min(z$winter_year), max(z$winter_year)))
cat("months present:\n"); print(table(z$month))
cat("by network:\n"); print(table(z$network))
cat(sprintf("warm sensor failures flagged: %d station-months\n", sum(z$warm_fail)))
if (any(z$warm_fail)) print(z[z$warm_fail, c("station_name","elevation_m","winter_year","month","mean_daily_min_c","min_temp_c")])
cat(sprintf("months shorter than 20 days: %d\n", sum(z$short)))
