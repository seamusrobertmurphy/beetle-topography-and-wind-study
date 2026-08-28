#!/usr/bin/env Rscript
## The 16-day modelling table.
##
## One row per cell per epoch, against the terrain, stand structure and the wind of that
## epoch's own sixteen days. This is the design the annual table could not support: wind
## now varies both across the grid within an epoch and between the 60 epochs, so a wind
## effect is identified in space and in time rather than across eight summers.
##
## The lag term is the previous epoch in the same season, not the previous year, so it
## measures spread within a flight season rather than persistence between them. The first
## epoch of each year has no predecessor and carries NA.

suppressPackageStartupMessages({library(terra); library(dplyr)})
set.seed(42)
ROOT <- "02.inputs/beetle-classification"
SA   <- file.path(ROOT, "study-area")
RESP <- file.path(ROOT, "epoch-response")
WIND <- file.path(ROOT, "covariates", "wind-epoch")
OUT  <- file.path(ROOT, "model-data")
N_PER_EPOCH <- 4000L

msk <- rast(file.path(SA, "perimeter_mask.tif"))
static <- c(rast(file.path(SA, "elevation.tif")),
            rast(file.path(ROOT, "geomorphometry", "geomorphometry.tif")),
            rast(file.path(SA, "vri_covariates.tif")))
ep <- read.csv(file.path(RESP, "epoch_summary.csv"))
ep <- ep[order(ep$year, ep$epoch), ]

rows <- list()
for (i in seq_len(nrow(ep))) {
  y <- ep$year[i]; e <- ep$epoch[i]
  rf <- file.path(RESP, sprintf("modhigh_%d_e%02d.tif", y, e))
  wf <- file.path(WIND, sprintf("wind_%d_e%02d.tif", y, e))
  if (!file.exists(rf) || !file.exists(wf)) next
  b <- rast(rf); names(b) <- "modhigh"

  ## Previous epoch in the same year, where one exists and was classified.
  prev <- ep[ep$year == y & ep$epoch < e, ]
  lg <- NULL
  if (nrow(prev)) {
    pe <- max(prev$epoch)
    pf <- file.path(RESP, sprintf("modhigh_%d_e%02d.tif", y, pe))
    if (file.exists(pf)) {
      p <- rast(pf)
      w <- focalMat(p, 90, "circle"); w[w > 0] <- 1
      w[ceiling(nrow(w)/2), ceiling(ncol(w)/2)] <- 0
      lg <- c(setNames(p, "ep_lag_self"),
              setNames(focal(p, w, fun = "mean", na.rm = TRUE), "ep_lag_nbr90"))
    }
  }
  if (is.null(lg)) {
    z <- c(msk, msk); names(z) <- c("ep_lag_self","ep_lag_nbr90"); values(z) <- NA
    lg <- z
  }
  s <- mask(c(b, static, rast(wf), lg), msk)
  ## Take every valid cell in the epoch and balance from it. A random sample of the whole
  ## raster wastes most draws: an epoch typically has cloud-free imagery over a third of
  ## the perimeter, so most cells have no response at all.
  smp <- as.data.frame(s, na.rm = FALSE, xy = TRUE)
  smp <- smp[!is.na(smp$modhigh), ]
  ## Balanced within epoch, so the intercept is not the epoch's own prevalence.
  a <- smp[smp$modhigh == 1, ]; o <- smp[smp$modhigh == 0, ]
  n <- min(nrow(a), nrow(o), N_PER_EPOCH)
  if (n < 100) { cat(sprintf("%d e%02d skipped, only %d of the rarer class\n", y, e, n)); next }
  smp <- rbind(a[sample(nrow(a), n), ], o[sample(nrow(o), n), ])
  smp$year <- y; smp$epoch <- e; smp$t <- i
  rows[[length(rows)+1]] <- smp
  cat(sprintf("%d e%02d  n %d per class\n", y, e, n))
}
d <- do.call(rbind, rows)
env <- setdiff(names(d), c("ep_lag_self","ep_lag_nbr90"))
d <- d[complete.cases(d[, env]), ]
write.csv(d, file.path(OUT, "epoch_model_table.csv"), row.names = FALSE)
cat(sprintf("\nepoch table: %d rows, %d epochs, %d years, %d with a within-season lag\n",
            nrow(d), length(unique(d$t)), length(unique(d$year)), sum(!is.na(d$ep_lag_self))))
