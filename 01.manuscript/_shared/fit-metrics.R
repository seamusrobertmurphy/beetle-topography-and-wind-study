## Predictive-accuracy metrics for the model comparison table.
##
## Sourced by every draft. AIC ranks models on likelihood and a parameter penalty; it
## says nothing about how far the predictions sit from the observations. These are the
## error metrics that answer that, computed on the fitted values of each model, together
## with the overfitting check from cross-validation.
##
## Which metrics are defined here, and which are not.
##
## The response is binary, moderate-to-high disturbance against everything else, and the
## prediction is a probability. RMSE, MAE and the Brier score are all well defined on
## that pair, and the Brier score IS the mean squared error, so RMSE is its square root.
##
## The RMSE ratio is not printed. On 2026-09-02 random ten-fold folds over cell-years gave
## 1.000 to 1.001 for every model, which is what a 26-parameter GLM on 42,791 rows must
## give and says nothing about overfitting on dependent rows; a blocked design by year or
## spatial block is the version worth reporting, if one is ever asked for. cv_rmse() stays
## for that. Seamus's rule of the same day: metrics the study chose not to report are
## design decisions kept out of the reader's sight, not sentences in a caption.
## The RMSE ratio was the overfitting check the 2026 companion paper reports. Each model
## is refitted in three repeats of ten-fold cross-validation, the RMSE of the held-out
## fold is averaged over the thirty test folds and divided by the average RMSE of the
## thirty training folds, and a ratio above 1.1 is read as overfitting. RMSE divided by
## prevalence, which an earlier draft printed as "RMSE (%)", is not that quantity and is
## no longer reported.
##
## Theil's U itself divides by the observed value, which is zero for the majority class
## of a binary response, so it is undefined without discarding that class and is not
## computed. The bias proportion of Theil's decomposition does not have that problem,
## because it is the squared difference between the mean prediction and the mean
## observation over the mean squared error. On training data it is zero by construction
## for any logistic regression with an intercept, so it is reported on the pooled
## held-out predictions of the cross-validation, where it is informative.
##
## Requires: pROC.

cv_rmse <- function(model, k = 10, reps = 3, seed = 20260902) {
  ## Refit by formula on the data object the call names, so any glm fitted with
  ## data = <frame> can be cross-validated without knowing how its formula was built.
  dat <- eval(model$call$data, environment(formula(model)))
  fml <- formula(model)
  yname <- all.vars(fml)[1]
  n <- nrow(dat)
  set.seed(seed)
  tr <- te <- numeric(0)
  pte_all <- yte_all <- numeric(0)
  for (r in seq_len(reps)) {
    fold <- sample(rep(seq_len(k), length.out = n))
    for (f in seq_len(k)) {
      train <- dat[fold != f, , drop = FALSE]
      test  <- dat[fold == f, , drop = FALSE]
      m <- glm(fml, data = train, family = model$family)
      ptr <- fitted(m)
      pte <- predict(m, newdata = test, type = "response")
      yte <- as.numeric(test[[yname]])
      tr <- c(tr, sqrt(mean((m$y - ptr)^2)))
      te <- c(te, sqrt(mean((yte - pte)^2)))
      pte_all <- c(pte_all, pte); yte_all <- c(yte_all, yte)
    }
  }
  mse_te <- mean((yte_all - pte_all)^2)
  list(rmse_train = mean(tr), rmse_test = mean(te), ratio = mean(te) / mean(tr),
       u_bias = (mean(pte_all) - mean(yte_all))^2 / mse_te,
       folds = k, reps = reps)
}

fit_metrics <- function(model, label = NULL, cv = FALSE, k = 10, reps = 3) {
  y <- model$y                       # 0/1 as glm stored it
  p <- fitted(model)                 # predicted probability
  n <- length(y)
  resid <- y - p

  brier <- mean(resid^2)             # mean squared error on the probability scale
  rmse  <- sqrt(brier)
  mae   <- mean(abs(resid))
  ybar  <- mean(y)

  ## Log loss, the metric the likelihood is actually built on, clipped so a fitted
  ## probability of exactly 0 or 1 cannot return infinity.
  pc <- pmin(pmax(p, 1e-15), 1 - 1e-15)
  logloss <- -mean(y * log(pc) + (1 - y) * log(1 - pc))

  auc <- as.numeric(pROC::auc(pROC::roc(y, p, quiet = TRUE)))

  ## Skill against the no-covariate model, which predicts the prevalence for every cell.
  ## This is the Brier skill score: 0 is no better than the base rate, 1 is perfect.
  bss <- 1 - brier / mean((y - ybar)^2)

  cvr <- if (cv) cv_rmse(model, k = k, reps = reps) else
    list(rmse_train = NA, rmse_test = NA, ratio = NA, u_bias = NA)

  data.frame(
    Model    = label %||% deparse(substitute(model)),
    n        = n,
    AIC      = AIC(model),
    RMSE     = rmse,
    `RMSE test` = cvr$rmse_test,
    `RMSE ratio` = cvr$ratio,
    `U bias` = cvr$u_bias,
    MAE      = mae,
    Brier    = brier,
    `Log loss` = logloss,
    AUC      = auc,
    `Brier skill` = bss,
    check.names = FALSE
  )
}

`%||%` <- function(a, b) if (is.null(a)) b else a

## Format the metric table for printing. Decimals follow recent entomology journal
## practice, three places on quantities below one and AIC as a whole number with a
## thousands separator. Brier and log loss are kept in the saved frame for the audit
## but not printed, because Brier is the square of RMSE and log loss is what AIC ranks.
fit_metrics_table <- function(...) {
  x <- do.call(rbind, list(...))
  x$dAIC <- x$AIC - min(x$AIC)
  data.frame(
    Model         = x$Model,
    AIC           = formatC(x$AIC, format = "f", digits = 0, big.mark = ","),
    `ΔAIC`        = formatC(x$dAIC, format = "f", digits = 0, big.mark = ","),
    RMSE          = sprintf("%.3f", x$RMSE),
    MAE           = sprintf("%.3f", x$MAE),
    AUC           = sprintf("%.3f", x$AUC),
    `Brier skill` = sprintf("%.3f", x$`Brier skill`),
    check.names = FALSE
  )
}
