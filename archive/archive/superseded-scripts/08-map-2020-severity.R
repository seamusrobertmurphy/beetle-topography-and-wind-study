#!/usr/bin/env Rscript
## A classified 2020 NDMI surface and an interactive map for locating the ground plots.
##
## The raster is the harmonised 2020 growing-season NDMI over the 2015 fire perimeter
## and 2 km around it, on the ETM+ scale via the Roy et al. (2016) coefficients, so it
## is the same quantity the outbreak-era epochs carry. Severity classes are tertiles of
## NDMI inside the burn: low NDMI is dry, open, dead-standing or burned ground and is
## labelled high severity; high NDMI is moist, closed canopy and is labelled low.
##
## What this map is for, stated so it is not over-read. The classes describe canopy
## moisture in 2020, five years after the fire. They are a search aid for finding where
## the plots sit, not a beetle severity product: nothing here separates beetle mortality
## from fire, and the correlation work in 07-search-cube.R shows 2020 NDMI carries only
## a weak relationship with measured plot mortality.

Sys.setenv(RETICULATE_PYTHON = path.expand("~/.virtualenvs/rgee/bin/python"))
suppressPackageStartupMessages({
  library(reticulate); library(rgee); library(sf); library(terra)
  library(leaflet); library(htmlwidgets); library(RColorBrewer)})

OUT <- "02.inputs/beetle/plot-locations"
MAP <- "03.outputs/maps"; dir.create(MAP, recursive = TRUE, showWarnings = FALSE)
ee_Initialize(project = "murphys-deforisk", drive = FALSE)

fire <- st_transform(st_read(path.expand(
  "~/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData/fire_perimiter/Fire.Perimiter.shp"),
  quiet = TRUE), 32611)
aoi  <- st_as_sfc(st_bbox(st_buffer(fire, 2000)))
aoi_ee <- sf_as_ee(st_transform(aoi, 4326))

SB <- c("BLUE","GREEN","RED","NIR","SWIR1","SWIR2")
ROY_I <- c(0.0003,0.0088,0.0061,0.0412,0.0254,0.0172)
ROY_S <- c(0.8474,0.8483,0.9047,0.8462,0.8937,0.9071)

ic <- ee$ImageCollection("LANDSAT/LC08/C02/T1_L2")$
  filterBounds(aoi_ee)$filterDate("2020-06-01","2020-09-30")$
  filter(ee$Filter$lt("CLOUD_COVER", 40))$
  map(function(i) {
    m  <- i$select("QA_PIXEL")$bitwiseAnd(strtoi("11111", base = 2))$eq(0)
    sr <- i$select(paste0("SR_B", 2:7))$rename(SB)$multiply(0.0000275)$add(-0.2)$updateMask(m)
    sr$multiply(ee$Image$constant(ROY_S))$add(ee$Image$constant(ROY_I))$rename(SB)
  })
cat(sprintf("2020 scenes in composite: %d\n", ic$size()$getInfo()))
ndmi <- ic$median()$normalizedDifference(c("NIR","SWIR1"))$rename("NDMI")

url <- ndmi$multiply(10000)$toInt16()$getDownloadURL(list(
  scale = 30, region = aoi_ee, crs = "EPSG:32611", format = "GEO_TIFF"))
