#!/usr/bin/env Rscript
## Moderate-to-high beetle disturbance at 16-day resolution.
##
## The annual maps collapse a growing season into one observation, which leaves eight
## points in time and makes any wind test a comparison between summers. Landsat repeats
## every 16 days, so this rebuilds the response at that cadence from the cube written by
## 42-cube-grid-ee.R: nine epochs a year from 1 May, 2005 to 2014 excluding 2012.
##
## The classification rule is the one already used for the annual maps, applied epoch by
## epoch rather than to a season median. Severity was cut from the drop in growing-season
## NDMI against 2005, unaffected above -0.05 and the attacked remainder split at -0.1304
## and -0.0804, so moderate-or-high is a drop of -0.0804 or deeper. Keeping the same
## threshold is what makes the 16-day series comparable to the annual one rather than a
## different measurement wearing the same name.
##
## The baseline is epoch-matched: epoch 5 of 2009 is differenced against epoch 5 of 2005,
## not against a season median. Phenology moves NDMI through the summer by more than the
## attack threshold, so differencing against the wrong part of the year manufactures
## attack in spring and hides it in late summer.

suppressPackageStartupMessages(library(terra))
ROOT <- "02.inputs/beetle"
CUBE <- file.path(ROOT, "cube-16day")
OUT  <- file.path(ROOT, "epoch-response"); dir.create(OUT, showWarnings = FALSE)
YEARS <- c(2006:2011, 2013, 2014)
NEPOCH <- 9L
THRESH <- -0.0804

msk <- rast(file.path(ROOT, "study-area", "perimeter_mask.tif"))
base <- list()
for (e in seq_len(NEPOCH)) {
  f <- file.path(CUBE, sprintf("ndmi_2005_e%02d.tif", e))
  base[[e]] <- if (file.exists(f)) rast(f) else NULL
}
cat(sprintf("baseline epochs available: %d of %d\n", sum(!sapply(base, is.null)), NEPOCH))

rows <- list()
for (y in YEARS) for (e in seq_len(NEPOCH)) {
  f <- file.path(CUBE, sprintf("ndmi_%d_e%02d.tif", y, e))
  if (!file.exists(f) || is.null(base[[e]])) next
  d <- rast(f) - base[[e]]
  b <- ifel(d <= THRESH, 1, 0)
  n <- sum(!is.na(values(b)))
  if (n < 1000) { cat(sprintf("%d e%02d skipped, only %d valid cells\n", y, e, n)); next }
  writeRaster(b, file.path(OUT, sprintf("modhigh_%d_e%02d.tif", y, e)), overwrite = TRUE,
              datatype = "INT1U", gdal = c("COMPRESS=DEFLATE"))
  d0 <- as.Date(sprintf("%d-01-01", y)) + 120 + (e - 1) * 16
  rows[[length(rows)+1]] <- data.frame(year = y, epoch = e,
    start = format(d0), end = format(d0 + 16), valid_cells = n,
    prevalence = round(mean(values(b), na.rm = TRUE), 4))
}
sm <- do.call(rbind, rows)
write.csv(sm, file.path(OUT, "epoch_summary.csv"), row.names = FALSE)
cat(sprintf("\n%d epoch maps written, %d of a possible %d\n",
            nrow(sm), nrow(sm), length(YEARS) * NEPOCH))
print(sm, row.names = FALSE)
