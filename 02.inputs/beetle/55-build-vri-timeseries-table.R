#!/usr/bin/env Rscript
## Year-matched stand structure for the modelling tables.
##
## Replaces the host columns in model_table.csv and epoch_model_table.csv with the value
## from the inventory snapshot for that row's own year. Until now every year of a cell
## carried the same value, taken from the live WFS composite projected to 2025, so the
## host terms had no time variation and had been grown forward through the outbreak they
## were meant to predict.
##
## Where a study year has no snapshot the previous year is carried forward, never averaged:
## the VRI is itself a projection, so carrying forward reproduces a stand structure the
## province actually published, whereas averaging invents one that was never published.
## Every substitution is recorded in vri_year_source.csv and is reported in the Methods.
##
## Writes: model-data/model_table_vri.csv, model-data/epoch_model_table_vri.csv,
##         model-data/vri_year_source.csv
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle/55-build-vri-timeseries-table.R

suppressPackageStartupMessages({library(sf); library(terra); library(dplyr)})

ROOT <- "02.inputs/beetle"
SA   <- file.path(ROOT, "study-area")
TS   <- file.path(SA, "vri-timeseries")
MD   <- file.path(ROOT, "model-data")

HOST <- c("BASAL_AREA","CROWN_CLOSURE","VRI_LIVE_STEMS_PER_HA","QUAD_DIAM_125",
          "PROJ_AGE_1","PROJ_HEIGHT_1","LIVE_STAND_VOLUME_125")
YEARS <- c(2005:2011, 2013, 2014)

## A snapshot counts as usable only if its host fields are actually populated, not merely
## present. The 2007 delivery carries BASAL_AREA and VRI_LIVE_STEMS_PER_HA as columns and
## fills neither: 0 and 3 per cent of polygons respectively, against 70 to 97 per cent in
## every other year. A file-existence test passes it and the year then silently drops out
## of the model at the complete-cases step, which is worse than substituting for it openly.
MIN_FILLED <- 0.20
usable <- function(y) {
  f <- file.path(TS, sprintf("vri_%d.gpkg", y))
  if (!file.exists(f)) return(FALSE)
  v <- try(suppressWarnings(sf::st_read(f, quiet = TRUE)), silent = TRUE)
  if (inherits(v, "try-error")) return(FALSE)
  ok <- vapply(HOST, function(k) {
    if (!k %in% names(v)) return(0)
    mean(!is.na(suppressWarnings(as.numeric(v[[k]]))))
  }, numeric(1))
  if (any(ok < MIN_FILLED))
    cat(sprintf("  %d unusable: %s below %.0f%% filled\n", y,
                paste(names(ok)[ok < MIN_FILLED], collapse = ", "), 100 * MIN_FILLED))
  all(ok >= MIN_FILLED)
}
have <- YEARS[vapply(YEARS, usable, logical(1))]
cat(sprintf("snapshots present: %s\n", paste(have, collapse = ", ")))
if (!length(have)) stop("no snapshots at all")

## Which snapshot each study year uses: its own where it exists, otherwise the most recent
## earlier one, otherwise the earliest available.
src <- sapply(YEARS, function(y) {
  if (y %in% have) return(y)
  e <- have[have < y]
  if (length(e)) max(e) else min(have)
})
map <- data.frame(year = YEARS, vri_year = src,
                  substituted = YEARS != src)
write.csv(map, file.path(MD, "vri_year_source.csv"), row.names = FALSE)
print(map, row.names = FALSE)

grid <- rast(file.path(SA, "perimeter_mask.tif"))

## Rasterise each snapshot once, then sample it at the cells each table needs.
stacks <- list()
for (y in unique(map$vri_year)) {
  v <- st_read(file.path(TS, sprintf("vri_%d.gpkg", y)), quiet = TRUE) |> st_transform(3153)
  for (f in HOST) if (!f %in% names(v)) v[[f]] <- NA_real_
  for (f in HOST) v[[f]] <- suppressWarnings(as.numeric(v[[f]]))
  ## PinePct and PINE_BA follow the same construction as 35-vri-covariates.R: pine share
  ## of cover accumulated across the species slots, and basal area times that share.
  sp <- grep("^SPECIES_CD_|^SPEC_CD_", names(v), value = TRUE)
  pc <- grep("^SPECIES_PCT_|^SPEC_PCT_", names(v), value = TRUE)
  pine <- rep(0, nrow(v))
  for (k in seq_along(sp)) {
    if (k > length(pc)) break
    is_pl <- grepl("^PL", as.character(v[[sp[k]]]))
    add <- suppressWarnings(as.numeric(v[[pc[k]]])); add[is.na(add)] <- 0
    pine <- pine + ifelse(is_pl, add, 0)
  }
  v$PinePct <- pine
  v$PINE_BA <- v$BASAL_AREA * pine / 100
  r <- rast(lapply(c(HOST, "PinePct", "PINE_BA"),
                   function(f) rasterize(vect(v), grid, field = f)))
  names(r) <- c(HOST, "PinePct", "PINE_BA")
  stacks[[as.character(y)]] <- r
  cat(sprintf("  rasterised %d: %d polygons, mean basal area %.1f\n",
              y, nrow(v), mean(values(r[["BASAL_AREA"]]), na.rm = TRUE)))
}

swap <- function(path, out) {
  d <- read.csv(path)
  pts <- vect(as.matrix(d[, c("x","y")]), crs = "EPSG:3153")
  for (f in c(HOST, "PinePct", "PINE_BA")) d[[f]] <- NA_real_
  for (i in seq_len(nrow(map))) {
    idx <- d$year == map$year[i]
    if (!any(idx)) next
    r <- stacks[[as.character(map$vri_year[i])]]
    e <- terra::extract(r, pts[idx])
    for (f in c(HOST, "PinePct", "PINE_BA")) d[[f]][idx] <- e[[f]]
  }
  before <- nrow(d)
  d <- d[stats::complete.cases(d[, c(HOST, "PinePct", "PINE_BA")]), ]
  write.csv(d, out, row.names = FALSE)
  cat(sprintf("%s: %d rows, %d dropped for missing host\n", basename(out), nrow(d), before - nrow(d)))
  d
}

a <- swap(file.path(MD, "model_table.csv"),       file.path(MD, "model_table_vri.csv"))
e <- swap(file.path(MD, "epoch_model_table.csv"), file.path(MD, "epoch_model_table_vri.csv"))

## The point of the exercise: host structure now varies between years.
cat("\nannual means by year, year-matched:\n")
print(a |> group_by(year) |>
        summarise(basal = mean(BASAL_AREA), stems = mean(VRI_LIVE_STEMS_PER_HA),
                  qmd = mean(QUAD_DIAM_125), vol = mean(LIVE_STAND_VOLUME_125),
                  .groups = "drop"), n = 20)
