#!/usr/bin/env Rscript
## Attacked against unattacked: the defensible headline accuracy.
##
## Why collapse. The four-class model reaches overall accuracy 0.600 and kappa 0.469,
## and almost all of the error is adjacent: low severity carries omission 0.608 and
## moderate 0.415, while unaffected is 0.182 and high 0.274. Low and moderate are
## tertile cuts through one continuous NDMI decline, so a boundary between them is a
## convention rather than a thing in the forest, and confusion across it is a property
## of the class definition. Attacked against unattacked is a boundary that means
## something: a stand either shows a red-stage decline against 2005 or it does not.
##
## Two numbers are reported and they answer different questions.
##   trained binary   an SVM fitted directly on the two-class label, which is what a
##                    user of the map would deploy
##   collapsed        the four-class model's predictions merged to two, which shows how
##                    much of the four-class error was adjacent-class confusion rather
##                    than real disagreement
##
## Accuracy on a balanced sample is not accuracy on the landscape. The training set is
## 250 per class, so the prior is one in four, while the landscape is 40.58 per cent
## unaffected. Both the balanced figure and a prior-corrected figure are reported: the
## second reweights the confusion matrix to the landscape class frequencies, and it is
## the one that should be quoted for a map.

suppressPackageStartupMessages({library(terra); library(e1071)})
set.seed(42)
ROOT <- "02.inputs/beetle-classification"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "red-stage-darkwoods")
LOC  <- file.path(ROOT, "plot-locations")
COST <- 0.947; GAMMA <- 0.10
PRED <- c("dndvi","dnbr","dtcw")
OY   <- c(2006:2011, 2013, 2014)
rd  <- function(nm, y) rast(file.path(IN, sprintf("%s_%d.tif", nm, y)))
dif <- function(nm, y) { r <- rd(nm, y) - rd(nm, 2005); names(r) <- paste0("d", nm); r }
stats2 <- function(cm) {
  oa <- sum(diag(cm)) / sum(cm)
  pe <- sum(rowSums(cm) * colSums(cm)) / sum(cm)^2
  c(oa = oa, kappa = (oa - pe) / (1 - pe))
}

pl <- read.csv(file.path(LOC, "darkwoods_balanced_plots_ndmi.csv"))
pv <- vect(pl, geom = c("easting","northing"), crs = "EPSG:32611")
X  <- matrix(NA_real_, nrow(pl), length(PRED), dimnames = list(NULL, PRED))
for (y in OY) {
  k <- which(pl$worst_year == y); if (!length(k)) next
  X[k, ] <- as.matrix(terra::extract(rast(list(dif("ndvi", y), dif("nbr", y),
                                               dif("tcw", y))), pv[k], ID = FALSE))
}
tr <- data.frame(X,
  sev = factor(pl$severity, levels = c("unaffected","low","moderate","high")),
  att = factor(ifelse(pl$severity == "unaffected", "unattacked", "attacked"),
               levels = c("unattacked","attacked")))
tr <- tr[stats::complete.cases(tr), ]
i  <- sample(nrow(tr), round(0.75 * nrow(tr)))
cat(sprintf("training rows %d; validation %d; balanced label %s\n",
            length(i), nrow(tr) - length(i), paste(table(tr$att), collapse = "/")))

## ---- trained binary ---------------------------------------------------------
fb <- as.formula(paste("att ~", paste(PRED, collapse = " + ")))
mb <- svm(fb, data = tr[i, ], kernel = "radial", cost = COST, gamma = GAMMA)
cb <- table(predicted = predict(mb, tr[-i, ]), observed = tr$att[-i])
sb <- stats2(cb)
cat("\nTRAINED BINARY, held-out quarter\n"); print(cb)
cat(sprintf("  overall accuracy %.3f   kappa %.3f\n", sb["oa"], sb["kappa"]))
cat(sprintf("  attacked: commission %.3f  omission %.3f\n",
            1 - cb["attacked","attacked"]/sum(cb["attacked",]),
            1 - cb["attacked","attacked"]/sum(cb[,"attacked"])))
