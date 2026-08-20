# Gate 1(d): recompute the parent study's NDMI validation metrics.
#
# Artefact under audit:
#   ~/repos/publications-pending/Darkwoods-Disturbance-Paper/
#     4.RData/1.Beetle_plots/3.beetle_plots_aug21.R      (the code)
#     4.RData/1.Beetle_plots/.RData                      (the saved objects)
#
# Defect: the script names its objects beetle_ndmi_pred_train (line 92) and
# beetle_ndmi_pred_test (line 107) but produces both with
# predict(svm_tasbright_linear, ...), the Tasselled Cap brightness model.
# Every NDMI error statistic downstream is the brightness model's.
# Published as R2 = 0.905, RMSE = 4.83 in
# FORECO-D-26-01171_Manuscript-FINAL-greycorrected.docx (Results, cleaned-text
# line 407; Table 7 rows, lines 419-420).
#
# The .RData holds the fitted objects and the training partition exactly as
# they were when the paper was written, so metrics are recomputed from those
# rather than refitted. A refit from the xlsx does NOT reproduce them: the
# xlsx carries a differently scaled ndmi column (see the scaling check below).
#
# Run: /usr/local/bin/Rscript 02.inputs/beetle-classification/00-recompute-parent-metrics.R

suppressMessages({
  library(caret); library(kernlab); library(ModelMetrics); library(DescTools)
  library(readxl)
})

PARENT <- "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper"
RDATA  <- file.path(PARENT, "4.RData/1.Beetle_plots/.RData")
XLSX   <- file.path(PARENT, "4.RData/1.Beetle_plots/2.1.darkwoods_beetle_ground_plots.xlsx")
stopifnot(file.exists(RDATA), file.exists(XLSX))

e <- new.env(); load(RDATA, envir = e)
full  <- e$darkwoods_beetle_plots_data
train <- e$beetle_train.data
test  <- e$beetle_test.data
ndmi_m <- e$svm_ndmi_linear
tasb_m <- e$svm_tasbright_linear

cat("=== the two frames ===\n")
cat(sprintf(".RData darkwoods_beetle_plots_data : %d x %d | cols: %s\n",
            nrow(full), ncol(full), paste(names(full), collapse = ", ")))
cat(sprintf("  train %d, test %d\n", nrow(train), nrow(test)))
x <- as.data.frame(read_excel(XLSX))
cat(sprintf("xlsx  2.1.darkwoods_beetle_ground_plots: %d x %d | cols: %s\n",
            nrow(x), ncol(x), paste(names(x), collapse = ", ")))
cat(sprintf("  .RData ndmi range %.4f to %.4f ; xlsx ndmi range %.4f to %.4f\n",
            min(full$ndmi), max(full$ndmi), min(x$ndmi), max(x$ndmi)))
cat(sprintf("  cor(.RData ndmi, pi_mpb_killed) = %.4f ; cor(xlsx ndmi, pi_mpb_killed) = %.4f\n\n",
            cor(full$ndmi, full$pi_mpb_killed), cor(x$ndmi, x$pi_mpb_killed)))

cat("=== nmi vs ndmi, closing the script's line-2 note ===\n")
if (all(c("nmi","ndmi") %in% names(full))) {
  cat(sprintf("cor(ndmi, nmi) = %.6f ; mean(nmi) = %.4f ; mean(ndmi) = %.4f\n\n",
              cor(full$ndmi, full$nmi), mean(full$nmi), mean(full$ndmi)))
} else {
  cat(sprintf("no 'nmi' column in the .RData frame; columns are: %s\n\n",
              paste(names(full), collapse = ", ")))
}

metrics <- function(pred, obs, label) {
  r2 <- caret::R2(pred, obs); r <- ModelMetrics::rmse(obs, pred)
  cat(sprintf("%-42s R2 = %.4f  RMSE = %.4f  MAE = %.4f  RMSE_rel = %5.1f%%  U2 = %.4f\n",
              label, r2, r, ModelMetrics::mae(obs, pred),
              r / mean(obs) * 100, DescTools::TheilU(obs, pred, type = 2)))
  invisible(c(R2 = r2, RMSE = r))
}

cat("=== as published: line 92, wrong model AND data= instead of newdata= ===\n")
metrics(predict(tasb_m, data = train), train$pi_mpb_killed,
        "tasbri model, train (published path)")
cat(sprintf("%-42s R2 = %.4f\n", "value stored as beetle_ndmi_pred_train_R2",
            e$beetle_ndmi_pred_train_R2))

cat("\n=== corrected model, still the broken data= call ===\n")
metrics(predict(ndmi_m, data = train), train$pi_mpb_killed, "ndmi model, train")

cat("\n=== corrected model AND corrected newdata= call ===\n")
tr <- metrics(predict(ndmi_m, newdata = train), train$pi_mpb_killed, "ndmi model, train")
te <- metrics(predict(ndmi_m, newdata = test),  test$pi_mpb_killed,  "ndmi model, HELD-OUT TEST")
cat(sprintf("%-42s test/train RMSE ratio = %.4f\n", "", te["RMSE"] / tr["RMSE"]))

cat("\n=== second defect: predict(fit, data=X) silently ignores X ===\n")
a <- predict(ndmi_m, data = train); b <- predict(ndmi_m, data = full)
cat(sprintf("identical(predict(fit, data=train), predict(fit, data=full)) = %s\n", identical(a, b)))
cat(sprintf("both length %d; nrow(train) = %d, nrow(full) = %d\n",
            length(a), nrow(train), nrow(full)))
