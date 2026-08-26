#!/usr/bin/env Rscript
## The refugia model: terrain exposure and wind, controlling for host.
##
## Structure, and why it is not one model per year. Wind interpolated from four to
## seven valley stations is nearly flat inside any single year: 2009 spans 7.27 to 7.79
## km/h across 50 km. Its real variation is between years, 6.38 to 7.95 km/h in flight
## mean and 0.329 to 0.434 in calm-hour fraction. A within-year model therefore cannot
## identify a wind effect at all, and a pooled model with year fixed effects cannot
## either, because wind is collinear with year by construction.
##
## So wind enters two ways and they answer different questions.
##   between-year   pooled model, no year term, wind main effects. Asks whether windier
##                  or calmer seasons carry more moderate-to-high attack. Eight annual
##                  observations of wind is a small n and the standard error is not to
##                  be believed on its own; it is reported with that stated.
##   within-year    exposure x calm interaction. Asks whether the advantage of a
##                  sheltered site is larger in a calm season than a windy one, which
##                  is the refugia mechanism in its testable form and IS identified
##                  within year, because exposure varies cell to cell.
##
## Every model carries the host controls, because 28-refugia-model.R showed elevation
## reversed sign and wetness halved once lodgepole pine cover was included.
##
## Sampling is balanced 1:1 per year, so no intercept is landscape prevalence.

suppressPackageStartupMessages(library(terra))
set.seed(42)
ROOT <- "02.inputs/beetle-classification"
IN   <- file.path(ROOT, "ndmi-darkwoods")
OUT  <- file.path(ROOT, "red-stage-darkwoods")
COV  <- file.path(ROOT, "covariates")
OY   <- c(2006:2011, 2013, 2014)
N_PER_CLASS <- 10000L
TERR <- c("elevation","slope","northness","eastness","TRI","TPI","twi","exposure")
HOST <- c("pinu_con","pinu_con_frac","conifer_total")
WIND <- c("flight_mean","flight_p95","flight_calm","flight_windy","jun","jul","aug")

base <- c(rast(file.path(COV, "covariates.tif")), rast(file.path(COV, "host_covariates.tif")))
base <- base[[setdiff(names(base), c("wind_50m","wind_100m","wind_150m"))]]
forest <- rast(file.path(IN, "ndmi_2005.tif")) > 0.20; forest[forest == 0] <- NA

rows <- list()
for (y in OY) {
  wf <- file.path(COV, "wind-hourly", sprintf("wind_metrics_%d.tif", y))
  if (!file.exists(wf)) { cat("no wind for", y, "\n"); next }
  cv <- c(base, rast(wf))
  cl <- mask(rast(file.path(OUT, sprintf("modhigh_%d.tif", y))), forest)
  smp <- do.call(rbind, lapply(c("other","modhigh"), function(k) {
    p <- spatSample(ifel(cl == k, 1, NA), size = N_PER_CLASS, method = "random",
                    as.points = TRUE, na.rm = TRUE, exhaustive = TRUE)
    cbind(data.frame(class = k), crds(p), terra::extract(cv, p, ID = FALSE)) }))
  smp$year <- y; smp$modhigh <- as.integer(smp$class == "modhigh")
  rows[[length(rows)+1]] <- smp
}
d <- do.call(rbind, rows); d$bec <- factor(d$bec)
d <- d[stats::complete.cases(d[, c(TERR, HOST, WIND, "bec", "modhigh")]), ]
write.csv(d, file.path(OUT, "refugia_wind_data.csv"), row.names = FALSE)
cat(sprintf("rows %d across %d years\n", nrow(d), length(unique(d$year))))

cat("\nwind by year (nearly constant within a year, which is the point):\n")
print(round(do.call(rbind, lapply(split(d, d$year), function(x)
  c(flight_mean = mean(x$flight_mean), flight_calm = mean(x$flight_calm),
    sd_within = sd(x$flight_calm)))), 4))

z <- function(x) (x - mean(x)) / sd(x)
dz <- d; for (v in c(TERR, HOST, WIND)) dz[[v]] <- z(dz[[v]])

## ---- between-year: does a calmer season carry more attack? --------------------
fb <- as.formula(paste("modhigh ~", paste(c(TERR, HOST, "bec",
                       "flight_mean","flight_calm","flight_p95"), collapse = " + ")))
mb <- glm(fb, data = dz, family = binomial)
cb <- coef(summary(mb))
cat("\nBETWEEN-YEAR wind terms (n = 8 annual wind values; treat SEs as optimistic):\n")
print(round(cb[c("flight_mean","flight_calm","flight_p95"), ], 4))

## ---- within-year: is shelter worth more in a calm season? --------------------
fi <- as.formula(paste("modhigh ~", paste(c(TERR, HOST, "bec",
                       "flight_calm", "exposure:flight_calm",
                       "TRI:flight_calm"), collapse = " + ")))
mi <- glm(fi, data = dz, family = binomial)
ci <- coef(summary(mi))
cat("\nWITHIN-YEAR interactions (identified: exposure and TRI vary cell to cell):\n")
print(round(ci[grep(":", rownames(ci)), , drop = FALSE], 4))
cat(sprintf("\nexposure main effect %+.3f (p %.2g); TRI main effect %+.3f (p %.2g)\n",
            ci["exposure","Estimate"], ci["exposure","Pr(>|z|)"],
            ci["TRI","Estimate"], ci["TRI","Pr(>|z|)"]))
cat(sprintf("AIC: terrain+host %.0f -> plus wind %.0f -> plus interactions %.0f\n",
            AIC(glm(as.formula(paste("modhigh ~", paste(c(TERR, HOST, "bec"), collapse = " + "))),
                    data = dz, family = binomial)), AIC(mb), AIC(mi)))

## ---- per-year exposure effect against that year's calm fraction ---------------
cat("\nPer-year exposure coefficient against that year's calm-hour fraction:\n")
pe <- do.call(rbind, lapply(split(dz, dz$year), function(x) {
  m <- glm(as.formula(paste("modhigh ~", paste(c(TERR, HOST, "bec"), collapse = " + "))),
           data = x, family = binomial)
  data.frame(year = x$year[1], calm = round(mean(d$flight_calm[d$year == x$year[1]]), 3),
             exposure = round(coef(m)["exposure"], 3),
             p = signif(coef(summary(m))["exposure","Pr(>|z|)"], 2)) }))
print(pe, row.names = FALSE)
cat(sprintf("\ncorrelation across the 8 years between calm fraction and exposure effect: %+.3f\n",
            cor(pe$calm, pe$exposure)))
cat("  positive means shelter matters more in calmer seasons, which is the refugia prediction\n")
write.csv(pe, file.path(OUT, "exposure_by_calm.csv"), row.names = FALSE)
