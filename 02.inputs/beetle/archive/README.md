# Archived beetle data, 2026-08-30

Superseded intermediates from the burn-only phase of this study, before it was rebuilt
across Darkwoods. Nothing here is read by the manuscript or by any script that still
produces a number the manuscript reports. Nothing was deleted.

| Folder | Size | Why it is here |
|---|---|---|
| `1. Beetle Plots Feb01/` | 88 MB | No script or manuscript refers to it. Duplicates the folder below under a different name. |
| `1.beetle_plots_feb01/` | 58 MB | No script or manuscript refers to it. |
| `beetle_stages/` | 24 MB | Read only by `02-parent-raster-audit.R`, an audit of the parent study's rasters. |
| `red-stage-ndmi/` | 23 MB | Written by `16-classify-red-stage.R`, the superseded burn-grid classification. Nothing live consumes it. |
| `ndmi-annual/` | 23 MB | Written by `15-ndmi-annual-grid.R` on the narrow burn grid. Superseded by `ndmi-darkwoods/`, built by `17-ndmi-annual-darkwoods.R`. `20-indices-darkwoods.R` names 17 in a comment only, not this folder. |

The scripts that wrote these are left in place so the chain stays documented. Scripts
`00-recompute-parent-metrics.R`, `01-scene-metadata.R`, `02-parent-raster-audit.R` and
`03-training-provenance.R` reach nothing the manuscript reads and are dead, but were left
alongside the rest for the same reason.

## Superseded scripts, added 2026-08-30

Sixteen files moved to `superseded-scripts/`. Each is either an audit of the parent study
or a phase a later numbered script explicitly replaced, in that later script's own header.

| File | Why it is here |
|---|---|
| `00-recompute-parent-metrics.R` | Gate 1(d), an audit of the parent study's NDMI validation metrics. |
| `01-scene-metadata.R` | Gate 1(a) and 1(c), an audit of which sensor supplied each annual scene. |
| `02-parent-raster-audit.R` | Gate 1(b), an audit of the parent study's differencing baseline. |
| `03-training-provenance.R` | Gate 3 blocker check on the parent's 310-row training sample. |
| `04-` to `14-` | The 28-ground-plot phase. `19-derive-balanced-plots.R` states in its own header why the parent's 28 plots cannot train a landscape classifier, and derives the class-balanced set that replaced them. |
| `landsat-scene-inventory.csv` | Written and read only by `01-scene-metadata.R`. |

`2.1.darkwoods_beetle_ground_plots_ndmi.xlsx` stays in place. `18-svm-red-stage-darkwoods.R`
still reads it, and 18 has not been ruled on.

Not moved, and needing a decision. Each looks superseded but the chain was not verified:
`15-ndmi-annual-grid.R` and `16-classify-red-stage.R`, the narrow burn grid that
`17-ndmi-annual-darkwoods.R` replaced, except that 16 writes `red-stage/`, which the live
scripts 39 and 40 read. `18-`, `21-` and `23-`, the classifier development that ended at
`24-modhigh-binary-svm.R`, named in CLAUDE.md as the manuscript's classifier.
`28-refugia-model.R`, replaced by `31-refugia-model-wind.R`. `29-wind-annual-stations.R`,
replaced by `30-wind-hourly-metrics.R`, whose header describes the replacement.
`32-refugia-coefficients.R`, which builds coefficient tables from 31.

## Dead wind covariates, added 2026-08-31

`covariates/wind-annual/`, 38 MB, the annual inverse-distance-weighted station wind surface
written by `29-wind-annual-stations.R`. Nothing reads it. `30-wind-hourly-metrics.R` names
it once, in a comment describing what it replaced.

The final model uses two wind terms and no others. `ep_wind_mean`, the MicroMet
terrain-resolved field accumulated over each sixteen-day epoch, and `wind_effect`, the
windward-leeward terrain exposure index, together with their interactions with stem density
and standing volume.

`covariates/wind-hourly/` stays despite feeding no reported coefficient. MicroMet does not
measure wind, it reshapes station observations over terrain, so those hourly records are the
raw material `41-micromet-wind.R` needs, and `36-wind-direction.R` and
`51-flight-window-climate.R` read them for the prevailing bearing and the climate figure.
`covariates/wind-epoch-sensitivity/` stays because it feeds the four-window table.

## Dead rasters and plot files, added 2026-08-31

