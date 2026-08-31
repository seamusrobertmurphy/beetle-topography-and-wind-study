#!/usr/bin/env Rscript
## Red-stage beetle outbreak, 2006-2014, across Darkwoods, by the parent study's method.
##
## Section 2.4 of Murphy et al. (2026): NDMI differenced against the 2005
## pre-disturbance scene, a support vector machine regression relating that difference
## to the fraction of plot basal area composed of beetle-killed pine, and a threshold
## at the same 80 per cent red-stage mortality the parent used to admit a plot to
## training. Hyperparameters are the published ones, Table 7: cost 0.947, gamma 0.10,
## radial kernel. Diagnostics reported are the ones the parent reports, so its
## R2 = 0.905, RMSE = 4.83, RMSE ratio = 1.09 and U_bias = 0.176 can be compared
## directly against what the same method returns here.
##
## The response is the parent's own `pi_mpb_killed%` from
## 2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx, which is twice the measured
## basal area killed and runs 1.25 to 94.73 per cent, median 24.7. It is NOT the
## `pi_mpb_killed_pc` column in the assembled workbook: that one runs 75.41 to 97.85,
## no saved script writes it, and training on it gives the regression no unattacked
## end at all, so a first run of this script predicted about 85 per cent everywhere
## and classified all 264,000 ha as red stage in every one of the eight years.
##
## One discrepancy recorded rather than resolved. Section 2.4 says plots were retained
## for training only if red-stage mortality exceeded 80 per cent. On the parent's own
## percentage column only 3 of the 28 plots do. That criterion cannot be reproduced
## from the delivered plot table, and it is not applied here.

suppressPackageStartupMessages({library(terra); library(sf); library(e1071); library(readxl)})
set.seed(42)
ROOT <- "02.inputs/beetle"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "red-stage-darkwoods"); dir.create(OUT, showWarnings = FALSE)
COST <- 0.947; GAMMA <- 0.10; THRESH <- 80

f  <- sort(list.files(IN, "^ndmi_\\d{4}\\.tif$", full.names = TRUE))
yr <- as.integer(sub(".*ndmi_(\\d{4})\\.tif$", "\\1", f))
s  <- rast(f); names(s) <- paste0("y", yr)
base <- s[[which(yr == 2005)]]
oy   <- yr[yr != 2005]
cat(sprintf("baseline 2005; outbreak years %s\n", paste(oy, collapse = ", ")))

## ---- training data: dNDMI at the plot pixels ------------------------------
d <- as.data.frame(read_excel(file.path(ROOT, "2.1.darkwoods_beetle_ground_plots_ndmi.xlsx")))
d$plot <- as.integer(d$plot)
par <- as.data.frame(read_excel(path.expand(paste0("~/repos/publications-pending/",
  "Darkwoods-Disturbance-Paper/2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx"))))
par <- par[!is.na(par$plot), ]; par$plot <- as.integer(par$plot)
d <- merge(d, par[, c("plot", "pi_mpb_killed%")], by = "plot")
stopifnot(nrow(d) == 28)
p <- vect(st_as_sf(d, coords = c("easting", "northing"), crs = 32611))
dn <- sapply(oy, function(y) terra::extract(s[[paste0("y", y)]] - base, p)[, 2])
colnames(dn) <- paste0("d", oy)
## the plots record mortality accumulated over the outbreak, not one year, so the
## predictor is the deepest drop against 2005 that any year reached at that pixel
tr <- data.frame(pc = d[["pi_mpb_killed%"]], dndmi = apply(dn, 1, min, na.rm = TRUE))
stopifnot(!anyNA(tr))
cat(sprintf("training plots %d; pc range %.2f to %.2f; above %d%%: %d of %d\n", nrow(tr),
            min(tr$pc), max(tr$pc), THRESH, sum(tr$pc > THRESH), nrow(tr)))
cat(sprintf("deepest dNDMI vs 2005: mean %+.4f, range %+.4f to %+.4f\n",
            mean(tr$dndmi), min(tr$dndmi), max(tr$dndmi)))

## ---- SVM regression, 75/25 split as in section 2.4 ------------------------
i <- sample(nrow(tr), round(0.75 * nrow(tr)))
m <- svm(pc ~ dndmi, data = tr[i, ], kernel = "radial", cost = COST, gamma = GAMMA)
pt <- predict(m, tr[i, ]); pv <- predict(m, tr[-i, ])
r2 <- 1 - sum((tr$pc[-i] - pv)^2) / sum((tr$pc[-i] - mean(tr$pc[-i]))^2)
rt <- sqrt(mean((tr$pc[i]  - pt)^2))
rv <- sqrt(mean((tr$pc[-i] - pv)^2))
ub <- (mean(pv) - mean(tr$pc[-i]))^2 / mean((pv - tr$pc[-i])^2)
cat(sprintf("\nSVM regression  R2 = %.3f  RMSE = %.2f  RMSE ratio = %.2f  U_bias = %.3f\n",
            r2, rv, rt / rv, ub))
cat(sprintf("  parent reports  R2 = 0.905  RMSE = 4.83  RMSE ratio = 1.09  U_bias = 0.176\n"))
cat(sprintf("  correlation of dNDMI with the fraction killed: %+.3f (n = %d)\n",
            cor(tr$dndmi, tr$pc), nrow(tr)))

## ---- apply to every year ---------------------------------------------------
full <- svm(pc ~ dndmi, data = tr, kernel = "radial", cost = COST, gamma = GAMMA)
res <- list()
for (y in oy) {
  dd <- s[[paste0("y", y)]] - base; names(dd) <- "dndmi"
  pr <- terra::predict(dd, full, na.rm = TRUE)
  names(pr) <- "pc_killed"
  red <- pr > THRESH
  n <- global(red, "sum", na.rm = TRUE)[[1]]
  nv <- global(!is.na(pr), "sum", na.rm = TRUE)[[1]]
  writeRaster(pr, file.path(OUT, sprintf("pc_killed_%d.tif", y)), overwrite = TRUE,
              datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
  writeRaster(classify(red, cbind(c(0,1), c(2,1))),
              file.path(OUT, sprintf("redstage_%d.tif", y)), overwrite = TRUE,
              datatype = "INT1U", gdal = "COMPRESS=DEFLATE")
  res[[length(res)+1]] <- data.frame(year = y, valid = nv, red_cells = n,
                                     red_pc = 100*n/nv, red_ha = n*900/1e4)
  cat(sprintf("%d  red stage %8d cells  %5.2f%% of %8d valid  %9.1f ha\n",
              y, n, 100*n/nv, nv, n*900/1e4))
}
tab <- do.call(rbind, res)
write.csv(tab, file.path(OUT, "red_stage_area_by_year.csv"), row.names = FALSE)

## grey stage: the union of red-attack years 2005-2011, as section 2.4 defines it
gy <- oy[oy <= 2011]
grey <- Reduce(`|`, lapply(gy, function(y)
  rast(file.path(OUT, sprintf("redstage_%d.tif", y))) == 1))
writeRaster(classify(grey, cbind(c(0,1), c(2,1))), file.path(OUT, "greystage_2005_2011.tif"),
            overwrite = TRUE, datatype = "INT1U", gdal = "COMPRESS=DEFLATE")
ng <- global(grey, "sum", na.rm = TRUE)[[1]]
cat(sprintf("\ngrey stage, union of %s: %d cells, %.1f ha\n",
            paste(gy, collapse = "+"), ng, ng*900/1e4))
