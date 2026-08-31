#!/usr/bin/env Rscript
## Refit the 16-day refugia model under each flight-window definition.
##
## The question this answers. The manuscript's result is a negative interaction between
## stand density and terrain-resolved wind: a dense canopy is worth less where and when
## the wind blows harder, which is what pheromone disruption requires. That result is
## currently fitted on a wind variable averaged over all 24 hours of each epoch, including
## the hours no beetle flies. If the mechanism is real, restricting the wind to the hours
## flight is thermally possible should SHARPEN the interaction. If the interaction instead
## weakens, it was partly an artefact of averaging across hours the insect was absent.
##
## The test can fail, and a failure is reported as a failure.
##
## Writes: model-data/flight_window_sensitivity.csv
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle/53-refit-flight-window.R

suppressPackageStartupMessages({library(terra); library(dplyr)})

ROOT <- "02.inputs/beetle"
SENS <- file.path(ROOT, "covariates", "wind-epoch-sensitivity")
DEFS <- c("all24", "h12_17", "h11_18", "gate")

de <- read.csv(file.path(ROOT, "model-data", "epoch_model_table.csv"))
cat(sprintf("epoch model table: %d cell-epochs, %d epochs\n", nrow(de), length(unique(de$t))))

## The covariate set and the interaction the manuscript reports, unchanged.
EV <- c("elevation","PINE_BA","LIVE_STAND_VOLUME_125","VRI_LIVE_STEMS_PER_HA",
        "QUAD_DIAM_125","CROWN_CLOSURE","tri","vrm","tpi","midslope_position",
        "valley_depth","curv_prof","solar_season_direct","solar_flight_direct",
        "wind_effect","ep_wind_mean")
GEO_LAB <- c("flat","peak","ridge","shoulder","spur","slope","hollow","footslope",
             "valley","pit")
EINT <- c("VRI_LIVE_STEMS_PER_HA:ep_wind_mean", "LIVE_STAND_VOLUME_125:ep_wind_mean")

pts <- vect(as.matrix(de[, c("x","y")]), crs = "EPSG:3153")

fit_one <- function(def) {
  ## Replace ep_wind_mean with the value this definition gives at each cell-epoch.
  w <- rep(NA_real_, nrow(de))
  for (k in unique(paste(de$year, de$epoch))) {
    p <- strsplit(k, " ")[[1]]
    f <- file.path(SENS, sprintf("wind_%s_%s_e%02d.tif", def, p[1], as.integer(p[2])))
    if (!file.exists(f)) next
    idx <- de$year == as.integer(p[1]) & de$epoch == as.integer(p[2])
    w[idx] <- terra::extract(rast(f), pts[idx])[, 2]
  }
  d <- de; d$ep_wind_mean <- w
  d <- d[!is.na(d$ep_wind_mean), ]
  if (!nrow(d)) return(NULL)

  b <- d
  for (v in EV) b[[v]] <- (b[[v]] - mean(b[[v]], na.rm = TRUE)) / sd(b[[v]], na.rm = TRUE)
  b$geomorphon <- droplevels(factor(GEO_LAB[round(d$geomorphons)], levels = GEO_LAB))
  b$geomorphon <- relevel(b$geomorphon,
                          ref = names(sort(table(b$geomorphon), decreasing = TRUE))[1])
  m <- glm(reformulate(c(EV, "geomorphon", EINT), "modhigh"), data = b, family = binomial)
  co <- as.data.frame(coef(summary(m))); names(co) <- c("beta","se","z","p")
  co$term <- rownames(co)
  auc <- as.numeric(pROC::auc(pROC::roc(b$modhigh, fitted(m), quiet = TRUE)))
  g <- function(v, col) { x <- co[[col]][co$term == v]; if (length(x)) x else NA_real_ }
  data.frame(
    definition = def, n = nrow(d), hours_note = "",
    wind_mean = mean(d$ep_wind_mean), wind_sd = sd(d$ep_wind_mean),
    stems_x_wind    = g(EINT[1], "beta"), stems_p    = g(EINT[1], "p"),
    volume_x_wind   = g(EINT[2], "beta"), volume_p   = g(EINT[2], "p"),
    wind_main       = g("ep_wind_mean", "beta"), wind_main_p = g("ep_wind_mean", "p"),
    AIC = AIC(m), AUC = auc)
}

res <- bind_rows(lapply(DEFS, function(d) { cat("  fitting", d, "\n"); fit_one(d) }))
write.csv(res, file.path(ROOT, "model-data", "flight_window_sensitivity.csv"), row.names = FALSE)

cat("\n")
print(res |> transmute(definition, n,
        wind = sprintf("%.2f (sd %.2f)", wind_mean, wind_sd),
        `stems x wind` = sprintf("%+.4f (p %.3g)", stems_x_wind, stems_p),
        `volume x wind` = sprintf("%+.4f (p %.3g)", volume_x_wind, volume_p),
        AIC = round(AIC), AUC = round(AUC, 3)),
      row.names = FALSE)
