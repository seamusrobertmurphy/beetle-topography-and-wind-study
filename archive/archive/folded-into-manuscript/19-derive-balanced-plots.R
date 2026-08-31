#!/usr/bin/env Rscript
## Derive a new, class-balanced plot set across Darkwoods and extract NDMI at it.
##
## Why the parent's 28 plots cannot train a landscape classifier. Every one of them
## is at least 75.41 per cent beetle-killed, median 86.60, because section 2.4 admitted
## a plot to training only when red-stage mortality was high. A regression fitted on a
## response with no low end predicts the high end everywhere: run on the 2005-baseline
## series it returned about 85 per cent for every cell and classified all 264,000 ha as
## red stage in all eight years. The training set needs unattacked and lightly attacked
## ground, and the parent's design deliberately excludes both.
##
## How severity is assigned here, stated plainly because it is the weak point. There
## is no field measurement anywhere outside those 28 plots, and the aerial survey is
## excluded as a label by decision. Severity is therefore assigned from the imagery
## itself: the deepest drop in growing-season NDMI that any outbreak year reached
## against the 2005 pre-disturbance baseline. That makes the class definition and the
## predictor relatives, so the resulting accuracy is a measure of internal consistency
## and self-separability, NOT of agreement with beetle mortality on the ground. The
## only external checks available are the 28 plots and, as a visual overlay only, the
## aerial survey.
##
## Balance. Equal plots per class by request, which fixes the prior at one in four
## against a true landscape prevalence far below that. Kappa and overall accuracy
## computed on a balanced sample will therefore read high; per-class rates and the
## classified area fraction are reported alongside them, because those are the numbers
## that reveal over-calling.

suppressPackageStartupMessages({library(terra); library(sf)})
set.seed(42)
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "plot-locations")
N_PER_CLASS <- 250L
MIN_SEP     <- 120      # metres, four Landsat pixels, to limit spatial autocorrelation
UNAFFECTED  <- -0.05    # dNDMI at or above this is treated as no red-stage signal

f  <- sort(list.files(IN, "^ndmi_\\d{4}\\.tif$", full.names = TRUE))
yr <- as.integer(sub(".*ndmi_(\\d{4})\\.tif$", "\\1", f))
s  <- rast(f); names(s) <- paste0("y", yr)
base <- s[[which(yr == 2005)]]
oy   <- yr[!yr %in% c(2005, 2020)]

## forest mask fixed at the pre-outbreak baseline so no later disturbance moves it
forest <- base > 0.20
cat(sprintf("forested cells in 2005: %d of %d (%.1f%%)\n",
            global(forest,"sum",na.rm=TRUE)[[1]], ncell(base),
            100*global(forest,"sum",na.rm=TRUE)[[1]]/ncell(base)))

## deepest drop against 2005 across the outbreak years, and the year it happened
dstack <- rast(lapply(oy, function(y) s[[paste0("y", y)]] - base))
names(dstack) <- paste0("d", oy)
dmin <- mask(min(dstack), forest, maskvalues = c(0, NA)); names(dmin) <- "dndmi"
wmin <- mask(which.min(dstack), forest, maskvalues = c(0, NA))
v <- values(dmin); v <- v[!is.na(v)]
cat(sprintf("deepest dNDMI: median %+.4f, 5th %+.4f, 1st %+.4f pct\n",
            median(v), quantile(v, .05), quantile(v, .01)))

## four classes: unaffected, then tertiles of the declines below the unaffected cut
att <- v[v < UNAFFECTED]
br  <- quantile(att, c(1/3, 2/3))
cat(sprintf("unaffected cut %+.3f; attacked tertile breaks %+.4f and %+.4f\n",
            UNAFFECTED, br[1], br[2]))
cls <- classify(dmin, matrix(c(-Inf, br[1], 4,          # high
                               br[1], br[2], 3,          # moderate
                               br[2], UNAFFECTED, 2,     # low
                               UNAFFECTED, Inf, 1),      # unaffected
                             ncol = 3, byrow = TRUE))
names(cls) <- "severity"
levels(cls) <- data.frame(value = 1:4,
                          severity = c("unaffected","low","moderate","high"))
writeRaster(cls, file.path(ROOT, "red-stage-darkwoods", "severity_class_2005base.tif"),
            overwrite = TRUE, datatype = "INT1U", gdal = "COMPRESS=DEFLATE")
ft <- freq(cls)
cat("\nlandscape class frequencies (this is the true prior the balanced sample departs from):\n")
ft$pc <- round(100 * ft$count / sum(ft$count), 2); print(ft[, c("value","count","pc")])

## ---- balanced sample, with a minimum separation between plots ---------------
pick <- function(k) {
  m  <- ifel(cls == k, 1, NA)
  sp <- spatSample(m, size = N_PER_CLASS * 40, method = "random", as.points = TRUE,
                   na.rm = TRUE, exhaustive = TRUE)
  xy <- crds(sp); keep <- integer(0)
  for (i in seq_len(nrow(xy))) {
    if (!length(keep)) { keep <- i; next }
    if (min(sqrt(rowSums((xy[keep, , drop = FALSE] - xy[i, ])^2))) >= MIN_SEP) keep <- c(keep, i)
    if (length(keep) == N_PER_CLASS) break
  }
  data.frame(easting = xy[keep,1], northing = xy[keep,2], class_id = k)
}
pl <- do.call(rbind, lapply(1:4, pick))
pl$severity <- c("unaffected","low","moderate","high")[pl$class_id]
pl$plot_id  <- seq_len(nrow(pl))
cat(sprintf("\nsampled %d plots, %s per class, minimum separation %d m\n",
            nrow(pl), paste(table(pl$severity), collapse = "/"), MIN_SEP))

## ---- extract NDMI: 2020, the 2005 baseline, every year, and the deepest drop --
pv <- vect(pl, geom = c("easting","northing"), crs = "EPSG:32611")
ex <- terra::extract(c(s, dmin, wmin), pv, ID = FALSE)
names(ex)[names(ex) == "which.min"] <- "worst_year_index"
pl <- cbind(pl, ex)
pl$worst_year <- oy[pl$worst_year_index]
pl <- pl[stats::complete.cases(pl[, c("y2005","y2020","dndmi")]), ]

out <- file.path(OUT, "darkwoods_balanced_plots_ndmi.csv")
write.csv(pl, out, row.names = FALSE)
st_write(st_as_sf(pl, coords = c("easting","northing"), crs = 32611),
         file.path(OUT, "darkwoods_balanced_plots.gpkg"), delete_dsn = TRUE, quiet = TRUE)

cat(sprintf("\nretained %d plots after dropping incomplete extractions\n", nrow(pl)))
cat("\nNDMI by severity class:\n")
print(round(do.call(rbind, lapply(split(pl, pl$severity), function(x)
  c(n = nrow(x), ndmi_2005 = mean(x$y2005), ndmi_2020 = mean(x$y2020),
    dndmi = mean(x$dndmi)))), 4))
cat(sprintf("\nwrote %s\n", out))
