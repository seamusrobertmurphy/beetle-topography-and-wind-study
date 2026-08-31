#!/usr/bin/env Rscript
## Assemble the modelling table on the parent's grid.
##
## Everything upstream lived in EPSG:32611. This step brings the response, the
## geomorphometry, the stand structure and the wind metrics onto one 30 m EPSG:3153
## grid inside the perimeter, and writes a single table the manuscript reads.
##
## The response is annual moderate-to-high beetle disturbance from 24-modhigh-binary-svm.R,
## never unioned across years: unioning destroys the year-to-year spread this study is
## about, and the union layer covered 73 per cent of the landscape, which is not credible.
##
## Reprojection uses nearest neighbour for the categorical response and bilinear for
## continuous surfaces. Every layer is resampled onto the perimeter mask, so cell
## centres are identical across the whole table by construction rather than by luck.

suppressPackageStartupMessages({library(terra)})
set.seed(42)
ROOT <- "02.inputs/beetle"
SA   <- file.path(ROOT, "study-area")
OUT  <- file.path(ROOT, "model-data"); dir.create(OUT, showWarnings = FALSE)
OY   <- c(2006:2011, 2013, 2014)

m   <- rast(file.path(SA, "perimeter_mask.tif"))
geo <- rast(file.path(ROOT, "geomorphometry", "geomorphometry.tif"))
vri <- rast(file.path(SA, "vri_covariates.tif"))
elv <- rast(file.path(SA, "elevation.tif"))
static <- c(elv, geo, vri)
cat(sprintf("static covariates: %d layers on %d cells\n", nlyr(static), sum(!is.na(values(m)))))

rows <- list()
for (y in OY) {
  f <- file.path(ROOT, "red-stage-darkwoods", sprintf("modhigh_%d.tif", y))
  if (!file.exists(f)) { cat("missing response", y, "\n"); next }
  r <- rast(f)
  ## The classification is categorical; freq() on it returns the LABEL in `value`, not
  ## the code, which once reported 100 per cent of the landscape attacked. It is
  ## converted to a plain 0/1 numeric here and never compared as a string again.
  ## Levels are value 1 = "other", 2 = "modhigh". Drop the category table and compare
  ## the code, never the label.
  b <- ifel(as.numeric(r) == 2, 1, 0)
  b <- project(b, m, method = "near")
  names(b) <- "modhigh"

  w <- project(rast(file.path(ROOT, "covariates", "wind-hourly",
                              sprintf("wind_metrics_%d.tif", y))), m, method = "bilinear")

  ## Previous-year beetle pressure, where a predecessor exists. 2006 has none, so its rows
  ## carry NA and drop out of any lagged model while remaining available to the
  ## environment-only models. The lag stack is already on this grid.
  ## MicroMet terrain-resolved wind for the same flight window, which unlike the station
  ## interpolation varies within the year across the grid.
  mmf <- file.path(ROOT, "covariates", "wind-micromet", sprintf("micromet_%d.tif", y))
  mm <- if (file.exists(mmf)) rast(mmf) else NULL

  lf <- file.path(ROOT, "lag-covariates", sprintf("lag_%d.tif", y))
  lg <- if (file.exists(lf)) rast(lf) else {
    z <- rast(m); z <- c(z, z, z); names(z) <- c("lag_self","lag_nbr90","lag_nbr510")
    values(z) <- NA; z }
  s <- mask(c(b, static, w, if (!is.null(mm)) mm, lg), m)
  d <- as.data.frame(s, na.rm = FALSE, xy = TRUE)
  d$year <- y
  rows[[length(rows)+1]] <- d
  cat(sprintf("%d  cells %d  moderate-to-high %.1f%%\n", y, sum(!is.na(d$modhigh)),
              100*mean(d$modhigh, na.rm = TRUE)))
}
d <- do.call(rbind, rows)
## Complete cases are required on everything EXCEPT the lag columns, so 2006 survives in
## the environment-only models and is dropped only where a lag term is fitted.
env <- setdiff(names(d), c("lag_self","lag_nbr90","lag_nbr510"))
d <- d[stats::complete.cases(d[, env]), ]
write.csv(d, file.path(OUT, "model_table.csv"), row.names = FALSE)
cat(sprintf("\nmodel table: %d rows, %d columns, %d years, prevalence %.3f\n",
            nrow(d), ncol(d), length(unique(d$year)), mean(d$modhigh)))
cat(sprintf("rows with a previous year: %d of %d\n",
            sum(!is.na(d$lag_self)), nrow(d)))
cat("columns:\n"); print(names(d))
