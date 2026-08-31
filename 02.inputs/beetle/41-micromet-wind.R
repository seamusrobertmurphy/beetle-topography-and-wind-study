#!/usr/bin/env Rscript
## Terrain-resolved wind: the MicroMet model of Liston and Elder (2006).
##
## WHY THIS EXISTS, AND WHY NOT WINDNINJA
## The wind surfaces used until now were interpolated from four to seven valley stations
## across 150 km and were nearly flat inside any year, spanning under a kilometre per hour
## over 50 km. A wind main effect fitted on them rests on eight annual values, and terrain
## indices standing in for wind were shown to be carrying insolation instead. WindNinja is
## the obvious tool and cannot be used here: release 3.12.2 ships Windows installers only,
## it is absent from MacPorts, and the CMake source build needs Qt5, boost, netcdf, poppler
## and curl, which is a multi-hour build on arm64 with a real chance of failing.
##
## MicroMet is the published alternative and needs no build at all. It is seven equations,
## implemented directly below with the paper's own equation numbers against each. Source:
## Liston, G.E. and Elder, K. (2006) A meteorological distribution system for
## high-resolution terrestrial modeling (MicroMet), Journal of Hydrometeorology 7:217-234,
## doi:10.1175/JHM486.1, retrieved open access from the publisher on 2026-08-26 and read in
## full text. There is nothing to install, import or compile; there is only arithmetic on
## the digital elevation model, and it is all here.
##
## THE MODEL, VERBATIM FROM THE PAPER
##   (12) terrain slope         beta  = atan( sqrt( (dz/dx)^2 + (dz/dy)^2 ) )
##   (13) slope azimuth         xi    = 3*pi/2 - atan( (dz/dy) / (dz/dx) ), north = 0
##   (14) curvature             Omega_c, the difference between a cell's elevation and the
##        mean of the two opposite cells one curvature length scale away, computed on the
##        S-N, W-E, SW-NE and NW-SE lines and averaged, then scaled to [-0.5, 0.5]
##   (15) slope in wind dir     Omega_s = beta * cos(theta - xi), scaled to [-0.5, 0.5]
##   (16) wind weighting        Ww = 1 + gamma_s * Omega_s + gamma_c * Omega_c
##   (17) terrain-modified      Wt = Ww * W
##   (18) diverting factor      theta_d = -0.5 * Omega_s * sin( 2 * (xi - theta) ), after
##        Ryan (1977); the modified direction is theta + theta_d
## The paper sets gamma_s = gamma_c = 0.5, "giving approximately equal weight to slope and
## curvature", which bounds Ww between 0.5 and 1.5. Those are the values used here.
##
## HOW IT IS RUN, AND WHY IT KEEPS HOURLY RESOLUTION
## Ww and theta_d depend on the wind DIRECTION, not on its speed. So the expensive part is
## computed once per direction bin rather than once per hour: 16 bins of 22.5 degrees give
## 16 weighting surfaces, and each hourly observation is multiplied by the surface for its
## own bin. The result is an hourly, spatially varying wind field at 30 m, at the cost of
## 16 raster operations rather than tens of thousands. Nothing is averaged before the
## terrain acts on it, which is the failure the interpolated surfaces had.
##
## The station speed and direction that drive it are the observations of that hour, from
## Environment and Climate Change Canada, not a climatology. Direction is interpolated as
## its components, u = -W sin(theta) and v = -W cos(theta) (equations 8 and 9), because
## averaging degrees across the 360/0 line is meaningless.

suppressPackageStartupMessages({library(weathercan); library(sf); library(terra); library(dplyr)})
ROOT  <- "02.inputs/beetle"
SA    <- file.path(ROOT, "study-area")
OUT   <- file.path(ROOT, "covariates", "wind-micromet")
dir.create(OUT, recursive = TRUE, showWarnings = FALSE)
YEARS <- c(2005:2011, 2013, 2014)
NBIN  <- 16L
GS <- GC <- 0.5
CALM  <- 5; WINDY <- 15                       # km/h, as in 30-wind-hourly-metrics.R

