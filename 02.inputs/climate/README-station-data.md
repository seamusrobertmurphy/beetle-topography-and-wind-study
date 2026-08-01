# Observed winter minimum air temperature near Darkwoods

Provenance for `station-winter-minima.csv`. Everything here is produced by
`fetch-station-minima.R` in this folder and by nothing else. Retrieved
2026-08-01.

## What question this answers

One question only. Do winter minima on this landscape reach the classical
lethal threshold for mountain pine beetle larvae, near -40 °C? The manuscript
finds attack halving above 1,900 m and cannot separate wind exposure from cold
limitation. If observed minima never approach -40 °C, the cold half of the
confound narrows from direct freeze mortality to degree-day accumulation.

The answer, from 347 station-winters that survive quality control across two
networks and seventeen winters, is no. The coldest defensible winter minimum
anywhere in the region is **-28.7 °C**, at Norns, 2,423 m, in winter 2014. No
station-winter reaches -40 °C, and none reaches -35 °C.

## Sources

### 1. BC Wildfire Service hourly weather stations

The only regional network with real vertical spread.

| | |
|---|---|
| Station layer | `WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP` |
| Station service | `https://openmaps.gov.bc.ca/geo/pub/WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP/ows` (WFS 2.0.0, GeoJSON, EPSG:4326) |
| Hourly archive | `https://www.for.gov.bc.ca/ftp/HPR/external/!publish/BCWS_DATA_MART/<year>/<year>_BCWS_WX_OBS.csv` |
| Portal | https://catalogue.data.gov.bc.ca/dataset/bc-wildfire-active-weather-stations |
| Licence | Open Government Licence, British Columbia |
| Retrieved | 2026-08-01 |

285 stations province-wide, 16 within 100 km of a study-area centroid of
49.35 N, 117.15 W, spanning 630 to 2,423 m. Thirteen of the sixteen reported
in at least one winter of 1999 to 2015. The three that did not are QD2 Deer
Park and QD7 Bootleg Complex, both installed in 2026, and Bigattini, installed
2001 but with no winter observations in the archive.

The annual observation files are 100 to 210 MB each. The script streams each
one through `curl` into an `awk` filter that keeps only the sixteen station
codes and only December, January and February, so roughly 2.7 GB crosses the
network but only 35 MB reaches disk, cached under `raw/` and gitignored
alongside 69 MB of ECCC response JSON.
Column order of the first five fields, `STATION_CODE`, `STATION_NAME`,
`DATE_TIME`, `HOURLY_PRECIPITATION`, `HOURLY_TEMPERATURE`, is stable across
1997 to 2015; the trailing field count is not, so only those five are read.

### 2. Environment and Climate Change Canada daily climate

Lowland context only, and it cannot answer the alpine question. Prior scoping
found no ECCC station above 1,200 m within 150 km reporting during 1999 to
2015, and this retrieval confirms it: 15 reporting stations spanning 435 to
1,039 m, against a landscape reaching 2,430 m.

| | |
|---|---|
| Endpoint | `https://api.weather.gc.ca/collections/climate-stations/items` and `https://api.weather.gc.ca/collections/climate-daily/items` |
| Query | `bbox=-117.85,48.90,-116.45,49.80`, `datetime=<Y-1>-12-01/<Y>-02-28`, `limit=10000`, `f=json`, one request per winter |
| Licence | Open Government Licence, Canada |
| Retrieved | 2026-08-01 |

Elevation is not carried in `climate-daily`, so it is joined from
`climate-stations` on `CLIMATE_IDENTIFIER`.

## Two data traps, both handled explicitly

### The -20.0 °C sensor floor

A large share of BCWS temperature sensors are clipped at exactly -20.0 °C
before roughly 2008. Across the 325,149 winter hourly observations retrieved
here, 1,193 report exactly that value. A station-winter whose minimum is
exactly -20.0 with observations sitting at that value is a sensor floor, not a
measurement: the true minimum is unknown and is at most -20.0.

Sixteen station-winters over nine stations are so affected, and they are
concentrated where the scoping memo predicted. Fifteen of the sixteen fall
before 2008, and within the pre-2008 half of the window 15 of 89
station-winters are censored, against 1 of 93 after it. Winter 1999 loses 7 of
9 station-winters and winter 2005 loses 5 of 11. Those rows carry
`censored_flag = TRUE` and their `min_temp_c_usable` is blank. The raw value
stays in `min_temp_c` so the censoring can be inspected rather than taken on
trust. 25,185 hourly observations are set aside with them, leaving 166 usable
BCWS station-winters of 182.

A second column, `suspect_flag`, marks a pile-up at -20.0 in a station-winter
whose minimum nonetheless goes lower, meaning a sensor clipped for part of the
winter. No station-winter triggers it.

### The unflagged -40.0 °C in the ECCC archive

The single coldest number in either raw archive is a daily minimum of -40.0 °C
at Nelson NE, 570 m, on 7 February 2014. It is spurious. The same day's
maximum is -4.5 °C, the adjacent days' minima are -13.5 and -10.5 °C, and the
value carries no ECCC quality-control flag, which is exactly why a bare
`min()` would have swallowed it and produced a headline that the landscape
does reach the lethal threshold. It sits 25.5 °C below its own neighbours at a
valley station in a winter when every high-elevation station in the region
bottomed out between -20 and -29 °C.

