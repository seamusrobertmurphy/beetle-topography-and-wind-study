# Testing the wind disruption hypothesis for beetle refugia

*Stand density, terrain and wind as competing controls on mountain pine beetle attack
(Dendroctonus ponderosae) in the Selkirk Mountains of British Columbia*

Krawchuk et al. (2020) proposed three mechanisms by which refugia from mountain pine beetle
could form. Cool ground that spares trees water stress, thin stands where wind disrupts the
aggregation pheromone, and a scarcity of large-diameter hosts. None had been fitted
spatially. This study fits all three across 5,573 ha of the Selkirk Mountains at 30 m,
using Landsat at its own sixteen-day repeat and a terrain-resolved wind field.

## Reproducing it

Open the manuscript and run every chunk. There is no code anywhere outside it. The document
pulls Landsat through Google Earth Engine, builds the terrain and wind surfaces, trains the
classifier, assembles the modelling tables, fits every model and writes its own tables and
figures. A full run needs Earth Engine credentials and SAGA GIS, and takes hours.

The analysis is 32 chunks in `01.manuscript/_sections/_pipeline.qmd`, which build the
variables, and 16 model fits in `01.manuscript/_sections/_preamble.qmd`, which produce every
number the article reports. Chunks carry `echo: false` so the code does not print in a
submission, but it runs.

## What is here

| Path | What it holds |
|---|---|
| `01.manuscript/Manuscript-Long.qmd` | The Frontiers in Ecology and the Environment draft, 2,222 words against its 2,500 limit |
| `01.manuscript/beetle-topography-wind-study-vri-timeseries.qmd` | The Journal of Applied Entomology submission, abstract 293 words against 300 |
| `01.manuscript/_sections/` | The pipeline and the preamble, included by both drafts |
| `01.manuscript/_shared/` | Helpers for the maps, the data inventory table and the fit metrics |
| `01.manuscript/_tools/` | The three pre-render and post-render hooks `_quarto.yml` invokes |
| `01.manuscript/submission-jae/` | Title page, cover letter, tables file and the assembled package |
| `02.inputs/beetle/` | 2.1 GB of imagery, terrain, stand structure and wind, all rebuilt by the pipeline |
| `02.inputs/literature/` | The screening tables the review reports, read at render time |
| `02.inputs/vri/` | The provincial forest inventory extract |
| `03.outputs/TBL/` | Eight tables, written by the render |
| `03.outputs/PNG/` | Three figures, written by the render |
| `05.tasks/` | Working files and correspondence. Nothing here is read or written by the study |
| `archive/` | Superseded drafts, discarded analyses and the data behind them |

Tables and figures are written by the render itself, so the outputs folder always matches
the current article. Nothing in it is edited by hand.

## Data

Every dataset is public and none was collected by the author. Beetle disturbance is
classified from Landsat Collection 2 Level-2 surface reflectance. Stand structure is the
provincial Vegetation Resources Inventory. Terrain is the Natural Resources Canada High
Resolution Digital Elevation Model. Wind is Environment and Climate Change Canada hourly
station data, modified over the terrain with the MicroMet model of Liston and Elder (2006).

## Status

The Journal of Applied Entomology draft is written and renders. One thing blocks submission.
The Dryad deposit has not been made, so the data availability statement still carries a
placeholder DOI, and the journal does not accept data on request or as supplementary files.
