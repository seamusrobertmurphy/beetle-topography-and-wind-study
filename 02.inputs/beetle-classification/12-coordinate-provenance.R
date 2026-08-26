#!/usr/bin/env Rscript
## Were the 28 plot coordinates in the delivered workbook recovered, or fitted?
##
## Every easting and northing in `2.1.darkwoods_beetle_ground_plots_ndmi.xlsx` is an
## integer congruent to 15 modulo 30, so all 28 are exact centres of a 30 m grid
## aligned on the UTM origin. They are Landsat pixel centres, not GPS fixes, and the
## parent's own workbook carries no coordinate column at all, so they were produced
## somewhere else. The distinction that matters for everything downstream:
##
##   recovered  the pixel containing a known ground location was looked up, and its
##              NDMI is then an independent observation at that plot
##   fitted     the pixel was chosen because its NDMI resembles the value the parent
##              study reports for that plot, in which case NDMI at these coordinates
##              is not evidence about the plots and cannot test anything
##
## The test. If a coordinate was chosen to match, its pixel is unusually close in
## NDMI to the parent's value compared with the other pixels nearby. Rank the chosen
## pixel against every pixel within 500 m on that closeness. Under recovery the 28
## ranks are uniform on (0,1); under fitting they crowd towards 0.

suppressPackageStartupMessages({library(readxl); library(sf); library(terra)})

ROOT <- "02.inputs/beetle-classification"
NEW  <- file.path(ROOT, "2.1.darkwoods_beetle_ground_plots_ndmi.xlsx")
R20  <- file.path("03.outputs/maps", "ndmi_2020_harmonised.tif")
RAD  <- 500
line <- function(s) cat("\n", s, "\n", strrep("-", nchar(s)), "\n", sep = "")

d <- as.data.frame(read_excel(NEW, sheet = 1)); d$plot <- as.integer(d$plot)
r <- rast(R20)
pts <- vect(st_as_sf(d, coords = c("easting", "northing"), crs = 32611))
d$ours <- terra::extract(r, pts)[, 2]
stopifnot(!anyNA(d$ours))

line("Grid alignment")
cat(sprintf("easting mod 30: %s   northing mod 30: %s\n",
            paste(sort(unique(d$easting %% 30)), collapse = ","),
            paste(sort(unique(d$northing %% 30)), collapse = ",")))
cat(sprintf("bounding box of the 28 plots: %.0f x %.0f m\n",
            diff(range(d$easting)), diff(range(d$northing))))
cat(sprintf("raster resolution %.0f m, origin (%.1f, %.1f)\n",
            res(r)[1], origin(r)[1], origin(r)[2]))

line("Agreement between the parent's ndmi and this project's 2020 NDMI")
cat(sprintf("pearson %+.4f, spearman %+.4f, mean difference %+.5f, RMSE %.5f\n",
            cor(d$ndmi, d$ours), cor(d$ndmi, d$ours, method = "spearman"),
            mean(d$ours - d$ndmi), sqrt(mean((d$ours - d$ndmi)^2))))

line(sprintf("Closeness rank of the chosen pixel within %d m", RAD))
buf <- buffer(pts, RAD)
q <- numeric(nrow(d)); nn <- integer(nrow(d))
for (i in seq_len(nrow(d))) {
  v <- unlist(terra::extract(r, buf[i], ID = FALSE)); v <- v[!is.na(v)]
  err <- abs(v - d$ndmi[i])
  nn[i] <- length(v)
  q[i]  <- mean(err < abs(d$ours[i] - d$ndmi[i]))   ## fraction of neighbours that beat it
}
d$rank_q <- q
cat(sprintf("neighbourhood size: median %d pixels\n", median(nn)))
cat(sprintf("chosen-pixel quantile: mean %.3f, median %.3f, min %.3f, max %.3f\n",
            mean(q), median(q), min(q), max(q)))
cat(sprintf("plots in the best decile of their own neighbourhood: %d of 28\n", sum(q < 0.10)))
ks <- suppressWarnings(ks.test(q, "punif"))
cat(sprintf("Kolmogorov-Smirnov against uniform: D = %.3f, p = %.4f\n",
            unname(ks$statistic), ks$p.value))
cat("  uniform means the coordinates carry no trace of having been matched on NDMI;\n")
cat("  a crowd near zero would mean they were.\n")

print(d[order(d$rank_q), c("plot", "easting", "northing", "ndmi", "ours", "rank_q")], row.names = FALSE)

line("Against the coordinates already recovered and verified on 2026-08-20")
## Those 112 points came from Google Drive, four per plot, and were verified per point
## against the band values ArcMap stored at them (r = 0.86 NIR). If the delivered
## coordinates are the same locations they should coincide; if they are the same
## pixels under different plot numbers, the nearest recovered point will be close but
## will carry a different plot label.
tr <- read.csv(file.path(ROOT, "plot-locations", "beetle_plots_training.csv"))
tp <- vect(tr[, c("easting_m", "northing_m")], geom = c("easting_m", "northing_m"), crs = "EPSG:32611")
dm <- distance(pts, tp)
d$nn_dist  <- apply(dm, 1, min)
d$nn_plot  <- tr$plot[apply(dm, 1, which.min)]
cat(sprintf("distance to the nearest recovered point: median %.0f m, min %.0f m, max %.0f m\n",
            median(d$nn_dist), min(d$nn_dist), max(d$nn_dist)))
cat(sprintf("delivered plot number equals the nearest recovered plot number: %d of 28\n",
            sum(d$plot == d$nn_plot)))
cat(sprintf("delivered points within 21 m (one pixel diagonal) of a recovered point: %d of 28\n",
            sum(d$nn_dist <= 21.3)))
