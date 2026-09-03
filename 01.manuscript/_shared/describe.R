## Full descriptive statistics for the stand-structure table.
##
## Sourced by every draft. The earlier table gave minimum, median, mean and maximum,
## which cannot tell a reader whether a variable is dispersed, skewed or heavy-tailed,
## and those are the properties that decide whether a linear term on it is defensible.
##
## Standard deviation AND standard error are both reported, because they answer
## different questions and the journal requires whichever is shown to be named in the
## heading. SD describes the spread of the landscape; SE describes how precisely the
## mean of that landscape is estimated, and with tens of thousands of cells it is small
## by construction and should not be read as precision about any one cell.
##
## Skewness and kurtosis are the third and fourth standardised moments, computed with
## the bias-corrected estimators in `e1071::skewness(type = 2)` and
## `e1071::kurtosis(type = 2)`, which are the ones SAS and SPSS report. Kurtosis is
## EXCESS kurtosis: 0 is Gaussian, positive is heavy-tailed.
##
## Requires: e1071.

describe_vars <- function(data, vars, labels = NULL) {
  ## unname() is load-bearing. labels[vars] keeps the lookup names, data.frame() turns
  ## them into row names, and a variable absent from the lookup gives an NA name, which
  ## fails with "row names contain missing values" and points at data.frame rather than
  ## at the missing label. Fall back to the raw column name instead.
  labs <- if (is.null(labels)) vars else unname(labels[vars])
  labs[is.na(labs)] <- vars[is.na(labs)]
  out <- lapply(seq_along(vars), function(i) {
    v <- data[[vars[i]]]
    v <- v[is.finite(v)]
    n <- length(v)
    sdv <- stats::sd(v)
    data.frame(
      Attribute  = labs[i],
      n          = n,
      Mean       = mean(v),
      SD         = sdv,
      SE         = sdv / sqrt(n),
      Median     = stats::median(v),
      Min        = min(v),
      Max        = max(v),
      Skewness   = e1071::skewness(v, type = 2),
      Kurtosis   = e1071::kurtosis(v, type = 2),
      check.names = FALSE)
  })
  do.call(rbind, out)
}

describe_table <- function(d) {
  data.frame(
    ## n is the same for every attribute and is stated in the caption; Seamus dropped the
    ## column by hand on 2026-09-02 and shortened the two moment headings, so the render
    ## does the same.
    Attribute    = d$Attribute,
    Mean         = sprintf("%.2f", d$Mean),
    SD           = sprintf("%.2f", d$SD),
    `SE#`        = sprintf("%.3f", d$SE),
    Median       = sprintf("%.2f", d$Median),
    Min          = sprintf("%.2f", d$Min),
    Max          = sprintf("%.2f", d$Max),
    Skew         = sprintf("%+.2f", d$Skewness),
    `Kurt.`      = sprintf("%+.2f", d$Kurtosis),
    check.names = FALSE)
}

## Readable names for the inventory's raw column headings. The manuscript prints these;
## the code keeps the raw names, so the mapping lives in one place and a table can never
## show a column the model did not fit.
VRI_LABELS <- c(
  BASAL_AREA            = "Stand basal area (m\u00b2 ha\u207b\u00b9)",
  CROWN_CLOSURE         = "Crown closure (%)",
  VRI_LIVE_STEMS_PER_HA = "Live stems (n/ha)",
  QUAD_DIAM_125         = "Quadratic mean diameter (cm)",
  PROJ_AGE_1            = "Stand age (years)",
  PROJ_HEIGHT_1         = "Stand height (m)",
  LIVE_STAND_VOLUME_125 = "Standing volume (m\u00b3 ha\u207b\u00b9)",
  PINE_BA               = "Susceptible pine BA (m\u00b2 ha\u207b\u00b9)",
  PinePct               = "Lodgepole pine cover (%)",
  elevation             = "Elevation (m)",
  tri                   = "Terrain ruggedness index",
  vrm                   = "Vector ruggedness measure",
  tpi                   = "Topographic position index",
  twi                   = "Topographic wetness index",
  valley_depth          = "Valley depth (m)",
  midslope_position     = "Mid-slope position",
  height_valley_floor   = "Height above valley floor (m)",
  curv_prof             = "Profile curvature",
  convergence           = "Convergence index",
  northness             = "Northness",
  eastness              = "Eastness",
  wind_effect           = "Windward-leeward index",
  solar_flight_direct   = "Flight-window direct radiation (kWh/m2)",
  solar_season_direct   = "Growing-season direct radiation (kWh/m2)",
  solar_season_total    = "Growing-season total radiation (kWh/m2)",
  mm_flight_mean        = "MicroMet flight-window wind (km/h)",
  ep_wind_mean          = "Epoch mean wind (km/h)",
  jun = "June mean wind (km/h)", jul = "July mean wind (km/h)",
  aug = "August mean wind (km/h)",
  ## Added 2026-08-28. Without these, pretty_terms() falls back to the raw column name and
  ## the submitted tables printed "flight_calm" beside nine labelled terms.
  flight_mean           = "Flight-window mean wind (km/h)",
  flight_p95            = "Flight-window 95th percentile wind (km/h)",
  flight_calm           = "Flight-window calm hours (share below 5 km/h)",
  flight_windy          = "Flight-window windy hours (share above 15 km/h)",
  lag_self              = "Attack in the same cell, previous year",
  lag_nbr90             = "Attack within 90 m, previous year",
  ep_lag_self           = "Attack in the same cell, previous epoch",
  ep_lag_nbr90          = "Attack within 90 m, previous epoch",
  mstpi                 = "Multi-scale topographic position",
  slope                 = "Slope (degrees)",
  curv_plan             = "Plan curvature",
  openness_pos          = "Positive openness",
  openness_neg          = "Negative openness",
  sky_view              = "Sky view factor",
  wind_afh              = "Effective air flow height",
  wind_exposition       = "Wind exposition index",
  wind_shelter          = "Wind shelter index",
  heat_load             = "Heat load index",
  normalised_height     = "Normalised height",
  height_above_valley   = "Height above valley floor (m)")

pretty_terms <- function(x) {
  out <- VRI_LABELS[x]
  ## An interaction is two terms joined by a colon; label each side, then rejoin.
  ix <- grepl(":", x, fixed = TRUE)
  if (any(ix)) {
    out[ix] <- vapply(strsplit(x[ix], ":", fixed = TRUE), function(p) {
      lab <- VRI_LABELS[p]; lab[is.na(lab)] <- p[is.na(lab)]
      paste(sub(" \\(.*\\)$", "", lab), collapse = " x ")
    }, character(1))
  }
  out[is.na(out)] <- x[is.na(out)]
  unname(out)
}
