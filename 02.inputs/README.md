# Input data: provenance and retrieval

Bulk data is carried in **Git LFS** as of 1 August 2026. Cloning without `git-lfs` installed leaves pointer files rather than data. Three things stay out of version control entirely: `*.tif`, `*.zip` (the survey download is kept locally but the unzipped geodatabase is what is committed), and `climate/raw/`, which is a regenerable API cache. The manuscript reads terrain from an external archive and everything else from this folder.

## Where the manuscript looks

``` r
DATA_ROOT <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
```

Set `DARKWOODS_DATA` to override without editing the manuscript. Everything else is repo-relative.

## What changed on 2026-08-27

This file described the design the study has abandoned. Three corrections, so that the
list below is read in the right order.

The **Aerial Overview Survey is no longer the response**, and it is no longer a training
label. It is a visual check only. The response is moderate-to-high beetle disturbance
classified from Landsat normalised difference moisture index by the parent study's own
method, rebuilt across Darkwoods by `beetle-classification/17-` through `24-`.

The **Global Wind Atlas is gone**. Wind now comes from Environment and Climate Change
Canada hourly station records, modified over the terrain with the MicroMet model of
Liston and Elder (2006), implemented in `beetle-classification/41-micromet-wind.R`.

The **grid is EPSG:3153 at 30 m**, the parent study's grid, not the inherited UTM
terrain archive described under source 3 below.

Sources 5 to 9 were added after that rewrite. Source 7, the annual VRI series, supersedes source 2 for any model.

## The nine sources

### 1. Visual check only: BC Aerial Overview Survey, pest infestation polygons

|  |  |
|-------------|-------------------------------------------------------|
| Layer | `pest_infestation_poly` (File Geodatabase) |
| Publisher | Province of British Columbia, Ministry of Forests |
| Portal | https://catalogue.data.gov.bc.ca/dataset/pest-infestation-polygons |
| Direct | https://pub.data.gov.bc.ca/datasets/450b67bb-02d5-4526-8bc0-ac7924125a1e/pest_infestation_poly.zip |
| Licence | Open Government Licence, British Columbia |
| Size | 769 MB zipped, 950 MB unzipped |
| Retrieved | 2026-07-30 |
| Local path | `02.inputs/aos/pest_infestation_poly.gdb` |

**Retained as a visual check, not as data.** No model in the manuscript takes a
response or a training label from this layer. Province-wide, all agents, survey years
1965 to 2025. The filter is server-side by extent, then to `PEST_SPECIES_CODE == "IBM"`
(mountain pine beetle) and `CAPTURE_YEAR` in 1999 to 2015. That yields 301 polygons over the Darkwoods extent. Severity is the ordinal `PEST_SEVERITY_CODE`: `T` trace, `L` light, `M` moderate, `S` severe, `V` very severe.

Read it with `terra::vect(..., layer = "pest_infestation_poly", extent = <SpatExtent in EPSG:3005>)`. Passing `extent` is essential; reading the whole layer is slow and memory-hostile on this machine.

### 2. Host: BC Vegetation Resources Inventory

|  |  |
|------------------------------------|------------------------------------|
| Layer | `WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY` |
| Portal | https://catalogue.data.gov.bc.ca/dataset/vri-forest-vegetation-composite-rank-1-layer-r1- |
| Service | `https://openmaps.gov.bc.ca/geo/pub/WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY/ows` (WFS 2.0.0) |
| Licence | Open Government Licence, British Columbia |
| Retrieved | 2026-07-30 |
| Local path | `02.inputs/vri/vri_darkwoods.geojson` (2,743 polygons, 6 MB) |

Pulled with a server-side bounding-box filter in BC Albers. To reproduce:

