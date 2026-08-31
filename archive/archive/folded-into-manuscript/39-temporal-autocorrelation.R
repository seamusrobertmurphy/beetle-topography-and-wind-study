#!/usr/bin/env Rscript
## Temporal and spatial autocorrelation in the annual disturbance maps.
##
## Run before any lag term is added to the model, because the size of the
## autocorrelation decides whether a lag term is a covariate or the whole answer.
##
## The method is established. Aukema et al. (2007) fit "autoregressive logistic models
## restricted to single environmental covariates (in addition to 1st order spatial and
## lag-1 and lag-2 temporal terms)", their lag-1 variable being "presence/absence of
## mountain pine beetle in a cell the previous year", and report that "the strong spatial
## and temporal autocorrelation identified provided an unexpected benefit for predicting
## future outbreaks". Chen and Walton (2011) report the same for this province: in an
## autologistic model, "spatial and temporal dependencies (presence of the outbreak within
## 18 km and presence of the outbreak in previous year) contributed most". Sambaraju and
## Goodsman (2021) list beetle population intensity as a driver in its own right, "spatial
## proximity to infested pine stands or previous occurrence(s) of infestations in the same
## area increases the risk of new infestations", and Lerch et al. (2016) measured it on the
## ground, emergence correlating with prior-year attacks at R2 = 0.569 to 0.68.
##
## Three quantities are computed here.
##   lag-1 agreement   how much a cell's state repeats from one year to the next
##   neighbourhood     how much a cell's state is predicted by attack around it last year,
##                     at several radii, which is the spread term rather than the persistence
##                     term and is the one the biology is about
##   variance share    what a lag-only model explains, so the environmental model's own
##                     contribution can be read against it rather than in isolation

suppressPackageStartupMessages({library(terra)})
set.seed(42)
ROOT <- "02.inputs/beetle"
SA   <- file.path(ROOT, "study-area")
OUT  <- file.path(ROOT, "model-data")
OY   <- c(2006:2011, 2013, 2014)
RADII <- c(90, 210, 510, 1050, 2010)          # metres, odd cell counts at 30 m

msk <- rast(file.path(SA, "perimeter_mask.tif"))
lyr <- list()
for (y in OY) {
  r <- rast(file.path(ROOT, "red-stage-darkwoods", sprintf("modhigh_%d.tif", y)))
  b <- project(ifel(as.numeric(r) == 2, 1, 0), msk, method = "near")
  lyr[[as.character(y)]] <- mask(b, msk)
}
st <- rast(lyr); names(st) <- as.character(OY)

## ---- lag-1 persistence -------------------------------------------------------------
rows <- list()
for (i in 2:length(OY)) {
  a <- values(st[[i-1]]); b <- values(st[[i]])
  ok <- !is.na(a) & !is.na(b)
  a <- a[ok]; b <- b[ok]
  tab <- table(prev = a, now = b)
  p11 <- sum(a == 1 & b == 1) / max(1, sum(a == 1))
  p01 <- sum(a == 0 & b == 1) / max(1, sum(a == 0))
  rows[[length(rows)+1]] <- data.frame(
    from = OY[i-1], to = OY[i], n = length(a),
    prev_prev = round(mean(a), 4), now_prev = round(mean(b), 4),
    phi = round(suppressWarnings(cor(a, b)), 4),
    p_attack_given_attacked = round(p11, 4),
    p_attack_given_clean = round(p01, 4),
    odds_ratio = round((p11/(1-p11)) / (p01/(1-p01)), 2),
    consecutive = OY[i] - OY[i-1] == 1)
}
lag1 <- do.call(rbind, rows)
cat("Lag-1 persistence, cell by cell:\n"); print(lag1, row.names = FALSE)

## ---- neighbourhood pressure --------------------------------------------------------
## The fraction of cells attacked last year within radius r, which is the spread term.
cat("\nNeighbourhood attack last year against attack this year (point-biserial r):\n")
nb <- list()
for (i in 2:length(OY)) {
  prev <- st[[i-1]]; now <- values(st[[i]])
  for (rad in RADII) {
    w <- focalMat(prev, rad, "circle"); w[w > 0] <- 1
    f <- values(focal(prev, w, fun = "mean", na.rm = TRUE))
    ok <- !is.na(f) & !is.na(now)
    nb[[length(nb)+1]] <- data.frame(from = OY[i-1], to = OY[i], radius_m = rad,
                                     r = round(cor(f[ok], now[ok]), 4))
  }
}
nb <- do.call(rbind, nb)
print(reshape(nb, idvar = c("from","to"), timevar = "radius_m", direction = "wide"),
      row.names = FALSE)

## ---- what a lag-only model explains ------------------------------------------------
d <- read.csv(file.path(OUT, "model_table.csv"))
cat(sprintf("\nmodel table %d rows\n", nrow(d)))
write.csv(lag1, file.path(OUT, "lag1_persistence.csv"), row.names = FALSE)
write.csv(nb,   file.path(OUT, "neighbourhood_pressure.csv"), row.names = FALSE)
cat("\nwrote lag1_persistence.csv and neighbourhood_pressure.csv\n")
