# Input data: provenance and retrieval

No bulk data is committed. `.gitignore` excludes `*.tif`, `*.zip` and `02.inputs/aos/`. The
manuscript reads terrain from an external archive and the two provincial datasets from this folder.

## Where the manuscript looks

```r
DATA_ROOT <- Sys.getenv("DARKWOODS_DATA",
  "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData")
```

Set `DARKWOODS_DATA` to override without editing the manuscript. Everything else is repo-relative.

## The three sources

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