```         
CQL_FILTER=BBOX(GEOMETRY,1669662,496309,1687819,515652,'EPSG:3005')
outputFormat=application/json  srsName=EPSG:3005
propertyName=FEATURE_ID,BEC_ZONE_CODE,BEC_SUBZONE,BEC_VARIANT,SPECIES_CD_1,SPECIES_PCT_1,
             SPECIES_CD_2,SPECIES_PCT_2,SPECIES_CD_3,SPECIES_PCT_3,CROWN_CLOSURE,QUAD_DIAM_125,
             BASAL_AREA,VRI_LIVE_STEMS_PER_HA,PROJ_AGE_1,PROJ_HEIGHT_1,LIVE_STAND_VOLUME_125,
             FEATURE_AREA_SQM,GEOMETRY
```

Quote the CRS as a string literal inside `BBOX(...)` or the CQL parser rejects it. Lodgepole cover is accumulated across the three species slots by matching `^PL`.

### 3. Terrain and wind (inherited, superseded)

**Superseded.** Retained for provenance only. Terrain is now the NRCan High Resolution
DEM reprojected to EPSG:3153 at 30 m, with 29 geomorphometric surfaces computed by SAGA
GIS in `beetle-classification/37-geomorphometry.R`. Wind is source 5 below, not the
Global Wind Atlas.

<details>
<summary>The inherited archive, as it was</summary>


From the companion study's archive, unchanged. Derived from the 1 m NRCan High Resolution DEM, smoothed, depression-filled (Wang and Liu 2006) and aggregated to 25 m; compound indices after Beers and Miller 1973 and Parker 1982. Wind is Global Wind Atlas mean speed. The manuscript adds a topographic position index at a 625 m neighbourhood, computed in-document.

| Layer                            | File                                    |
|------------------------------------|------------------------------------|
| Elevation, and the analysis grid | `terrain_environment/Elevation.utm.tif` |
| Slope                            | `terrain_environment/Slope.utm.tif`     |
| Topographic wetness              | `terrain_environment/TWI.utm.tif`       |
| Ruggedness                       | `terrain_environment/Rutm.tif`          |
| Mean wind speed                  | `terrain_environment/Wind.utm.tif`      |
| BEC subzones                     | `bec_zones/BEC.ecozones.shp`            |

</details>

### 4. Winter minimum air temperature, station observations

|  |  |
|------------------------------------|------------------------------------|
| Networks | BC Wildfire Service hourly, Environment and Climate Change Canada daily |
| Stations | `https://openmaps.gov.bc.ca/geo/pub/WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP/ows` (WFS 2.0.0) |
| Hourly | `https://www.for.gov.bc.ca/ftp/HPR/external/!publish/BCWS_DATA_MART/<year>/<year>_BCWS_WX_OBS.csv` |
| ECCC | `https://api.weather.gc.ca/collections/climate-daily/items` and `.../climate-stations/items` |
| Licence | Open Government Licence, British Columbia; Open Government Licence, Canada |
| Retrieved | 2026-08-01 |
| Script | `02.inputs/climate/fetch-station-minima.R` |
| Local path | `02.inputs/climate/station-winter-minima.csv` (363 station-winters, 58 KB) |
| Full note | `02.inputs/climate/README-station-data.md` |

Answers one question: do winter minima here reach the classical -40 °C lethal threshold for mountain pine beetle larvae? Across 347 station-winters surviving quality control, no. The coldest defensible minimum in the region is -28.7 °C, at Norns, 2,423 m, winter 2014, and across the 26 usable station-winters at or above 1,500 m the mean is -19.4 °C.

The annual BCWS files are 100 to 210 MB, so the script streams each through `curl` into an `awk` filter and caches only the winter rows for the sixteen stations within 100 km. Those extracts live in `02.inputs/climate/raw/`, 107 MB, and are gitignored; the summary CSV is committed because it is what the manuscript cites. Quote `min_temp_c_usable`, never `min_temp_c`.

Rerun with `/usr/local/bin/Rscript 02.inputs/climate/fetch-station-minima.R`. It is idempotent, reuses the cache, and reprints every number above.

### 5. Wind: ECCC hourly station observations, modified over terrain

