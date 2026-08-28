---
title: "Testing the wind disruption hypothesis for beetle refugia"
subtitle: "Stand density, terrain shape and flight-window wind as competing controls on mountain pine beetle attack (Dendroctonus ponderosae) in the Selkirk Mountains of British Columbia"
author:
  - name: Seamus Murphy
    orcid: 0000-0002-1792-0351
    email: seamusrobertmurphy@gmail.com
keywords:
  - Beetle refugia
  - Mountain pine beetle
  - Stand density
  - Geomorphometry
  - Wind exposure
  - Pheromone disruption

date: today
keep-md: true

format:
  docx:
    prefer-html: true
    reference-doc: ../04.references/style-formal.docx
    highlight-style: pygments
    number-sections: true
  html:
    page-layout: full
    toc: true
    number-sections: true
    embed-resources: true
    toc-title: ""
    toc-location: right
    toc-depth: 3
    theme:
      - ../04.references/style.scss
      - cosmo
    code-fold: false
    code-tools: true
    code-link: true
    grid:
      body-width: 1100px
      margin-width: 220px

execute:
  eval: true
  echo: true
  warning: false
  message: false
  error: false
  comment: NA

always_allow_html: true
engine: knitr
citeproc: true
editor: visual
bibliography: ../04.references/references-beetle.bib
csl: ../04.references/springer-basic-author-date.csl
df-print: kable
---


::: {.cell}

```{.r .cell-code}
## Every quantity in this manuscript is computed here at render time. No number in the
## prose is typed: each is an inline expression over an object built in a chunk below.
## error = FALSE on purpose. In a document whose numbers are all computed, a chunk that
## fails quietly while downstream inline expressions carry stale values is the single
## failure this design exists to prevent.

suppressPackageStartupMessages({
  library(terra); library(sf); library(dplyr); library(tidyr); library(ggplot2)
  library(knitr); library(mgcv); library(car); library(ranger); library(patchwork)
  library(tidyterra); library(ggspatial); library(e1071)
})

## Shared with every draft of this study, so the three cannot show different maps of the
## same landscape or different metrics for the same model. Edit those files, not this one.
for (.f in c("map-academic", "fit-metrics", "describe", "diameter-test"))
  source(file.path("_shared", paste0(.f, ".R")))
set.seed(42)
knitr::opts_chunk$set(dpi = 300, fig.width = 9, fig.height = 6)

here <- function(...) file.path("..", ...)          # repo-relative, from 01.manuscript/
BC   <- here("02.inputs", "beetle-classification")
SA   <- file.path(BC, "study-area")
LIT  <- here("02.inputs", "literature")

fmt <- function(x, d = 0) formatC(x, format = "f", digits = d, big.mark = ",")
pv  <- function(p) if (p < 1e-16) "< 1e-16" else sprintf("%.3g", p)
```
:::



<!-- Computation runs here, in one block, because the Abstract below is computed
     from the results and knitr evaluates inline expressions in document order.
     Every chunk keeps its own label, code and comments; only its position moved. -->


::: {.cell}

```{.r .cell-code}
## Two screening products are read, both built by scripts committed with the manuscript
## so that every count below is checkable rather than remembered.
##
##   review-screening.csv    the systematic screen of the terrain-and-attack corpus,
##                           02.inputs/literature/build-review-screening.py
##   wind-temporal-summary   the temporal-resolution extraction, built by
##                           02.inputs/literature/extract-wind-temporal.py
##   mechanism-summary.csv   the mechanism extraction, built by
##                           02.inputs/literature/extract-mechanism.py, which reads the
##                           full text of every mountain pine beetle and refugia paper
##                           in the central store and writes out every sentence that
##                           mentions wind together with a mechanism term.

rev <- read.csv(file.path(LIT, "review-screening.csv"), stringsAsFactors = FALSE)
wt  <- read.csv(file.path(LIT, "wind-temporal-summary.csv"), stringsAsFactors = FALSE)
mech_sent <- read.csv(file.path(LIT, "mechanism-evidence.csv"), stringsAsFactors = FALSE)
mech <- read.csv(file.path(LIT, "mechanism-summary.csv"), stringsAsFactors = FALSE)

N_INC    <- sum(rev$stage2_include == "yes", na.rm = TRUE)
N_WIND   <- sum(rev$stage2_include == "yes" & rev$wind_predictor == "yes", na.rm = TRUE)
N_NOWIND <- N_INC - N_WIND
YR_RANGE <- range(rev$year[rev$stage2_include == "yes"], na.rm = TRUE)

MECH_PAPERS <- nrow(mech)
MECH_SENT   <- nrow(mech_sent)
N_PHER  <- sum(mech$pheromone > 0)
N_DENS  <- sum(mech$density  > 0)
N_TERR  <- sum(mech$terrain  > 0)
N_FLIGHT<- sum(mech$flight   > 0)
```
:::



::: {.cell}

```{.r .cell-code}
WT_TOTAL  <- nrow(wt)
WT_NOWIND <- sum(wt$n_wind == 0, na.rm = TRUE)
WT_WIND   <- WT_TOTAL - WT_NOWIND
## "scales" is the temporal vocabulary the extraction found; empty means the study
## mentions wind and says nothing about over what interval.
WT_SILENT <- sum(wt$n_wind > 0 & (is.na(wt$scales) | wt$scales == ""), na.rm = TRUE)
```
:::



::: {.cell}

```{.r .cell-code}
msk  <- rast(file.path(SA, "perimeter_mask.tif"))
elev <- rast(file.path(SA, "elevation.tif"))
per  <- st_read(file.path(SA, "study_perimeter.gpkg"), quiet = TRUE)
DATA <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
burn <- st_transform(st_union(st_read(file.path(DATA, "fire_perimiter", "Fire.Perimiter.shp"),
                                      quiet = TRUE)), 3153)

N_CELL  <- sum(!is.na(values(msk)))
AREA_HA <- N_CELL * 900 / 1e4
BURN_HA <- as.numeric(st_area(burn)) / 1e4
ELEV_R  <- as.vector(minmax(elev))
EPSG    <- crs(msk, describe = TRUE)$code
CRSNAME <- crs(msk, describe = TRUE)$name
burn_e  <- range(values(mask(crop(elev, vect(burn)), vect(burn))), na.rm = TRUE)
```
:::



::: {.cell}

```{.r .cell-code}
d <- read.csv(file.path(BC, "model-data", "model_table.csv"), stringsAsFactors = FALSE)
YRS      <- sort(unique(d$year))
N_ROWS   <- nrow(d)
PREV     <- mean(d$modhigh)
prev_yr  <- d |> group_by(year) |> summarise(prev = mean(modhigh), n = n())
```
:::



::: {.cell}

```{.r .cell-code}
VRI_V <- c("BASAL_AREA","CROWN_CLOSURE","VRI_LIVE_STEMS_PER_HA","QUAD_DIAM_125",
           "PROJ_AGE_1","PROJ_HEIGHT_1","LIVE_STAND_VOLUME_125","PinePct","PINE_BA")
QMD_THRESH <- 25
PCT_ABOVE_QMD <- 100 * mean(d$QUAD_DIAM_125 >= QMD_THRESH)
```
:::



::: {.cell}

```{.r .cell-code}
## Read from the raster, never typed. A hardcoded list here reported 20 surfaces after
## the stack had grown to 29, because the radiation and slope-position layers were added
## to the pipeline and not to the list.
GEO_V <- names(rast(file.path(BC, "geomorphometry", "geomorphometry.tif")))
wdir <- read.csv(file.path(BC, "covariates", "wind_direction_flight_window.csv"))
WDIR <- as.numeric(readLines(file.path(BC, "covariates", "wind_direction_pooled.txt")))
```
:::



::: {.cell}

```{.r .cell-code}
WIND_V <- c("jun","jul","aug","flight_mean","flight_p95","flight_calm","flight_windy")
wind_yr <- d |> group_by(year) |>
  summarise(across(all_of(WIND_V), mean))
```
:::



::: {.cell}

```{.r .cell-code}
## The candidate set, grouped by the pathway each variable belongs to. Grouping is not
## cosmetic: the selection below is required to retain at least one variable from each
## pathway, so a collinearity filter cannot silently delete a hypothesis.

## The candidate set, grouped by the mechanism each variable belongs to. Grouping is not
## cosmetic: selection is required to retain at least one variable from each group, so a
## collinearity filter cannot silently delete a hypothesis.
##
## The first three groups are Krawchuk et al.'s (2020) own three mechanisms, in their
## order: topographic shading, host density, and large-diameter host. The remaining
## groups carry terrain shape and the thermal gate on
## flight, plus the landscape context that has to be controlled.

PATH <- list(
  ## Topographic shading. Season radiation is the tree's water-stress load; sky view
  ## and openness are the geometry that produces it.
  shading  = c("solar_season_direct","solar_season_total","sky_view","heat_load",
               "northness","eastness"),
  ## Host density: the pathway the pheromone argument says wind acts through.
  density  = c("BASAL_AREA","CROWN_CLOSURE","VRI_LIVE_STEMS_PER_HA","LIVE_STAND_VOLUME_125"),
  ## Large-diameter host, against the 25 cm source-sink threshold.
  hostsize = c("QUAD_DIAM_125","PROJ_HEIGHT_1","PROJ_AGE_1","PinePct","PINE_BA"),
  ## The thermal gate on flight: radiation during the flight window, in the hours
  ## the flight peak occupies, rather than an annual index.
  flightsun = c("solar_flight_direct","solar_flight_diffuse"),
  ## Terrain exposure to wind.
  wind_geo = c("wind_effect","wind_afh","wind_exposition","wind_shelter",
               "openness_pos","openness_neg"),
  ## Terrain shape, including the parent study's ruggedness term.
  shape    = c("tri","vrm","tpi","mstpi","convergence","slope","curv_prof","curv_plan"),
  ## The landforms the literature names, plus elevation.
  landform = c("elevation","twi","valley_depth","height_valley_floor",
               "normalised_height","midslope_position"),
  ## Flight-window wind at hourly source resolution, interpolated from stations. Nearly
  ## flat within any year, so it carries the between-year signal only.
  wind_t   = c("flight_mean","flight_p95","flight_calm","flight_windy","jun","jul","aug"),
  ## Flight-window wind after terrain modification by MicroMet, which does vary within
  ## the year across the grid. Only the mean is carried: the calm fraction is its mirror
  ## image at r = -0.98 and entering both puts two collinear terms in with the same sign.
  wind_mm  = c("mm_flight_mean")
)
CAND <- unlist(PATH, use.names = FALSE)
stopifnot(all(CAND %in% names(d)))
N_CAND <- length(CAND)

## Balanced sample per year. The landscape prevalence is about 11 per cent, and an
## unbalanced fit at that prevalence reports the intercept, not the covariates.
bal <- d |> group_by(year, modhigh) |>
  slice_sample(n = 4000, replace = FALSE) |> ungroup()
N_BAL <- nrow(bal)

z <- function(x) (x - mean(x)) / sd(x)
bz <- bal; for (v in CAND) bz[[v]] <- z(bz[[v]])

## Geomorphons are a landform CLASS, not a magnitude, so they cannot be z-scored,
## correlated or ranked by variance inflation alongside the continuous candidates. They
## enter every model as a factor instead, bypassing the numeric selection stages, with
## the most common class as the reference level. The ten-class scheme is Jasiewicz and
## Stepien's; classes 1 and 10, flat and pit, do not occur on this perimeter.
GEO_LAB <- c("flat","peak","ridge","shoulder","spur","slope","hollow","footslope",
             "valley","pit")
bz$geomorphon <- factor(GEO_LAB[bal$geomorphons], levels = GEO_LAB)
bz$geomorphon <- droplevels(bz$geomorphon)
bz$geomorphon <- relevel(bz$geomorphon,
                         ref = names(sort(table(bz$geomorphon), decreasing = TRUE))[1])
GEOM_REF <- levels(bz$geomorphon)[1]
GEOM_N   <- nlevels(bz$geomorphon)
```
:::



::: {.cell}

```{.r .cell-code}
uni <- lapply(CAND, function(v) {
  m <- glm(reformulate(v, "modhigh"), data = bz, family = binomial)
  s <- coef(summary(m))
  data.frame(term = v,
             group = names(PATH)[sapply(PATH, function(g) v %in% g)][1],
             beta = s[v, "Estimate"], p = s[v, "Pr(>|z|)"],
             auc = as.numeric(pROC::auc(pROC::roc(bz$modhigh, fitted(m), quiet = TRUE))))
}) |> bind_rows() |> arrange(desc(auc))
UNI_KEEP <- uni$term[uni$p < 0.01]
```
:::



::: {.cell}

```{.r .cell-code}
cm <- cor(bz[, CAND], use = "complete.obs")
hc <- hclust(as.dist(1 - abs(cm)), method = "average")
CUT <- 0.25                                  # clusters at |r| >= 0.75
cl  <- cutree(hc, h = CUT)

## Within each cluster keep the variable with the highest univariate AUC, so the survivor
## is chosen on its relationship to the response rather than on alphabetical order.
keep_cluster <- sapply(split(names(cl), cl), function(vs)
  vs[which.max(uni$auc[match(vs, uni$term)])])
CLUST_KEEP <- intersect(unname(keep_cluster), UNI_KEEP)
N_CLUST <- length(unique(cl))
```
:::



::: {.cell}

```{.r .cell-code}
vif_drop <- function(vars, thresh = 5) {
  dropped <- character(0)
  repeat {
    if (length(vars) < 2) break
    m <- glm(reformulate(vars, "modhigh"), data = bz, family = binomial)
    v <- car::vif(m)
    if (max(v) < thresh) break
    worst <- names(v)[which.max(v)]
    ## A pathway is never emptied: if dropping this variable would remove the last
    ## member of its group, the next worst is taken instead.
    grp <- names(PATH)[sapply(PATH, function(g) worst %in% g)][1]
    if (sum(vars %in% PATH[[grp]]) <= 1) {
      v <- v[setdiff(names(v), worst)]
      if (!length(v) || max(v) < thresh) break
      worst <- names(v)[which.max(v)]
    }
    vars <- setdiff(vars, worst); dropped <- c(dropped, worst)
  }
  list(keep = vars, dropped = dropped)
}
vf <- vif_drop(CLUST_KEEP)
VIF_KEEP <- vf$keep
vif_final <- car::vif(glm(reformulate(VIF_KEEP, "modhigh"), data = bz, family = binomial))
```
:::



::: {.cell}

```{.r .cell-code}
rf <- ranger::ranger(as.factor(modhigh) ~ ., data = bz[, c("modhigh", VIF_KEEP)],
                     num.trees = 500, importance = "permutation",
                     probability = TRUE, seed = 42)
imp <- data.frame(term = names(rf$variable.importance),
                  importance = as.numeric(rf$variable.importance)) |>
  left_join(uni |> select(term, group), by = "term") |>
  arrange(desc(importance))
RF_AUC <- as.numeric(pROC::auc(pROC::roc(bz$modhigh, rf$predictions[, 2], quiet = TRUE)))
FINAL <- imp$term
```
:::