cat(sprintf("  unattacked: commission %.3f  omission %.3f\n",
            1 - cb["unattacked","unattacked"]/sum(cb["unattacked",]),
            1 - cb["unattacked","unattacked"]/sum(cb[,"unattacked"])))

## ---- collapsed from the four-class model ------------------------------------
fc <- as.formula(paste("sev ~", paste(PRED, collapse = " + ")))
mc <- svm(fc, data = tr[i, ], kernel = "radial", cost = COST, gamma = GAMMA)
co <- function(x) factor(ifelse(x == "unaffected", "unattacked", "attacked"),
                         levels = c("unattacked","attacked"))
cc <- table(predicted = co(predict(mc, tr[-i, ])), observed = co(tr$sev[-i]))
sc <- stats2(cc)
cat("\nFOUR-CLASS MODEL COLLAPSED TO TWO\n"); print(cc)
cat(sprintf("  overall accuracy %.3f   kappa %.3f\n", sc["oa"], sc["kappa"]))
cat(sprintf("  four-class model before collapsing: OA 0.600, kappa 0.469\n"))

## ---- prior correction to the landscape ---------------------------------------
## reweight each observed column to the landscape frequency of that class
cls <- rast(file.path(OUT, "severity_class_2005base.tif"))
ft  <- freq(cls); w <- setNames(ft$count / sum(ft$count), as.character(ft$value))
p_un <- unname(w["unaffected"]); p_at <- 1 - p_un
cw <- cb
cw[, "unattacked"] <- cb[, "unattacked"] / sum(cb[, "unattacked"]) * p_un
cw[, "attacked"]   <- cb[, "attacked"]   / sum(cb[, "attacked"])   * p_at
sw <- stats2(cw)
cat(sprintf("\nPRIOR-CORRECTED to the landscape (%.1f%% unaffected, %.1f%% attacked)\n",
            100*p_un, 100*p_at))
cat(sprintf("  overall accuracy %.3f   kappa %.3f\n", sw["oa"], sw["kappa"]))
cat("  this is the figure to quote for the map; the balanced one is a model diagnostic\n")

## ---- apply to every year ------------------------------------------------------
mfull <- svm(fb, data = tr, kernel = "radial", cost = COST, gamma = GAMMA)
res <- list()
for (y in OY) {
  st <- rast(list(dif("ndvi", y), dif("nbr", y), dif("tcw", y)))
  cl <- terra::predict(st, mfull, na.rm = TRUE,
        filename = file.path(OUT, sprintf("attacked_svm_%d.tif", y)), overwrite = TRUE,
        wopt = list(datatype = "INT1U", gdal = "COMPRESS=DEFLATE"))
  f2 <- freq(cl); c2 <- setNames(f2$count, as.character(f2$value))
  tot <- sum(f2$count); a <- sum(c2["attacked"], na.rm = TRUE)
  res[[length(res)+1]] <- data.frame(year = y, valid = tot, attacked_cells = a,
                                     attacked_pc = 100*a/tot, attacked_ha = a*900/1e4)
  cat(sprintf("%d  attacked %5.2f%%  %9.0f ha\n", y, 100*a/tot, a*900/1e4))
}
write.csv(do.call(rbind, res), file.path(OUT, "attacked_by_year.csv"), row.names = FALSE)

## grey stage: union of red-attack years 2005-2011, as section 2.4 of the parent defines
gy <- OY[OY <= 2011]
grey <- Reduce(`|`, lapply(gy, function(y)
  rast(file.path(OUT, sprintf("attacked_svm_%d.tif", y))) == "attacked"))
writeRaster(grey, file.path(OUT, "greystage_2006_2011.tif"), overwrite = TRUE,
            datatype = "INT1U", gdal = "COMPRESS=DEFLATE")
ng <- global(grey, "sum", na.rm = TRUE)[[1]]
cat(sprintf("\ngrey stage, union of %s: %d cells, %.0f ha (%.1f%% of grid)\n",
            paste(gy, collapse = "+"), ng, ng*900/1e4, 100*ng/ncell(grey)))
