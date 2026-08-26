#!/usr/bin/env Rscript
## Verify the delivered plot file `2.1.darkwoods_beetle_ground_plots_ndmi.xlsx`.
##
## The file arrived 2026-08-24 carrying, for each of the 28 ground plots, a
## coordinate pair in both UTM and geographic form, an NDMI value, a normalised
## NDMI value, their difference, and three tasselled-cap components. Nothing here
## is assumed: every column is checked against something computed independently.
##
## Four questions, in order.
##   1. Is the sheet internally consistent? Do easting/northing and lon/lat
##      describe the same points, and is norm_diff the difference it looks like?
##   2. Where are these plots relative to the coordinates recovered on 2026-08-20
##      into `plot-locations/beetle_plots_training.csv`, and relative to the 2015
##      Mt Midgeley fire perimeter?
##   3. Does the delivered `ndmi` column reproduce the parent study's reported
##      correlation with mortality, and which mortality column does it need?
##   4. Does the delivered `ndmi` column match the 2020 harmonised NDMI surface
##      this project built in 08-map-2020-severity.R, sampled at the delivered
##      coordinates? If it does, the coordinates and the surface corroborate each
##      other. If it does not, at most one of them can be right.

suppressPackageStartupMessages({library(readxl); library(sf); library(terra)})

ROOT <- "02.inputs/beetle-classification"
LOC  <- file.path(ROOT, "plot-locations")
XLSX <- file.path(ROOT, "2.1.darkwoods_beetle_ground_plots_ndmi.xlsx")
NDMI <- file.path("03.outputs/maps", "ndmi_2020_harmonised.tif")
FIRE <- path.expand(paste0("~/repos/publications-pending/Darkwoods-Disturbance-Paper",
                           "/3.SpatialData/fire_perimiter/Fire.Perimiter.shp"))
line <- function(s) cat("\n", s, "\n", strrep("-", nchar(s)), "\n", sep = "")

d <- as.data.frame(read_excel(XLSX, sheet = 1))
d$plot <- as.integer(d$plot)
stopifnot(nrow(d) == 28, !anyDuplicated(d$plot))

line("1. Internal consistency of the delivered sheet")
cat(sprintf("rows %d, columns: %s\n", nrow(d), paste(names(d), collapse = ", ")))

## easting/northing read as UTM 11N against the supplied lon/lat
p_utm <- st_as_sf(d, coords = c("easting", "northing"), crs = 32611)
p_ll  <- st_as_sf(d, coords = c("lon", "lat"), crs = 4326)
sep   <- as.numeric(st_distance(p_utm, st_transform(p_ll, 32611), by_element = TRUE))
cat(sprintf("UTM 11N vs supplied lon/lat: max separation %.2f m, median %.2f m\n",
            max(sep), median(sep)))

nd <- d$ndmi_norm - d$ndmi
cat(sprintf("norm_diff == ndmi_norm - ndmi: max abs error %.3e\n",
            max(abs(nd - d$norm_diff))))

## the percentage column, checked rather than trusted (see 09-classify-plot-severity.R)
fit <- lm(pi_mpb_killed_pc ~ pi_mpb_killed, data = d)
cat(sprintf("pi_mpb_killed_pc vs pi_mpb_killed: r = %.4f, slope %.4f, intercept %.4f\n",
            cor(d$pi_mpb_killed_pc, d$pi_mpb_killed), coef(fit)[2], coef(fit)[1]))
cat(sprintf("  is it 2 x basal area (the parent's rule)? max abs error %.4f\n",
            max(abs(d$pi_mpb_killed_pc - 2 * d$pi_mpb_killed))))

line("2. Where these coordinates sit")
tr <- read.csv(file.path(LOC, "beetle_plots_training.csv"))
ctr <- aggregate(cbind(easting_m, northing_m) ~ plot, data = tr, FUN = mean)
m <- merge(d[, c("plot", "easting", "northing")], ctr, by = "plot")
m$dE <- m$easting - m$easting_m
m$dN <- m$northing - m$northing_m
m$dist <- sqrt(m$dE^2 + m$dN^2)
cat(sprintf("Offset from the 2026-08-20 recovered plot centres, over %d plots:\n", nrow(m)))
cat(sprintf("  dE   mean %+8.1f  sd %7.1f  min %+8.1f  max %+8.1f m\n",
            mean(m$dE), sd(m$dE), min(m$dE), max(m$dE)))
cat(sprintf("  dN   mean %+8.1f  sd %7.1f  min %+8.1f  max %+8.1f m\n",
            mean(m$dN), sd(m$dN), min(m$dN), max(m$dN)))
cat(sprintf("  dist mean %8.1f  sd %7.1f  min %8.1f  max %8.1f m\n",
            mean(m$dist), sd(m$dist), min(m$dist), max(m$dist)))

if (file.exists(FIRE)) {
  fire <- st_transform(st_read(FIRE, quiet = TRUE), 32611)
  inside_new <- lengths(st_intersects(p_utm, fire)) > 0
  old <- st_as_sf(ctr, coords = c("easting_m", "northing_m"), crs = 32611)
  inside_old <- lengths(st_intersects(old, fire)) > 0
  cat(sprintf("Inside the 2015 fire perimeter: delivered %d/28, recovered %d/28\n",
              sum(inside_new), sum(inside_old)))
  dfire <- as.numeric(st_distance(p_utm, st_union(fire)))
  cat(sprintf("Delivered plots, distance to the burn: min %.0f m, median %.0f m, max %.0f m\n",
              min(dfire), median(dfire), max(dfire)))
} else cat("Fire perimeter not found at", FIRE, "\n")