|  |  |
|------------------------------------|------------------------------------|
| Network | Environment and Climate Change Canada, hourly |
| Service | `https://api.weather.gc.ca/collections/climate-hourly/items` |
| Licence | Open Government Licence, Canada |
| Scripts | `beetle-classification/30-wind-hourly-metrics.R`, `36-wind-direction.R`, `41-micromet-wind.R`, `44-epoch-wind.R` |
| Local path | `beetle-classification/covariates/wind-micromet/`, `covariates/wind-epoch/` |

Four to seven valley stations, which interpolate to a surface spanning under a kilometre
per hour across 50 km. That is why the field is not interpolated but modelled: MicroMet's
wind component is seven equations over the DEM, implemented directly against the paper's
equation numbers, giving a weighting factor that varies at 30 m. WindNinja, the usual
tool, ships no macOS binary. `wind_weight_by_direction.tif` holds one surface per 16
direction bins; each hourly observation is multiplied by the surface for its own bin, so
nothing is averaged before the terrain acts on it.

### 6. Flight-season climate, hourly station records

|  |  |
|------------------------------------|------------------------------------|
| Network | Environment and Climate Change Canada, hourly, via `weathercan` |
| Period | 1 May to 30 September, 2005 to 2014 excluding 2012 |
| Retrieved | 2026-08-28 |
| Script | `beetle-classification/51-flight-window-climate.R` |
| Local path | `covariates/flight-window/` (236,079 hourly records) |

The flight window, 1 July to 15 August and the hours 12:00 to 17:00, is taken from the
bionomics and is not fitted to these data. This is what checks it: inside the window 89.5
per cent of afternoon hours fall within the 19 to 41 degrees C flight gate against 51.4 per
cent outside it, and the afternoon mean is 26.0 against 19.2 degrees C. Mean wind speed
peaks in the same hours as temperature, 10.4 km/h at 14:00 to 15:00 against 6.5 at 09:00,
so the hours the beetle can fly are the windiest of the day.

`30-wind-hourly-metrics.R` fetches June to August and keeps only nine summary rows, so
nothing else on disk carries the shape within a season.

### 7. Stand structure over time: VRI Historical, annual snapshots

|  |  |
|------------------------------------|------------------------------------|
| Dataset | VRI - HISTORICAL Vegetation Resource Inventory (2002 - 2024) |
| Catalogue id | `02dba161-fdb7-48ae-a4bb-bd6ef017c36d` |
| Portal | https://catalogue.data.gov.bc.ca/dataset/vri-historical-vegetation-resource-inventory-2002-2024- |
| Licence | Open Government Licence, British Columbia |
| Script | `beetle-classification/50-fetch-vri-timeseries.R` |
| Local path | `study-area/vri-timeseries/vri_<year>.gpkg` |
| Status | **incomplete as of 2026-08-28**; see below |

**This supersedes source 2 for any model.** Source 2 is the live WFS composite, a single
layer projected to 2025: every annual observation of a cell carried the same basal area,
volume, stems and diameter, and those attributes had been grown forward through and past
the outbreak they were meant to predict. On this perimeter that layer gives a mean basal
area of 35.18 m2/ha; the year-matched 2014 snapshot gives 30.0, with 787 stems per hectare
against 670 and a quadratic mean diameter of 26.74 cm against 30.13.

Each annual file is "updated for depletions, such as harvesting, and projected annually for
growth", and its `PROJECTED_DATE` is 31 December of the year before its label, so the 2014
file is the stand entering 2014.

Three traps, all of which cost time:

1.  The archives are about 3.9 GB each, so all nine would be 35 GB. GDAL reads them in
    place over HTTP and pulls only the byte ranges the spatial filter needs.
2.  **The server answers `HEAD` with 404**, which breaks vsicurl's size probe and makes the
    dataset look unopenable. `CPL_VSIL_CURL_USE_HEAD=NO` is required, not optional.
