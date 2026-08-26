#!/usr/bin/env Rscript
## Outbreak-era spectra at the 28 ground plots, and which spectral change actually
## predicts the measured mortality.
##
## The 2020 imagery used by the parent study cannot answer this: the Mt Midgeley
## wildfire burned this ground in 2015, so a 2003-to-2020 difference carries fire,
## beetle and regeneration together. The plots record cumulative pine mortality, so
## the honest comparison is against cumulative spectral change during the outbreak
## itself, 2003 to 2014, before the fire.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf)})

ROOT <- "02.inputs/beetle-classification"; OUT <- file.path(ROOT, "plot-locations")
ee_Initialize(project = "murphys-deforisk", drive = FALSE)

pl <- read.csv(file.path(OUT, "beetle_plots_training.csv"))
pts <- sf_as_ee(st_transform(st_as_sf(pl, coords = c("easting_m","northing_m"), crs = 32611), 4326))

SENSOR <- c(`2003`="LT05",`2005`="LT05",`2006`="LT05",`2007`="LT05",`2008`="LT05",
            `2009`="LT05",`2010`="LT05",`2011`="LT05",`2012`="LE07",`2013`="LC08",`2014`="LC08")
COLL <- c(LT05="LANDSAT/LT05/C02/T1_L2", LE07="LANDSAT/LE07/C02/T1_L2", LC08="LANDSAT/LC08/C02/T1_L2")
SB <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")

ndmi_year <- function(year) {
  s <- SENSOR[[as.character(year)]]
  b <- if (s == "LC08") paste0("SR_B", 2:7) else c(paste0("SR_B", 1:5), "SR_B7")
  ic <- ee$ImageCollection(COLL[[s]])$
    filterBounds(pts$geometry())$
    filterDate(sprintf("%d-06-01", year), sprintf("%d-08-31", year))$
    filter(ee$Filter$lt("CLOUD_COVER", 40))$
    map(function(i) {
      m <- i$select("QA_PIXEL")$bitwiseAnd(strtoi("11111", base = 2))$eq(0)
      i$select(b)$rename(SB)$multiply(0.0000275)$add(-0.2)$updateMask(m)
    })
  ic$median()$normalizedDifference(c("NIR","SWIR1"))$rename(sprintf("NDMI_%d", year))
}

years <- as.integer(names(SENSOR))
img <- ndmi_year(years[1])
for (y in years[-1]) img <- img$addBands(ndmi_year(y))

fc <- img$sampleRegions(collection = pts, scale = 30, geometries = FALSE)
info <- fc$getInfo()
props <- lapply(info$features, function(f) f$properties)
keys <- unique(unlist(lapply(props, names)))
s <- as.data.frame(do.call(rbind, lapply(props, function(p) {
  v <- p[keys]; v[vapply(v, is.null, logical(1))] <- NA; unlist(v) })), stringsAsFactors = FALSE)
s[] <- lapply(s, function(x) as.numeric(as.character(x)))
d <- merge(pl, s[, c("point_id", grep("^NDMI_", names(s), value = TRUE))], by = "point_id")
write.csv(d, file.path(OUT, "beetle_plots_ndmi_timeseries.csv"), row.names = FALSE)

ncols <- grep("^NDMI_", names(d), value = TRUE)
ag <- aggregate(d[, ncols], by = list(plot = d$plot, mort = d$pi_mpb_killed), FUN = mean, na.rm = TRUE)
cat(sprintf("plots: %d\n\ncorrelation of NDMI with measured mortality, by year:\n", nrow(ag)))
for (v in ncols) cat(sprintf("  %-10s r = % .4f   (n=%d)\n", v,
    cor(ag[[v]], ag$mort, use = "complete.obs"), sum(!is.na(ag[[v]]))))

## Cumulative change during the outbreak, relative to the 2003 pre-outbreak baseline.
out <- ncols[ncols != "NDMI_2003"]
ag$dNDMI_min <- apply(ag[, out] - ag$NDMI_2003, 1, min, na.rm = TRUE)   # deepest decline
ag$NDMI_min  <- apply(ag[, out], 1, min, na.rm = TRUE)
cat(sprintf("\ndeepest outbreak-era decline vs 2003 : r = % .4f\n", cor(ag$dNDMI_min, ag$mort)))
cat(sprintf("minimum outbreak-era NDMI            : r = % .4f\n", cor(ag$NDMI_min,  ag$mort)))
write.csv(ag, file.path(OUT, "beetle_plots_ndmi_by_plot.csv"), row.names = FALSE)
cat("\nwrote beetle_plots_ndmi_by_plot.csv\n")