line("3. Does the delivered NDMI reproduce the parent's correlation?")
resp <- c("pi_mpb_killed", "pi_mpb_killed_pc")
pred <- c("ndmi", "ndmi_norm", "norm_diff", "taswet", "tasgre", "tasbri")
cat(sprintf("%-16s %-18s %8s %8s %10s\n", "predictor", "response", "pearson", "spearman", "p (pearson)"))
for (p in pred) for (r in resp) {
  ct <- cor.test(d[[p]], d[[r]])
  cat(sprintf("%-16s %-18s %+8.3f %+8.3f %10.4f\n", p, r,
              unname(ct$estimate), cor(d[[p]], d[[r]], method = "spearman"), ct$p.value))
}

line("4. Delivered NDMI against this project's 2020 harmonised surface")
if (file.exists(NDMI)) {
  r <- rast(NDMI)
  d$ndmi_ours <- terra::extract(r, vect(p_utm))[, 2]
  n <- sum(!is.na(d$ndmi_ours))
  cat(sprintf("Sampled %d/28 plots inside the surface (extent %s)\n", n,
              paste(round(as.vector(ext(r))), collapse = " ")))
  if (n > 2) {
    ok <- !is.na(d$ndmi_ours)
    cat(sprintf("delivered ndmi : mean %+.4f  sd %.4f  range %+.4f to %+.4f\n",
                mean(d$ndmi), sd(d$ndmi), min(d$ndmi), max(d$ndmi)))
    cat(sprintf("our 2020 NDMI  : mean %+.4f  sd %.4f  range %+.4f to %+.4f\n",
                mean(d$ndmi_ours[ok]), sd(d$ndmi_ours[ok]),
                min(d$ndmi_ours[ok]), max(d$ndmi_ours[ok])))
    cat(sprintf("agreement      : r = %+.3f, mean difference %+.4f, RMSE %.4f\n",
                cor(d$ndmi[ok], d$ndmi_ours[ok]),
                mean(d$ndmi_ours[ok] - d$ndmi[ok]),
                sqrt(mean((d$ndmi_ours[ok] - d$ndmi[ok])^2))))
    ct <- cor.test(d$ndmi_ours[ok], d$pi_mpb_killed[ok])
    cat(sprintf("our NDMI vs pi_mpb_killed: r = %+.3f, p = %.4f (n = %d)\n",
                unname(ct$estimate), ct$p.value, n))
  }
} else cat("Harmonised 2020 NDMI not found at", NDMI, "\n")

write.csv(d, file.path(LOC, "beetle_plots_delivered_ndmi.csv"), row.names = FALSE)
cat("\nwrote:", file.path(LOC, "beetle_plots_delivered_ndmi.csv"), "\n")

line("5. Why the delivered `ndmi` behaves unlike an image band")
## Section 3 returned Spearman -0.999 between `ndmi` and mortality and +1.000
## against the percentage. A band sampled from a satellite image cannot rank-order
## 28 field plots that way. These checks establish what the column actually is.

o <- order(d$pi_mpb_killed_pc)
cat(sprintf("Rank of `ndmi` identical to rank of pi_mpb_killed_pc: %s\n",
            identical(rank(d$ndmi), rank(d$pi_mpb_killed_pc))))
cat(sprintf("Rank of `ndmi` identical to reversed rank of pi_mpb_killed: %s\n",
            identical(rank(d$ndmi), rank(-d$pi_mpb_killed))))

## the three tasselled-cap components are the internal control: same plots, same
## imagery, and no monotone relationship with the field measurement at all
for (v in c("taswet", "tasgre", "tasbri"))
  cat(sprintf("  control %s: spearman with pi_mpb_killed %+.3f\n", v,
              cor(d[[v]], d$pi_mpb_killed, method = "spearman")))

## is `ndmi` a smooth function of the percentage, as a modelled surface would be?
f <- lm(ndmi ~ poly(pi_mpb_killed_pc, 2), data = d)
cat(sprintf("ndmi ~ quadratic in pi_mpb_killed_pc: R2 = %.5f, residual sd %.3e\n",
            summary(f)$r.squared, sd(resid(f))))

## float32 signature: a value read from a Float32 raster round-trips exactly
f32 <- function(x) as.numeric(readBin(writeBin(x, raw(), size = 4), "numeric",
                                      n = length(x), size = 4))
for (v in c("ndmi", "ndmi_norm"))
  cat(sprintf("  %s is exactly Float32: %s\n", v, isTRUE(all.equal(d[[v]], f32(d[[v]])))))

line("6. Is `ndmi_norm` the same quantity this project computed?")
if (!is.null(d$ndmi_ours)) {
  cat(sprintf("ndmi_norm vs our 2020 NDMI: r = %+.4f, spearman %+.4f\n",
              cor(d$ndmi_norm, d$ndmi_ours), cor(d$ndmi_norm, d$ndmi_ours, method = "spearman")))
  cat(sprintf("  mean difference %+.5f, RMSE %.5f, max abs difference %.5f\n",
              mean(d$ndmi_ours - d$ndmi_norm), sqrt(mean((d$ndmi_ours - d$ndmi_norm)^2)),
              max(abs(d$ndmi_ours - d$ndmi_norm))))
  cat(sprintf("  both against pi_mpb_killed: ndmi_norm %+.4f, ours %+.4f\n",
              cor(d$ndmi_norm, d$pi_mpb_killed), cor(d$ndmi_ours, d$pi_mpb_killed)))
}
