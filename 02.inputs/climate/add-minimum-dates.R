# Date of the winter minimum for each BC Wildfire Service station-winter
#
# Purpose: the manuscript's cold check compares observed minima against lethal
# temperatures. Lethal temperature for this insect is not a constant. It depends
# on when in the winter the minimum arrives, because cold-hardiness is acquired
# by accumulating glycerol through autumn and lost again in late winter
# (Safranyik and Carroll 2006, p. 24). A minimum needs a date before it can be
# compared with a lethal threshold.
#
# `fetch-station-minima.R` reduces the hourly series to one row per
# station-winter and does not carry the timestamp of the minimum. Rather than
# re-stream 2.7 GB to add one column, this script reads the winter extracts that
# fetch script already cached under `raw/` and writes the dates alongside.
#
# Runs outside the render for the same reason the fetch does: it reads a 107 MB
# cache the document should not have to hold. Its output is small and is
# committed.
#
# Input:  raw/bcws-winter-<year>.csv, the cached hourly winter extracts.
#         Columns are unheaded; 1 station id, 2 name, 3 stamp YYYYMMDDHH,
#         5 air temperature in degrees Celsius.
# Output: station-winter-minimum-dates.csv
#
# Base R only. Run from this directory.

RAW <- "raw"
OUT <- "station-winter-minimum-dates.csv"

files <- list.files(RAW, pattern = "^bcws-winter-\\d+\\.csv$", full.names = TRUE)
stopifnot(length(files) > 0)

acc <- list()
for (f in files) {
  d <- utils::read.csv(f, header = FALSE, colClasses = "character")
  if (!nrow(d)) next
  temp  <- suppressWarnings(as.numeric(d[[5]]))
  stamp <- d[[3]]
  # A plain range screen. Sub-daily spike rejection is the fetch script's job and
  # is not repeated here; this file supplies dates, not a second usable minimum.
  ok <- !is.na(temp) & temp > -60 & temp < 50 & nchar(stamp) >= 8
  d <- d[ok, ]; temp <- temp[ok]; stamp <- stamp[ok]
  year  <- as.integer(substr(stamp, 1, 4))
  month <- as.integer(substr(stamp, 5, 6))
  # A winter labelled Y runs 1 December Y-1 to the end of February Y, matching
  # the convention in fetch-station-minima.R.
  winter <- ifelse(month == 12L, year + 1L, year)
  key <- paste(d[[1]], winter, sep = "|")
  i   <- tapply(seq_along(temp), key, function(ix) ix[which.min(temp[ix])])
  acc[[f]] <- data.frame(
    station_id  = d[[1]][unlist(i)],
    station_name = d[[2]][unlist(i)],
    winter_year = winter[unlist(i)],
    min_temp_c  = temp[unlist(i)],
    min_date    = as.Date(substr(stamp[unlist(i)], 1, 8), format = "%Y%m%d"),
    min_month   = month[unlist(i)],
    stringsAsFactors = FALSE)
}
z <- do.call(rbind, acc)

# One file can hold both December and January of the same winter, so reduce again
# across files before writing.
k <- paste(z$station_id, z$winter_year, sep = "|")
z <- z[unlist(tapply(seq_len(nrow(z)), k, function(ix) ix[which.min(z$min_temp_c[ix])])), ]
z <- z[order(z$station_name, z$winter_year), ]

utils::write.csv(z, OUT, row.names = FALSE)
cat(sprintf("wrote %s: %d station-winters, %d stations\n",
            OUT, nrow(z), length(unique(z$station_id))))
cat("month of minimum:\n"); print(table(z$min_month))
