## Predictive-accuracy metrics for the model comparison table.
##
## Sourced by every draft. AIC ranks models on likelihood and a parameter penalty; it
## says nothing about how far the predictions sit from the observations. These are the
## error metrics that answer that, computed on the fitted values of each model.
##
## Which metrics are defined here, and which are not.
##
## The response is binary, moderate-to-high disturbance against everything else, and the
## prediction is a probability. RMSE, MAE and the Brier score are all well defined on
## that pair: the Brier score IS the mean squared error, so RMSE is its square root.
## Relative RMSE is reported against the mean of the observed response, which for a
## binary variable is its prevalence.
##
## MAPE and Theil's U are NOT computed, and the reason is arithmetic rather than taste.
## Both divide by the observed value. In a binary response most observed values are
## zero, so every one of those terms is a division by zero: MAPE is infinite and Theil's
## U undefined. Reporting either would require silently dropping the zeros, which throws
## away the majority class and produces a number that looks like an error rate and is
## not one. The metrics that carry the same information for a classifier are the
## discrimination measures below, so those are given instead.
##
## Requires: pROC.

fit_metrics <- function(model, label = NULL) {
  y <- model$y                       # 0/1 as glm stored it
  p <- fitted(model)                 # predicted probability
  n <- length(y)
  resid <- y - p

  brier <- mean(resid^2)             # mean squared error on the probability scale
  rmse  <- sqrt(brier)
  mae   <- mean(abs(resid))
  ybar  <- mean(y)                   # prevalence, the denominator relative error uses

  ## Log loss, the metric the likelihood is actually built on, clipped so a fitted
  ## probability of exactly 0 or 1 cannot return infinity.
  pc <- pmin(pmax(p, 1e-15), 1 - 1e-15)
  logloss <- -mean(y * log(pc) + (1 - y) * log(1 - pc))

  auc <- as.numeric(pROC::auc(pROC::roc(y, p, quiet = TRUE)))

  ## Skill against the no-covariate model, which predicts the prevalence for every cell.
  ## This is the Brier skill score: 0 is no better than the base rate, 1 is perfect.
  bss <- 1 - brier / mean((y - ybar)^2)

  data.frame(
    Model    = label %||% deparse(substitute(model)),
    n        = n,
    AIC      = AIC(model),
    RMSE     = rmse,
    `RMSE %` = 100 * rmse / ybar,
    MAE      = mae,
    Brier    = brier,
    `Log loss` = logloss,
    AUC      = auc,
    `Brier skill` = bss,
    check.names = FALSE
  )
}

`%||%` <- function(a, b) if (is.null(a)) b else a

## Format the metric table for printing. Decimals follow Journal of Applied Entomology's
## own recent practice: three places on quantities below one, two on percentages, and
## AIC as a whole number with a thousands separator.
fit_metrics_table <- function(...) {
  x <- do.call(rbind, list(...))
  x$dAIC <- x$AIC - min(x$AIC)
  data.frame(
    Model         = x$Model,
    AIC           = formatC(x$AIC, format = "f", digits = 0, big.mark = ","),
    `ΔAIC`        = formatC(x$dAIC, format = "f", digits = 0, big.mark = ","),
    RMSE          = sprintf("%.3f", x$RMSE),
    `RMSE (%)`    = sprintf("%.1f", x$`RMSE %`),
    MAE           = sprintf("%.3f", x$MAE),
    Brier         = sprintf("%.3f", x$Brier),
    `Log loss`    = sprintf("%.3f", x$`Log loss`),
    AUC           = sprintf("%.3f", x$AUC),
    `Brier skill` = sprintf("%.3f", x$`Brier skill`),
    check.names = FALSE
  )
}
