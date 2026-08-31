#!/usr/bin/env Rscript
## Train the red-stage model on the 28 ground plots, not on the aerial survey.
##
## The plot coordinates were recovered on 2026-08-20 from `beetle_plots_join1.shp`
## in Google Drive (Data Collection / ArcMap working folder). Each plot carries four
## Landsat pixel centres, 112 points in all, and the measured response is the basal
## area of pine killed by mountain pine beetle, 0.62 to 47.37 m2/ha, recorded in the
## 2020 field campaign.
##
## What the label supports, stated plainly. The plots were measured once, in 2020,
## and record cumulative mortality over the whole outbreak. They therefore calibrate
## a cumulative severity model against a cumulative spectral change, not an annual
## one. Anything annual that follows is an assumption about how that change
## accumulated, and is reported as such.
##
## Spectra are extracted here from Collection 2 Level-2 surface reflectance at the
## plot coordinates, which is the fix for the defect recorded on 2026-08-19: the
## inherited 310-row sample was Level-1 quantised DN from a single 2020 scene and
## could not be transferred to the outbreak years.

## reticulate must be pointed at the pre-existing rgee virtualenv before rgee loads.
## Without this it resolves a bare uv-cached interpreter that has no earthengine-api,
## and ee_Initialize fails with a message about miniconda that is not the problem.
Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf); library(terra)})

ROOT  <- "02.inputs/beetle"
PLOTS <- file.path(ROOT, "plot-locations", "beetle_plots_training.csv")
OUT   <- file.path(ROOT, "plot-locations")
BASE_YEAR <- 2003
TARGET_YEAR <- 2020          # the year the plots were measured

ee_Initialize(project = "murphys-deforisk", drive = FALSE)

pl <- read.csv(PLOTS)
stopifnot(nrow(pl) == 112, length(unique(pl$plot)) == 28)
pts_sf <- st_as_sf(pl, coords = c("easting_m", "northing_m"), crs = 32611)
pts_ee <- sf_as_ee(st_transform(pts_sf, 4326))

## Collection 2 Level-2, scaled, cloud/shadow/snow masked, growing season median.
SB <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")
prep <- function(img, sensor) {
  b <- if (sensor == "LC08") paste0("SR_B", 2:7) else c(paste0("SR_B", 1:5), "SR_B7")
  qa <- img$select("QA_PIXEL")
  mask <- qa$bitwiseAnd(strtoi("11111", base = 2))$eq(0)
  img$select(b)$rename(SB)$multiply(0.0000275)$add(-0.2)$updateMask(mask)
}
composite <- function(year, sensor, coll) {
  ic <- ee$ImageCollection(coll)$
    filterBounds(pts_ee$geometry())$
    filterDate(sprintf("%d-06-01", year), sprintf("%d-08-31", year))$
    filter(ee$Filter$lt("CLOUD_COVER", 40))$
    map(function(i) prep(i, sensor))
  m <- ic$median()
  m$addBands(m$normalizedDifference(c("NIR","SWIR1"))$rename("NDMI"))
}

base <- composite(BASE_YEAR,  "LT05", "LANDSAT/LT05/C02/T1_L2")
targ <- composite(TARGET_YEAR,"LC08", "LANDSAT/LC08/C02/T1_L2")
dndmi <- targ$select("NDMI")$subtract(base$select("NDMI"))$rename("dNDMI")
stack <- targ$addBands(dndmi)

## sampleRegions rather than ee_extract: ee_extract calls reduceRegions with a named
## `image` argument that the installed earthengine-api no longer accepts.
fc   <- stack$sampleRegions(collection = pts_ee, scale = 30, geometries = FALSE)
info <- fc$getInfo()
props <- lapply(info$features, function(f) f$properties)
keys <- unique(unlist(lapply(props, names)))
samp <- as.data.frame(do.call(rbind, lapply(props, function(p) {
  v <- p[keys]; v[vapply(v, is.null, logical(1))] <- NA; unlist(v)
})), stringsAsFactors = FALSE)
samp[] <- lapply(samp, function(x) as.numeric(as.character(x)))
samp <- samp[order(samp$point_id), ]
df <- merge(pl, samp[, c("point_id", setdiff(names(samp), names(pl)))],
            by = "point_id", all.x = TRUE)
df <- df[stats::complete.cases(df[, c("NDMI","dNDMI","NIR","SWIR1")]), ]
cat(sprintf("extracted %d of 112 points with valid reflectance\n", nrow(df)))
write.csv(df, file.path(OUT, "beetle_plots_spectra.csv"), row.names = FALSE)

## Aggregate to the plot, because the label is a plot-level measurement and the four
## pixels are not independent observations of it.
ag <- aggregate(cbind(NDMI, dNDMI, NIR, SWIR1, SWIR2, RED, GREEN, BLUE) ~ plot +
                pi_mpb_killed + pi_mpb_killed_pc, data = df, FUN = mean)
cat(sprintf("plots with spectra: %d\n", nrow(ag)))

## Split by plot, never by pixel, so no plot appears in both partitions.
set.seed(123)
tr_id <- sample(ag$plot, size = round(0.75 * nrow(ag)))
tr <- ag[ag$plot %in% tr_id, ]; te <- ag[!ag$plot %in% tr_id, ]

fit  <- lm(pi_mpb_killed ~ dNDMI, data = tr)
pred <- predict(fit, newdata = te)
r2   <- function(o, p) 1 - sum((o - p)^2) / sum((o - mean(o))^2)
rmse <- function(o, p) sqrt(mean((o - p)^2))

cat("\n--- cumulative severity model, trained on ground plots ---\n")
print(summary(fit)$coefficients)
cat(sprintf("train n=%d  R2=%.4f  RMSE=%.3f m2/ha\n", nrow(tr),
            summary(fit)$r.squared, rmse(tr$pi_mpb_killed, fitted(fit))))
cat(sprintf("test  n=%d  R2=%.4f  RMSE=%.3f m2/ha\n", nrow(te),
            r2(te$pi_mpb_killed, pred), rmse(te$pi_mpb_killed, pred)))
cat(sprintf("cor(dNDMI, mortality) = %.4f over all %d plots\n",
            cor(ag$dNDMI, ag$pi_mpb_killed), nrow(ag)))

saveRDS(list(fit = fit, plots = ag, points = df),
        file.path(OUT, "plot-trained-model.rds"))
cat("\nwrote plot-trained-model.rds\n")
