# Archived inputs, 2026-08-30

Nothing in this folder is read by the manuscript or by any script that produces a number
the manuscript reports. It was moved here so `02.inputs/` shows only the data the study
actually used. Nothing was deleted, and nothing here was ever tracked in git.

Each folder was checked by searching every `.R` and `.py` script in
`02.inputs/beetle/` and both live manuscript `.qmd` files for its name.

| Folder | Size | Why it is here |
|---|---|---|
| `aos/` | 1.6 GB | The BC aerial overview survey. The study moved off it entirely. It is not a response variable and supplies no training label, and the manuscript says so in Materials. No script reads it. |
| `legacy-tree/` | 189 MB | No reference in any script or manuscript. |
| `beetle-task/` | 55 MB | No reference in any script or manuscript. |
| `tallo/` | 51 MB | No reference in any script or manuscript. |
| `scripts 15.10.42/` | 21 MB | A dated copy of a scripts folder. No reference anywhere. |
| `larch/` | 6.0 MB | No reference in any script or manuscript. Belongs to a different study. |
| `enfor/` | 5.0 MB | No reference in any script or manuscript. |

What stayed in `02.inputs/`, and why:

- `beetle/` is the pipeline.
- `climate/` is read by seven scripts.
- `literature/` supplies the review screening tables the manuscript reads at render time.
- `vri/` holds `vri_darkwoods.geojson`, written by `34-fetch-vri.py`, which the Data
  availability statement names.