::: {.cell}

```{.r .cell-code}
DENS <- intersect(FINAL, PATH$density)
WGEO <- intersect(FINAL, PATH$wind_geo)
WTMP <- intersect(FINAL, PATH$wind_t)
WMM  <- intersect(FINAL, PATH$wind_mm)
SHAD <- intersect(FINAL, PATH$shading)
FSUN <- intersect(FINAL, PATH$flightsun)
HSIZ <- intersect(FINAL, PATH$hostsize)
SHAP <- intersect(FINAL, PATH$shape)
LFRM <- intersect(FINAL, PATH$landform)
```
:::



::: {.cell}

```{.r .cell-code}
## Geomorphon class is in every model, including M0: it is a description of landform,
## not a hypothesis being added, and leaving it out of the baseline would let it be
## credited to whichever pathway entered next.
f <- function(vars, extra = character(0))
  reformulate(c(vars, "geomorphon", extra), "modhigh")

## M0 is host size and topographic shading together with the
## landform context that must be controlled before any of the rest can be read.
V_CTX  <- c(HSIZ, SHAD, LFRM)
M0 <- glm(f(V_CTX), data = bz, family = binomial)
M1 <- glm(f(c(V_CTX, DENS)), data = bz, family = binomial)
M2 <- glm(f(c(V_CTX, DENS, WGEO, SHAP, FSUN)), data = bz, family = binomial)

INT <- character(0)
if (length(DENS) && length(WGEO)) INT <- c(INT, paste0(DENS[1], ":", WGEO[1]))
if (length(DENS) && length(WTMP)) INT <- c(INT, paste0(DENS[1], ":", WTMP[1]))
## The interaction objective 4 requires, plus the one the thermal gate implies: whether the flight-
## window radiation a slope receives changes what stand density buys, since a stand the
## beetle cannot reach at flight temperature is not a stand density can protect.
if (length(DENS) && length(FSUN)) INT <- c(INT, paste0(DENS[1], ":", FSUN[1]))
M3 <- glm(f(c(V_CTX, DENS, WGEO, SHAP, FSUN, WTMP), INT),
          data = bz, family = binomial)

## The counterfactual the Results section turns on: the same model with flight-window
## radiation removed. Fitted here so the coefficient quoted for it is computed, not
## remembered from an earlier draft.
M3_norad <- glm(f(c(setdiff(c(V_CTX, DENS, WGEO, SHAP), FSUN), WTMP),
                  setdiff(INT, paste0(DENS[1], ":", FSUN[1]))),
                data = bz, family = binomial)
cnr <- as.data.frame(coef(summary(M3_norad)))
names(cnr) <- c("beta", "se", "z", "p"); cnr$term <- rownames(cnr)
bnr <- function(v) sprintf("%+.3f", cnr$beta[cnr$term == v])
znr <- function(v) sprintf("%.1f", cnr$z[cnr$term == v])
pnr <- function(v) pv(cnr$p[cnr$term == v])

## M4 adds previous-year beetle pressure, following the autologistic design of
## Aukema et al. (2007), who fit environmental covariates "in addition to 1st order
## spatial and lag-1 and lag-2 temporal terms". Persistence and spread enter separately:
## lag_self is whether the cell itself was attacked last year, lag_nbr90 the fraction of
## its 90 m neighbourhood that was, excluding itself. 2006 has no predecessor and drops,
## so M4 is fitted on the seven year-pairs and is not AIC-comparable with M0 to M3.
bl <- bz[!is.na(bz$lag_self), ]
LAGV <- c("lag_self","lag_nbr90","lag_nbr510")
for (v in LAGV) bl[[v]] <- (bl[[v]] - mean(bl[[v]])) / sd(bl[[v]])
M3l <- glm(formula(M3), data = bl, family = binomial)
M4  <- glm(f(c(V_CTX, DENS, WGEO, SHAP, FSUN, WTMP, LAGV), INT),
           data = bl, family = binomial)

## M5 replaces the station wind terms with the terrain-resolved MicroMet field, which is
## the only wind variable in this study that varies within a year. Its main effect is
## therefore identified in space, unlike the station terms, and its interaction with stand
## density is the spatial form of the test the station terms could only make in time.
INT_MM <- if (length(DENS) && length(WMM)) paste0(DENS[1], ":", WMM[1]) else character(0)
INT_NOW <- INT[!grepl(paste0(":", paste(PATH$wind_t, collapse = "|:")), INT)]
M5 <- glm(f(c(V_CTX, DENS, WGEO, SHAP, FSUN, LAGV, WMM), c(INT_NOW, INT_MM)),
          data = bl, family = binomial)
co5 <- as.data.frame(coef(summary(M5)))
names(co5) <- c("beta","se","z","p"); co5$term <- rownames(co5)
b5 <- function(v) sprintf("%+.3f", co5$beta[co5$term == v])
z5 <- function(v) sprintf("%.1f", co5$z[co5$term == v])
p5 <- function(v) pv(co5$p[co5$term == v])
AUC5 <- as.numeric(pROC::auc(pROC::roc(bl$modhigh, fitted(M5), quiet = TRUE)))
co4 <- as.data.frame(coef(summary(M4)))
names(co4) <- c("beta", "se", "z", "p"); co4$term <- rownames(co4)
b4 <- function(v) sprintf("%+.3f", co4$beta[co4$term == v])
z4 <- function(v) sprintf("%.1f", co4$z[co4$term == v])
p4 <- function(v) pv(co4$p[co4$term == v])
co3l <- as.data.frame(coef(summary(M3l)))
names(co3l) <- c("beta","se","z","p"); co3l$term <- rownames(co3l)
b3l <- function(v) sprintf("%+.3f", co3l$beta[co3l$term == v])

## What autocorrelation does to every environmental coefficient, on the same rows.
shift <- merge(co3l[, c("term","beta")], co4[, c("term","beta")], by = "term",
               suffixes = c("_env", "_auto"))
shift <- shift[!grepl("^\\(Intercept|^geomorphon|^lag_", shift$term), ]
shift$retained <- shift$beta_auto / shift$beta_env
shift <- shift[order(-abs(shift$beta_env)), ]
AUC3l <- as.numeric(pROC::auc(pROC::roc(bl$modhigh, fitted(M3l), quiet = TRUE)))
AUC4  <- as.numeric(pROC::auc(pROC::roc(bl$modhigh, fitted(M4),  quiet = TRUE)))

## ---- the 16-day series -------------------------------------------------------------
## The annual response gives eight observations in time, so a wind effect can only be
## tested as a comparison between summers. Landsat repeats every 16 days, which is the
## finest cadence the sensor supports, and 42- to 45- rebuild the whole chain at that
## cadence: imagery, classification, terrain-resolved wind and the modelling table. Wind
## then varies both across the grid within an epoch and between the 59 epochs, so its
## effect is identified in space and in time rather than across eight annual values.
de <- read.csv(file.path(BC, "model-data", "epoch_model_table.csv"))
EP_N     <- nrow(de); EP_EPOCHS <- length(unique(de$t)); EP_YEARS <- length(unique(de$year))
epsum    <- read.csv(file.path(BC, "epoch-response", "epoch_summary.csv"))
epwind   <- read.csv(file.path(BC, "covariates", "wind-epoch", "epoch_wind_summary.csv"))

EV <- c("elevation","PINE_BA","LIVE_STAND_VOLUME_125","VRI_LIVE_STEMS_PER_HA",
        "QUAD_DIAM_125","CROWN_CLOSURE","tri","vrm","tpi","midslope_position",
        "valley_depth","curv_prof","solar_season_direct","solar_flight_direct",
        "wind_effect","ep_wind_mean")
be <- de; for (v in EV) be[[v]] <- (be[[v]] - mean(be[[v]])) / sd(be[[v]])
be$geomorphon <- droplevels(factor(GEO_LAB[round(de$geomorphons)], levels = GEO_LAB))
be$geomorphon <- relevel(be$geomorphon,
                         ref = names(sort(table(be$geomorphon), decreasing = TRUE))[1])
EINT <- c("VRI_LIVE_STEMS_PER_HA:ep_wind_mean", "LIVE_STAND_VOLUME_125:ep_wind_mean")

E1 <- glm(reformulate(c(EV, "geomorphon", EINT), "modhigh"), data = be, family = binomial)

## The same model with the previous epoch in the same season entered, so the interaction
## is read after within-season spread rather than alongside it.
esel <- !is.na(be$ep_lag_self) & !is.na(be$ep_lag_nbr90)
bel <- be[esel, ]
bel$geomorphon <- relevel(droplevels(bel$geomorphon),
                          ref = names(sort(table(droplevels(bel$geomorphon)), decreasing = TRUE))[1])
for (v in c("ep_lag_self","ep_lag_nbr90")) bel[[v]] <- (bel[[v]] - mean(bel[[v]])) / sd(bel[[v]])
E2 <- glm(reformulate(c(EV, "geomorphon", "ep_lag_self", "ep_lag_nbr90", EINT), "modhigh"),
          data = bel, family = binomial)

ce1 <- as.data.frame(coef(summary(E1))); names(ce1) <- c("beta","se","z","p"); ce1$term <- rownames(ce1)
ce2 <- as.data.frame(coef(summary(E2))); names(ce2) <- c("beta","se","z","p"); ce2$term <- rownames(ce2)
be1 <- function(v) sprintf("%+.3f", ce1$beta[ce1$term == v])
ze1 <- function(v) sprintf("%.1f", ce1$z[ce1$term == v])
pe1 <- function(v) pv(ce1$p[ce1$term == v])
be2 <- function(v) sprintf("%+.3f", ce2$beta[ce2$term == v])
ze2 <- function(v) sprintf("%.1f", ce2$z[ce2$term == v])
pe2 <- function(v) pv(ce2$p[ce2$term == v])
AUCE1 <- as.numeric(pROC::auc(pROC::roc(be$modhigh,  fitted(E1), quiet = TRUE)))
AUCE2 <- as.numeric(pROC::auc(pROC::roc(bel$modhigh, fitted(E2), quiet = TRUE)))
EP_LAG_N <- nrow(bel)

aic <- data.frame(Model = c("M0 host size + shading + landform", "M1 + stand density",
                            "M2 + terrain and flight radiation", "M3 + interactions"),
                  df = c(length(coef(M0)), length(coef(M1)), length(coef(M2)), length(coef(M3))),
                  AIC = c(AIC(M0), AIC(M1), AIC(M2), AIC(M3)))
aic$dAIC <- aic$AIC - min(aic$AIC)

co3 <- as.data.frame(coef(summary(M3)))
names(co3) <- c("beta", "se", "z", "p")
co3$term <- rownames(co3)

## Accessors, so no coefficient is ever transcribed into the prose by hand.
b3 <- function(v) sprintf("%+.3f", co3$beta[co3$term == v])
z3 <- function(v) sprintf("%.1f", co3$z[co3$term == v])
p3 <- function(v) pv(co3$p[co3$term == v])
DENS_V <- if (length(DENS)) DENS[1] else NA_character_
WGEO_V <- if (length(WGEO)) WGEO[1] else NA_character_
WTMP_V <- if (length(WTMP)) WTMP[1] else NA_character_
I_GEO  <- paste0(DENS_V, ":", WGEO_V)
I_TMP  <- paste0(DENS_V, ":", WTMP_V)

## Retention of an environmental coefficient once previous-year pressure is in the model.
## Defined here rather than beside the fit because it needs the interaction names above.
## What each radiation surface is actually correlated with on this landscape. Computed
## rather than asserted, because the interpretation of the shading result turns entirely
## on whether radiation is separable from wind exposure here, and on this site it is
## separable for one of the two surfaces and not for the other.
cc <- function(a, b) sprintf("%+.3f", cor(d[[a]], d[[b]]))
ccn <- function(a, b) cor(d[[a]], d[[b]])

ret <- function(v) sprintf("%.2f", shift$retained[shift$term == v])
I_TMP_R <- ret(I_TMP)
```
:::



::: {.cell}

```{.r .cell-code}
bz$above_qmd <- as.integer(bal$QUAD_DIAM_125 >= QMD_THRESH)
Mc <- glm(f(setdiff(c(V_CTX, DENS, WGEO), "QUAD_DIAM_125")), data = bz, family = binomial)
Md <- glm(f(c(setdiff(c(V_CTX, DENS, WGEO), "QUAD_DIAM_125"), "above_qmd")),
          data = bz, family = binomial)
qmd_bin <- bal |>
  mutate(bin = cut(QUAD_DIAM_125, breaks = c(0, 15, 20, 25, 30, 40, Inf),
                   labels = c("<15","15-20","20-25","25-30","30-40",">40"))) |>
  group_by(bin) |> summarise(n = n(), attack = mean(modhigh))

## The tests the diameter table needs, computed here so the prose reads them rather than
## restating a difference by eye. See _shared/diameter-test.R for what each one asks.
QT <- diameter_tests(qmd_bin)
```
:::



::: {.cell}

```{.r .cell-code}
## Objective 6. The two decisions not fixed by the data are which covariates enter and
## how wind is summarised in time. Both are varied and the density coefficient reported.

dens_beta <- function(mod, v) if (v %in% rownames(coef(summary(mod))))
  coef(summary(mod))[v, "Estimate"] else NA_real_

sens <- bind_rows(
  data.frame(Specification = "Full model M3",
             beta = dens_beta(M3, DENS[1])),
  data.frame(Specification = "No terrain terms",
             beta = dens_beta(M1, DENS[1])),
  data.frame(Specification = "Elevation as a spline",
             beta = {
               m <- mgcv::gam(as.formula(paste("modhigh ~ s(elevation) + geomorphon +",
                    paste(setdiff(c(V_CTX, DENS, WGEO), "elevation"), collapse = "+"))),
                    data = bz, family = binomial)
               s <- summary(m)$p.table
               if (DENS[1] %in% rownames(s)) s[DENS[1], "Estimate"] else NA_real_ })
)

for (w in WIND_V) {
  m <- glm(f(c(V_CTX, DENS, WGEO, w)), data = bz, family = binomial)
  sens <- bind_rows(sens, data.frame(
    Specification = paste("Wind summarised as", w), beta = dens_beta(m, DENS[1])))
}
```
:::


# Abstract {.unnumbered}


::: {.cell}

```{.r .cell-code}
## The abstract is the last thing measured, because Journal of Applied Entomology
## caps it at 300 words and an abstract over the cap is a desk rejection. The count
## is taken from the rendered text, not from the source, so inline expressions are
## counted as the words they become.
ABS_LIMIT <- 300
```
:::


