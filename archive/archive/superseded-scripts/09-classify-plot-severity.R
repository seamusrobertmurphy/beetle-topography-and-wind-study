#!/usr/bin/env Rscript
## Classify the 28 ground plots by measured mortality severity, then test the
## recovered coordinates against the 2020 NDMI severity surface.
##
## The severity label uses only the field measurement, `pi_mpb_killed`, the basal
## area of pine killed by mountain pine beetle in m2/ha, so it is independent of
## imagery and of any coordinate. Classes are tertiles of the 28 plot values,
## chosen to match the raster, whose classes are tertiles of 2020 NDMI inside the
## 2015 burn (see 08-map-2020-severity.R). Matching the break rule is what makes
## class 3 on the ground comparable with class 3 on the map.
##
## The percentage the parent study modelled, `pi_mpb_killed%` in
## 2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx, is checked here rather than
## trusted: it is reproduced exactly by doubling the basal area, which is a fixed
## 50 m2/ha denominator for every plot, not a measured stand total.
##
## Coordinates are the recovered ones and the -400E -1550N shifted hypothesis.
## Neither is confirmed, which is the whole point of the test.

suppressPackageStartupMessages({library(sf); library(terra)})

ROOT <- "02.inputs/beetle"
LOC  <- file.path(ROOT, "plot-locations")
MAP  <- "03.outputs/maps"
PAR  <- path.expand("~/repos/publications-pending/Darkwoods-Disturbance-Paper")

## ---- field severity, no coordinates involved -------------------------------
pl <- read.csv(file.path(LOC, "beetle_plots_training.csv"))
stopifnot(nrow(pl) == 112, length(unique(pl$plot)) == 28)
pk <- aggregate(pi_mpb_killed ~ plot, data = pl, FUN = function(x) {
  stopifnot(length(unique(round(x, 9))) == 1); x[1] })

br <- quantile(pk$pi_mpb_killed, c(1/3, 2/3))
cat(sprintf("Mortality tertile breaks: %.3f and %.3f m2/ha\n", br[1], br[2]))
pk$severity <- cut(pk$pi_mpb_killed, c(-Inf, br, Inf), labels = 1:3)
pk$severity_label <- c("1 low", "2 moderate", "3 high")[as.integer(pk$severity)]

## The parent's percentage, audited rather than reused.
xl <- file.path(PAR, "2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx")
if (file.exists(xl) && requireNamespace("readxl", quietly = TRUE)) {
  gp <- as.data.frame(readxl::read_excel(xl, n_max = 28))
  names(gp)[1:3] <- c("plot", "killed", "killed_pc")
  gp <- gp[order(gp$plot), ]
  dmax <- max(abs(gp$killed_pc - 2 * gp$killed))
  cat(sprintf("Parent percent column vs 2 x basal area, max abs difference: %.2e\n", dmax))
  pk$parent_pc <- gp$killed_pc[match(pk$plot, gp$plot)]
} else {
  cat("Parent workbook not readable; percent column not audited.\n")
  pk$parent_pc <- NA_real_
}

## BC forest-health severity codes applied to that percentage, with its denominator
## assumption carried forward, not hidden.
pk$bc_code <- cut(pk$parent_pc, c(-Inf, 1, 10, 29, 50, Inf),
                  labels = c("T trace", "L light", "M moderate", "S severe", "V very severe"))

## ---- the coordinate test ---------------------------------------------------
ndmi <- rast(file.path(MAP, "ndmi_2020_harmonised.tif"))
cls  <- rast(file.path(MAP, "ndmi_2020_severity_classes.tif"))
## Recover the raster's own break values from the two saved files, so the class
## edges can be quoted without rerunning 08-map-2020-severity.R.
rb <- sapply(1:3, function(k) range(values(ndmi)[!is.na(values(cls)) &
                                                 values(cls) == k], na.rm = TRUE))
cat(sprintf("NDMI range by map class: 1 %.4f to %.4f, 2 %.4f to %.4f, 3 %.4f to %.4f\n",
            rb[1,1], rb[2,1], rb[1,2], rb[2,2], rb[1,3], rb[2,3]))