dem <- rast(file.path(SA, "elevation.tif"))
msk <- rast(file.path(SA, "perimeter_mask.tif"))

## ---- (12) and (13): slope and slope azimuth ---------------------------------------
g  <- terra::terrain(dem, v = c("slope", "aspect"), unit = "radians", neighbors = 8)
beta <- g[["slope"]]
xi   <- g[["aspect"]]                          # terra returns azimuth from north, radians

## ---- (14): curvature at a length scale set from the terrain itself -----------------
## eta is "approximately half the wavelength of the topographic features within the domain
## (e.g. the distance from a typical ridge to the nearest valley)". It is estimated here
## rather than assumed, as the distance at which elevation stops being autocorrelated with
## itself, and the estimate is printed so the choice is visible.
z <- dem
sh <- function(dx, dy) shift_grid(z, dx, dy)
shift_grid <- function(r, dx, dy) {
  m <- as.matrix(r, wide = TRUE)
  n <- nrow(m); p <- ncol(m)
  out <- matrix(NA_real_, n, p)
  ri <- (1:n) - dy; ci <- (1:p) + dx
  ok_r <- ri >= 1 & ri <= n; ok_c <- ci >= 1 & ci <= p
  out[ok_r, ok_c] <- m[ri[ok_r], ci[ok_c]]
  o <- rast(r); values(o) <- out; o
}
prof <- sapply(1:40, function(k) {
  a <- values(z); b <- values(shift_grid(z, k, 0))
  ok <- !is.na(a) & !is.na(b); cor(a[ok], b[ok]) })
ETA_CELLS <- which(prof < 0.5)[1]
if (is.na(ETA_CELLS)) ETA_CELLS <- 20L
ETA <- ETA_CELLS * res(dem)[1]
cat(sprintf("curvature length scale: %d cells = %.0f m (first lag where elevation autocorrelation drops below 0.5)\n",
            ETA_CELLS, ETA))

k <- ETA_CELLS
zW <- shift_grid(z,-k,0); zE <- shift_grid(z,k,0)
zS <- shift_grid(z,0,-k); zN <- shift_grid(z,0,k)
zSW<- shift_grid(z,-k,-k); zNE<- shift_grid(z,k,k)
zNW<- shift_grid(z,-k,k);  zSE<- shift_grid(z,k,-k)
oc <- 0.25 * ( (z - 0.5*(zW+zE)) / (2*ETA) +
               (z - 0.5*(zS+zN)) / (2*ETA) +
               (z - 0.5*(zSW+zNE)) / (2*sqrt(2)*ETA) +
               (z - 0.5*(zNW+zSE)) / (2*sqrt(2)*ETA) )
scale05 <- function(r) {
  v <- values(r); m <- max(abs(v), na.rm = TRUE)
  if (!is.finite(m) || m == 0) return(r * 0)
  r / (2*m)                                    # maps onto [-0.5, 0.5]
}
OC <- scale05(oc)
cat(sprintf("curvature Omega_c range %.3f to %.3f\n", minmax(OC)[1], minmax(OC)[2]))