Refugia from mountain pine beetle (*Dendroctonus ponderosae* Hopkins) are hypothesised to
form where stands are thin enough for wind to disrupt the pheromone plume coordinating mass
attack. The hypothesis names topographic shading, low host density and few large-diameter
hosts, and none has been fitted. We tested all three over 5,573 ha of the Selkirk
Mountains, British Columbia, at 30 m across 914 m of relief, using Landsat
at its 16-day repeat: 59 epochs across 8 outbreak years,
71,127 cell-epochs. Predictors were inventory stand structure,
29 geomorphometric surfaces, solar radiation computed separately for the
flight window and the growing season, and a terrain-resolved wind field from the MicroMet
model driven by hourly station data for each epoch's own sixteen days.

The wind-disruption mechanism was supported. Stand density interacted negatively with wind,
-0.094 for stem density (p = < 1e-16) and -0.041 for standing
volume (p = 4.91e-07), and both survived a within-season spread term carrying
+0.672. Host held through standing volume, +0.381,
and attack peaked at
45.9 per cent at 25 to 30 cm
diameter, the source-sink threshold. Topographic shading failed,
.

Temporal resolution decided the outcome. With one map a year, the same wind field, covariates
and threshold gave +0.031 (p = 0.0364), the opposite sign. Two further
specification tests showed why proxies mislead here: flight-window radiation cut the density
by terrain-exposure interaction from +0.311 to +0.221, and previous-year
pressure cut the landform terms to 0.50 to 
of their values. A wind test aggregated to the year answers a different question from the one
the mechanism poses, and answers it wrongly.

# Introduction

Bark beetle outbreaks and drought are the primary processes by which climate change has been
implicated in tree mortality across western North America, and mountain pine beetle
(*Dendroctonus ponderosae* Hopkins) is the agent that has killed the most lodgepole pine
(*Pinus contorta* Douglas ex Loudon) in British Columbia in the recorded period
[@taylor2003; @sambaraju2021]. Where a landscape is not killed uniformly, the surviving
patches matter for what the forest becomes, and one framework for those patches is
disturbance refugia, defined as places buffered from disturbance over time [@krawchuk2020].
Locating refugia is locally useful; explaining them requires that mechanistic links be
established between refugium occurrence and landscape drivers such as terrain, soil and
stand structure [@cartwright2018].

@krawchuk2020 proposed such a mechanism for this insect. Refugia from mountain pine beetle,
they suggested, could occur "in areas with cooler temperatures (eg from topographic shading)
that protect trees from water stress; in areas with lower host density, allowing for greater
wind disruption of beetle pheromone communication and more vigorous tree growth and chemical
defenses; and in areas with fewer large-diameter host trees or among trees with greater
investment in insect-resistance strategies, such as resin ducts". Three mechanisms are named
there, two of them terrain, and none has been fitted spatially. Of the 11 studies
retained by the screen described in @sec-screening, 1 enters a wind term at all, and
that one is a companion study on this landscape whose response is conifer regeneration
rather than beetle attack [@murphy2026].

The wind half of that proposal is not a claim about wind in open air. It is a claim about
what a thin canopy admits. @cartwright2018, the one retained study designed to identify
insect refugia and model their controls, found them in stands of low basal area and gave the
physical step directly: "thinner stands also increase wind penetration, helping to disperse
beetle pheromones and disrupt chemical communications needed to coordinate attacks."
@powell2014 state the same relation as the condition for outbreak rather than for refuge:
"higher local host density, which minimizes pheromone plume dispersion, reduces wind, and
promotes successful switching to nearby hosts, positively influences outbreak propensity."
A model that controls stand density out and then reads a terrain coefficient as a wind
effect has removed the pathway it set out to test. The wind ceiling the argument leans on,
approximately 2 m s⁻¹, is itself an inference across species whose primary citation concerns
*D. pseudotsugae*; in the one wind-tunnel trial on *D. ponderosae*, beetles flew longer at 0,
0.5 and 1 m s⁻¹ than at 2, a reduction in flight duration rather than arrest
[@carroll2004bionomics; @jones2019].

Terrain nevertheless conditions disturbance on this landscape, and it does so through more
than airflow. Flight is thermally gated, and narrowly: the limits for flight are 19 and
41 degrees C, most flight occurs between 22 and 32 degrees C, emergence needs above
20 degrees C, and "most flights occur on bright sunny days, and peak flight is in the early
to mid afternoon" [@safranyik2006chap1; @mccambridge1971]. A slope that does not reach the
gate during the flight period is not reached by flight whatever its stand density, so the
terrain variable representing this mechanism is not an annual heat index but the radiation a
slope receives during those hours. Light, temperature and wind are also named as one triad
rather than as alternatives: stand density "affects tree vigour and within-stand
microclimate, which in turn influence success of bark beetle dispersal, host selection,
attack or brood development", and the silvicultural prescription that followed aims at
"uniform spacing to create stand microclimate conditions (higher temperatures, light
intensity, and within-stand winds) that hinder beetle dispersal, attack behaviour and
survival" [@safranyik2006chap1]. Particular landforms are implicated: infested groups "are
frequently associated with draws and gullies, edges of swamps or other places with wide
fluctuation in the water table", and "thick bark and deep snow will insulate beetle broods
from declining ambient temperatures".

Radiation is also where the refugia proposal meets an older and unsettled argument about why
thinning reduces attack. One answer is tree vigour, in which fewer stems means less
competition, more growth and more resin. The other is microclimate, in which thinning changes
light, temperature and within-stand wind until the beetle cannot operate; @bartos1989 put
that position in their title, "Microclimate: an alternative to tree vigor as a basis for
mountain pine beetle infestations", and @safranyik2006chap1 report a model in which "host
vigour and stand age has much less affect on the risk of mountain pine beetle attack than
stand microclimate". The shading mechanism of @krawchuk2020 belongs to the vigour side, and
indirectly: shade cools, cooling relieves water stress, relieved water stress funds defence,
and nothing in that chain acts on the insect. The microclimate position predicts the opposite
sign on the same coefficient, because a shaded slope is a cold slope and a cold slope is one
a beetle cannot fly onto during the flight period.

A third argument reaches the vigour side's prediction by an independent route. Development is
temperature-driven and voltinism is not fixed: egg to adult requires 478 to 547 degree-days
above 5.6 degrees C, and "in areas that are too cold for optimal development of MPB, the life
cycle could extend to 2 years (semivoltinism)" [@safranyik2006chap1; @sambaraju2021]. A
shaded slope accumulates fewer degree-days, so adaptive seasonality also predicts less attack
there. Two arguments that disagree about mechanism agree about sign, which makes a
growing-season radiation coefficient a test rather than a description.

Measuring the wind the hypothesis concerns is the remaining difficulty, and it is
unresolved in both dimensions. No available product reports an instantaneous below-canopy
speed at flight height during the flight period; gridded climatologies report a long-run mean
at 10 m over open ground and are produced by downscaling a coarse field over a digital
elevation model, which makes them partly a transform of the terrain they are offered
alongside [@badger2014; @davis2023]. Nor does the literature state over what interval wind
should be summarised. Of the 11 studies read in full text for this question,
4 contain no wind term once "window" and "windthrow" are excluded, and of the
7 that do, 6 attach no temporal vocabulary of any kind; @krawchuk2020
specify no interval. The design adopted here splits the two signals, assigning the spatial
variation in wind to terrain, which is what generates it, and the temporal variation to
station records at their native hourly resolution, reduced only at the last step and only
into the flight period.

Two further gaps in this literature bear on specification. Host is never coded as the
attribute the life history says governs brood production: none of the retained studies
mentions quadratic mean diameter or the 25 cm source-sink threshold, though that threshold
has been standard since 2003 [@carroll2004bionomics], and host enters instead as cover, basal
area or a susceptibility class, none of which distinguishes a stand that produces beetles
from one that consumes them. And scale is acknowledged without being tested: no retained
study refits one model across extent, grain and response coding on one dataset and reports
whether its own conclusion survives.

Remote sensing supplies the response. Trees killed by mountain pine beetle pass from green
attack through red attack, a colour shift six to twelve months after initial attack, to grey
attack once foliage is shed, and Landsat-derived indices including the normalised difference
moisture index classify the red-attack stage with accuracies between 70 and 90 per cent
[@wulder2006red; @cartwright2018].

@tbl-hypotheses states, for each landscape attribute entered here, the direction expected of
it and the reasoning behind that expectation. The objectives of this study were to (1) test
whether stand density predicts moderate-to-high beetle disturbance in the direction the
pheromone-disruption mechanism requires, (2) test the topographic shading mechanism against
the microclimate and adaptive-seasonality arguments that predict the opposite sign, by
entering radiation separately for the flight period and for the growing season, (3) test
whether terrain shape and the named landforms predict disturbance independently of stand
density and radiation, (4) test whether the effect of stand density is conditional on terrain
exposure, on flight-period radiation and on flight-period wind, as the mechanism requires,
(5) test whether coding host as quadratic mean diameter against the 25 cm threshold changes
the answer relative to coding it as cover, and (6) report how much of the answer depends on
decisions the data does not fix.