Eight folders were reviewed file by file against the preamble, the manuscript master and
all 42 live scripts. Filenames built at runtime were resolved by reading the code that
builds them, not by matching text, because the first pass got that wrong.

`dead-rasters/`, 17 files. Twelve `*_l8raw.tif`, the raw Landsat 8 years before
harmonisation. `22-harmonise-landsat8.R` writes them and nothing reads them, and
`19-derive-balanced-plots.R` lists NDMI with `^ndmi_\d{4}\.tif$`, which excludes them by
construction. Three 2020 index rasters, `nbr_2020.tif`, `ndvi_2020.tif` and `tcw_2020.tif`:
`24-modhigh-binary-svm.R` loops 2006 to 2014 against a 2005 baseline and never reaches
2020. `ndmi_2020.tif` is NOT here, because 19 does read it. Plus
`study-area/darkwoods_perimeter.gpkg` and `study-area/perimeter_forest_mask.tif`, which no
script or manuscript reads.

`dead-plots/`, the 28-ground-plot material, superseded by the class-balanced set. Every
`beetle_plots_*` file, `candidate_universe.gpkg`, both `cube_correlation_search` tables,
`plot-trained-model.rds`, the `search-area/` folder and `red-stage/training-sample.csv`.
`plot-locations/` now holds only `darkwoods_balanced_plots.gpkg` and
`darkwoods_balanced_plots_ndmi.csv`, which `24-modhigh-binary-svm.R` trains on.

Nothing was moved from `geomorphometry/saga`, `model-data`, `lag-covariates` or
`red-stage-darkwoods`. Every file in all four is reached by live code. In particular every
`ndvi_`, `nbr_` and `tcw_` raster for 2005 to 2014 is a live predictor: 24 reads them
through `sprintf("%s_%d.tif", nm, y)`, so their names never appear literally in any script.

## Decline rasters, added 2026-08-31

`red-stage/dec_2006.tif` through `dec_2014.tif`, nine files, about 10 MB. Only
`dec_2005.tif` is used, and only as a grid template: `17-ndmi-annual-darkwoods.R` line 28
reads it to define the analysis grid. Nothing constructs the other years by any pattern.
`dec_2005.tif` stays in `red-stage/`.

A full sweep of `02.inputs/beetle` on 2026-08-31 found nothing else unused. Two families
that looked dead to a text match are live once the code that builds their names is read.
`43-epoch-classification.R` reads all 81 `cube-16day` rasters through
`sprintf("ndmi_%d_e%02d.tif", y, e)`, and `38-assemble-model-data.R` reads all nine annual
MicroMet rasters through `sprintf("micromet_%d.tif", y)`, which still matters after model
M5 was dropped because `mm_flight_mean` remains a column in the modelling table. The
manuscript's base map is another such case: `basemap_relief.tif` and
`basemap_water.geojson` are read by `map_context()` in `01.manuscript/_shared/map-academic.R`,
not by the manuscript or the preamble directly.

## Intermediates, archived 2026-08-31

`intermediates/` holds every file the pipeline builds but the render never opens, 749 files
and about 1.6 GB, moved on Seamus's instruction that intermediary files belong in the
archive. The directory structure is preserved, so restoring any of it is a move back.

What stayed, and why. The render's dependency set was read out of
`01.manuscript/_sections/_preamble.qmd`, the manuscript master and
`01.manuscript/_shared/*.R`, and it is 36 files. Twenty-seven are opened by name. The other
nine are `study-area/vri-timeseries/vri_YYYY.gpkg`, which `data-inventory.R` counts with
`list.files()` to fill the year range and snapshot count in Table 1. Nothing else under
`02.inputs/beetle` is read at render time.

What this costs. The manuscript still renders. The pipeline no longer re-runs from source
without moving folders back: `24-modhigh-binary-svm.R` needs `ndmi-darkwoods/`,
`37-geomorphometry.R` needs `geomorphometry/saga/`, `43-epoch-classification.R` needs
`cube-16day/`, and `53-refit-flight-window.R` needs `covariates/wind-epoch-sensitivity/`.
A Dryad deposit that claims to reproduce every number must therefore draw its derived data
from here, not from the working tree.

`epoch-response/` keeps only `epoch_summary.csv`. Its 60 `modhigh_*_e*.tif` rasters are
here: the `ep` path in `data-inventory.R` is assigned at line 42 and never used again.
