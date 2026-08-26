#!/usr/bin/env Rscript
## A 16-day Landsat cube over the beetle plots, harmonised across sensors, and a
## search for the epoch and index that actually track measured plot mortality.
##
## Why a cube rather than one composite per year. The plots were measured once, in
## summer 2020, and the outbreak ran 2005 to 2011. A 2020-trained classifier can only
## be applied to the outbreak years if the 2020 scene sits on the same radiometric
## scale as they do, so the series has to be built and normalised as one object with
## a consistent grid, cadence and scale, and only then read.
##
## Three normalisations are applied, in this order:
##   1. Sensor. Landsat 8 OLI surface reflectance is converted onto the ETM+ scale
##      with the published Roy et al. (2016) band-pass coefficients, so 2020 and the
##      Landsat 5 outbreak years are comparable. Without this the 2020 NDMI is offset
##      from the earlier years by the bandpass difference alone.
##   2. Time. Fixed 16-day epochs on a common calendar, 1 May to 30 September, so
##      every year is sampled on the same cadence rather than as one summer median.
##   3. Space. One grid: EPSG:32611 at 30 m, the native Landsat posting, sampled at
##      the plot pixel centres recovered from the ArcMap working files.
##
## Every plot lies inside the 2015 Mt Midgeley fire perimeter, all 112 points, so the
## 2020 epochs describe five-year post-fire ground. That is recorded here rather than
## worked around, and it is the first thing to check if 2020 behaves oddly.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({library(reticulate); library(rgee); library(sf)})

ROOT <- "02.inputs/beetle-classification"; OUT <- file.path(ROOT, "plot-locations")
ee_Initialize(project = "murphys-deforisk", drive = FALSE)

## PLOTS_CSV / CUBE_CSV let the same pipeline be run over an alternative set of plot
## coordinates, which is how the mislabelled-coordinate hypothesis is tested: identical
## imagery, identical epochs, identical harmonisation, only the locations differ.
PLOTS_CSV <- Sys.getenv("PLOTS_CSV", "beetle_plots_training.csv")
CUBE_CSV  <- Sys.getenv("CUBE_CSV",  "beetle_plots_cube_16day.csv")
pl  <- read.csv(file.path(OUT, PLOTS_CSV))
pts <- sf_as_ee(st_transform(st_as_sf(pl, coords = c("easting_m","northing_m"), crs = 32611), 4326))

SB     <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")
YEARS  <- c(2003, 2005:2011, 2013, 2014, 2020)
SENSOR <- function(y) if (y >= 2013) "LC08" else if (y == 2012) "LE07" else "LT05"
COLL   <- c(LT05="LANDSAT/LT05/C02/T1_L2", LE07="LANDSAT/LE07/C02/T1_L2",
            LC08="LANDSAT/LC08/C02/T1_L2")

## Roy et al. (2016), Remote Sensing of Environment 185:57-70, Table 2: OLI to ETM+
## surface reflectance, ETM+ = intercept + slope * OLI.
ROY_I <- c(BLUE=0.0003, GREEN=0.0088, RED=0.0061, NIR=0.0412, SWIR1=0.0254, SWIR2=0.0172)
ROY_S <- c(BLUE=0.8474, GREEN=0.8483, RED=0.9047, NIR=0.8462, SWIR1=0.8937, SWIR2=0.9071)

prep <- function(img, sensor) {
  b <- if (sensor == "LC08") paste0("SR_B", 2:7) else c(paste0("SR_B", 1:5), "SR_B7")
  m <- img$select("QA_PIXEL")$bitwiseAnd(strtoi("11111", base = 2))$eq(0)   # fill/cloud/shadow/snow/cirrus
  sr <- img$select(b)$rename(SB)$multiply(0.0000275)$add(-0.2)$updateMask(m)
  if (sensor == "LC08")
    sr <- sr$multiply(ee$Image$constant(unname(ROY_S[SB])))$
             add(ee$Image$constant(unname(ROY_I[SB])))$rename(SB)
  sr
}

indices <- function(sr) {
  ee$Image$cat(
    sr$normalizedDifference(c("NIR","SWIR1"))$rename("NDMI"),
    sr$normalizedDifference(c("NIR","RED"))$rename("NDVI"),
    sr$normalizedDifference(c("NIR","SWIR2"))$rename("NBR"),
    sr$normalizedDifference(c("SWIR1","NIR"))$rename("MSI"),
    sr$expression("(R/G)", list(R = sr$select("RED"), G = sr$select("GREEN")))$rename("RGI"),
    sr$expression("0.0315*B+0.2021*G+0.3102*R+0.1594*N-0.6806*S1-0.6109*S2",
      list(B=sr$select("BLUE"),G=sr$select("GREEN"),R=sr$select("RED"),
           N=sr$select("NIR"),S1=sr$select("SWIR1"),S2=sr$select("SWIR2")))$rename("TCW")
  )
}

EP_START <- 121L   # 1 May
EP_N     <- 10L    # ten 16-day epochs to 30 September
rows <- list()

for (y in YEARS) {
  s <- SENSOR(y)
  for (k in seq_len(EP_N)) {
    d0 <- as.Date(sprintf("%d-01-01", y)) + (EP_START - 1) + (k - 1) * 16
    d1 <- d0 + 16
    ic <- ee$ImageCollection(COLL[[s]])$
      filterBounds(pts$geometry())$
      filterDate(format(d0, "%Y-%m-%d"), format(d1, "%Y-%m-%d"))$
      map(function(i) prep(i, s))
    n <- ic$size()$getInfo()
    if (n == 0) next
    img <- indices(ic$median())
    fc  <- img$sampleRegions(collection = pts, scale = 30, geometries = FALSE)
    info <- tryCatch(fc$getInfo(), error = function(e) NULL)
    if (is.null(info) || length(info$features) == 0) next
    p <- lapply(info$features, function(f) f$properties)
    keys <- unique(unlist(lapply(p, names)))
    df <- as.data.frame(do.call(rbind, lapply(p, function(q) {
      v <- q[keys]; v[vapply(v, is.null, logical(1))] <- NA; unlist(v) })), stringsAsFactors = FALSE)
    df[] <- lapply(df, function(x) as.numeric(as.character(x)))
    df$year <- y; df$epoch <- k; df$epoch_start <- format(d0, "%Y-%m-%d")
    df$sensor <- s; df$n_scenes <- n
    rows[[length(rows) + 1]] <- df
    cat(sprintf("%d epoch %2d (%s) %s  scenes=%d  points=%d\n", y, k, format(d0,"%b %d"), s, n, nrow(df)))
  }
}

cube <- do.call(rbind, lapply(rows, function(x) x[, union(names(rows[[1]]), names(x))]))
write.csv(cube, file.path(OUT, CUBE_CSV), row.names = FALSE)
cat(sprintf("\ncube: %d rows, %d year-epochs\n", nrow(cube),
            nrow(unique(cube[, c("year","epoch")]))))