## ---- (15) to (18): one weighting surface per direction bin -------------------------
bins <- (seq_len(NBIN) - 1) * 360 / NBIN       # bin centres, degrees from north
Ww <- list(); Td <- list()
for (i in seq_along(bins)) {
  th <- bins[i] * pi/180
  os <- beta * cos(th - xi)                    # (15)
  OS <- scale05(os)
  Ww[[i]] <- 1 + GS*OS + GC*OC                 # (16)
  Td[[i]] <- -0.5 * OS * sin(2*(xi - th))      # (18)
}
Wstack <- mask(rast(Ww), msk); names(Wstack) <- sprintf("bin_%03.0f", bins)
writeRaster(Wstack, file.path(OUT, "wind_weight_by_direction.tif"), overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
cat(sprintf("wind weighting factor Ww over all %d bins: %.3f to %.3f (paper bounds 0.5 to 1.5)\n",
            NBIN, min(minmax(Wstack)[1,]), max(minmax(Wstack)[2,])))

## ---- hourly station observations, driving the model hour by hour -------------------
ctr <- st_transform(st_sfc(st_point(c(mean(ext(dem)[1:2]), mean(ext(dem)[3:4]))),
                           crs = crs(dem)), 4326)
cc  <- st_coordinates(ctr)
sl  <- weathercan::stations_search(coords = c(cc[2], cc[1]), interval = "hour", dist = 150)
sl  <- sl[!is.na(sl$start) & sl$start <= 2014 & !is.na(sl$end) & sl$end >= 2005, ]
ids <- unique(sl$station_id)

summ <- list()
for (y in YEARS) {
  w <- try(weathercan::weather_dl(station_ids = ids, interval = "hour",
             start = sprintf("%d-07-01", y), end = sprintf("%d-08-15", y)), silent = TRUE)
  if (inherits(w, "try-error")) { cat("no data", y, "\n"); next }
  ## Speed and direction to components (8) and (9), averaged across stations per hour,
  ## then back to speed and direction (10) and (11).
  h <- w |> filter(!is.na(wind_spd), !is.na(wind_dir)) |>
    mutate(th = wind_dir * 10 * pi/180,
           u = -wind_spd * sin(th), v = -wind_spd * cos(th)) |>
    group_by(time) |>
    summarise(u = mean(u), v = mean(v), n = n(), .groups = "drop") |>
    mutate(W = sqrt(u^2 + v^2),
           theta = (atan2(-u, -v) * 180/pi) %% 360,
           bin = (round(theta / (360/NBIN)) %% NBIN) + 1L)
  if (!nrow(h)) next

  ## Accumulate the flight-window metrics cell by cell, over hours, each hour weighted by
  ## the terrain surface for its own direction bin. Done analytically rather than by
  ## looping over hours: for a bin whose weighting surface is Ww, the hour-by-hour sum is
  ## Ww times the sum of that bin's speeds, and the count of hours a cell spends below the
  ## calm threshold is the number of that bin's speeds below CALM/Ww, which is a lookup
  ## into the sorted speed vector. A first version multiplied one raster per hour and was
  ## tens of thousands of raster operations.
  cells <- !is.na(values(msk))
  acc <- rep(0, sum(cells)); ccalm <- acc; cwindy <- acc; nc <- 0
  for (b in sort(unique(h$bin))) {
    sp <- sort(h$W[h$bin == b])
    wv <- values(Wstack[[b]])[cells]
    acc    <- acc + wv * sum(sp)
    ccalm  <- ccalm  + findInterval(CALM  / wv, sp)          # count of sp < CALM/Ww
    cwindy <- cwindy + (length(sp) - findInterval(WINDY / wv, sp))
    nc <- nc + length(sp)
  }
  put <- function(v) { r <- msk; values(r)[cells] <- v; values(r)[!cells] <- NA; r }
  mean_f <- put(acc / nc); calm_f <- put(ccalm / nc); windy_f <- put(cwindy / nc)
  s <- c(setNames(mean_f, "mm_flight_mean"),
         setNames(calm_f, "mm_flight_calm"),
         setNames(windy_f, "mm_flight_windy"))
  s <- mask(s, msk)
  writeRaster(s, file.path(OUT, sprintf("micromet_%d.tif", y)), overwrite = TRUE,
              datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))
  rng <- minmax(s[["mm_flight_mean"]])
  summ[[length(summ)+1]] <- data.frame(year = y, hours = nrow(h),
    stations = max(h$n), mean_kmh = round(mean(values(mean_f), na.rm = TRUE), 3),
    spatial_min = round(rng[1], 3), spatial_max = round(rng[2], 3),
    spatial_range = round(rng[2] - rng[1], 3),
    calm = round(mean(values(calm_f), na.rm = TRUE), 3))
  cat(sprintf("%d  %5d hours  mean %.2f km/h  spatial range %.2f km/h across the grid\n",
              y, nrow(h), mean(values(mean_f), na.rm = TRUE), rng[2] - rng[1]))
}
sm <- do.call(rbind, summ)
write.csv(sm, file.path(OUT, "micromet_summary.csv"), row.names = FALSE)
cat("\nSpatial variation now present within each year, which the station interpolation never had:\n")
print(sm, row.names = FALSE)