cat(sprintf("stored beetle_ndmi_pred_train and beetle_ndmi_pred_test identical = %s\n",
            identical(unname(e$beetle_ndmi_pred_train), unname(e$beetle_ndmi_pred_test))))
cat("  -> parent line 109's test/train RMSE ratio is a guard that cannot fail.\n")

cat("\n=== parent line 91: lm(predict(svm_ndmi_linear) ~ observed) ===\n")
cat(sprintf("r.squared = %.4f\n", summary(lm(predict(ndmi_m) ~ train$pi_mpb_killed))$r.squared))

cat("\n=== recovered svm_ndmi_linear parameters (for the EE band expression) ===\n")
fm <- ndmi_m$finalModel; pp <- ndmi_m$preProcess
cat(sprintf("tuned C = %.6f\n", ndmi_m$bestTune$C))
cat(sprintf("centre  = %.7f\nscale   = %.7f\n", pp$mean["ndmi"], pp$std["ndmi"]))
cat(sprintf("n support vectors = %d\n", fm@nSV))
cat(sprintf("type = %s, epsilon = %s\n", fm@type,
            if (!is.null(fm@param$epsilon)) fm@param$epsilon else NA))
# caret centres/scales the predictor, then kernlab scales AGAIN internally
# (ksvm defaults to scaled = TRUE and also scales the response). Both layers
# must be unwound or the transferred expression is wrong by a factor of ~14.
cf <- kernlab::coef(fm); if (is.list(cf)) cf <- cf[[1]]
xm <- kernlab::xmatrix(fm); if (is.list(xm)) xm <- xm[[1]]
w  <- sum(as.numeric(cf) * as.numeric(xm))
xc <- fm@scaling$x.scale[["scaled:center"]]; xs <- fm@scaling$x.scale[["scaled:scale"]]
yc <- fm@scaling$y.scale[["scaled:center"]]; ys <- fm@scaling$y.scale[["scaled:scale"]]
cat(sprintf("primal weight on caret-scaled predictor = %.7f\n", w))
cat(sprintf("intercept b = %.7f\n", fm@b))
cat(sprintf("kernlab x.scale centre/scale = %.3e / %.7f\n", xc, xs))
cat(sprintf("kernlab y.scale centre/scale = %.7f / %.7f\n", yc, ys))

# collapse both layers into one line in raw NDMI units: severity = A * NDMI + B
A <- (w / xs) * ys / pp$std["ndmi"]
B <- yc - ys * fm@b - (w / xs) * ys * (xc + pp$mean["ndmi"] / pp$std["ndmi"])
manual <- A * train$ndmi + B
cat(sprintf("check: max |manual - predict(train)| = %.3e\n",
            max(abs(manual - predict(ndmi_m, newdata = train)))))
cat(sprintf("check: max |manual - predict(test)|  = %.3e\n",
            max(abs((A * test$ndmi + B) - predict(ndmi_m, newdata = test)))))
cat(sprintf("\nEE BAND EXPRESSION  severity = %.7f * NDMI + %.7f\n", A, B))
cat(sprintf("  valid over the training NDMI range %.4f to %.4f\n",
            min(full$ndmi), max(full$ndmi)))
cat("  NOTE: this .RData ndmi is the 0-1 RESCALED index, not (NIR-SWIR1)/(NIR+SWIR1).\n")
cat(sprintf("  cor(ndmi, nmi) = 1 exactly and nmi is the raw scaled integer (mean %.4f),\n",
            mean(full$nmi)))
cat("  so any imagery-side NDMI must be put on the same 0-1 scale before this applies.\n")

cat("\n=== does ANY stored model reproduce Table 7's R2 = 0.905, RMSE = 4.83? ===\n")
cat("Table 7 (tables/Table_07.docx): NDMI 0.905/4.83 C=0.947 | TAS-Wet 0.904/4.92 C=0.316\n")
cat("                                TAS-Green 0.650/8.87 C=2.368 | TAS-Bright 0.679/8.36 C=1.263\n")
mods <- list(ndmi = e$svm_ndmi_linear, taswet = e$svm_taswet_linear,
             tasgre = e$svm_tasgreen_linear, tasbri = e$svm_tasbright_linear)
for (nm in names(mods)) {
  m <- mods[[nm]]
  ptr <- predict(m, newdata = train); pte <- predict(m, newdata = test)
  cat(sprintf("%-7s stored C = %.6f | train R2 %.4f RMSE %.3f | test R2 %.4f RMSE %.3f\n",
              nm, m$bestTune$C, caret::R2(ptr, train$pi_mpb_killed),
              ModelMetrics::rmse(train$pi_mpb_killed, ptr),
              caret::R2(pte, test$pi_mpb_killed),
              ModelMetrics::rmse(test$pi_mpb_killed, pte)))
}
cat("\nGrid check: seq(0, 3, length = 20) has step 3/19 = 0.1578947.\n")
cat(sprintf("Table 7's C values are all on that grid (0.947=6x, 0.316=2x, 2.368=15x, 1.263=8x),\n"))
cat(sprintf("as is the stored NDMI C = 2.526316 = 16x. So Table 7 came from a DIFFERENT run\n"))
cat("of the same script, not from the workspace saved in .RData.\n")
