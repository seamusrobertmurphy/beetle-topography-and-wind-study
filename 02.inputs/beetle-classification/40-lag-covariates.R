#!/usr/bin/env Rscript
## Previous-year beetle pressure: the persistence term and the spread term.
##
## Justified and measured before being built. The method is autologistic regression, in
## which a cell's state is modelled against its own previous state and against the state of
## its neighbourhood, alongside environmental covariates. Aukema et al. (2007) use exactly
## this on this province's outbreak, fitting environmental covariates "in addition to 1st
## order spatial and lag-1 and lag-2 temporal terms", and Chen and Walton (2011) report
## that in such a model the spatial and temporal dependencies "contributed most".
## 39-temporal-autocorrelation.R measured both on this grid: lag-1 odds ratios of 15.7 to
## 138.8, and neighbourhood correlation peaking at a 90 m radius.
##
## Two terms are built, not one, because they answer different questions and the biology
## separates them.
##   lag_self  the cell was moderate-to-high last year. This is persistence: a stand under
##             attack stays under attack while susceptible stems remain.
##   lag_nbr   the fraction of cells attacked last year within a radius, EXCLUDING the cell
##             itself. This is spread, and it is the term the dispersal biology is about:
##             brood emerging from last year's attacked trees flying into this year's.
## Keeping them apart matters because a single combined term would let persistence, which
## is nearly a tautology, stand in for spread, which is the process.
##
## 2013's lag is 2011, a two-year gap, because 2012 is excluded from the whole study: it is
## the only Landsat 7 year and the scan-line corrector has been off since May 2003. The gap
## is flagged in the output so no model can treat that row as a one-year lag by accident.
## 2006 has no predecessor and drops out of any lagged model, leaving seven year-pairs.

suppressPackageStartupMessages({library(terra)})
ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")
OUT  <- file.path(ROOT, "lag-covariates"); dir.create(OUT, showWarnings = FALSE)
OY   <- c(2006:2011, 2013, 2014)
RADII <- c(90, 510)     # metres: the local spread peak, and a stand-scale neighbourhood

msk <- rast(file.path(SA, "perimeter_mask.tif"))
get <- function(y) {
  r <- rast(file.path(ROOT, "red-stage-darkwoods", sprintf("modhigh_%d.tif", y)))
  mask(project(ifel(as.numeric(r) == 2, 1, 0), msk, method = "near"), msk)
}

for (i in 2:length(OY)) {
  y <- OY[i]; yp <- OY[i-1]
  prev <- get(yp)
  lay <- list(setNames(prev, "lag_self"))
  for (rad in RADII) {
    w <- focalMat(prev, rad, "circle"); w[w > 0] <- 1
    w[ceiling(nrow(w)/2), ceiling(ncol(w)/2)] <- 0      # exclude the focal cell
    f <- focal(prev, w, fun = "mean", na.rm = TRUE)
    lay[[length(lay)+1]] <- setNames(f, sprintf("lag_nbr%d", rad))
  }
  s <- mask(rast(lay), msk)
  writeRaster(s, file.path(OUT, sprintf("lag_%d.tif", y)), overwrite = TRUE,
              datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
  cat(sprintf("%d (lag from %d, gap %d yr): self %.3f, nbr90 %.3f, nbr510 %.3f\n",
              y, yp, y - yp, mean(values(s[["lag_self"]]), na.rm = TRUE),
              mean(values(s[["lag_nbr90"]]), na.rm = TRUE),
              mean(values(s[["lag_nbr510"]]), na.rm = TRUE)))
}
write.csv(data.frame(year = OY[-1], lag_from = OY[-length(OY)],
                     gap_years = diff(OY)),
          file.path(OUT, "lag_pairs.csv"), row.names = FALSE)
cat(sprintf("\nwrote %d annual lag stacks; 2006 has no predecessor and is excluded\n",
            length(OY) - 1))