The script therefore rejects isolated cold spikes in both networks under one
rule, stated once: a reading colder than **both** immediate neighbours by more
than 15 °C, with both neighbours no more than two time steps away so a data
gap is never mistaken for a spike. Every rejection is printed with its context
so the decision is auditable. One daily value is rejected, the Nelson NE
-40.0. Four hourly values are rejected, all of them momentary drops to about
-20 from ambient near -2, which is the same censoring artefact showing up as a
single-hour dropout. Removing the Nelson NE spike moves the coldest ECCC
minimum from -40.0 to -26.5 °C.

### The Darkwoods station covers almost none of the window

The BCWS station actually named DARKWOODS, code 1203, 1,657 m, 14.5 km from
the centroid, **was installed on 14 October 2014**. It contributes exactly one
winter to a seventeen-winter window, Dec 2014 to Feb 2015, with a minimum of
-20.9 °C. It is also at 116.950 W, just east of the study bounding box. Any
statement about in-area temperature during the outbreak rests on stations
outside the study area, not on this one.

## What the file contains

One row per station-winter. A winter labelled Y runs 1 December Y-1 to the end
of February Y, so the 1998 observation file is retrieved to complete winter
1999. 363 rows, 182 BCWS and 181 ECCC.

| Column | Meaning |
|---|---|
| `network` | `BCWS` or `ECCC` |
| `station_id` | BCWS station code, or ECCC climate identifier |
| `station_name`, `latitude`, `longitude`, `elevation_m` | from the station inventory |
| `dist_km_centroid` | kilometres from 49.35 N, 117.15 W |
| `install_date` | BCWS install date, or ECCC first record |
| `winter_year` | the January year of the winter |
| `winter_period` | first and last date actually observed in that winter |
| `n_obs` | observations in the winter, hourly for BCWS, daily for ECCC |
| `obs_interval` | `hourly` or `daily` |
| `min_temp_c` | raw minimum, before any rejection. Do not quote this column |
| `n_spike_rejected` | isolated cold spikes rejected |
| `n_at_minus20` | observations at exactly -20.0 °C |
| `n_just_below_minus20` | observations in [-21.0, -20.0), the comparison that makes a pile-up visible |
| `n_below_minus20` | observations below -20.0 °C |
| `censored_flag` | the minimum is the sensor floor and is unusable |
| `suspect_flag` | pile-up at the floor but colder values present |
| `min_temp_c_usable` | **the column to quote.** Blank when censored, otherwise the minimum after spike rejection |

## Coldest usable winter minimum by station

Printed by the script, reproduced here for reading. Median is across the
station's usable winters.

| Station | Elevation | Usable winters | Coldest | Median |
|---|---|---|---|---|
| NORNS | 2,423 m | 13 | -28.7 | -19.2 |
| DARKWOODS | 1,657 m | 1 | -20.9 | -20.9 |
| DEWAR CREEK | 1,608 m | 12 | -28.0 | -19.5 |
| OCTOPUS CREEK | 1,432 m | 13 | -25.7 | -19.0 |
| NANCY GREENE | 1,397 m | 14 | -25.8 | -19.5 |
| SLOCAN | 1,230 m | 16 | -23.8 | -18.1 |
| GOATFELL | 1,098 m | 15 | -26.9 | -18.4 |
| POWDER CREEK | 1,019 m | 10 | -19.8 | -14.3 |
| SMALLWOOD | 997 m | 16 | -22.6 | -17.2 |
| NICOLL | 866 m | 11 | -24.0 | -19.5 |
| AKOKLI CREEK | 821 m | 13 | -19.4 | -14.2 |
| PENDOREILLE | 725 m | 15 | -22.0 | -16.9 |
| GRAND FORKS | 630 m | 17 | -28.2 | -19.4 |

Across the 26 usable station-winters at or above 1,500 m the coldest minimum
is -28.7 °C and the mean is -19.4 °C. The classical -40 °C threshold is
roughly eleven degrees colder than anything observed, and the operational
-37 °C under-bark figure is about eight.

## What this cannot support

The table is a plausibility check, not a temperature surface, and it does not
disturb the scoping memo's negative result. Four limits matter.

Under-bark phloem temperature is the variable that kills larvae. These are
screen-height air temperatures at fire-weather stations, buffered differently
by bark, canopy and snow at the bole.

No station sits inside the study area during the outbreak. The nearest,
Darkwoods, arrives in October 2014. The vertical spread is real but it is
spread across 100 km of separate massifs.

Elevation is a weak ordering of these minima. Grand Forks at 630 m reaches
-28.2 °C, colder than every station between 800 and 1,400 m and within half a
degree of Norns at 2,423 m. That is cold-air pooling, and it is the reason a
lapse-rate temperature surface would misrepresent this landscape.

The pre-2008 record is the censored half, so the years with the least
trustworthy cold tail are the early outbreak years.

## How to rerun

```
/usr/local/bin/Rscript 02.inputs/climate/fetch-station-minima.R
```

Base R 4.4.1 plus `jsonlite`, with `curl` and `awk` on the path. Idempotent:
cached extracts under `raw/` are reused, so a rerun takes seconds and
regenerates the CSV and the printed summary unchanged. Set `REFRESH <- TRUE`
at the top of the script, or delete `raw/`, to re-download; a cold run takes
about nine minutes. Bounding boxes, radius, year range, the -20.0 censoring
value and the 15 °C spike threshold are all variables in the configuration
block at the top.

To keep the printed summary alongside the data:

```
/usr/local/bin/Rscript 02.inputs/climate/fetch-station-minima.R | tee 02.inputs/climate/retrieval-log.txt
```

`retrieval-log.txt` in this folder is that output from the 2026-08-01 run.
Every number quoted above appears in it. A failed year is reported by name and
the run continues; the script refuses to write an empty or partial CSV.
