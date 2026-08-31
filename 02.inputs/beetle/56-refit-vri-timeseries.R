#!/usr/bin/env Rscript
## Refit every model on year-matched stand structure, and report what changed.
##
## The comparison is like for like: the same covariates, the same selection, the same
## interactions, the same balanced sampling. Only the host columns differ, static 2025
## composite against the year-matched snapshots. Whatever the interaction does, it is
## reported: this test can weaken the refugia result and that outcome is a result.
##
## Writes: model-data/vri_refit_comparison.csv
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle/56-refit-vri-timeseries.R

suppressPackageStartupMessages({library(dplyr); library(pROC)})

ROOT <- "02.inputs/beetle"; MD <- file.path(ROOT, "model-data")
GEO_LAB <- c("flat","peak","ridge","shoulder","spur","slope","hollow","footslope",
             "valley","pit")
EV <- c("elevation","PINE_BA","LIVE_STAND_VOLUME_125","VRI_LIVE_STEMS_PER_HA",
        "QUAD_DIAM_125","CROWN_CLOSURE","tri","vrm","tpi","midslope_position",
        "valley_depth","curv_prof","solar_season_direct","solar_flight_direct",
        "wind_effect","ep_wind_mean")
EINT <- c("VRI_LIVE_STEMS_PER_HA:ep_wind_mean", "LIVE_STAND_VOLUME_125:ep_wind_mean")

fit_epoch <- function(path, label) {
  d <- read.csv(path)
  d <- d[stats::complete.cases(d[, c(EV, "modhigh", "geomorphons")]), ]
  b <- d
  for (v in EV) b[[v]] <- (b[[v]] - mean(b[[v]])) / sd(b[[v]])
  b$geomorphon <- droplevels(factor(GEO_LAB[round(d$geomorphons)], levels = GEO_LAB))
  b$geomorphon <- relevel(b$geomorphon,
                          ref = names(sort(table(b$geomorphon), decreasing = TRUE))[1])
  m <- glm(reformulate(c(EV, "geomorphon", EINT), "modhigh"), data = b, family = binomial)
  co <- as.data.frame(coef(summary(m))); names(co) <- c("beta","se","z","p")
  co$term <- rownames(co)
  g <- function(v, col) { x <- co[[col]][co$term == v]; if (length(x)) x else NA_real_ }
  ## Does host structure actually vary in time now? If it does not, the refit is a no-op
  ## and the comparison below means nothing, so it is measured rather than assumed.
  hv <- d |> group_by(year) |>
    summarise(v = mean(LIVE_STAND_VOLUME_125), s = mean(VRI_LIVE_STEMS_PER_HA),
              .groups = "drop")
  data.frame(
    model = label, n = nrow(d),
    host_years = nrow(hv), host_vol_sd = sd(hv$v), host_stems_sd = sd(hv$s),
    stems_x_wind = g(EINT[1], "beta"), stems_p = g(EINT[1], "p"),
    volume_x_wind = g(EINT[2], "beta"), volume_p = g(EINT[2], "p"),
    volume_main = g("LIVE_STAND_VOLUME_125", "beta"),
    stems_main  = g("VRI_LIVE_STEMS_PER_HA", "beta"),
    wind_main   = g("ep_wind_mean", "beta"),
    AIC = AIC(m),
    AUC = as.numeric(auc(roc(b$modhigh, fitted(m), quiet = TRUE))))
}

res <- bind_rows(
  fit_epoch(file.path(MD, "epoch_model_table.csv"),     "static 2025 composite"),
  fit_epoch(file.path(MD, "epoch_model_table_vri.csv"), "year-matched VRI"))
write.csv(res, file.path(MD, "vri_refit_comparison.csv"), row.names = FALSE)

cat("\n")
print(res |> transmute(model, n,
  `host varies (sd of yearly mean volume)` = sprintf("%.2f", host_vol_sd),
  `stems x wind` = sprintf("%+.4f (p %.3g)", stems_x_wind, stems_p),
  `volume x wind` = sprintf("%+.4f (p %.3g)", volume_x_wind, volume_p),
  AUC = round(AUC, 4)), row.names = FALSE)
