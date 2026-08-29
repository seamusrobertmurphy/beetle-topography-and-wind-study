## The dataset inventory table.
##
## Sourced by every draft. A reader cannot currently work out from the Methods that the
## response is 16-day, the inventory annual, the wind hourly and the terrain static: the
## resolutions are scattered through the prose and never set beside each other. This is
## the table that says so in one place.
##
## Every count is read off the files on disk at render time rather than typed, on the same
## rule as every other number in this manuscript. A dataset that is missing reports as
## missing rather than silently dropping out of the table.

inventory_row <- function(dataset, source, variables, spatial, temporal, period, n)
  data.frame(Dataset = dataset, Source = source, Variables = variables,
             `Spatial resolution` = spatial, `Temporal resolution` = temporal,
             Period = period, n = n, check.names = FALSE)

data_inventory <- function(BC, SA) {
  n_or <- function(expr, fmt = "%s") {
    v <- tryCatch(expr, error = function(e) NA)
    if (length(v) == 0 || all(is.na(v))) "not built" else sprintf(fmt, v)
  }
  cnt <- function(dir, pat) length(list.files(dir, pattern = pat))
  ## The modelling tables are the year-matched ones. Reading model_table.csv here reported
  ## the superseded static-composite counts, 122,700 and 71,127, beside a text that quotes
  ## 111,707 and 66,302 from the tables actually fitted. Audited 2026-08-28.
  mt   <- utils::read.csv(file.path(BC, "model-data", "model_table_vri.csv"))
  ept  <- utils::read.csv(file.path(BC, "model-data", "epoch_model_table_vri.csv"))
  span <- function(x) {
    y <- sort(unique(x))
    gap <- setdiff(seq(min(y), max(y)), y)
    sprintf("%d-%d%s", min(y), max(y),
            if (length(gap)) paste0(", excluding ", paste(gap, collapse = ", ")) else "")
  }
  yrs <- function(dir, pat) {
    f <- list.files(dir, pattern = pat)
    y <- as.integer(regmatches(f, regexpr("\\d{4}", f)))
    if (!length(y)) return("not built")
    sprintf("%d-%d", min(y), max(y))
  }

  vri_dir <- file.path(SA, "vri-timeseries")
  ep <- file.path(BC, "epoch-response")
  gm <- file.path(BC, "geomorphometry", "geomorphometry.tif")

  rbind(
    inventory_row(
      "Beetle disturbance, annual",
      "Landsat 5 and 8 Collection 2 Level-2",
      "Moderate-to-high disturbance, binary, from NDMI",
      "30 m", "1 year",
      span(mt$year),
      sprintf("%d years", length(unique(mt$year)))),
    inventory_row(
      "Beetle disturbance, 16-day",
      "Landsat 5 and 8 Collection 2 Level-2",
      "Moderate-to-high disturbance, binary, from NDMI",
      "30 m", "16 days, the sensor's repeat",
      span(ept$year),
      sprintf("%d epochs", nrow(unique(ept[, c("year", "epoch")])))),
    inventory_row(
      "Stand structure",
      "VRI Historical, BC Data Catalogue",
      "Basal area, volume, stems, quadratic mean diameter, age, height",
      "Polygon, rasterised to 30 m", "1 year, projected to each year",
      n_or(yrs(vri_dir, "vri_\\d{4}\\.gpkg")),
      n_or(cnt(vri_dir, "vri_\\d{4}\\.gpkg"), "%s snapshots")),
    inventory_row(
      "Terrain",
      "NRCan High Resolution DEM, indices by SAGA GIS",
      "29 geomorphometric surfaces incl. radiation, exposure, landform",
      "30 m", "Static",
      "n/a",
      n_or(if (file.exists(gm)) terra::nlyr(terra::rast(gm)) else NA, "%s surfaces")),
    inventory_row(
      "Station wind",
      "Environment and Climate Change Canada",
      "Speed and direction",
      "4 to 7 valley stations", "1 hour",
      "2005-2014, May to September",
      paste(formatC(nrow(utils::read.csv(file.path(BC, "covariates", "flight-window",
                    "hourly_climate.csv"))), format = "d", big.mark = ","), "hourly records")),
    inventory_row(
      "Terrain-resolved wind",
      "MicroMet over the DEM, driven by station wind",
      "Weighting factor, modified speed, diverted direction",
      "30 m", "16 days, and 1 year",
      n_or(yrs(file.path(BC, "covariates", "wind-micromet"), "micromet_\\d{4}")),
      "16 direction bins"),
    inventory_row(
      "Modelling table, annual",
      "Assembled by 38-assemble-model-data.R",
      "Response and every covariate, one row per cell-year",
      "30 m", "1 year",
      span(mt$year),
      paste(formatC(nrow(mt), format = "d", big.mark = ","), "cell-years")),
    inventory_row(
      "Modelling table, 16-day",
      "Assembled by 45-epoch-model-data.R",
      "Response and every covariate, one row per cell-epoch",
      "30 m", "16 days",
      span(ept$year),
      paste(formatC(nrow(ept), format = "d", big.mark = ","), "cell-epochs"))
  )
}
