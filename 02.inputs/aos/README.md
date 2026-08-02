# BC Aerial Overview Survey: pest infestation polygons

**This is the manuscript's response variable.** Everything the paper models is derived from
this layer.

The Aerial Overview Survey is the operational provincial record of forest health. Observers
sketch-map damage annually from fixed-wing aircraft and label each polygon by year, causal
agent, severity class and host species.

## Source and licence

| | |
|---|---|
| Layer | `pest_infestation_poly` (File Geodatabase) |
| Publisher | Province of British Columbia, Ministry of Forests |
| Portal | https://catalogue.data.gov.bc.ca/dataset/pest-infestation-polygons |
| Direct download | https://pub.data.gov.bc.ca/datasets/450b67bb-02d5-4526-8bc0-ac7924125a1e/pest_infestation_poly.zip |
| Licence | Open Government Licence, British Columbia |
| Coverage | Province-wide, all agents, survey years 1965 to 2025 |
| Size | 769 MB zipped, 950 MB unzipped |
| Retrieved | 2026-07-30 |

## Contents

| File | What it is | In version control |
|---|---|---|
| `pest_infestation_poly.gdb` | The unzipped File Geodatabase the manuscript reads | Yes, via Git LFS |
| `pest_infestation_poly.zip` | The download as retrieved | No, `*.zip` is gitignored |

Cloning without `git-lfs` installed leaves pointer files rather than data. The zip is kept
locally for convenience only; re-download it from the link above if you need it.

## How the manuscript uses it

Filtered server-side by extent, then to `PEST_SPECIES_CODE == "IBM"`, mountain pine beetle,
and `CAPTURE_YEAR` within 1999 to 2015. That yields 301 polygons over the Darkwoods extent,
rasterised to the 25 m analysis grid as the maximum severity class each cell reached.

Severity is the ordinal `PEST_SEVERITY_CODE`: `T` trace, `L` light, `M` moderate, `S` severe,
`V` very severe. The manuscript models this ordinally rather than collapsing it to
attacked or not, because the binary coding hides the study's clearest result.

## Traps

1. **Always pass an `extent` filter when reading.** Reading the whole provincial layer is slow
   and memory-hostile on an 8 GB machine.

   ```r
   terra::vect(path, layer = "pest_infestation_poly", extent = <SpatExtent in EPSG:3005>)
   ```

2. **The geodatabase is in EPSG:3005** (BC Albers). The analysis grid is EPSG:32611 (UTM 11N).
   Build the extent filter in 3005 and project the result, not the other way round.

3. **This is sketch-mapped observer data.** Positional and severity errors are real but they
   are observer errors, which is precisely why the manuscript prefers it to a spectral
   classification whose errors would be correlated with the terrain under test.