3.  Nothing about the archives is uniform. The zip name changes after 2006; the folder
    inside the zip does not always match the zip stem, and where it does not GDAL reports
    the whole archive as "not recognized as being in a supported file format", which reads
    as a corrupt download and is not one; and the layer is `VEG_COMP_LYR_R1_POLY_FINALV4`
    in 2005 and 2006 but `VEG_COMP_LYR_R1_POLY` from 2007. The script discovers all three.

**Status: complete.** All nine study years are extracted and verified, and every model in
`beetle-topography-wind-study-vri-timeseries.qmd` is fitted on them.

Every year that first looked like a data gap was a renamed column. Three schema generations
appear in the series and the field map in `50-fetch-vri-timeseries.R` covers all of them:

| Attribute | 2007 and earlier | 2008 | 2009 onward |
|---|---|---|---|
| Crown closure | `CR_CLOSURE` | `CROWN_CLOSURE` | `CROWN_CLOSURE` |
| Live stems | `LIVE_STEMS` | `VRI_LIVE_STEMS_PER_HA` | `VRI_LIVE_STEMS_PER_HA` |
| Quadratic mean diameter | `Q_DIAM_125` | `QUAD_DIAM_125` | `QUAD_DIAM_125` |
| Stand height | `PROJ_HT_1` | `PROJ_HEIGHT_1` | `PROJ_HEIGHT_1` |
| Species code | `SPEC_CD_1` | `SPECIES_CD_1` | `SPECIES_CD_1` |
| Standing volume | `VOLSP1_125`..`VOLSP6_125`, summed | `VOL_PER_HA_SPP1_125`..`SPP6`, summed | `LIVE_STAND_VOLUME_125` |

**One genuine gap.** The 2007 delivery carries `BASAL_AREA` and `VRI_LIVE_STEMS_PER_HA` as
columns and fills neither: 0 and 3 per cent of polygons respectively, against 70 to 97 per
cent in every other year. `55-build-vri-timeseries-table.R` therefore requires a field to be
at least 20 per cent populated before a year counts as usable, and carries 2006 forward for
2007. Carried forward, never averaged: the inventory is itself a projection, so carrying
forward reproduces a stand structure the province published where averaging would invent one
it did not. The substitution is recorded in `model-data/vri_year_source.csv`.

**Two traps that cost hours.**

4.  **The resolver was timing out, not failing.** 2009 and 2011 reported "could not resolve
    archive or layer" three times each. Both archives open fine. Probing candidate inner
    paths with `ogrinfo` costs minutes per attempt against a 3.9 GB remote zip, so the loop
    never reached the right one. Extracting directly with the confirmed inner names,
    `veg_comp_lyr_r1_poly.gdb` for 2009 and `veg_comp_lyr_r1.gdb` for 2011, worked first
    time.
5.  **Concurrent writes corrupt these GeoPackages silently.** A retry loop restarted the
    fetch while a direct extraction was writing the same file; 2011 and 2013 were destroyed
    that way earlier the same day. The corrupted file exists at a plausible size and fails
    only when read. Only one process may write `vri-timeseries/` at a time.

### 8. Response: Landsat Collection 2 Level-2 surface reflectance

|  |  |
|------------------------------------|------------------------------------|
| Product | Landsat 5, 7, 8 Collection 2 Level-2 surface reflectance |
| Access | Google Earth Engine through `rgee` |
| Grid | 1739 x 1695 at 30 m, EPSG:3153, 2,947,605 cells |
| Years | 2005 to 2011, 2013, 2014, 2020 |
| Scripts | `beetle-classification/17-`, `20-`, `22-`, `19-`, `24-`, and `42-` to `45-` for the 16-day series |

2012 is excluded: Landsat 7 only, scan-line corrector off since May 2003. Run
`22-harmonise-landsat8.R` before anything downstream. Skipping it put 52 per cent of the
landscape in the attacked class for 2013 and 2014.

### 9. Base map: BC Freshwater Atlas

