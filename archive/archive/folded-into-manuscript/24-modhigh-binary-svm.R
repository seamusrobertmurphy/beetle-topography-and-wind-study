#!/usr/bin/env Rscript
## Moderate-to-high beetle disturbance against everything else, annually.
##
## The target class. This manuscript tests whether topography and wind shape where
## beetle attack does and does not reach, so what has to be mapped is unambiguous
## attack, not the faint end of a spectral gradient. The positive class is therefore
## moderate or high severity, the negative class is unaffected or low, and the two
## carry 500 plots each out of the 1000 in `darkwoods_balanced_plots_ndmi.csv`. That
## is a genuinely balanced 1:1 label, unlike collapsing to attacked-against-unattacked,
## which left 250 against 748 and pushed the model toward calling attack.
##
## No union across years. Each year is classified on its own and reported on its own.
## The parent study unioned 2006-2011 into a single grey-stage layer because its point
## process model needed one binary covariate at the time of the 2015 fire; here the
## annual distribution and how its horizontal and vertical spread changes year to year
## IS the result, so unioning would destroy the signal being tested.
##
## Predictors remain the 2005-baseline differences in NDVI, NBR and TCW. NDMI is held
## out because the severity classes were cut from the NDMI drop, and a model given its
## own class definition would report an accuracy that means nothing.
##
## Landsat 8 years are the stable-forest-normalised series from 22-harmonise-landsat8.R.

suppressPackageStartupMessages({library(terra); library(e1071)})
set.seed(42)
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "red-stage-darkwoods")
LOC  <- file.path(ROOT, "plot-locations")
COST <- 0.947; GAMMA <- 0.10
PRED <- c("dndvi","dnbr","dtcw")
OY   <- c(2006:2011, 2013, 2014)
rd  <- function(nm, y) rast(file.path(IN, sprintf("%s_%d.tif", nm, y)))
dif <- function(nm, y) { r <- rd(nm, y) - rd(nm, 2005); names(r) <- paste0("d", nm); r }

pl <- read.csv(file.path(LOC, "darkwoods_balanced_plots_ndmi.csv"))
pv <- vect(pl, geom = c("easting","northing"), crs = "EPSG:32611")
X  <- matrix(NA_real_, nrow(pl), length(PRED), dimnames = list(NULL, PRED))
for (y in OY) {
  k <- which(pl$worst_year == y); if (!length(k)) next
  X[k, ] <- as.matrix(terra::extract(rast(list(dif("ndvi", y), dif("nbr", y),
                                               dif("tcw", y))), pv[k], ID = FALSE))
}
tr <- data.frame(X, cls = factor(
  ifelse(pl$severity %in% c("moderate","high"), "modhigh", "other"),
  levels = c("other","modhigh")))
tr <- tr[stats::complete.cases(tr), ]
cat(sprintf("training pool %d, label balance %s\n", nrow(tr),
            paste(names(table(tr$cls)), table(tr$cls), collapse = " / ")))

i  <- sample(nrow(tr), round(0.75 * nrow(tr)))
f  <- as.formula(paste("cls ~", paste(PRED, collapse = " + ")))
m  <- svm(f, data = tr[i, ], kernel = "radial", cost = COST, gamma = GAMMA)
p  <- predict(m, tr[-i, ]); o <- tr$cls[-i]
cm <- table(predicted = p, observed = o)
oa <- sum(diag(cm)) / sum(cm)
pe <- sum(rowSums(cm) * colSums(cm)) / sum(cm)^2
kp <- (oa - pe) / (1 - pe)
tp <- cm["modhigh","modhigh"]; fp <- cm["modhigh","other"]
fn <- cm["other","modhigh"];   tn <- cm["other","other"]
cat(sprintf("\nMODERATE-TO-HIGH BINARY SVM, held-out %d plots, balance %s\n",
            sum(cm), paste(table(o), collapse = "/")))
print(cm)
cat(sprintf("  overall accuracy %.3f   kappa %.3f\n", oa, kp))
cat(sprintf("  producer accuracy (recall)   %.3f   omission  %.3f\n", tp/(tp+fn), fn/(tp+fn)))
cat(sprintf("  user accuracy (precision)    %.3f   commission %.3f\n", tp/(tp+fp), fp/(tp+fp)))
cat(sprintf("  specificity                  %.3f\n", tn/(tn+fp)))
cat(sprintf("  F1                           %.3f\n", 2*tp/(2*tp+fp+fn)))
cat(sprintf("  parent Table 8, NDMI: OA 0.824, kappa 0.750 (28 plots, all >75%% killed)\n"))

## five-fold cross-validation, because a single 75/25 split on 1000 plots is one draw
folds <- sample(rep(1:5, length.out = nrow(tr)))
cv <- t(sapply(1:5, function(k) {
  mk <- svm(f, data = tr[folds != k, ], kernel = "radial", cost = COST, gamma = GAMMA)
  c2 <- table(factor(predict(mk, tr[folds == k, ]), levels = levels(tr$cls)),
              tr$cls[folds == k])
  a  <- sum(diag(c2))/sum(c2); e <- sum(rowSums(c2)*colSums(c2))/sum(c2)^2
  c(oa = a, kappa = (a - e)/(1 - e))
}))
cat(sprintf("\nfive-fold CV: accuracy %.3f (sd %.3f), kappa %.3f (sd %.3f)\n",
            mean(cv[,"oa"]), sd(cv[,"oa"]), mean(cv[,"kappa"]), sd(cv[,"kappa"])))

## ---- annual maps, no union ----------------------------------------------------
mfull <- svm(f, data = tr, kernel = "radial", cost = COST, gamma = GAMMA)
res <- list()
for (y in OY) {
  st <- rast(list(dif("ndvi", y), dif("nbr", y), dif("tcw", y)))
  cl <- terra::predict(st, mfull, na.rm = TRUE,
        filename = file.path(OUT, sprintf("modhigh_%d.tif", y)), overwrite = TRUE,
        wopt = list(datatype = "INT1U", gdal = "COMPRESS=DEFLATE"))
  fq <- freq(cl); ct <- setNames(fq$count, as.character(fq$value))
  tot <- sum(fq$count); a <- sum(ct["modhigh"], na.rm = TRUE)
  res[[length(res)+1]] <- data.frame(year = y, valid = tot, modhigh_cells = a,
                                     modhigh_pc = 100*a/tot, modhigh_ha = a*900/1e4)
  cat(sprintf("%d  moderate-to-high %6.2f%%  %9.0f ha\n", y, 100*a/tot, a*900/1e4))
}
write.csv(do.call(rbind, res), file.path(OUT, "modhigh_by_year.csv"), row.names = FALSE)
cat(sprintf("\nwrote annual rasters modhigh_YYYY.tif and %s\n",
            file.path(OUT, "modhigh_by_year.csv")))
