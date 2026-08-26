#!/usr/bin/env Rscript
## Does the terrain signal survive controlling for where lodgepole pine grows?
##
## The test the manuscript turns on. Moderate-to-high attack sits lower, gentler,
## smoother and wetter than unattacked forest in all eight years. Two explanations fit
## that equally well: terrain and exposure limit where beetle reaches, which is the
## Krawchuk refugia hypothesis, or beetle simply follows its host and lodgepole pine
## happens to grow lower, gentler, smoother and wetter. This script fits both models
## per year and reports whether the terrain coefficients hold once host is present.
##
##   m0   modhigh ~ terrain + exposure
##   m1   modhigh ~ terrain + exposure + host cover + host fraction + BEC subzone
##
## A terrain effect that collapses between m0 and m1 was host distribution wearing a
## topographic costume. One that holds is evidence for refugia. Coefficients are on
## standardised predictors so their sizes are comparable, and every year is fitted
## separately because the annual change in the pattern is the object of the study.
##
## Sampling is balanced 1:1 within each year, so intercepts are not landscape
## prevalence and should not be read as such; the annual prevalence sits in
## `modhigh_by_year.csv`.

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

cv <- c(rast(file.path(COV, "covariates.tif")), rast(file.path(COV, "host_covariates.tif")))
forest <- rast(file.path(IN, "ndmi_2005.tif")) > 0.20; forest[forest == 0] <- NA

rows <- list()
for (y in OY) {
  cl <- mask(rast(file.path(OUT, sprintf("modhigh_%d.tif", y))), forest)
  smp <- do.call(rbind, lapply(c("other","modhigh"), function(k) {
    p <- spatSample(ifel(cl == k, 1, NA), size = N_PER_CLASS, method = "random",
                    as.points = TRUE, na.rm = TRUE, exhaustive = TRUE)
    cbind(data.frame(class = k), crds(p), terra::extract(cv, p, ID = FALSE)) }))
  smp$year <- y; smp$modhigh <- as.integer(smp$class == "modhigh")
  rows[[length(rows)+1]] <- smp
}
d <- do.call(rbind, rows)
d$bec <- factor(d$bec)
d <- d[stats::complete.cases(d[, c(TERR, HOST, "bec", "modhigh")]), ]
write.csv(d, file.path(OUT, "refugia_model_data.csv"), row.names = FALSE)
cat(sprintf("rows %d over %d years; host present (pinu_con > 0) on %.1f%%\n",
            nrow(d), length(unique(d$year)), 100*mean(d$pinu_con > 0)))

z <- function(x) (x - mean(x)) / sd(x)
f0 <- as.formula(paste("modhigh ~", paste(TERR, collapse = " + ")))
f1 <- as.formula(paste("modhigh ~", paste(c(TERR, HOST, "bec"), collapse = " + ")))

cat("\nStandardised log-odds coefficients, terrain only (m0) then with host (m1).\n")
cat("A coefficient that shrinks toward zero from m0 to m1 was host distribution.\n\n")
res <- list()
for (y in OY) {
  x <- d[d$year == y, ]
  for (v in c(TERR, HOST)) x[[v]] <- z(x[[v]])
  m0 <- glm(f0, data = x, family = binomial)
  m1 <- glm(f1, data = x, family = binomial)
  a <- coef(summary(m0)); b <- coef(summary(m1))
  r <- data.frame(year = y, term = TERR,
                  m0 = round(a[TERR, "Estimate"], 3),
                  m1 = round(b[TERR, "Estimate"], 3),
                  p_m1 = signif(b[TERR, "Pr(>|z|)"], 2))
  r$retained <- round(ifelse(abs(r$m0) < 1e-6, NA, r$m1 / r$m0), 2)
  res[[length(res)+1]] <- r
  cat(sprintf("--- %d   AIC m0 %.0f -> m1 %.0f   host terms: %s\n", y,
              AIC(m0), AIC(m1),
              paste(sprintf("%s %+.2f", HOST, b[HOST, "Estimate"]), collapse = "  ")))
  print(r[, c("term","m0","m1","retained","p_m1")], row.names = FALSE)
}
tab <- do.call(rbind, res)
write.csv(tab, file.path(OUT, "refugia_coefficients.csv"), row.names = FALSE)

cat("\nAcross all eight years, mean coefficient and mean fraction retained:\n")
s <- do.call(rbind, lapply(split(tab, tab$term), function(x)
  data.frame(term = x$term[1], mean_m0 = round(mean(x$m0), 3),
             mean_m1 = round(mean(x$m1), 3),
             mean_retained = round(mean(x$retained, na.rm = TRUE), 2),
             sign_stable = sum(sign(x$m1) == sign(x$m1[1])))))
print(s[order(-abs(s$mean_m1)), ], row.names = FALSE)