::: {#tbl-hypotheses .cell tbl-cap='Landscape attributes entered in this study, the direction expected of each, and the reasoning behind that expectation.'}

```{.r .cell-code}
tibble::tribble(
  ~Attribute, ~Expected, ~Rationale,
  "Stand basal area, volume, crown closure, stems", "positive",
  "Denser canopy holds the pheromone plume together; thinner stands admit wind that disperses it [@krawchuk2020; @cartwright2018; @powell2014].",
  "Quadratic mean diameter", "positive above 25 cm",
  "Trees under 25 cm are beetle sinks, over 25 cm are sources [@carroll2004bionomics].",
  "Lodgepole pine cover and basal area", "positive",
  "Attack cannot occur where the host is absent; a cell without pine is not a refugium [@cartwright2018].",
  "Flight-period direct radiation", "positive",
  "Flight is gated between 19 and 41 degrees C and peaks on bright afternoons, so sunlit slopes are reachable [@safranyik2006chap1; @mccambridge1971].",
  "Growing-season direct radiation", "negative",
  "Shading cools, relieving water stress and funding defence, and cool sites also push the beetle toward a two-year cycle [@krawchuk2020; @sambaraju2021].",
  "Terrain exposure to wind", "negative",
  "Wind disrupts the pheromone plume, so exposed ground should carry less attack [@krawchuk2020].",
  "Terrain ruggedness", "uncertain",
  "The strongest terrain term in the companion study on this landscape, but fitted there against regeneration rather than attack [@murphy2026].",
  "Convergence, wetness, valley depth, slope position", "positive in convergent terrain",
  "Infested groups gather in draws and gullies, and deep snow insulates overwintering brood [@safranyik2006chap1].",
  "Flight-period wind speed", "negative",
  "The mechanism acts during dispersal, and no study specifies the interval, so it is taken at the flight period [@krawchuk2020; @jones2019].",
  "Elevation", "uncertain",
  "A composite of temperature, snowpack, season length and host distribution that this design cannot separate [@sambaraju2021]."
) |>
  kable(booktabs = TRUE, align = "lll", row.names = FALSE)
```

::: {.cell-output-display}


|Attribute                                          |Expected                       |Rationale                                                                                                                                               |
|:--------------------------------------------------|:------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------|
|Stand basal area, volume, crown closure, stems     |positive                       |Denser canopy holds the pheromone plume together; thinner stands admit wind that disperses it [@krawchuk2020; @cartwright2018; @powell2014].            |
|Quadratic mean diameter                            |positive above 25 cm           |Trees under 25 cm are beetle sinks, over 25 cm are sources [@carroll2004bionomics].                                                                     |
|Lodgepole pine cover and basal area                |positive                       |Attack cannot occur where the host is absent; a cell without pine is not a refugium [@cartwright2018].                                                  |
|Flight-period direct radiation                     |positive                       |Flight is gated between 19 and 41 degrees C and peaks on bright afternoons, so sunlit slopes are reachable [@safranyik2006chap1; @mccambridge1971].     |
|Growing-season direct radiation                    |negative                       |Shading cools, relieving water stress and funding defence, and cool sites also push the beetle toward a two-year cycle [@krawchuk2020; @sambaraju2021]. |
|Terrain exposure to wind                           |negative                       |Wind disrupts the pheromone plume, so exposed ground should carry less attack [@krawchuk2020].                                                          |
|Terrain ruggedness                                 |uncertain                      |The strongest terrain term in the companion study on this landscape, but fitted there against regeneration rather than attack [@murphy2026].            |
|Convergence, wetness, valley depth, slope position |positive in convergent terrain |Infested groups gather in draws and gullies, and deep snow insulates overwintering brood [@safranyik2006chap1].                                         |
|Flight-period wind speed                           |negative                       |The mechanism acts during dispersal, and no study specifies the interval, so it is taken at the flight period [@krawchuk2020; @jones2019].              |
|Elevation                                          |uncertain                      |A composite of temperature, snowpack, season length and host distribution that this design cannot separate [@sambaraju2021].                            |


:::
:::


# Materials

## Literature screening {#sec-screening}

The statements the specification rests on were drawn from two full-text screens, both
reproducible from scripts committed with this manuscript. The first retained studies that
model bark beetle attack or refugium occurrence against terrain or stand attributes,
published between 2006 and 2026, and recorded for each whether a wind
term entered the model. The second read every mountain pine beetle, bark beetle and
disturbance-refugia paper held in the group's reference store and extracted every sentence
mentioning wind alongside a mechanism term, returning 96 sentences from
27 papers. The wind match excludes "window", "windthrow" and "windfall": a first
run without that guard counted "temporal window" as a wind mention. Every retained study was
read in full text, because several of the claims above are absences, and an absence
established from titles and abstracts is not evidence.


::: {#tbl-screening .cell tbl-cap='Full-text screening of the terrain-and-attack corpus. Counts are computed from the screening table committed with the manuscript.'}

```{.r .cell-code}
data.frame(
  Stage = c("Records screened", "Full text verified",
            "Retained", "Entering a wind term"),
  Studies = c(nrow(rev), sum(rev$status == "verified"), N_INC, N_WIND)) |>
  kable(booktabs = TRUE, align = "lr")
```

::: {.cell-output-display}


|Stage                | Studies|
|:--------------------|-------:|
|Records screened     |      69|
|Full text verified   |      54|
|Retained             |      11|
|Entering a wind term |       1|


:::
:::



## Study area


The study area is 5,573 ha of the Selkirk Mountains in southeastern British
Columbia, 61,923 cells at 30 m, spanning 830 to
1,744 m and 914 m of relief.

The coordinate reference system is EPSG:3153, NAD83(CSRS) / BC Albers. This is the parent study's
grid, adopted so that results are directly comparable to it: "All disturbance and covariate
rasters were aligned to a common 30 m grid in EPSG:3153, the native resolution of the
Landsat-derived dNBR and dNDMI products", and "The plot anchor was georeferenced with a
handheld GPS receiver in EPSG:3153" [@murphy2026].

The perimeter is anchored on the 2015 Mt Midgeley fire, 480 ha, which is the
parent study's site. That study reports its site as spanning "elevations from 830 to 1744 m
a.s.l."; the digital elevation model used here returns 856 to
1,744 m inside the same perimeter, which reproduces the statement. The present
study expands beyond that hard boundary, because 480 ha cannot carry the stand-density
contrast the pheromone mechanism runs on. It does not expand arbitrarily: the perimeter is the
burn buffered 5 km and then cut to the elevation band the parent's site occupies, so the
added ground is ecologically the same kind of ground. Without that cut a 1 km buffer already
reaches the Kootenay Lake surface at 534 m, which is not a site elevation.


::: {.cell}
::: {.cell-output-display}
![The study area over the British Columbia Freshwater Atlas, with Kootenay Lake and the Kootenay River to the east. (a) Elevation, with the 2015 Mt Midgeley burn that anchors the perimeter outlined in red. (b) Terrain ruggedness index. (c) Stand basal area from the Vegetation Resources Inventory, the density term the pheromone-disruption mechanism runs through. The study perimeter is the grey outline and contours are at 250 m. All panels share one extent, projection and scale, so the north arrow, scale bar and representative fraction are drawn once, on (a); the representative fraction holds at a printed panel width of 66 mm. Coordinates are EPSG:3153, NAD83(CSRS) / BC Albers.](beetle-topography-wind-study_files/figure-docx/fig-study-area-1.png){#fig-study-area}
:::
:::



::: {.cell}
::: {.cell-output-display}
![The predictor surfaces, over the same base map and extent as Figure 1, with the 2015 burn outlined in red. (a) flight-window direct radiation, the thermal gate on flight; (b) growing-season direct radiation, the shading pathway; (c) the MicroMet wind weighting factor at the prevailing bearing; (d) terrain ruggedness; (e) stand basal area; (f) quadratic mean diameter, whose 25 cm source-sink threshold falls near the midpoint of the scale. Contours are omitted so the surfaces read cleanly. Coordinates are EPSG:3153; scale and orientation are as Figure 1.](beetle-topography-wind-study_files/figure-docx/fig-layers-1.png){#fig-layers}
:::
:::


## Beetle disturbance


The response is annual moderate-to-high beetle disturbance, classified from Landsat
normalised difference moisture index by the method of the parent study and rebuilt for this
project. It covers 8 outbreak years, 2006 to 2014,
excluding 2012, the one year covered only by Landsat 7, which has flown with its scan-line
corrector off since May 2003. Annual prevalence inside the perimeter runs
4.5 to 20.2 per
cent, pooled 12.5 per cent over 122,700 cell-years.

Years are never unioned. Unioning destroys the year-to-year spread this study measures, and
the union layer over the wider grid reached 73 per cent of the landscape, which is not
credible for a beetle outbreak.

The provincial aerial overview survey is not used as a response and supplies no training
label. It is retained only as a visual check.


::: {#tbl-prevalence .cell tbl-cap='Moderate-to-high beetle disturbance by year inside the study perimeter.'}

```{.r .cell-code}
prev_yr |>
  transmute(Year = year, Cells = fmt(n),
            `Moderate-to-high (%)` = sprintf("%.1f", 100*prev)) |>
  kable(booktabs = TRUE, align = "lrr", row.names = FALSE)
```

::: {.cell-output-display}


|Year |  Cells| Moderate-to-high (%)|
|:----|------:|--------------------:|
|2006 | 15,339|                  4.5|
|2007 | 15,340|                  5.6|
|2008 | 15,340|                 20.2|
|2009 | 15,340|                 11.5|
|2010 | 15,322|                 15.5|
|2011 | 15,340|                 13.3|
|2013 | 15,339|                 14.2|
|2014 | 15,340|                 15.1|


:::
:::


## Stand structure


Stand structure comes from the provincial Vegetation Resources Inventory layer
`VEG_COMP_LYR_R1_POLY`, retrieved by web feature service over the perimeter. Six attributes
carry the mechanism and the stem-size threshold: total basal area, crown closure, live stems per
hectare, quadratic mean diameter over stems 12.5 cm and up, stand age, and susceptible pine
basal area formed as total basal area times the pine share of cover.

78.3 per cent of cell-years sit at or above the
25 cm source-sink threshold.


::: {#tbl-vri .cell tbl-cap='Stand structure across the study perimeter, from the Vegetation Resources Inventory. n is cell-years. SD is the standard deviation of the landscape; SE is the standard error of the mean and is small by construction at this n, so it is not precision about any one cell. Skewness and kurtosis are the bias-corrected third and fourth standardised moments; kurtosis is excess, so 0 is Gaussian.'}
::: {.cell-output-display}


|Attribute                           |       n|   Mean|     SD|    SE| Median|   Min|     Max| Skewness| Kurtosis|
|:-----------------------------------|-------:|------:|------:|-----:|------:|-----:|-------:|--------:|--------:|
|Stand basal area (m2/ha)            | 122,700|  35.18|  11.84| 0.034|  37.06|  2.08|   64.26|    -0.77|    +0.49|
|Crown closure (%)                   | 122,700|  45.32|  13.55| 0.039|  48.00|  4.00|   60.00|    -1.31|    +1.29|
|Live stems (n/ha)                   | 122,700| 670.00| 256.78| 0.733| 686.00| 64.00| 1614.00|    +0.33|    +1.22|
|Quadratic mean diameter (cm)        | 122,700|  30.13|   7.19| 0.021|  30.32| 13.48|   62.35|    +0.54|    +1.39|
|Stand age (years)                   | 122,700| 125.22|  26.47| 0.076| 124.00| 20.00|  184.00|    -1.39|    +3.48|
|Stand height (m)                    | 122,700|  28.07|   6.05| 0.017|  29.00|  7.70|   41.60|    -0.70|    +1.79|
|Standing volume (m3/ha)             | 122,700| 283.40| 129.22| 0.369| 292.90|  0.90|  620.32|    +0.00|    -0.02|
|Lodgepole pine cover (%)            | 122,700|  17.36|  22.82| 0.065|  10.00|  0.00|  100.00|    +1.63|    +2.09|
|Susceptible pine basal area (m2/ha) | 122,700|   5.45|   7.03| 0.020|   3.24|  0.00|   31.67|    +1.52|    +1.86|


:::
:::


The inventory is a projected operational product, not a census, and its polygons here carry
reference years spanning several decades. A polygon interpreted from late-outbreak
photography describes a stand the beetle had already worked through, so basal area and pine
cover are post-attack for part of the window. There is no unattacked vintage, so this is
reported rather than corrected, and @sec-limits returns to it.

## Geomorphometry


Terrain is described by 29 geomorphometric surfaces computed with SAGA GIS
from the same 30 m elevation model, over the full reprojected surface and only then clipped
to the perimeter, so a search radius near the boundary sees real ground rather than missing
data. Each surface is here because a specific statement in the literature calls for it.

**Radiation, twice.** Flight-window insolation is
direct and diffuse radiation accumulated over 1 July to 15 August and restricted to 12:00 to
17:00, the hours @safranyik2006chap1 identify as the flight peak. It exists because flight
is thermally gated between 19 and 41 degrees C. Growing-season insolation is the total over
1 May to 30 September across the whole day, and it exists because Krawchuk et al.'s first
refugia mechanism is topographic shading acting on tree water stress. A single annual heat
index cannot separate the two, and the two are not interchangeable: across this perimeter
flight-window direct radiation spans
33 to
224 kWh m⁻², a
7-fold range, while
growing-season total spans only
2.6-fold.

**Exposure to wind.** The windward-leeward index and effective air flow height at the
prevailing flight-window bearing; the omnidirectional wind exposition index over a 300 m
search; the wind shelter index, the maximum upwind slope angle within 510 m at that bearing;
and topographic openness in both directions at 500 m.

**Shape.** Terrain ruggedness index, vector ruggedness measure, topographic position
index and its multi-scale form, convergence index, slope, and profile and plan curvature.
Ruggedness is included because it is the strongest terrain term the parent study reports.

**Landform.** Topographic wetness and convergence, because infested groups are
reported to gather in draws and gullies; valley depth, height above the valley floor,
normalised height and mid-slope position, because where cold air pools and snow lies deep is
where broods are insulated through winter.

**Aspect** is circular and enters as its northward and eastward components rather than as
degrees, alongside the heat load index of @mccune2002, whose aspect is folded about the
southwest to northeast axis.

One distinction has to be stated because the literature makes it easy to conflate. The
strongest aspect statements in @safranyik2006chap1 concern the aspect of the *bole*, not of
the slope: "beetles emerge at greater relative rates from the south aspect of the bole
compared with the north aspect", and in the clear bole zone "the heaviest attacks are usually
found on the northern aspect". Those are within-tree effects at centimetre scale and cannot
be measured by a 30 m terrain raster. Nothing in this study tests them.


::: {#tbl-wind-direction .cell tbl-cap='Prevailing wind direction in the flight window, 1 July to 15 August, speed-weighted from hourly ECCC station records. Consistency is the resultant length: 0 is no prevailing direction, 1 is constant.'}

```{.r .cell-code}
wdir |>
  transmute(Year = year, Hours = fmt(n_hours), Stations = n_stations,
            `From (deg)` = sprintf("%.1f", prevailing_deg),
            Consistency = sprintf("%.3f", consistency),
            `Mean speed (km/h)` = sprintf("%.2f", mean_spd)) |>
  kable(booktabs = TRUE, align = "lrrrrr")
```

::: {.cell-output-display}


|Year | Hours| Stations| From (deg)| Consistency| Mean speed (km/h)|
|:----|-----:|--------:|----------:|-----------:|-----------------:|
|2005 | 4,695|        6|      241.1|       0.121|              9.10|
|2006 | 4,724|        6|      240.0|       0.137|              8.95|
|2007 | 4,261|        5|      265.4|       0.172|              9.37|
|2008 | 3,293|        4|      269.3|       0.163|              9.52|
|2009 | 4,090|        5|      255.9|       0.053|              8.84|
|2010 | 4,156|        5|      290.6|       0.153|              8.60|
|2011 | 3,864|        5|      224.5|       0.179|              8.57|
|2013 | 5,320|        6|      293.4|       0.187|              8.43|
|2014 | 6,304|        7|      246.1|       0.198|              7.92|


:::
:::


The pooled bearing is 258.2 degrees. It is weakly constrained: the
resultant length is about 0.15 and the between-year
spread runs 224.5 to
293.4 degrees. The omnidirectional indices are
carried alongside the directional ones for that reason, and the variable-selection stage in
@sec-selection is allowed to choose between them.

## Terrain-resolved wind {#sec-micromet}


::: {.cell}

```{.r .cell-code}
mmsum <- read.csv(file.path(BC, "covariates", "wind-micromet", "micromet_summary.csv"))
mmW   <- rast(file.path(BC, "covariates", "wind-micromet", "wind_weight_by_direction.tif"))
MM_WW <- range(as.vector(minmax(mmW)))
```
:::


Station wind is nearly flat within a year, so this study also computes a wind field that
varies in space, using the MicroMet model of @liston2006. The steps are set out here in full
because every one of them is a choice.

**Why not WindNinja.** WindNinja is the standard tool for terrain-resolved wind in forest
and fire science, and it could not be used. Release 3.12.2 ships Windows installers only, it
is not packaged for MacPorts, and the CMake source build requires Qt5, boost, netcdf, poppler
and curl, which on this platform is a multi-hour build with a real chance of failing.

**What was installed and compiled.** Nothing. MicroMet's wind component is seven equations,
not a program. They were implemented directly in R in
`02.inputs/beetle-classification/41-micromet-wind.R`, with each equation carrying the
number it has in the published paper, which was retrieved open access from the publisher and
read in full text.

**The model.** Terrain slope $\beta$ and slope azimuth $\xi$ come from the elevation model
(equations 12 and 13). Curvature $\Omega_c$ is the difference between a cell's elevation and
the mean of the two opposite cells one curvature length scale away, computed on the four
direction lines and averaged (equation 14). The length scale is "approximately half the
wavelength of the topographic features within the domain"; rather than assume it, it is
estimated as the first lag at which elevation stops being autocorrelated with itself above
0.5, giving 600 m. The slope in the direction of the wind is
$\Omega_s = \beta \cos(\theta - \xi)$ (equation 15), and both $\Omega_c$ and $\Omega_s$ are
scaled to lie between $-0.5$ and $0.5$. The wind weighting factor is
$W_w = 1 + \gamma_s \Omega_s + \gamma_c \Omega_c$ (equation 16) with
$\gamma_s = \gamma_c = 0.5$, the values the paper recommends for equal weight, and the
terrain-modified speed is $W_t = W_w W$ (equation 17). Direction is diverted by
$\theta_d = -0.5\,\Omega_s \sin[2(\xi - \theta)]$ after Ryan (1977), equation 18.

**How it is run at hourly resolution.** $W_w$ depends on wind direction and not on speed, so
it is computed once for each of 16 direction bins rather than once per hour, and each hourly
station observation is multiplied by the surface for its own bin. Nothing is averaged before
the terrain acts on it. Over all bins $W_w$ runs 0.60 to
1.38, inside the 0.5 to 1.5 the paper's parameter choice implies.
Speed and direction are combined as components, $u = -W\sin\theta$ and $v = -W\cos\theta$
(equations 8 and 9), because averaging degrees across the 360/0 line is meaningless.

**What it produces.** A flight-window mean, calm fraction and windy fraction per year that
vary across the grid (@tbl-micromet). The spatial range within a year is
1.9 to
2.8 km h⁻¹, against under 1 km h⁻¹ for the
interpolated station surface over a far larger area.


::: {#tbl-micromet .cell tbl-cap='Terrain-resolved flight-window wind by year. Spatial range is the difference between the windiest and least windy cell within that year, which the interpolated station surface did not have.'}

```{.r .cell-code}
mmsum |>
  transmute(Year = year, Hours = fmt(hours), Stations = stations,
            `Grid mean (km/h)` = sprintf("%.2f", mean_kmh),
            `Min` = sprintf("%.2f", spatial_min), `Max` = sprintf("%.2f", spatial_max),
            `Spatial range` = sprintf("%.2f", spatial_range),
            `Calm fraction` = sprintf("%.3f", calm)) |>
  kable(booktabs = TRUE, align = "lrrrrrrr")
```

::: {.cell-output-display}


|Year | Hours| Stations| Grid mean (km/h)|  Min|  Max| Spatial range| Calm fraction|
|:----|-----:|--------:|----------------:|----:|----:|-------------:|-------------:|
|2005 | 1,104|        8|             4.93| 3.72| 6.11|          2.40|         0.599|
|2006 | 1,104|        8|             4.76| 3.61| 5.91|          2.29|         0.630|
|2007 | 1,104|        7|             5.07| 3.88| 6.23|          2.35|         0.606|
|2008 | 1,101|        6|             6.01| 4.61| 7.39|          2.77|         0.470|
|2009 | 1,103|        7|             5.21| 3.99| 6.35|          2.36|         0.546|
|2010 | 1,104|        7|             4.66| 3.57| 5.67|          2.10|         0.629|
|2011 | 1,101|        7|             5.22| 3.87| 6.57|          2.69|         0.556|
|2013 | 1,104|        8|             4.17| 3.16| 5.08|          1.91|         0.702|
|2014 | 1,104|        9|             4.54| 3.46| 5.66|          2.20|         0.659|


:::
:::


The terrain-resolved field is not a repackaged version of the terrain indices it might be
confused with. It correlates +0.153 with the
windward-leeward index, +0.124 with flight-window
radiation and +0.002 with ruggedness. Its strongest association is
with elevation, +0.326, which is a real property of mountain
wind and a confound this study has to carry.

## Flight-window wind


Wind is taken from Environment and Climate Change Canada hourly station records, at their
native hourly resolution, and reduced only at the last step. Monthly means for June, July
and August retain seasonal progression. Over the flight window of 1 July to 15 August, four
metrics are formed: mean hourly speed, the 95th percentile, the fraction of hours below
5 km h⁻¹, and the fraction above 15 km h⁻¹.

What the hourly source resolution buys is metrics, not observations. The response is
annual, so every hourly reading collapses into one of 8 annual values per
metric. Hourly is why a calm-hour fraction exists at all, and why the flight window can be
separated from the season around it, but it adds no degrees of freedom.

That has a consequence the model has to respect and this study states rather than hides.
Stand density varies cell to cell; a season's wind does not. Within any one year the
interpolated wind surface is nearly flat, spanning less than a kilometre per hour across
50 km, so a wind main effect is identified only across 8 annual values and
its standard error should not be believed on its own. The interaction between stand
density and wind is identified within year, because the density half of it varies over
61,923 cells. This is why the interaction is the claim this paper makes and the
wind main effect is not.

The calm fraction is the metric the pheromone argument predicts should matter most, because a stand calm enough
to hold a plume is a stand where mass attack can be coordinated.


::: {#tbl-wind .cell tbl-cap='Flight-window wind by year, from hourly station records interpolated to the analysis grid.'}

```{.r .cell-code}
wind_yr |>
  transmute(Year = year,
            `Mean (km/h)` = sprintf("%.2f", flight_mean),
            `95th pct` = sprintf("%.2f", flight_p95),
            `Calm fraction` = sprintf("%.3f", flight_calm),
            `Windy fraction` = sprintf("%.3f", flight_windy)) |>
  kable(booktabs = TRUE, align = "lrrrr", row.names = FALSE)
```

::: {.cell-output-display}


|Year | Mean (km/h)| 95th pct| Calm fraction| Windy fraction|
|:----|-----------:|--------:|-------------:|--------------:|
|2006 |        6.37|    17.05|         0.418|          0.065|
|2007 |        7.50|    17.33|         0.286|          0.075|
|2008 |        7.80|    17.33|         0.275|          0.084|
|2009 |        7.19|    17.11|         0.332|          0.074|
|2010 |        7.06|    17.15|         0.333|          0.068|
|2011 |        6.90|    15.36|         0.321|          0.053|
|2013 |        7.50|    18.78|         0.321|          0.091|
|2014 |        6.74|    16.17|         0.351|          0.068|


:::
:::


# Methods

## Variable selection {#sec-selection}


The candidate set is 45 variables in six groups, one group per pathway the review
names: stand density, host quality, terrain exposure to wind, terrain shape, landscape
context, and flight-window wind. Selection proceeds in four
stages and is required to retain at least one variable from each pathway, so that a
collinearity filter cannot silently delete a hypothesis the review established.

Fitting uses a class-balanced sample of 47,328 cell-years, 4,000 of each
class per year. Landscape prevalence is about 12 per cent, and an
unbalanced fit at that prevalence reports the intercept rather than the covariates.

### Univariate screening


Each candidate is fitted alone against the response. The statistic recorded is the area
under the receiver operating characteristic curve, which is comparable across variables on
different scales. 42 of 45 candidates clear p < 0.01.


::: {#tbl-univariate .cell tbl-cap='Univariate screening. Each candidate fitted alone against moderate-to-high beetle disturbance on the balanced sample, ordered by discrimination.'}

```{.r .cell-code}
uni |>
  transmute(Variable = term, Pathway = group,
            Beta = sprintf("%+.3f", beta), AUC = sprintf("%.3f", auc),
            p = sapply(p, pv)) |>
  kable(booktabs = TRUE, align = "llrrr")
```

::: {.cell-output-display}


|Variable              |Pathway   |   Beta|   AUC|        p|
|:---------------------|:---------|------:|-----:|--------:|
|PINE_BA               |hostsize  | +0.783| 0.715|  < 1e-16|
|sky_view              |shading   | +0.862| 0.709|  < 1e-16|
|PinePct               |hostsize  | +0.742| 0.709|  < 1e-16|
|elevation             |landform  | +0.767| 0.698|  < 1e-16|
|wind_afh              |wind_geo  | +0.766| 0.698|  < 1e-16|
|height_valley_floor   |landform  | -0.698| 0.674|  < 1e-16|
|tri                   |shape     | -0.631| 0.664|  < 1e-16|
|slope                 |shape     | -0.591| 0.661|  < 1e-16|
|openness_pos          |wind_geo  | +0.661| 0.660|  < 1e-16|
|valley_depth          |landform  | -0.552| 0.639|  < 1e-16|
|vrm                   |shape     | -0.617| 0.618|  < 1e-16|
|normalised_height     |landform  | +0.395| 0.612|  < 1e-16|
|tpi                   |shape     | +0.398| 0.607|  < 1e-16|
|QUAD_DIAM_125         |hostsize  | -0.314| 0.601|  < 1e-16|
|wind_exposition       |wind_geo  | +0.339| 0.588|  < 1e-16|
|mm_flight_mean        |wind_mm   | +0.311| 0.578|  < 1e-16|
|VRI_LIVE_STEMS_PER_HA |density   | +0.155| 0.575|  < 1e-16|
|solar_flight_direct   |flightsun | +0.239| 0.566|  < 1e-16|
|northness             |shading   | +0.236| 0.565|  < 1e-16|
|PROJ_AGE_1            |hostsize  | +0.174| 0.559|  < 1e-16|
|jul                   |wind_t    | +0.204| 0.558|  < 1e-16|
|CROWN_CLOSURE         |density   | -0.059| 0.555| 1.63e-09|
|flight_mean           |wind_t    | +0.204| 0.553|  < 1e-16|
|mstpi                 |shape     | +0.206| 0.552|  < 1e-16|
|flight_windy          |wind_t    | +0.159| 0.551|  < 1e-16|
|jun                   |wind_t    | +0.159| 0.549|  < 1e-16|
|LIVE_STAND_VOLUME_125 |density   | +0.149| 0.547|  < 1e-16|
|convergence           |shape     | +0.157| 0.543|  < 1e-16|
|curv_plan             |shape     | +0.143| 0.540|  < 1e-16|
|flight_calm           |wind_t    | -0.211| 0.535|  < 1e-16|
|wind_effect           |wind_geo  | +0.199| 0.535|  < 1e-16|
|solar_season_total    |shading   | +0.143| 0.533|  < 1e-16|
|solar_season_direct   |shading   | +0.138| 0.532|  < 1e-16|
|eastness              |shading   | -0.118| 0.531|  < 1e-16|
|midslope_position     |landform  | +0.096| 0.530|  < 1e-16|
|solar_flight_diffuse  |flightsun | +0.115| 0.529|  < 1e-16|
|PROJ_HEIGHT_1         |hostsize  | -0.049| 0.528| 5.46e-07|
|aug                   |wind_t    | +0.123| 0.525|  < 1e-16|
|flight_p95            |wind_t    | +0.009| 0.521|    0.341|
|wind_shelter          |wind_geo  | -0.125| 0.520|  < 1e-16|
|BASAL_AREA            |density   | +0.001| 0.516|    0.882|
|curv_prof             |shape     | +0.042| 0.513| 1.95e-05|
|twi                   |landform  | -0.079| 0.512| 5.16e-15|
|openness_neg          |wind_geo  | -0.026| 0.508|  0.00905|
|heat_load             |shading   | -0.009| 0.496|    0.347|


:::
:::


### Collinearity


Candidates are clustered on 1 minus the absolute Pearson correlation, cut so that any pair
correlated at |r| >= 0.75 falls in one cluster. That yields 26 clusters from
45 candidates. Within each, the variable with the highest univariate discrimination
is retained.


::: {#tbl-clusters .cell tbl-cap='Collinearity clusters. Variables in one cluster are correlated at |r| >= 0.75; the retained member is the one with the highest univariate AUC.'}

```{.r .cell-code}
data.frame(cluster = cl, term = names(cl)) |>
  left_join(uni |> select(term, group, auc), by = "term") |>
  arrange(cluster, desc(auc)) |>
  group_by(Cluster = cluster) |>
  summarise(Pathways = paste(sort(unique(group)), collapse = ", "),
            Members = paste(term, collapse = ", "),
            Retained = term[which.max(auc)]) |>
  kable(booktabs = TRUE, align = "lllr")
```

::: {.cell-output-display}


|Cluster |Pathways           |Members                                            |              Retained|
|:-------|:------------------|:--------------------------------------------------|---------------------:|
|1       |shading            |northness, solar_season_total, solar_season_direct |             northness|
|2       |shading, wind_geo  |sky_view, openness_pos                             |              sky_view|
|3       |flightsun, shading |solar_flight_direct, heat_load                     |   solar_flight_direct|
|4       |shading            |eastness                                           |              eastness|
|5       |density, hostsize  |LIVE_STAND_VOLUME_125, PROJ_HEIGHT_1, BASAL_AREA   | LIVE_STAND_VOLUME_125|
|6       |density            |CROWN_CLOSURE                                      |         CROWN_CLOSURE|
|7       |density            |VRI_LIVE_STEMS_PER_HA                              | VRI_LIVE_STEMS_PER_HA|
|8       |hostsize           |QUAD_DIAM_125                                      |         QUAD_DIAM_125|
|9       |hostsize           |PROJ_AGE_1                                         |            PROJ_AGE_1|
|10      |hostsize           |PINE_BA, PinePct                                   |               PINE_BA|
|11      |flightsun, shape   |tri, slope, solar_flight_diffuse                   |                   tri|
|12      |wind_geo           |wind_effect, wind_shelter                          |           wind_effect|
|13      |landform, wind_geo |elevation, wind_afh                                |             elevation|
|14      |shape, wind_geo    |tpi, wind_exposition, mstpi                        |                   tpi|
|15      |wind_geo           |openness_neg                                       |          openness_neg|
|16      |shape              |vrm                                                |                   vrm|
|17      |shape              |convergence, curv_plan                             |           convergence|
|18      |shape              |curv_prof                                          |             curv_prof|
|19      |landform           |twi                                                |                   twi|
|20      |landform           |valley_depth                                       |          valley_depth|
|21      |landform           |height_valley_floor, normalised_height             |   height_valley_floor|
|22      |landform           |midslope_position                                  |     midslope_position|
|23      |wind_t             |flight_mean, flight_calm, aug                      |           flight_mean|
|24      |wind_t             |jul, flight_windy, flight_p95                      |                   jul|
|25      |wind_t             |jun                                                |                   jun|
|26      |wind_mm            |mm_flight_mean                                     |        mm_flight_mean|


:::
:::


### Variance inflation


Surviving variables are entered together and variance inflation factors computed. Any
variable above 5 is dropped, worst first, and the model refitted, except that a pathway is
never emptied. 5 variables are dropped at this stage. The maximum
variance inflation factor in the retained set is
5.46.


::: {#tbl-vif .cell tbl-cap='Variance inflation factors of the retained set.'}

```{.r .cell-code}
data.frame(Variable = names(vif_final), VIF = sprintf("%.2f", vif_final)) |>
  arrange(desc(VIF)) |>
  kable(booktabs = TRUE, align = "lr")
```

::: {.cell-output-display}


|Variable              |  VIF|
|:---------------------|----:|
|solar_flight_direct   | 5.46|
|wind_effect           | 4.33|
|LIVE_STAND_VOLUME_125 | 4.21|
|tri                   | 3.28|
|QUAD_DIAM_125         | 3.21|
|valley_depth          | 2.66|
|PROJ_AGE_1            | 2.55|
|CROWN_CLOSURE         | 2.50|
|tpi                   | 2.47|
|twi                   | 2.41|
|elevation             | 2.25|
|VRI_LIVE_STEMS_PER_HA | 2.08|
|northness             | 1.90|
|mm_flight_mean        | 1.67|
|PINE_BA               | 1.60|
|jun                   | 1.44|
|convergence           | 1.34|
|vrm                   | 1.31|
|midslope_position     | 1.25|
|curv_prof             | 1.15|
|jul                   | 1.14|


:::
:::


### Multivariate importance


A random forest with permutation importance is fitted on the retained set, to rank
variables under a model that makes no linearity assumption. It is a diagnostic, not the
inferential model: the logistic models in @sec-results carry the inference. Out-of-bag
discrimination is 0.959.


::: {.cell}

```{.r .cell-code}
ggplot(imp, aes(reorder(term, importance), importance, fill = group)) +
  geom_col() + coord_flip() +
  scale_fill_brewer(palette = "Set2", name = "Pathway") +
  labs(x = NULL, y = "Permutation importance") +
  theme_minimal(base_size = 10)
```

::: {.cell-output-display}
![Permutation importance of the retained variables, coloured by the pathway each belongs to.](beetle-topography-wind-study_files/figure-docx/fig-importance-1.png){#fig-importance}
:::
:::


The final set carries 21 variables:
elevation, PINE_BA, valley_depth, QUAD_DIAM_125, VRI_LIVE_STEMS_PER_HA, LIVE_STAND_VOLUME_125, jun, jul, mm_flight_mean, tri, northness, wind_effect, tpi, PROJ_AGE_1, CROWN_CLOSURE, solar_flight_direct, midslope_position, twi, vrm, convergence, curv_prof.

## Models


Four models are fitted, each adding one claim to the last, so that every term's
contribution is visible as a change in fit rather than asserted.

M0 carries Krawchuk's first and third mechanisms together with landform context: host size,
topographic shading, and the terrain that governs where cold air and snow collect. M1 adds
stand density, the second of Krawchuk's mechanisms, which is objective 1. M2 adds terrain shape,
terrain exposure to wind, and flight-window radiation, which are objectives 3 and 4. M3 adds
the interactions objective 4 requires: stand density by terrain exposure, by flight-window
radiation, and by flight-window wind.

# Results {#sec-results}



::: {#tbl-aic .cell tbl-cap='Model comparison. Each model adds one pathway to the previous. AIC ranks on likelihood and a parameter penalty; the remaining columns are predictive error on the fitted probabilities. RMSE is the root mean squared error and is the square root of the Brier score; RMSE (%) expresses it against the prevalence of the response. Brier skill is the improvement over predicting the prevalence for every cell, where 0 is no better than the base rate. MAPE and Theil\'s U are not reported: both divide by the observed value, which is zero for the majority class of a binary response, so both are undefined without discarding that class.'}
::: {.cell-output-display}


|Model                             |    AIC|  ΔAIC|  RMSE| RMSE (%)|   MAE| Brier| Log loss|   AUC|Brier skill |
|:---------------------------------|------:|-----:|-----:|--------:|-----:|-----:|--------:|-----:|:-----------|
|M0 host size + shading + landform | 49,547| 2,307| 0.416|    128.3| 0.346| 0.173|    0.523| 0.771|0.211       |
|M1 + stand density                | 49,049| 1,809| 0.412|    127.3| 0.342| 0.170|    0.518| 0.775|0.223       |
|M2 + terrain and flight radiation | 48,305| 1,065| 0.409|    126.2| 0.336| 0.167|    0.510| 0.784|0.237       |
|M3 + interactions                 | 47,240|     0| 0.404|    124.7| 0.327| 0.163|    0.498| 0.798|0.256       |


:::
:::



::: {#tbl-m3 .cell tbl-cap='Full model, continuous terms. Coefficients are per standard deviation on a class-balanced sample, so the intercept is not landscape prevalence. The geomorphon landform classes are also in this model and are reported separately in @tbl-geomorphon.'}

```{.r .cell-code}
co3 |>
  filter(term != "(Intercept)", !grepl("^geomorphon", term)) |>
  arrange(desc(abs(beta))) |>
  transmute(Term = pretty_terms(term), Beta = sprintf("%+.3f", beta), SE = sprintf("%.3f", se),
            z = sprintf("%.2f", z), p = sapply(p, pv)) |>
  kable(booktabs = TRUE, align = "lrrrr", row.names = FALSE)
```

::: {.cell-output-display}


|Term                                        |   Beta|    SE|      z|        p|
|:-------------------------------------------|------:|-----:|------:|--------:|
|Flight-window direct radiation (kWh/m2)     | +0.487| 0.028|  17.21|  < 1e-16|
|Susceptible pine basal area (m2/ha)         | +0.459| 0.014|  32.40|  < 1e-16|
|Quadratic mean diameter (cm)                | -0.422| 0.023| -18.35|  < 1e-16|
|Northness                                   | +0.382| 0.016|  23.19|  < 1e-16|
|Standing volume (m3/ha)                     | +0.381| 0.024|  15.61|  < 1e-16|
|Windward-leeward index                      | +0.358| 0.029|  12.37|  < 1e-16|
|Elevation (m)                               | +0.329| 0.018|  18.20|  < 1e-16|
|Live stems x Windward-leeward index         | +0.221| 0.021|  10.63|  < 1e-16|
|Stand age (years)                           | +0.218| 0.018|  11.89|  < 1e-16|
|July mean wind (km/h)                       | +0.215| 0.012|  17.84|  < 1e-16|
|Valley depth (m)                            | -0.193| 0.022|  -8.70|  < 1e-16|
|Crown closure (%)                           | -0.183| 0.020|  -9.02|  < 1e-16|
|Live stems x Flight-window direct radiation | -0.144| 0.017|  -8.58|  < 1e-16|
|June mean wind (km/h)                       | +0.107| 0.012|   8.66|  < 1e-16|
|Live stems (n/ha)                           | -0.099| 0.018|  -5.36| 8.29e-08|
|Topographic wetness index                   | +0.073| 0.019|   3.74| 0.000184|
|Mid-slope position                          | +0.063| 0.013|   4.69| 2.78e-06|
|Vector ruggedness measure                   | -0.043| 0.019|  -2.21|   0.0272|
|Topographic position index                  | +0.040| 0.023|   1.77|   0.0761|
|Profile curvature                           | -0.038| 0.012|  -3.04|  0.00236|
|Terrain ruggedness index                    | -0.036| 0.023|  -1.54|    0.124|
|Convergence index                           | -0.029| 0.014|  -2.07|   0.0384|
|Live stems x June mean wind                 | -0.001| 0.013|  -0.12|    0.905|


:::
:::


Every pathway the review identified earns its place. Adding stand density to host size,
shading and landform drops AIC by 498; adding terrain shape,
terrain exposure and flight-window radiation drops it a further
744; adding the interactions objective 4 requires drops it
1,065 more (@tbl-aic). No stage is decoration.

**Objective 1, stand density.** The density pathway is supported in one of its measures and
not the others, and that split is itself the result. Live stand volume carries
+0.381 log-odds per standard deviation
(z = 15.6), so more standing wood means more moderate-to-high
disturbance, which is the direction the pheromone argument predicts. Stem count runs the other way at
-0.099 (z = -5.4), and crown closure is
indistinguishable from zero at -0.183 (p = < 1e-16). Total
basal area, the variable @cartwright2018 found strongest, did not survive selection: its
univariate discrimination is 0.516, below
chance.

Volume and stem count measure different things in the same stand. A stand can hold many
small stems at low volume, and this beetle needs large ones. Read together they say what
predicts attack is standing wood in large trees, not how many trees there are, which is the
bionomics of the species rather than a contradiction in the data.

**Objectives 2 and 3, radiation.** Computing radiation twice was not a refinement. The two
terms enter with opposite signs and comparable size, so a single annual index would have
cancelled them against each other and reported nothing.

Flight-window direct radiation, accumulated over 1 July to 15 August between noon and 17:00,
carries +0.487 (z = 17.2). Slopes that take
more sun during the hours of the flight peak carry more attack. That is the thermal gate
behaving as stated: flight needs 19 degrees C to start and the flight peak falls on bright
afternoons, so radiation in that window is a measure of whether a slope is reachable at all.

Growing-season direct radiation carries 
(z = ). More sun across the season means less attack, so shaded
ground carries more attack, not less.

That contradicts the shading mechanism. @krawchuk2020 predict refugia "in areas with cooler temperatures (eg
from topographic shading) that protect trees from water stress", which requires shaded
ground to carry less attack. On this landscape it carries more. The shading mechanism is
not merely unsupported here; its sign is the wrong way round.

**Objective 3, terrain shape and landform.** Terrain predicts attack independently of both
density and radiation. Terrain ruggedness carries -0.036 (z = -1.5) and the
vector ruggedness measure agrees at -0.043: rugged ground carries less attack.
Ruggedness is the strongest shape term, as it is in the parent study, but with the opposite
sign, and the two are not in conflict, because the parent's response is seedling
establishment rather than beetle attack. Rugged ground that shelters a seedling need not be
ground a beetle reaches.

The landforms named in the synthesis all enter and all matter. Mid-slope position carries
+0.063 (z = 4.7), height above the valley floor
, normalised height  and valley depth
-0.193. The windward-leeward index carries +0.358
(z = 12.4), so ground exposed to the prevailing flight-window bearing
carries more attack, not less. Elevation remains the largest single term at
+0.329.

**Objective 4, the wind pathway, and what radiation did to it.** This is where the revision
changed the answer, and the change is worth stating precisely.

Fitted without flight-window radiation, stand density interacts with terrain exposure at
+0.311 (z = 19.2, p = < 1e-16), which reads as a wind result
pointing the wrong way. With radiation in the model the same interaction is +0.221
(z = 10.6, p = < 1e-16), which is nothing. The apparent
density-by-exposure effect was radiation wearing a terrain index: windward slopes here are
also the slopes that take afternoon sun, and with only one of the two in the model the
survivor collected both.

What survives is two interactions, both negative. Stand density by flight-window radiation
is -0.144
(z = -8.6), the largest interaction in the model: on
sun-exposed slopes, stand density buys less. Stand density by flight-window mean wind speed
is -0.001 (z = -0.1): in a windier season, stand density also buys less.

Both are the direction the pheromone-disruption mechanism predicts, and neither is a terrain
index. Where the mechanism is tested against a measured environmental condition, radiation
or wind, it holds. Where it was tested against landform, it did not, and that earlier result
is now explained rather than merely contradicted.

## The 16-day test {#sec-epoch}


::: {#tbl-epoch .cell tbl-cap='The refugia interaction at 16-day resolution. E1 uses all epochs; E2 adds the previous epoch in the same season, so the interaction is read after within-season spread. A negative interaction is what the pheromone-disruption mechanism predicts: stand density buys less where and when the wind blows harder.'}

```{.r .cell-code}
data.frame(
  Model = c(rep("E1 all epochs", 3), rep("E2 with within-season lag", 5)),
  Term  = c("ep_wind_mean", EINT, "ep_wind_mean", EINT, "ep_lag_self", "ep_lag_nbr90"),
  Beta  = c(be1("ep_wind_mean"), be1(EINT[1]), be1(EINT[2]),
            be2("ep_wind_mean"), be2(EINT[1]), be2(EINT[2]),
            be2("ep_lag_self"), be2("ep_lag_nbr90")),
  z     = c(ze1("ep_wind_mean"), ze1(EINT[1]), ze1(EINT[2]),
            ze2("ep_wind_mean"), ze2(EINT[1]), ze2(EINT[2]),
            ze2("ep_lag_self"), ze2("ep_lag_nbr90")),
  p     = c(pe1("ep_wind_mean"), pe1(EINT[1]), pe1(EINT[2]),
            pe2("ep_wind_mean"), pe2(EINT[1]), pe2(EINT[2]),
            pe2("ep_lag_self"), pe2("ep_lag_nbr90"))) |>
  kable(booktabs = TRUE, align = "lllrr", row.names = FALSE)
```

::: {.cell-output-display}


|Model                     |Term                               |Beta   |     z|        p|
|:-------------------------|:----------------------------------|:------|-----:|--------:|
|E1 all epochs             |ep_wind_mean                       |+0.035 |   4.0| 6.94e-05|
|E1 all epochs             |VRI_LIVE_STEMS_PER_HA:ep_wind_mean |-0.094 | -11.7|  < 1e-16|
|E1 all epochs             |LIVE_STAND_VOLUME_125:ep_wind_mean |-0.041 |  -5.0| 4.91e-07|
|E2 with within-season lag |ep_wind_mean                       |+0.127 |   7.8| 4.79e-15|
|E2 with within-season lag |VRI_LIVE_STEMS_PER_HA:ep_wind_mean |-0.067 |  -4.8| 1.26e-06|
|E2 with within-season lag |LIVE_STAND_VOLUME_125:ep_wind_mean |-0.039 |  -2.7|  0.00726|
|E2 with within-season lag |ep_lag_self                        |+0.447 |  20.3|  < 1e-16|
|E2 with within-season lag |ep_lag_nbr90                       |+0.672 |  26.4|  < 1e-16|


:::
:::


At the sensor's own cadence the mechanism holds, in both of its density measures, and it
holds after the within-season spread term is in the model.

The response is 59 epochs across 8 years, 71,127 cell-epochs
balanced within each epoch, each carrying the terrain-resolved wind of its own sixteen days.
Between-epoch mean wind runs 3.65 to
6.84 km h⁻¹, and within any one epoch the field spans
1.7 to
4.0 km h⁻¹ across the grid. Wind is therefore
identified twice over, in space and in time, which no earlier specification in this study
managed.

Stem density interacted with epoch wind is -0.094 (z = -11.7,
p = < 1e-16) and standing volume interacted with epoch wind is -0.041
(z = -5.0, p = 4.91e-07). Both are negative, which is the direction
@krawchuk2020 require: a dense stand is worth less where the wind blows harder.

Adding the previous epoch of the same season, which carries +0.447 for the
cell itself and +0.672 for its 90 m neighbourhood and raises discrimination
from 0.668 to 0.756, leaves both interactions in
place: -0.067 (p = 1.26e-06) and -0.039
(p = 0.00726) on 29,298 rows. The mechanism is not an artefact of
where the outbreak already was.

This is the result the annual specification could not reach, and the reason is resolution
rather than statistics. One map a year forces the wind comparison to be made between
summers, and eight summers cannot carry it. At 16 days the same landscape, the same
covariates and the same threshold give the opposite sign, because the question has changed
from which summer was windy to which sixteen days were windy where.


::: {.cell}

```{.r .cell-code}
nd_base <- be[1, , drop = FALSE]
for (v in EV) nd_base[[v]] <- 0
pred_panel <- function(dv, lab) {
  qs <- quantile(be[[dv]], c(0.1, 0.9))
  gr <- expand.grid(w = seq(min(be$ep_wind_mean), max(be$ep_wind_mean), length.out = 60),
                    d = qs)
  nd <- nd_base[rep(1, nrow(gr)), ]
  nd$ep_wind_mean <- gr$w; nd[[dv]] <- gr$d
  nd$geomorphon <- factor(levels(be$geomorphon)[1], levels = levels(be$geomorphon))
  gr$p <- predict(E1, newdata = nd, type = "response")
  gr$Density <- factor(gr$d, labels = c("low (10th pct)", "high (90th pct)"))
  ggplot(gr, aes(w, p, colour = Density)) + geom_line(linewidth = 0.8) +
    scale_colour_manual(values = c("#2c7fb8", "#d95f02")) +
    labs(x = "Epoch wind (SD units)", y = "P(moderate-to-high)", title = lab) +
    theme_minimal(base_size = 9)
}
pa <- pred_panel("VRI_LIVE_STEMS_PER_HA", "(a) Stem density")
pb <- pred_panel("LIVE_STAND_VOLUME_125", "(b) Standing volume")

cf <- bind_rows(
  ce1 |> mutate(model = "E1 all epochs"),
  ce2 |> mutate(model = "E2 with lag")) |>
  filter(!grepl("^geomorphon|Intercept", term)) |>
  group_by(term) |> filter(any(abs(beta) > 0.05)) |> ungroup()
pc <- ggplot(cf, aes(reorder(term, beta), beta, colour = model)) +
  geom_hline(yintercept = 0, linewidth = 0.3, colour = "grey60") +
  geom_pointrange(aes(ymin = beta - 1.96*se, ymax = beta + 1.96*se),
                  position = position_dodge(width = 0.5), size = 0.25) +
  coord_flip() + scale_colour_manual(values = c("#1b9e77", "#7570b3")) +
  labs(x = NULL, y = "Log-odds per SD", title = "(c) 16-day model coefficients") +
  theme_minimal(base_size = 8) + theme(legend.position = "bottom")

pd <- epsum |>
  inner_join(epwind, by = c("year","epoch")) |>
  ggplot(aes(mean_kmh, prevalence)) +
  geom_point(aes(colour = factor(year)), size = 1.6) +
  geom_smooth(method = "lm", se = TRUE, colour = "black", linewidth = 0.5) +
  labs(x = "Epoch mean wind (km/h)", y = "Epoch prevalence",
       colour = "Year", title = "(d) Epochs") +
  theme_minimal(base_size = 8)

(pa | pb) / (pc | pd)
```

::: {.cell-output-display}
![The refugia mechanism as fitted. (a) Predicted probability of moderate-to-high disturbance against terrain-resolved epoch wind, at the 10th and 90th percentiles of stem density, all other terms held at their means; the lines cross, so wind raises attack in thin stands and lowers it in dense ones, which is the interaction. (b) The same for standing volume. (c) Coefficients of the 16-day model, with and without the within-season spread term. (d) Epoch prevalence against epoch mean wind, one point per epoch.](beetle-topography-wind-study_files/figure-docx/fig-interaction-1.png){#fig-interaction}
:::
:::


## Wind as a measurement {#sec-micromet-result}


::: {#tbl-micromet-model .cell tbl-cap='The wind terms under two specifications, both with previous-year pressure in the model. M4 carries station wind, which is flat within a year and identified only across years. M5 carries the terrain-resolved MicroMet field, which varies within the year and is identified in space.'}

```{.r .cell-code}
data.frame(
  Model = c("M4 station wind", "M4 station wind",
            "M5 terrain-resolved wind", "M5 terrain-resolved wind"),
  Term = c(WTMP_V, I_TMP, WMM, INT_MM),
  Beta = c(b4(WTMP_V), b4(I_TMP), b5(WMM), b5(INT_MM)),
  z = c(z4(WTMP_V), z4(I_TMP), z5(WMM), z5(INT_MM)),
  p = c(p4(WTMP_V), p4(I_TMP), p5(WMM), p5(INT_MM))) |>
  kable(booktabs = TRUE, align = "lllrr", row.names = FALSE)
```

::: {.cell-output-display}


|Model                    |Term                                 |Beta   |    z|       p|
|:------------------------|:------------------------------------|:------|----:|-------:|
|M4 station wind          |jun                                  |-0.002 | -0.1|   0.926|
|M4 station wind          |VRI_LIVE_STEMS_PER_HA:jun            |+0.020 |  1.2|   0.247|
|M5 terrain-resolved wind |mm_flight_mean                       |+0.467 | 28.4| < 1e-16|
|M5 terrain-resolved wind |VRI_LIVE_STEMS_PER_HA:mm_flight_mean |+0.031 |  2.1|  0.0364|


:::
:::


This section reports the same wind field at the annual resolution the study first used, and
it is retained because the contrast with @sec-epoch is the paper's methodological result.

The terrain-resolved field carries +0.467 log-odds per standard deviation
(z = 28.4, p = < 1e-16) when the response is one map per year. Windier ground
carries more moderate-to-high disturbance. The interaction the mechanism turns on is
+0.031 (z = 2.1, p = 0.0364), positive where the
pheromone-disruption mechanism requires negative.

At 16 days the same wind field, the same covariates and the same classification threshold
give -0.094 and -0.041 (@sec-epoch). Nothing about the landscape or the
wind product changed between the two. What changed is that an annual response can only ask
whether windy summers carry less attack than calm ones, and a summer contains both windy and
calm weeks. Averaging across them destroys exactly the contrast the mechanism operates on.

The station terms behave the same way and for the same reason. In this specification they
collapse to jun at -0.002, which carries no flight-window information at all.

The lesson generalises past this dataset. The mechanism concerns a plume that persists for
minutes, acting on a flight period of weeks. A test that aggregates the response to a year is
not a weaker version of the right test; it is a different question, and this study answers it
in the opposite direction.

## Previous-year pressure {#sec-autologistic}


::: {#tbl-autologistic .cell tbl-cap='Environmental coefficients before and after previous-year beetle pressure enters, fitted on the same seven year-pairs. Retained is the ratio of the two.'}

```{.r .cell-code}
shift |>
  head(14) |>
  transmute(Term = pretty_terms(term),
            `Environment only` = sprintf("%+.3f", beta_env),
            `With autocorrelation` = sprintf("%+.3f", beta_auto),
            Retained = sprintf("%.2f", retained)) |>
  kable(booktabs = TRUE, align = "lrrr", row.names = FALSE)
```

::: {.cell-output-display}


|Term                                        | Environment only| With autocorrelation| Retained|
|:-------------------------------------------|----------------:|--------------------:|--------:|
|Susceptible pine basal area (m2/ha)         |           +0.494|               +0.346|     0.70|
|Flight-window direct radiation (kWh/m2)     |           +0.482|               +0.302|     0.63|
|Quadratic mean diameter (cm)                |           -0.437|               -0.190|     0.43|
|Standing volume (m3/ha)                     |           +0.367|               +0.165|     0.45|
|Windward-leeward index                      |           +0.357|               +0.215|     0.60|
|Northness                                   |           +0.353|               +0.160|     0.45|
|Elevation (m)                               |           +0.331|               +0.319|     0.96|
|Live stems x Windward-leeward index         |           +0.232|               +0.115|     0.50|
|Stand age (years)                           |           +0.224|               +0.062|     0.28|
|Valley depth (m)                            |           -0.191|               -0.096|     0.50|
|Crown closure (%)                           |           -0.172|               -0.053|     0.31|
|Live stems x Flight-window direct radiation |           -0.148|               -0.075|     0.50|
|July mean wind (km/h)                       |           +0.147|               +0.432|     2.93|
|Live stems (n/ha)                           |           -0.103|               -0.081|     0.79|


:::
:::


Attack this year happens where attack was last year, and by a margin that changes how every
other coefficient should be read. Measured on the classified maps before any model was
fitted, a cell attacked in one year is between
16
and
139
times more likely to be attacked the next, and neighbourhood attack within 90 m correlates
with this year's state at r =
0.45
to
0.77,
falling away with radius.

Entering persistence and local spread as separate terms, after Aukema et al., the cell's own
previous state carries +0.873 log-odds per standard deviation
(z = 42.6) and its 90 m neighbourhood +0.950
(z = 29.8). Discrimination rises from
0.799 to 0.888.

The environmental terms survive that in changed but not collapsed form, and which ones
survive best is the informative part (@tbl-autologistic).

Growing-season radiation is the most robust term in the model, retaining
 of its
environment-only coefficient. Terrain ruggedness retains
0.61 and flight-window radiation
0.63. These are the
terms describing conditions a cell has whether or not the beetle was there last year, and
they behave accordingly.

The landform terms do not. Valley depth retains
0.50, mid-slope position
1.32 and height above the
valley floor . Most
of what they measured was where the outbreak had already been. That is the same failure the
terrain-wind index showed against radiation, one level up: a landform variable in an
outbreak that spreads locally will collect the outbreak's own history unless that history is
in the model.

Stand density falls to
0.45 of its
environment-only value and terrain exposure to
0.60. Both keep their sign and
both remain separable from zero, but a study reporting either without a lag term is
reporting roughly twice the effect it has evidence for. The density-by-radiation
interaction retains
0.50.

Two cautions belong with this. Persistence, +0.873, is close to a tautology in a
classified response: a stand under attack stays classified under attack while susceptible
stems remain, so it measures the classifier as much as the insect. Local spread,
+0.950, is the term the dispersal biology is about, and it is the larger of the
two. And 2006 has no predecessor, so this model is fitted on seven year-pairs rather than
eight and is not comparable by AIC with the models above.

## Landform class {#sec-geomorphon}


::: {#tbl-geomorphon .cell tbl-cap='Moderate-to-high beetle disturbance by geomorphon landform class, and the class coefficient in the full model. Coefficients are against the reference class, which is the most common one on this perimeter.'}

```{.r .cell-code}
gm_desc <- bz |>
  group_by(geomorphon) |>
  summarise(n = n(), attack = mean(modhigh), .groups = "drop")
gm_co <- co3[grepl("^geomorphon", co3$term), ]
gm_co$geomorphon <- sub("^geomorphon", "", gm_co$term)

gm_desc |>
  left_join(gm_co, by = "geomorphon") |>
  transmute(Landform = as.character(geomorphon), Cells = fmt(n),
            `Attacked (%)` = sprintf("%.1f", 100*attack),
            Beta = ifelse(is.na(beta), sprintf("%s (reference)", GEOM_REF), sprintf("%+.3f", beta)),
            p = ifelse(is.na(p), "", sapply(p, function(x) if (is.na(x)) "" else pv(x)))) |>
  arrange(desc(`Attacked (%)`)) |>
  kable(booktabs = TRUE, align = "lrrrr", row.names = FALSE)
```

::: {.cell-output-display}


|Landform |  Cells| Attacked (%)|              Beta|        p|
|:--------|------:|------------:|-----------------:|--------:|
|peak     |     90|         67.8|            +0.233|    0.335|
|shoulder |      6|         50.0|            -0.025|    0.976|
|ridge    |    567|         43.9|            -0.440| 5.67e-05|
|spur     | 10,458|         40.7|            +0.052|    0.109|
|slope    | 30,373|         32.0| slope (reference)|         |
|hollow   |  4,825|         19.3|            -0.230| 8.69e-06|
|valley   |  1,009|         11.6|            -1.019| 8.42e-15|


:::
:::


Landform class describes the pattern well and adds almost nothing once the continuous
terrain surfaces are in the model, and both halves of that are worth reporting.

Descriptively the gradient is clean and monotone from convex to concave. Attack runs
67.8 per cent on peaks,
43.9 on ridges and
40.7 on spurs, down to
19.3 in hollows and
11.6 in valleys
(@tbl-geomorphon). Convex, exposed, sunlit ground carries roughly twice the attack of
concave sheltered ground.

Conditioned on the continuous terms, that gradient nearly disappears. Spurs sit
+0.052 above the reference class
(p = 0.109) and ridges
-0.440
(p = 5.67e-05), and no other class is separable from the
reference. Adding 6 landform contrasts moves AIC by less than the single
radiation term does.

The reading is that geomorphons are a compact summary of what curvature, topographic
position, ruggedness and radiation already measure between them, not an additional
mechanism. Reported alone, the class gradient would look like strong evidence that landform
governs attack. Reported alongside the surfaces, it shows that what landform is standing for
is measurable directly, which is the same lesson the terrain-wind index taught in
@sec-results.

## Host as diameter {#sec-diameter}



::: {#tbl-qmd .cell tbl-cap='Moderate-to-high beetle disturbance by quadratic mean diameter class, on the balanced sample. The 25 cm boundary is the source-sink threshold of the species\' bionomics. Intervals are Wilson score intervals on the class proportion. Note that 30 m cells in a spreading outbreak are not independent, so the accompanying tests are anti-conservative.'}
::: {.cell-output-display}


|QMD class (cm) |      n| Attacked| Attacked (%)| 95% CI (%)|
|:--------------|------:|--------:|------------:|----------:|
|<15            |    736|      232|         31.5|  28.3-35.0|
|15-20          |  2,371|      564|         23.8|  22.1-25.5|
|20-25          |  7,058|    2,559|         36.3|  35.1-37.4|
|25-30          | 14,634|    6,717|         45.9|  45.1-46.7|
|30-40          | 18,902|    4,639|         24.5|  23.9-25.2|
|>40            |  3,627|      617|         17.0|  15.8-18.3|


:::
:::


Coding host as diameter changes the picture cover alone gives. Attack peaks in the
25 to 30 cm class at
45.9 per cent and falls away
above it, to 24.5 per cent at 30
to 40 cm and 17.0 per cent above 40
(@tbl-qmd). The step across the 25 cm source-sink boundary is from
36.3 to
45.9 per cent.

In the full model diameter carries -0.422 per standard deviation
(z = -18.4). It is negative because the relationship is not monotone: a
linear term fitted through a humped response returns the slope of its falling limb, which
is the larger part of the range. The class table, not the coefficient, is the result here,
and the point stands, because a stand's cover says nothing about whether its stems can
produce brood.

The smallest class is not evidence. It holds 736 cells
against 14,634 in the modal class, and a stand below
15 cm quadratic mean diameter in an inventory whose vintage postdates the outbreak is more
likely a stand the beetle already stripped of large stems than a stand attacked at that
size.

## Specification sensitivity {#sec-sensitivity}



::: {#tbl-sensitivity .cell tbl-cap='Sensitivity of the stand-density coefficient to decisions the data does not fix.'}

```{.r .cell-code}
sens |>
  transmute(Specification, `Density beta` = sprintf("%+.3f", beta)) |>
  kable(booktabs = TRUE, align = "lr")
```

::: {.cell-output-display}


|Specification                   | Density beta|
|:-------------------------------|------------:|
|Full model M3                   |       -0.099|
|No terrain terms                |       -0.017|
|Elevation as a spline           |       -0.023|
|Wind summarised as jun          |       +0.003|
|Wind summarised as jul          |       +0.002|
|Wind summarised as aug          |       +0.005|
|Wind summarised as flight_mean  |       +0.002|
|Wind summarised as flight_p95   |       +0.005|
|Wind summarised as flight_calm  |       +0.008|
|Wind summarised as flight_windy |       -0.003|


:::
:::


The stand-density coefficient is not stable, and saying so is the point of the table. It
runs from -0.099 in the full
model to -0.017 with all
terrain terms removed, a range of
0.107 log-odds (@tbl-sensitivity). Drop
terrain and the density effect halves.

That is not noise, and it is not a failure of the model. It is the same fact the
interactions report, seen from another angle: density and terrain are not separable claims
on this landscape, because the terrain that carries dense stands is also the terrain that
gets afternoon sun and takes the prevailing wind. A study that fits density without terrain
will overstate density, and one that fits terrain without radiation will overstate terrain.

Against the decisions that do not touch terrain, the coefficient is stable. Entering
elevation as a spline rather than a linear term moves it to
-0.023, and all
7 ways of summarising wind in time return
-0.003 to
+0.008. This
disposes of the temporal-resolution worry for this dataset: no study says over what interval wind should be
measured, and here the interval does not matter.

It also settles a failure this study previously had. An earlier specification reported a
wind effect that vanished the moment elevation entered flexibly. The density effect does not
behave that way: the spline moves it by
0.076
log-odds and does not reverse it.

# Discussion

## Radiation, not wind

The clearest result of this study is methodological, and it changes what a terrain variable
in this literature is allowed to be taken for.

Fitted with a terrain-wind index and no radiation, stand density interacts with terrain
exposure at +0.311, and the natural reading is a wind effect. Add flight-window
radiation and that interaction becomes +0.221, p = < 1e-16, while density by
radiation appears at -0.144. The exposure index was standing
in for the sun.

That is not a peculiarity of this dataset. A windward-leeward index and an afternoon
radiation surface are both functions of slope and aspect, and on a range whose prevailing
flight-window bearing is 258 degrees the windward slopes are the
west-facing ones, which are also the slopes that take afternoon sun during the flight peak.
Any study that enters a terrain-derived wind index without a radiation term on the same
clock will attribute radiation to wind.

## An old argument

Growing-season radiation carries  and retains
 of that after previous-year pressure enters, the highest
retention of any term in the model. Shaded ground carries more attack. Two independent
bodies of theory predict the opposite, and before either is invoked the coefficient has to
be said plainly for what it is.

It is an aspect variable. Growing-season direct radiation correlates
-0.834 with northness on this landscape, so what the
model has fitted is north-facing against south-facing ground and everything that travels
with that axis: soil depth, snow duration, moisture, species composition, harvest history.
Calling it "shading" names one of those and asserts the rest away.

What it is not, on this site, is shelter. Its correlation with the windward-leeward index at
the prevailing flight-window bearing is -0.015, and
with the wind shelter index +0.040. That matters
because the objection is obvious on a steep ridge: a shaded slope is often a lee slope, and
more attack on shaded ground would then be the refugia mechanism confirmed rather than
contradicted. Here the two are close to orthogonal, so that reading is not available for
this term.

It is available for the other one. Flight-window radiation, +0.487,
correlates -0.599 with the windward-leeward index and
+0.546 with wind shelter. The reason is geometric:
the pooled prevailing bearing is 258 degrees, so windward slopes face
west, and west-facing slopes are the ones taking sun through the early and mid afternoon
when flight peaks. On this landscape a warm slope in the flight window and an exposed slope
in the flight window are the same slope, and no coefficient fitted here can separate them.
The positive sign is consistent with the thermal gate on flight and equally consistent with
exposure raising attack, which the refugia hypothesis says it should not.

Against that, the vigour-microclimate argument this result was supposed to arbitrate cannot
be arbitrated. @bartos1989's alternative, that thinning acts through light, temperature and
within-stand wind rather than through tree vigour, is not testable with a surface that
conflates light and wind. The adaptive-seasonality prediction fares no better: fewer
degree-days on shaded slopes predicts less attack, and this study measures radiation rather
than degree-days, so what is being compared to that prediction is a proxy for a proxy.

The one terrain term these confounds leave largely alone is ruggedness. It correlates
-0.351 with growing-season radiation and
-0.326 with flight-window radiation, the weakest entanglement
of any terrain variable with either, and it retains 0.61 after autocorrelation. Of
the terrain surfaces fitted here it is the one whose coefficient can be read closest to face
value, which is also why the parent study's use of it is the sounder precedent.

## What survives

@krawchuk2020 name three mechanisms. At the resolution the sensor and the insect share, two
of the three hold and the third does not.

Host density holds, and it holds in the way the mechanism specifies rather than as a bare
main effect. Standing volume predicts disturbance at +0.381, and
its interaction with wind is -0.041 while stem density's is -0.094. The
claim was never that dense stands are attacked more; it was that a dense canopy holds a
plume together, and that what a dense canopy buys should shrink as the wind rises. Both
halves are present.

Large-diameter host holds as a threshold rather than a slope. Attack peaks at
45.9 per cent in the 25 to 30 cm
class, at the source-sink boundary of @carroll2004bionomics, and falls away on both sides.

Topographic shading does not hold. Growing-season radiation is 
and retains  after autocorrelation, so shaded ground carries
more attack where the mechanism requires less. That coefficient is also the least
interpretable in the model, for the reasons set out above: it is
-0.834 correlated with northness and tests aspect rather
than shading, and the water-stress pathway @krawchuk2020 describe is not measured here.

## The wind claim

The mechanism holds, and the reason earlier specifications rejected it is temporal
resolution rather than anything about the landscape.

At Landsat's own 16-day cadence, stand density interacts with terrain-resolved wind at
-0.094 for stem density and -0.041 for standing volume, both negative,
both at p below < 1e-16 and 4.91e-07 respectively. A dense stand is worth
less where and when the wind blows harder, which is what @krawchuk2020 predict. The result
survives entering the previous epoch of the same season, so it is not the outbreak's own
spread wearing a wind coefficient.

Every coarser specification in this study rejected the same mechanism. With one map a year
and station wind, the interaction was +0.020 on eight annual values, right sign and
weak identification. With one map a year and the terrain-resolved field it was
+0.031, wrong sign. The difference is not the wind product and not the covariate
set, both of which are shared: it is that a single annual map forces the comparison to be
made between summers, and a summer is not the unit the insect flies in.

That has a consequence beyond this paper. The mechanism concerns a plume that persists for
minutes over a flight period of weeks. Any test that aggregates the response to a year is
testing whether windy years have less attack than calm years, which is a different and much
weaker question, and it will answer no. The literature has never fitted a wind term at all,
so nothing in it establishes the resolution at which one should be fitted; this study's
answer is that it must be at least as fine as the flight period itself.

Two limits stay attached to the claim. The interaction is small, roughly a tenth of the
standing volume main effect. And the wind field, though it varies in space, is still
terrain-modified station data rather than measurement on the ridge, so what is established
is that the modelled wind field behaves as the mechanism requires, not that the air did.

## Autocorrelation as a control

The clearest methodological result of this study is that a landscape variable in a spreading
outbreak collects the outbreak's own history unless that history is in the model, and that
this is measurable rather than a matter of judgement.

Previous-year state is not a nuisance here. Persistence carries +0.873 and local
spread +0.950, and together they raise discrimination from
0.799 to 0.888. Aukema et al. found the same on the
Chilcotin Plateau and called the autocorrelation an unexpected benefit for prediction.

What it does to the environmental terms is the part worth reporting. The landform variables
lose most of their coefficient, valley depth to 0.50 and mid-slope
position to 1.32. The radiation and ruggedness terms lose least,
 and 0.61. The pattern is interpretable: a
description of the ground survives, a description of position within the outbreak does not,
and the two are not distinguishable by inspection.

This is the same failure as the terrain-wind index one level up. There, a terrain proxy
collected insolation. Here, a landform proxy collected outbreak history. In both cases the
proxy looked like a mechanism until the thing it stood for was measured and entered.

## Ruggedness and regeneration

The two papers now share a grid, a landscape and a terrain covariate set, and they disagree
on the sign of ruggedness: -0.036 for beetle attack here against a positive
coefficient for conifer regeneration there [@murphy2026]. Read together they describe a
landscape in which rugged ground both resists the disturbance and shelters the recovery from
it. That is a coherent picture, not a contradiction, and it is only visible because the two
studies were fitted on the same grid in EPSG:3153.

## What stays confounded

Elevation remains the largest single term at +0.329, and elevation is not one
thing. It carries temperature, snowpack, growing-season length and the distribution of
lodgepole pine, and this design cannot take them apart. Reporting the elevation coefficient
as a result would be reporting a composite.

The same caution now applies in reverse to every terrain term in the model. Radiation
absorbed one terrain interaction entirely. There is no guarantee that some further
unmeasured environmental surface would not absorb another.

# Conclusions

The wind-disruption mechanism proposed by @krawchuk2020 holds on this landscape, at the
resolution the sensor and the insect share. Across 59 sixteen-day epochs, stand
density interacts negatively with terrain-resolved wind, -0.094 for stem density
and -0.041 for standing volume, and both survive a within-season spread term. A
dense canopy is worth less to the beetle where and when the wind blows harder, which is what
a plume-disruption mechanism requires.

Of the three mechanisms that proposal names, two hold. Host density holds through standing
volume rather than crown closure, and large-diameter host holds as a threshold at 25 to 30 cm
rather than as a slope, at the source-sink boundary of @carroll2004bionomics. Topographic
shading does not hold, and the coefficient that rejects it is also the least interpretable in
the study, being -0.834 correlated with northness.

The methodological finding is the more transferable one, and it has three parts. A terrain
index is not an environmental measurement: entering flight-window radiation cut the density
by terrain-exposure interaction from +0.311 to +0.221. A landform variable in
a spreading outbreak records the outbreak's own history: entering previous-year pressure cut
the landform terms to between 0.50 and  of
their values. And an annual response cannot test a mechanism that operates over weeks: the
same wind field, covariates and threshold gave +0.031 at annual resolution against
-0.094 at sixteen days.

Since no previous study has fitted a wind term at all [@krawchuk2020; @cartwright2018], there
is no precedent establishing the resolution at which one should be fitted. This study's answer
is that it must be no coarser than the flight period, and that a test which aggregates past it
will reject a mechanism that is there.

# Limitations {#sec-limits}

**The inventory postdates part of the outbreak.** Vegetation Resources Inventory polygons in
this perimeter carry reference years spanning several decades, and a polygon interpreted
after the beetle passed through describes the stand it left, not the stand it found. Basal
area, volume and diameter are therefore partly an outcome of the response they are used to
predict. That is the most likely explanation for total basal area discriminating below
chance, at 0.516, and for the negative
linear diameter coefficient. There is no unattacked vintage of this product, so the problem
cannot be corrected, only stated.

**Radiation and exposure are not separable in the flight window.** The pooled prevailing
bearing is 258 degrees, so windward slopes face west, and west-facing
slopes take sun through the afternoon when flight peaks. Flight-window direct radiation
correlates -0.599 with the windward-leeward index and
+0.546 with wind shelter. Its positive coefficient is
consistent with the thermal gate on flight and equally consistent with exposure raising
attack, and this design cannot choose between them. Separating them needs a measured wind
field that varies within the year, not a terrain index.

**Growing-season radiation tests aspect, not shading.** Its correlation with northness is
-0.834. North-facing ground on this landscape also
differs in soil depth, snow duration, moisture and species composition, and the mechanism
Krawchuk et al. describe runs through tree water stress, which is not measured here. The
coefficient contradicts their prediction without identifying what produced the
contradiction. It is separable from wind exposure, -0.015,
which is the one thing it does establish.

**The shading result may be an artefact of the response, and this is the way to break it.**
Moderate-to-high disturbance is classified from a drop in the normalised difference moisture
index. A shaded, moist, north-facing stand starts the outbreak with a higher index than a
sun-exposed one and therefore has further to fall before the classifier calls it attacked.
If that is what is happening, the growing-season radiation coefficient is measuring the
classifier's dynamic range rather than the beetle, and the sign would be negative whatever
the beetle did. Two checks would separate them, neither run here: refitting with the
pre-outbreak 2005 index as an offset, and testing whether the coefficient survives inside
strata of similar baseline moisture. Until one of them is done, the reversal against both
vigour and semivoltinism should be read as a flag on the response, not as a finding about
the insect.

**The response is classified, not observed.** Moderate-to-high beetle disturbance is
inferred from Landsat moisture indices, trained on plots cut from those same indices, so its
reported accuracy measures separability rather than agreement with mortality on the ground.
The only ground plots available lie inside the 480 ha burn, were measured five years after a
fire, and their coordinates could not be reconciled with the imagery. No claim in this paper
rests on plot-level validation, and none should.

**The prevailing bearing is weak.** The speed-weighted resultant over the flight window has
length 0.15, with a between-year spread of
69 degrees. A directional terrain index
computed on a bearing that weakly constrained is a blunt instrument, which is part of why
the omnidirectional indices were carried alongside it.

**Station wind is spatially flat.** The temporal wind metrics come from four to seven valley
stations interpolated across 150 km. They resolve years, not ridges. The design deliberately
assigns the spatial signal to terrain and the temporal signal to the stations, and the
central result depends on that division being sound.

**One landscape, eight years.** Every conclusion here is conditioned on a single mountain
range during one outbreak. The between-year wind contrast rests on
8 annual values.

# Data availability

Every dataset used here is public and none was collected by the author. Beetle disturbance
is classified from Landsat Collection 2 Level-2 surface reflectance. Stand structure is the
provincial Vegetation Resources Inventory layer `VEG_COMP_LYR_R1_POLY`, retrieved from the
British Columbia Data Catalogue web feature service by
`02.inputs/beetle-classification/34-fetch-vri.py`. Terrain derives from the Natural
Resources Canada High Resolution Digital Elevation Model [@nrcan2017], with geomorphometry
computed by SAGA GIS in `37-geomorphometry.R`. Wind is Environment and Climate Change Canada
hourly station data, retrieved by `30-wind-hourly-metrics.R` and `36-wind-direction.R`.


::: {.cell}

```{.r .cell-code}
sessionInfo()
```

::: {.cell-output .cell-output-stdout}

```
R version 4.4.1 (2024-06-14)
Platform: aarch64-apple-darwin20
Running under: macOS 15.7.7

Matrix products: default
BLAS:   /opt/local/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRblas.0.dylib 
LAPACK: /opt/local/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

locale:
[1] en_CA.UTF-8/en_CA.UTF-8/en_CA.UTF-8/C/en_CA.UTF-8/en_CA.UTF-8

time zone: America/Vancouver
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] e1071_1.7-17     ggspatial_1.1.10 tidyterra_1.1.0  patchwork_1.3.2 
 [5] ranger_0.18.0    car_3.1-5        carData_3.0-6    mgcv_1.9-4      
 [9] nlme_3.1-168     knitr_1.51       ggplot2_4.0.2    tidyr_1.3.2     
[13] dplyr_1.2.0      sf_1.1-0         terra_1.9-1     

loaded via a namespace (and not attached):
 [1] s2_1.1.9            generics_0.1.4      class_7.3-23       
 [4] KernSmooth_2.23-26  lattice_0.22-9      pROC_1.19.0.1      
 [7] digest_0.6.39       magrittr_2.0.4      evaluate_1.0.5     
[10] grid_4.4.1          RColorBrewer_1.1-3  fastmap_1.2.0      
[13] jsonlite_2.0.0      Matrix_1.7-5        Formula_1.2-5      
[16] DBI_1.3.0           purrr_1.2.1         viridisLite_0.4.3  
[19] scales_1.4.0        codetools_0.2-20    abind_1.4-8        
[22] cli_3.6.5           rlang_1.1.7         units_1.0-1        
[25] splines_4.4.1       withr_3.0.2         yaml_2.3.12        
[28] otel_0.2.0          tools_4.4.1         vctrs_0.7.2        
[31] R6_2.6.1            proxy_0.4-29        lifecycle_1.0.5    
[34] classInt_0.4-11     pkgconfig_2.0.3     pillar_1.11.1      
[37] gtable_0.3.6        data.table_1.18.2.1 glue_1.8.0         
[40] Rcpp_1.1.1          xfun_0.57           tibble_3.3.1       
[43] tidyselect_1.2.1    farver_2.1.2        htmltools_0.5.9    
[46] labeling_0.4.3      rmarkdown_2.30      wk_0.9.5           
[49] compiler_4.4.1      S7_0.2.1           
```


:::
:::


# References