|  |  |
|------------------------------------|------------------------------------|
| Layers | `WHSE_BASEMAPPING.FWA_LAKES_POLY`, `WHSE_BASEMAPPING.FWA_RIVERS_POLY` |
| Service | `https://openmaps.gov.bc.ca/geo/pub/<layer>/ows` (WFS 2.0.0) |
| Licence | Open Government Licence, British Columbia |
| Retrieved | 2026-08-27 |
| Script | `beetle-classification/46-fetch-basemap.py` |
| Local path | `beetle-classification/study-area/basemap_water.geojson` (529 features) |

Kootenay Lake, 42,300 ha, sits 1.9 km from the study perimeter, and the Kootenay River
0.6 km. The perimeter is the burn buffered 5 km and then cut to the parent's elevation
band, so its edge is ragged; with no surrounding feature on the page that raggedness
reads as a rendering fault rather than as a study boundary.

## Ground plots, and what they can and cannot do

`2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx` in the companion archive holds 28 plots with the basal area of pine killed by beetle, 0.62 to 47.37 m²/ha, or 1.25 to 94.73 per cent of plot basal area, plus the 2020 Landsat values at each plot. These calibrate the severity scale.

**No coordinates exist for these plots anywhere in the archive.** Every `.xlsx` sheet was checked; only `dataset_seedlings` and `dataset_burnplots` carry `x`/`y`. The `.RData` workspace is 28 by 7 with no geometry, and `MPBfishnet.shp` is 154 unattributed lines with no CRS. The plots therefore anchor the severity scale but cannot validate the spatial placement of survey polygons. The manuscript says so rather than implying a validation that was not performed.

## Traps

1.  **The old clipped rasters are superseded.** `beetle_stages/Beetle.Outbreak.*.tif` cover only 2 by 4 km and write the out-of-survey background as `|128|`, tagged as nodata in only two of seven files. Analysing them without excluding that background inflates every elevation contrast. The manuscript now uses the provincial survey instead and keeps the clip only as the small-extent comparison in the extent table.
2.  **`mpb_grey_attackcount.tif` is stale** (932 cells, max 4; correct is 1,541 and 5). Not used.
3.  **`dplyr::intersect` masks `terra::intersect`.** Namespace it explicitly.
4.  **VRI basal area is missing on 121,353 of 388,003 terrain cells**, which are unmapped or non-productive. The manuscript drops them explicitly rather than letting `glm` do it silently, which reduces the modelled area from 245 km² to 168 km².
5.  **The masterfile holds the lost `.dbf`.** `1.0.darkwoods_masterfile.xlsx`, sheet `dataset_beetle_bcgov`, is the attribute table for `MPB_BC_AerialSurveys.shp`, joinable by FID. Superseded by the provincial download but useful as a cross-check.
6.  **`freq()` on a categorical SpatRaster returns the class label in `value`, not the code.** Comparing it numerically succeeds silently and once reported 100 per cent of the landscape attacked while the rasters underneath were correct.
7.  **The parent's `ndmi` column is rank-locked to its own field mortality**, Spearman -0.9995, while three tasselled-cap columns from the same rows give |rho| below 0.034. It is not an independent image measurement.
8.  **The `pi_mpb_killed_pc` column, 75 to 98 per cent, is not the parent's percentage.** The parent's `pi_mpb_killed%` runs 1.25 to 94.73 and is exactly twice the basal area.
9.  **Some Freshwater Atlas polygons carry NA vertices**, and `sf::st_crop` stops on them with `!anyNA(x) is not TRUE`. Select the features that intersect the page instead and let the plot clip.
10.  **BCWS temperature is censored at exactly -20.0 °C before 2008**, and the ECCC daily archive carries an unflagged -40.0 °C at Nelson NE on 7 February 2014 whose same-day maximum is -4.5 °C. A bare `min()` over either archive produces a number that is not a measurement. `fetch-station-minima.R` detects and flags both; use `min_temp_c_usable`.
