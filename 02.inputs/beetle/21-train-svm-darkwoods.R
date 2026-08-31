#!/usr/bin/env Rscript
## SVM regression and SVM classification of red-stage beetle outbreak across Darkwoods.
##
## Follows section 2.4 of Murphy et al. (2026): a support vector machine regression
## relating spectral change to outbreak severity, then a supervised SVM classification,
## both on a 75/25 train/validation split, with the published hyperparameters from
## Table 7, radial kernel, cost 0.947, gamma 0.10.
##
## Training data are the 1000 class-balanced plots from 19-derive-balanced-plots.R,
## 250 in each of unaffected, low, moderate and high, replacing the parent's 28 plots,
## every one of which was at least 75.41 per cent killed and which together left the
## regression with no unattacked end at all.
##
## Predictors are deliberately NOT NDMI. The severity classes were cut from thresholds
## on the 2005-baseline NDMI drop, so a model given that drop would recover its own
## thresholds and report an accuracy that means nothing. Predictors are the
## 2005-baseline differences in NDVI, NBR and TCW, three of the four indices the parent
## screened. NDMI is held back and used only to define the labels and, in the
## diagnostics below, to show how much of the label a model can recover without it.
##
## What the accuracy figures do and do not mean. The labels are derived from imagery,
## not from the ground, so overall accuracy and kappa here measure whether one set of
## spectral indices can reproduce a class boundary drawn on another. They are not
## agreement with beetle mortality. Balanced classes fix the prior at one in four
## against a landscape prior of 31.9 per cent unaffected, so the classified area
## fraction is reported for every year as the check on over-calling.

suppressPackageStartupMessages({library(terra); library(e1071)})
set.seed(42)
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "red-stage-darkwoods"); dir.create(OUT, showWarnings = FALSE)
LOC  <- file.path(ROOT, "plot-locations")
COST <- 0.947; GAMMA <- 0.10
PRED <- c("dndvi","dnbr","dtcw")
OY   <- c(2006:2011, 2013, 2014)

rd <- function(nm, y) rast(file.path(IN, sprintf("%s_%d.tif", nm, y)))
dif <- function(nm, y) { r <- rd(nm, y) - rd(nm, 2005); names(r) <- paste0("d", nm); r }

pl <- read.csv(file.path(LOC, "darkwoods_balanced_plots_ndmi.csv"))
pv <- vect(pl, geom = c("easting","northing"), crs = "EPSG:32611")
cat(sprintf("plots %d; classes %s\n", nrow(pl), paste(table(pl$severity), collapse = "/")))

## predictors at each plot's own worst year, which is the year its decline was deepest
X <- matrix(NA_real_, nrow(pl), length(PRED), dimnames = list(NULL, PRED))
for (y in OY) {
  k <- which(pl$worst_year == y); if (!length(k)) next
  st <- rast(list(dif("ndvi", y), dif("nbr", y), dif("tcw", y)))
  X[k, ] <- as.matrix(terra::extract(st, pv[k], ID = FALSE))
}
tr <- data.frame(X, sev = factor(pl$severity, levels = c("unaffected","low","moderate","high")),
                 dndmi = pl$dndmi)
tr <- tr[stats::complete.cases(tr), ]
cat(sprintf("complete training rows %d\n", nrow(tr)))
i  <- sample(nrow(tr), round(0.75 * nrow(tr)))

## ---- 1. SVM regression: spectral change predicts depth of the NDMI decline --------
fr <- as.formula(paste("dndmi ~", paste(PRED, collapse = " + ")))
mr <- svm(fr, data = tr[i, ], kernel = "radial", cost = COST, gamma = GAMMA)
pt <- predict(mr, tr[i, ]); pv2 <- predict(mr, tr[-i, ])
r2 <- 1 - sum((tr$dndmi[-i] - pv2)^2) / sum((tr$dndmi[-i] - mean(tr$dndmi[-i]))^2)
rt <- sqrt(mean((tr$dndmi[i] - pt)^2)); rv <- sqrt(mean((tr$dndmi[-i] - pv2)^2))
ub <- (mean(pv2) - mean(tr$dndmi[-i]))^2 / mean((pv2 - tr$dndmi[-i])^2)
cat(sprintf("\nSVM REGRESSION (dNDVI+dNBR+dTCW -> dNDMI), n_train=%d n_val=%d\n",
            length(i), nrow(tr) - length(i)))
