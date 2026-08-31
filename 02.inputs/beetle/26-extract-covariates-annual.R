#!/usr/bin/env Rscript
## Join the topographic and wind covariates to each annual moderate-to-high map.
##
## One row per sampled cell per year, which is the table the refugia model is fitted
## on. Years are kept separate and never pooled or unioned: the hypothesis under test
## is that terrain and exposure shape where attack reaches, and the horizontal and
## vertical spread of attack changing year to year is the signal, not noise to average
## away.
##
## Sampling. 2.95 million cells times 8 years will not fit in memory on this machine,
## so each year is sampled to 20,000 cells, balanced 10,000 per class, inside the 2005
## forest mask. Balance is for model fitting; the true annual class fraction is carried
## in the summary table so any prevalence correction can be made later.
##
## Wind carries two limitations and both are in the output rather than in a footnote.
## The Global Wind Atlas rasters held here cover 21.6 per cent of the grid, so wind is
## NA for most cells. And they are a static long-term climatology cited by the parent
## for 2015 to 2020, after this outbreak, so they cannot represent the wind of any
## given outbreak year. `exposure`, elevation relative to a 990 m neighbourhood mean,
## is the terrain-derived proxy that covers the whole grid.

suppressPackageStartupMessages(library(terra))
set.seed(42)
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "red-stage-darkwoods")
COV  <- file.path(ROOT, "covariates")
OY   <- c(2006:2011, 2013, 2014)
N_PER_CLASS <- 10000L

cv <- rast(file.path(COV, "covariates.tif"))
forest <- rast(file.path(IN, "ndmi_2005.tif")) > 0.20
forest[forest == 0] <- NA

rows <- list(); summ <- list()
for (y in OY) {
  cl <- mask(rast(file.path(OUT, sprintf("modhigh_%d.tif", y))), forest)
  fq <- freq(cl); ct <- setNames(fq$count, as.character(fq$value)); tot <- sum(fq$count)
  prev <- unname(ct["modhigh"]) / tot
  smp <- do.call(rbind, lapply(c("other","modhigh"), function(k) {
    m <- ifel(cl == k, 1, NA)
    p <- spatSample(m, size = N_PER_CLASS, method = "random", as.points = TRUE,
                    na.rm = TRUE, exhaustive = TRUE)
    d <- cbind(data.frame(class = k), crds(p), terra::extract(cv, p, ID = FALSE))
    d
  }))
  smp$year <- y
  smp$modhigh <- as.integer(smp$class == "modhigh")
  rows[[length(rows)+1]] <- smp
  s <- do.call(rbind, lapply(split(smp, smp$class), function(x)
    data.frame(class = x$class[1], n = nrow(x),
               elevation = mean(x$elevation, na.rm = TRUE),
               slope = mean(x$slope, na.rm = TRUE),
               northness = mean(x$northness, na.rm = TRUE),
               eastness = mean(x$eastness, na.rm = TRUE),
               tri = mean(x$TRI, na.rm = TRUE), tpi = mean(x$TPI, na.rm = TRUE),
               twi = mean(x$twi, na.rm = TRUE),
               exposure = mean(x$exposure, na.rm = TRUE),
               wind_50m = mean(x$wind_50m, na.rm = TRUE),
               wind_n = sum(!is.na(x$wind_50m)))))
  s$year <- y; summ[[length(summ)+1]] <- s
  cat(sprintf("%d  prevalence %5.2f%%  sampled %d  wind available on %d of %d rows\n",
              y, 100*prev, nrow(smp), sum(!is.na(smp$wind_50m)), nrow(smp)))
}
d <- do.call(rbind, rows)
write.csv(d, file.path(OUT, "covariates_by_year.csv"), row.names = FALSE)
sm <- do.call(rbind, summ)
write.csv(sm, file.path(OUT, "covariate_means_by_year_class.csv"), row.names = FALSE)

cat(sprintf("\n%d rows written to covariates_by_year.csv\n", nrow(d)))
cat("\nmean covariate by class, pooled over years (the refugia signal, unmodelled):\n")
print(round(do.call(rbind, lapply(split(d, d$class), function(x)
  colMeans(x[, c("elevation","slope","northness","eastness","TRI","TPI","twi",
                 "exposure","wind_50m")], na.rm = TRUE))), 3))
cat("\nper year, difference in mean (moderate-high minus other):\n")
dif <- do.call(rbind, lapply(split(d, d$year), function(x) {
  a <- colMeans(x[x$modhigh == 1, c("elevation","slope","northness","TRI","twi",
                                    "exposure","wind_50m")], na.rm = TRUE)
  b <- colMeans(x[x$modhigh == 0, c("elevation","slope","northness","TRI","twi",
                                    "exposure","wind_50m")], na.rm = TRUE)
  c(year = x$year[1], round(a - b, 3)) }))
print(dif)