tf <- tempfile(fileext = ".tif"); download.file(url, tf, mode = "wb", quiet = TRUE)
r <- rast(tf) / 10000; names(r) <- "NDMI"
writeRaster(r, file.path(MAP, "ndmi_2020_harmonised.tif"), overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE"))

## Tertile breaks computed inside the burn, where the question is.
inb <- mask(crop(r, vect(fire)), vect(fire))
br  <- as.numeric(global(inb, function(x) quantile(x, c(1/3, 2/3), na.rm = TRUE))[1, ])
if (any(is.na(br))) br <- as.numeric(quantile(values(inb), c(1/3,2/3), na.rm = TRUE))
cat(sprintf("NDMI tertile breaks inside the burn: %.4f and %.4f\n", br[1], br[2]))
cls <- classify(r, rbind(c(-Inf, br[1], 3), c(br[1], br[2], 2), c(br[2], Inf, 1)))
levels(cls) <- data.frame(value = 1:3,
  class = c("Low severity (moist canopy)","Moderate severity","High severity (dry / open)"))
writeRaster(cls, file.path(MAP, "ndmi_2020_severity_classes.tif"), overwrite = TRUE,
            datatype = "INT1U", gdal = c("COMPRESS=DEFLATE"))

## Interactive map.
pts   <- st_as_sf(read.csv(file.path(OUT, "beetle_plots_training.csv")),
                  coords = c("easting_m","northing_m"), crs = 32611)
shift <- st_as_sf(read.csv(file.path(OUT, "beetle_plots_training_shift.csv")),
                  coords = c("easting_m","northing_m"), crs = 32611)
tiers <- st_read(file.path(OUT, "search-area/search_area_all_tiers.gpkg"), quiet = TRUE)
t1 <- st_transform(tiers[tiers$tier == "1_moderate_severe_in_burn", ], 4326)
t3 <- st_transform(tiers[tiers$tier == "3_any_IBM_in_burn", ], 4326)

pal <- colorFactor(c("#2c7bb6","#fdae61","#d7191c"), domain = 1:3, na.color = "transparent")
m <- leaflet() |>
  addProviderTiles("Esri.WorldImagery", group = "Satellite") |>
  addProviderTiles("OpenTopoMap", group = "Topographic") |>
  addRasterImage(cls, colors = pal, opacity = 0.65, project = TRUE,
                 group = "2020 NDMI severity") |>
  addPolygons(data = st_transform(fire, 4326), fill = FALSE, color = "#ffff00",
              weight = 3, group = "2015 fire perimeter") |>
  addPolygons(data = t3, fillColor = "#7570b3", fillOpacity = .25, color = "#7570b3",
              weight = 1, group = "Any beetle severity (survey)",
              popup = ~sprintf("poly %s<br>severity %s<br>survey %s",
                               POLYGON_NUMBER, PEST_SEVERITY_CODE, CAPTURE_YEAR)) |>
  addPolygons(data = t1, fillColor = "#e7298a", fillOpacity = .35, color = "#e7298a",
              weight = 2, group = "Moderate/severe beetle (survey)",
              popup = ~sprintf("poly %s<br>severity %s<br>survey %s",
                               POLYGON_NUMBER, PEST_SEVERITY_CODE, CAPTURE_YEAR)) |>
  addCircleMarkers(data = st_transform(pts, 4326), radius = 4, color = "#ffffff",
                   fillColor = "#000000", fillOpacity = .9, weight = 1,
                   group = "Plot points, as recorded",
                   popup = ~sprintf("plot %s, point %s<br>pine killed %.1f m2/ha (%.1f%%)",
                                    plot, point_id, pi_mpb_killed, pi_mpb_killed_pc)) |>
  addCircleMarkers(data = st_transform(shift, 4326), radius = 4, color = "#ffffff",
                   fillColor = "#00ffff", fillOpacity = .6, weight = 1,
                   group = "Plot points, shifted -400E -1550N",
                   popup = ~sprintf("plot %s (shifted hypothesis)", plot)) |>
  addLegend(colors = c("#2c7bb6","#fdae61","#d7191c"),
            labels = c("Low (moist canopy)","Moderate","High (dry / open)"),
            title = "2020 NDMI class", position = "bottomright") |>
  addLayersControl(baseGroups = c("Satellite","Topographic"),
    overlayGroups = c("2020 NDMI severity","2015 fire perimeter",
                      "Moderate/severe beetle (survey)","Any beetle severity (survey)",
                      "Plot points, as recorded","Plot points, shifted -400E -1550N"),
    options = layersControlOptions(collapsed = FALSE)) |>
  hideGroup("Plot points, shifted -400E -1550N") |>
  addScaleBar(position = "bottomleft")

saveWidget(m, file.path(MAP, "beetle-plot-locator.html"), selfcontained = TRUE,
           title = "Darkwoods beetle plot locator")
cat("\nwrote:\n  ", file.path(MAP, "beetle-plot-locator.html"), "\n  ",
    file.path(MAP, "ndmi_2020_severity_classes.tif"), "\n  ",
    file.path(MAP, "ndmi_2020_harmonised.tif"), "\n")