sample_at <- function(csv, tag) {
  p  <- read.csv(file.path(LOC, csv))
  sf <- vect(p, geom = c("easting_m", "northing_m"), crs = "EPSG:32611")
  ec <- terra::extract(cls, sf)[, 2]
  ## The class band is categorical: extract returns the label, and its factor
  ## levels are in the same order as the raster's value table, so as.integer
  ## recovers 1, 2, 3 without parsing the label text.
  v  <- data.frame(plot = p$plot,
                   ndmi = terra::extract(ndmi, sf)[, 2],
                   cls  = as.integer(ec))
  a <- aggregate(v[, c("ndmi", "cls")], by = list(plot = v$plot),
                 FUN = function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE))
  names(a) <- c("plot", paste0("ndmi_", tag), paste0("cls_", tag))
  a
}
rec <- sample_at("beetle_plots_training.csv", "recorded")
shf <- sample_at("beetle_plots_training_shift.csv", "shifted")

out <- merge(merge(pk, rec, by = "plot", all.x = TRUE), shf, by = "plot", all.x = TRUE)
out$cls_recorded <- round(out$cls_recorded)
out$cls_shifted  <- round(out$cls_shifted)

report <- function(obs, pred, tag) {
  ok <- !is.na(obs) & !is.na(pred)
  tb <- table(field = obs[ok], ndmi = factor(pred[ok], levels = 1:3))
  cat(sprintf("\n--- %s coordinates (n = %d plots with raster cover) ---\n", tag, sum(ok)))
  print(tb)
  agree <- sum(diag(as.matrix(tb))) / sum(tb)
  o <- as.integer(as.character(obs[ok])); p <- as.integer(pred[ok])
  cat(sprintf("exact agreement %.1f%%, within one class %.1f%%\n",
              100 * agree, 100 * mean(abs(o - p) <= 1)))
  invisible(NULL)
}
report(out$severity, out$cls_recorded, "recorded")
report(out$severity, out$cls_shifted,  "shifted -400E -1550N")

sp <- function(x, y) { k <- !is.na(x) & !is.na(y); cor(x[k], y[k], method = "spearman") }
cat(sprintf("\nSpearman, mortality vs 2020 NDMI: recorded %.3f, shifted %.3f\n",
            sp(out$pi_mpb_killed, out$ndmi_recorded),
            sp(out$pi_mpb_killed, out$ndmi_shifted)))
cat("A real location would give a negative correlation: more pine killed, drier canopy.\n")

## Permutation test, because 28 plots make a weak rho easy to draw by chance.
perm_p <- function(x, y, n = 9999) {
  k <- !is.na(x) & !is.na(y); x <- x[k]; y <- y[k]
  obs <- cor(x, y, method = "spearman")
  set.seed(123)
  null <- replicate(n, cor(x, sample(y), method = "spearman"))
  (1 + sum(abs(null) >= abs(obs))) / (n + 1)
}
cat(sprintf("two-sided permutation p: recorded %.3f, shifted %.3f\n",
            perm_p(out$pi_mpb_killed, out$ndmi_recorded),
            perm_p(out$pi_mpb_killed, out$ndmi_shifted)))

## Where the plots sit on the map, ignoring their measured severity.
cat("\n2020 NDMI class at the recorded plot centres, all 28 plots:\n")
print(table(factor(out$cls_recorded, levels = 1:3,
                   labels = c("1 low sev / moist", "2 moderate", "3 high sev / dry"))))

## ---- what the classification says on its own -------------------------------
cat("\nPlots by measured severity class:\n")
for (s in 1:3) {
  p <- out$plot[as.integer(out$severity) == s]
  cat(sprintf("  class %d (%s): %s\n", s, c("low","moderate","high")[s],
              paste(p, collapse = ", ")))
}

cat("\nPer plot:\n")
pr <- out[order(-out$pi_mpb_killed),
          c("plot","pi_mpb_killed","parent_pc","severity_label","bc_code",
            "ndmi_recorded","cls_recorded","ndmi_shifted","cls_shifted")]
print(pr, row.names = FALSE, digits = 4)

write.csv(out[order(-out$pi_mpb_killed), ],
          file.path(LOC, "beetle_plots_severity_classes.csv"), row.names = FALSE)
cat("\nwrote: ", file.path(LOC, "beetle_plots_severity_classes.csv"), "\n")
