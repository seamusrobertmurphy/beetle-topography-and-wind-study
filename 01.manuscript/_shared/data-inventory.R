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
             Spatial = spatial, Temporal = temporal,
             Period = period, n = n, check.names = FALSE)

data_inventory <- function(BC, SA) {
  n_or <- function(expr, fmt = "%s") {
    v <- tryCatch(expr, error = function(e) NA)
    if (length(v) == 0 || all(is.na(v))) "not built" else sprintf(fmt, v)
  }
  cnt <- function(dir, pat) length(list.files(dir, pattern = pat))
  ## The modelling tables are the annualized ones. Reading model_table.csv here reported
  ## the superseded static-composite counts, 122,700 and 71,127, beside a text that quotes
  ## 111,707 and 66,302 from the tables actually fitted. Audited 2026-08-28.
  mt   <- utils::read.csv(file.path(BC, "model-data", "model_table_vri.csv"))
  ept  <- utils::read.csv(file.path(BC, "model-data", "epoch_model_table_vri.csv"))
  span <- function(x) {
    y <- sort(unique(x))
    gap <- setdiff(seq(min(y), max(y)), y)
    sprintf("%d-%d%s", min(y), max(y),
            if (length(gap)) paste0(", (excl. ", paste(gap, collapse = ", "), ")") else "")
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
      "Beetle attack (Annual)",
      "Landsat 5 and 8 Collection 2 Level-2",
      "Moderate-to-high NDMI binary",
      "30 m", "1 year",
      span(mt$year),
      sprintf("%d years", length(unique(mt$year)))),
    inventory_row(
      "Beetle attack (/16-day)",
      "Landsat 5 and 8 Collection 2 Level-2",
      "Moderate-to-high NDMI binary",
      "30 m", "16 days",
      span(ept$year),
      sprintf("%d epochs", nrow(unique(ept[, c("year", "epoch")])))),
    inventory_row(
      "Stand structure",
      "VRI Historical, BC Data Catalogue",
      "BA, volume, stems, quadratic mean diameter, age, height",
      "30 m (rasterised)", "1 year, projected-yr",
      n_or(yrs(vri_dir, "vri_\\d{4}\\.gpkg")),
      n_or(cnt(vri_dir, "vri_\\d{4}\\.gpkg"), "%s windows")),
    inventory_row(
      "Terrain",
      "NRCan High-Res DEM, SAGA indices",
      "Geomorphons (incl. radiation, exposure, landform)",
      "30 m", "Static",
      "n/a",
      n_or(if (exists("N_FINAL_TERRAIN")) N_FINAL_TERRAIN else NA, "%s fitted")),
    inventory_row(
      "Station wind",
      "Env. & Climate Change Canada",
      "Speed and direction",
      "4 to 7 stations", "1 hour",
      "2005-2014, May-Sept",
      paste(formatC(nrow(utils::read.csv(file.path(BC, "covariates", "flight-window",
                    "hourly_climate.csv"))), format = "d", big.mark = ","), "hourly records")),
    inventory_row(
      "Terrain-resolved wind",
      "DEM-conditioned MicroMet wind field of station data",
      "Weighting factor, modified speed, diverted direction",
      "30 m", "16 days, & 1 year",
      n_or(yrs(file.path(BC, "covariates", "wind-micromet"), "micromet_\\d{4}")),
      "16 sectors (22.5\u00b0)"),
    inventory_row(
      "Model frame (Annual)",
      "Rows joined above, (one row / cell-year)",
      "Response & covariates, one row per cell-year",
      "30 m", "1 year",
      span(mt$year),
      paste(formatC(nrow(mt), format = "d", big.mark = ","), "cell-years")),
    inventory_row(
      "Model frame (/16-day)",
      "Rows joined above per Landsat pass (one row / cell-epoch)",
      "Response & covariates, one row per cell-epoch",
      "30 m", "16 days",
      span(ept$year),
      paste(formatC(nrow(ept), format = "d", big.mark = ","), "cell-epochs"))
  )
}
