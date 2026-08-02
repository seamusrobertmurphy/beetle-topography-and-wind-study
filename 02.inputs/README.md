# Input data: provenance and retrieval

Bulk data is carried in **Git LFS** as of 1 August 2026. Cloning without `git-lfs` installed
leaves pointer files rather than data. Three things stay out of version control entirely:
`*.tif`, `*.zip` (the survey download is kept locally but the unzipped geodatabase is what is
committed), and `climate/raw/`, which is a regenerable API cache. The manuscript reads terrain
from an external archive and everything else from this folder.

## Where the manuscript looks

```r
DATA_ROOT <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
```

Set `DARKWOODS_DATA` to override without editing the manuscript. Everything else is repo-relative.

## The four sources

### 1. Response: BC Aerial Overview Survey, pest infestation polygons

| | |
|---|---|
| Layer | `pest_infestation_poly` (File Geodatabase) |
| Publisher | Province of British Columbia, Ministry of Forests |
| Portal | https://catalogue.data.gov.bc.ca/dataset/pest-infestation-polygons |
| Direct | https://pub.data.gov.bc.ca/datasets/450b67bb-02d5-4526-8bc0-ac7924125a1e/pest_infestation_poly.zip |
| Licence | Open Government Licence, British Columbia |
| Size | 769 MB zipped, 950 MB unzipped |
| Retrieved | 2026-07-30 |
| Local path | `02.inputs/aos/pest_infestation_poly.gdb` |

Province-wide, all agents, survey years 1965 to 2025. The manuscript filters server-side by
extent, then to `PEST_SPECIES_CODE == "IBM"` (mountain pine beetle) and `CAPTURE_YEAR` in
1999 to 2015. That yields 301 polygons over the Darkwoods extent. Severity is the ordinal
`PEST_SEVERITY_CODE`: `T` trace, `L` light, `M` moderate, `S` severe, `V` very severe.

Read it with `terra::vect(..., layer = "pest_infestation_poly", extent = <SpatExtent in EPSG:3005>)`.
Passing `extent` is essential; reading the whole layer is slow and memory-hostile on this machine.

### 2. Host: BC Vegetation Resources Inventory

| | |
|---|---|
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

Quote the CRS as a string literal inside `BBOX(...)` or the CQL parser rejects it. Lodgepole cover
is accumulated across the three species slots by matching `^PL`.

### 3. Terrain and wind (inherited)

From the companion study's archive, unchanged. Derived from the 1 m NRCan High Resolution DEM,
smoothed, depression-filled (Wang and Liu 2006) and aggregated to 25 m; compound indices after
Beers and Miller 1973 and Parker 1982. Wind is Global Wind Atlas mean speed. The manuscript adds a
topographic position index at a 625 m neighbourhood, computed in-document.

| Layer | File |
|---|---|
| Elevation, and the analysis grid | `terrain_environment/Elevation.utm.tif` |
| Slope | `terrain_environment/Slope.utm.tif` |
| Topographic wetness | `terrain_environment/TWI.utm.tif` |
| Ruggedness | `terrain_environment/Rutm.tif` |
| Mean wind speed | `terrain_environment/Wind.utm.tif` |
| BEC subzones | `bec_zones/BEC.ecozones.shp` |

### 4. Winter minimum air temperature, station observations

| | |
|---|---|
| Networks | BC Wildfire Service hourly, Environment and Climate Change Canada daily |
| Stations | `https://openmaps.gov.bc.ca/geo/pub/WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP/ows` (WFS 2.0.0) |
| Hourly | `https://www.for.gov.bc.ca/ftp/HPR/external/!publish/BCWS_DATA_MART/<year>/<year>_BCWS_WX_OBS.csv` |
| ECCC | `https://api.weather.gc.ca/collections/climate-daily/items` and `.../climate-stations/items` |
| Licence | Open Government Licence, British Columbia; Open Government Licence, Canada |
| Retrieved | 2026-08-01 |
| Script | `02.inputs/climate/fetch-station-minima.R` |
| Local path | `02.inputs/climate/station-winter-minima.csv` (363 station-winters, 58 KB) |
| Full note | `02.inputs/climate/README-station-data.md` |

Answers one question: do winter minima here reach the classical -40 °C lethal threshold for
mountain pine beetle larvae? Across 347 station-winters surviving quality control, no. The
coldest defensible minimum in the region is -28.7 °C, at Norns, 2,423 m, winter 2014, and
across the 26 usable station-winters at or above 1,500 m the mean is -19.4 °C.

The annual BCWS files are 100 to 210 MB, so the script streams each through `curl` into an
`awk` filter and caches only the winter rows for the sixteen stations within 100 km. Those
extracts live in `02.inputs/climate/raw/`, 107 MB, and are gitignored; the summary CSV is committed
because it is what the manuscript cites. Quote `min_temp_c_usable`, never `min_temp_c`.

Rerun with `/usr/local/bin/Rscript 02.inputs/climate/fetch-station-minima.R`. It is
idempotent, reuses the cache, and reprints every number above.

## Ground plots, and what they can and cannot do

`2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx` in the companion archive holds 28 plots with
the basal area of pine killed by beetle, 0.62 to 47.37 m²/ha, or 1.25 to 94.73 per cent of plot
basal area, plus the 2020 Landsat values at each plot. These calibrate the severity scale.

**No coordinates exist for these plots anywhere in the archive.** Every `.xlsx` sheet was checked;
only `dataset_seedlings` and `dataset_burnplots` carry `x`/`y`. The `.RData` workspace is 28 by 7
with no geometry, and `MPBfishnet.shp` is 154 unattributed lines with no CRS. The plots therefore
anchor the severity scale but cannot validate the spatial placement of survey polygons. The
manuscript says so rather than implying a validation that was not performed.

## Traps

1. **The old clipped rasters are superseded.** `beetle_stages/Beetle.Outbreak.*.tif` cover only
   2 by 4 km and write the out-of-survey background as `|128|`, tagged as nodata in only two of
   seven files. Analysing them without excluding that background inflates every elevation contrast.
   The manuscript now uses the provincial survey instead and keeps the clip only as the small-extent
   comparison in the extent table.
2. **`mpb_grey_attackcount.tif` is stale** (932 cells, max 4; correct is 1,541 and 5). Not used.
3. **`dplyr::intersect` masks `terra::intersect`.** Namespace it explicitly.
4. **VRI basal area is missing on 121,353 of 388,003 terrain cells**, which are unmapped or
   non-productive. The manuscript drops them explicitly rather than letting `glm` do it silently,
   which reduces the modelled area from 245 km² to 168 km².
5. **The masterfile holds the lost `.dbf`.** `1.0.darkwoods_masterfile.xlsx`, sheet
   `dataset_beetle_bcgov`, is the attribute table for `MPB_BC_AerialSurveys.shp`, joinable by FID.
   Superseded by the provincial download but useful as a cross-check.
6. **BCWS temperature is censored at exactly -20.0 °C before 2008**, and the ECCC daily archive
   carries an unflagged -40.0 °C at Nelson NE on 7 February 2014 whose same-day maximum is
   -4.5 °C. A bare `min()` over either archive produces a number that is not a measurement.
   `fetch-station-minima.R` detects and flags both; use `min_temp_c_usable`.
