#!/usr/bin/env Rscript
## Coefficient tables for the manuscript's wind-disruption test.
##
## 31-refugia-model-wind.R fits the models and writes its 62 MB sample to
## refugia_wind_data.csv, which is too large to commit and so cannot travel with a
## clone. This script refits from that sample and writes the small tables the
## manuscript reads at render time, on the same discipline as the literature
## review's screening table: the prose quotes a file, and the file is produced by
## saved code rather than typed.
##
## SIGN CONVENTION, and it is the one thing to get right here. `exposure` is a
## cell's elevation minus the mean of a 990 m neighbourhood (25-terrain-wind-
## covariates.R). POSITIVE MEANS EXPOSED: the cell stands above its surroundings,
## a convexity or ridge, the ground the refugia hypothesis says wind should
## protect. NEGATIVE MEANS SHELTERED. A positive coefficient on `exposure`
## therefore means exposed ground carries MORE attack, which contradicts the
## hypothesis rather than supporting it. The comments in 31-refugia-model-wind.R
## called this term "shelter" and had the reading backwards.

set.seed(42)
ROOT <- "02.inputs/beetle"
OUT  <- file.path(ROOT, "red-stage-darkwoods")
TERR <- c("elevation","slope","northness","eastness","TRI","TPI","twi","exposure")
HOST <- c("pinu_con","pinu_con_frac","conifer_total")
WIND <- c("flight_mean","flight_p95","flight_calm","flight_windy","jun","jul","aug")

d <- read.csv(file.path(OUT, "refugia_wind_data.csv"))
d$bec <- factor(d$bec)
z <- function(x) (x - mean(x)) / sd(x)
dz <- d; for (v in c(TERR, HOST, WIND)) dz[[v]] <- z(dz[[v]])

f <- function(extra = character(0))
  as.formula(paste("modhigh ~", paste(c(TERR, HOST, "bec", extra), collapse = " + ")))

m_base <- glm(f(), data = dz, family = binomial)
m_wind <- glm(f(c("flight_mean","flight_calm","flight_p95")), data = dz, family = binomial)
m_int  <- glm(f(c("flight_calm","exposure:flight_calm","TRI:flight_calm")),
              data = dz, family = binomial)

tab <- function(m, model) {
  ct <- coef(summary(m))
  keep <- !grepl("^bec", rownames(ct))
  data.frame(model = model, term = rownames(ct)[keep],
             beta = round(ct[keep, "Estimate"], 4),
             se = round(ct[keep, "Std. Error"], 4),
             z = round(ct[keep, "z value"], 2),
             p = signif(ct[keep, "Pr(>|z|)"], 3), row.names = NULL)
}
co <- rbind(tab(m_base, "terrain_host"), tab(m_wind, "plus_wind"), tab(m_int, "plus_interactions"))
write.csv(co, file.path(OUT, "refugia_wind_coefficients.csv"), row.names = FALSE)

## Between-year support for the interaction, which is the weak half of the result:
## eight annual wind values, so the correlation is quoted with its p-value and n.
pe <- read.csv(file.path(OUT, "exposure_by_calm.csv"))
ct <- cor.test(pe$calm, pe$exposure)

## Raw exposure contrast, so the prose can state the effect in metres as well as
## in standardised log-odds.
sm <- data.frame(
  rows = nrow(d), years = length(unique(d$year)),
  bec_units = nlevels(d$bec),
  expo_modhigh = round(mean(d$exposure[d$modhigh == 1]), 3),
  expo_other = round(mean(d$exposure[d$modhigh == 0]), 3),
  expo_min = round(min(d$exposure), 1), expo_max = round(max(d$exposure), 1),
  calm_min = round(min(pe$calm), 3), calm_max = round(max(pe$calm), 3),
  calm_r = round(unname(ct$estimate), 3), calm_p = round(ct$p.value, 3), calm_n = nrow(pe),
  aic_base = round(AIC(m_base)), aic_wind = round(AIC(m_wind)), aic_int = round(AIC(m_int)))
write.csv(sm, file.path(OUT, "refugia_wind_summary.csv"), row.names = FALSE)

print(sm)
print(co[co$term %in% c("exposure","TRI","flight_calm","flight_mean",
                        "exposure:flight_calm","TRI:flight_calm"), ])