cat(sprintf("  R2 = %.3f   RMSE = %.4f   RMSE ratio = %.2f   U_bias = %.3f\n",
            r2, rv, rt / rv, ub))
cat(sprintf("  parent Table 7, NDMI on plot mortality: R2 = 0.905, RMSE = 4.83, ratio = 1.09, U_bias = 0.176\n"))

## ---- 2. SVM classification, four severity classes ---------------------------------
fc <- as.formula(paste("sev ~", paste(PRED, collapse = " + ")))
mc <- svm(fc, data = tr[i, ], kernel = "radial", cost = COST, gamma = GAMMA)
pc <- predict(mc, tr[-i, ]); ob <- tr$sev[-i]
cm <- table(predicted = pc, observed = ob)
oa <- sum(diag(cm)) / sum(cm)
pe <- sum(rowSums(cm) * colSums(cm)) / sum(cm)^2
cat(sprintf("\nSVM CLASSIFICATION, four classes, n_val = %d\n", sum(cm)))
print(cm)
cat(sprintf("  overall accuracy = %.3f   kappa = %.3f\n", oa, (oa - pe) / (1 - pe)))
cat(sprintf("  parent Table 8, NDMI: OA = 0.824, kappa = 0.750\n"))
cat("  per class, commission (predicted but wrong) and omission (missed):\n")
for (k in levels(ob)) cat(sprintf("    %-11s commission %.3f  omission %.3f\n", k,
    1 - cm[k, k] / max(1, sum(cm[k, ])), 1 - cm[k, k] / max(1, sum(cm[, k]))))

## ---- 3. apply the classifier to every outbreak year -------------------------------
mfull <- svm(fc, data = tr, kernel = "radial", cost = COST, gamma = GAMMA,
             probability = FALSE)
res <- list()
for (y in OY) {
  st <- rast(list(dif("ndvi", y), dif("nbr", y), dif("tcw", y)))
  cl <- terra::predict(st, mfull, na.rm = TRUE, filename = file.path(OUT,
        sprintf("severity_svm_%d.tif", y)), overwrite = TRUE,
        wopt = list(datatype = "INT1U", gdal = "COMPRESS=DEFLATE"))
  ## freq() on a categorical raster returns the LABEL in `value`, not the code, so
  ## the classes are matched by name; comparing `value` numerically silently
  ## compares strings and reported 100 per cent attacked in every year.
  ft  <- freq(cl)
  cnt <- setNames(ft$count, as.character(ft$value))
  gc  <- function(k) sum(cnt[k], na.rm = TRUE)
  tot <- sum(ft$count)
  att <- gc(c("low","moderate","high")); red <- gc(c("moderate","high"))
  res[[length(res)+1]] <- data.frame(year = y, valid = tot,
    attacked_pc = 100*att/tot, attacked_ha = att*900/1e4,
    modhigh_pc = 100*red/tot, modhigh_ha = red*900/1e4)
  cat(sprintf("%d  any attack %5.1f%% (%8.0f ha)   moderate+high %5.1f%% (%8.0f ha)\n",
              y, 100*att/tot, att*900/1e4, 100*red/tot, red*900/1e4))
}
tab <- do.call(rbind, res)
write.csv(tab, file.path(OUT, "svm_red_stage_by_year.csv"), row.names = FALSE)
cat(sprintf("\nwrote %s\n", file.path(OUT, "svm_red_stage_by_year.csv")))
