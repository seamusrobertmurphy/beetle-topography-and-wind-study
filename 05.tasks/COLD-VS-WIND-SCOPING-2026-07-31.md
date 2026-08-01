# Scoping memo: can cold limitation be separated from wind exposure at Darkwoods?

**Date:** 31 July 2026
**Scopes:** item 1 of `TASK-REQUEST-2026-07-31.md` §4, the highest-value open item
**Status:** research and feasibility only. No manuscript text was changed and no analysis was run.
**Answer in one line:** no independent temperature surface exists for this landscape, the reason is
structural rather than a gap in the catalogue, and the honest response is a reframed Limitations
paragraph plus one cheap aspect-based test.

---

## 1. The identifiability problem

The manuscript reports that beetle attack halves above 1,900 m while lodgepole cover holds and
stands thin, and that the component of the Global Wind Atlas surface orthogonal to elevation is the
largest negative coefficient in the host-present model. Orthogonalising wind against elevation
removes the linear elevation component of the wind surface, but it does not remove temperature,
which strengthens with elevation on the same gradient and limits this beetle through overwinter
mortality and through the degree-day accumulation required for univoltine development. To break the
tie the model needs a temperature predictor carrying spatial information that elevation does not
already carry. The trap is that any temperature surface of the form `T(x) = a + b·DEM(x)` is, as a
raster, an affine rescaling of the elevation layer: its correlation with elevation is exactly one,
it is rank-deficient with the elevation term already in the design matrix, and it contributes
literally zero degrees of freedom. This holds whether `b` came from a physical constant, from a
mesoscale model, or from a regression on real thermometers. **The fitted-ness of the lapse rate is
irrelevant to identification.** Only the part of temperature that elevation does not explain can
identify anything, and mapping that part onto a 25 m grid over 168 km² requires either dense
in-area observations, which do not exist here, or a terrain model of cold-air pooling, which puts
the DEM straight back in. That is the whole problem, and it is why the answer below is negative.

## 2. What the station networks actually contain over the South Selkirks

This section is the memo's original contribution. Every figure below was computed from files
retrieved during this scoping exercise, listed in §7. **None of it has been checked into the
pipeline, so per the repo rule none of it may be quoted in the manuscript until it is.**

### Environment and Climate Change Canada

Queried the ECCC OGC station collection
(`https://api.weather.gc.ca/collections/climate-stations/items`) over a box from 48.45 to 50.25 N
and 118.6 to 115.7 W, which returns 97 stations. Distances are to a study-area centroid of
49.35 N, 117.15 W.

| Radius | Stations, all periods | With daily data overlapping 1999 to 2015 | Elevation span of those stations |
|---|---|---|---|
| 50 km | 44 | 13 | 435 to 1,039 m |
| 100 km | 73 | 22 | 435 to 1,039 m |
| 150 km | 97 | 31 | 435 to 1,100 m |

**Within 150 km there is not one ECCC station above 1,200 m with daily observations during the
outbreak window.** Only three stations in the entire box ever exceeded 1,200 m, and all three died
before the window opened: Old Glory Mountain at 2,347 m ended December 1967, Kootenay Pass at
1,774 m ended December 1989, Grand Forks Phoenix at 1,414 m ended April 1977. Inside the study
bounding box itself, every ECCC station that has ever operated sits between 457 and 760 m, against a
study area spanning 654 to 2,430 m. The network samples the valley floor and nothing else.

The Adjusted and Homogenized Canadian Climate Data are worse, not better, for this purpose. AHCCD is
a quality-controlled subset of the same archive, homogenised for instrument changes and relocations
(https://open.canada.ca/data/en/dataset/9c4ebc00-3ea4-4fe0-8bf2-66cfe1cddd1d), and the OGC endpoint
`https://api.weather.gc.ca/collections/ahccd-stations/items` returns 23 stations over the same box.
All lie between 457 and 940 m except Old Glory Mountain at 2,347 m, which stopped in 1967.
Homogenisation improves the trend fidelity of valley records; it creates no high-elevation ones.

**Verdict: ECCC and AHCCD cannot support an observed lapse rate over the elevation band that matters.
The vertical spread available during the outbreak window is roughly 600 m, all of it below the
1,900 m threshold where the manuscript's signal lives. Extrapolating a lapse fitted from 435 to
1,039 m up to 2,430 m is extrapolation of about 1.4 times the fitted range, straight through the
inversion layer the interpolation literature says is the part that misbehaves.**

### BC Automated Snow Pillow network

The BC Automated Snow Weather Station layer
(`WHSE_WATER_MANAGEMENT.SSL_SNOW_ASWS_STNS_SP` via the BC openmaps WFS) holds 152 stations
province-wide, and the archive carries hourly air temperature alongside snow water equivalent, snow
depth and precipitation (https://open.canada.ca/data/en/dataset/5e7acd31-b242-4f09-8a64-000af872d68f).
Three stations lie within 50 km, and they sit at exactly the elevations the paper cares about:
Redfish Creek at 2,100 m and 38 km, Gray Creek Lower at 1,650 m and 45 km, Gray Creek Upper at
1,930 m and 46 km. Within 100 km there are eight, spanning 519 to 2,100 m.

This is the best vertical spread of any network examined, and it is still only three points near the
study area, none of them inside it. The archive is also awkwardly partitioned: hourly archived data
run only from 1 October 2011 to 8 January 2016, with daily data before that
(https://open.canada.ca/data/en/dataset/5e7acd31-b242-4f09-8a64-000af872d68f), so a consistent
hourly series across 1999 to 2015 does not exist. Hourly air temperature is at
`http://www.env.gov.bc.ca/wsd/data_searches/snow/asws/data/TA_Archive.csv`.

**Verdict: genuinely high elevation and genuinely observational, but three stations cannot map a
residual temperature field across 168 km² of dissected terrain. Useful for a plausibility check,
not for a predictor.**

### BC Wildfire Service weather stations

This network has the vertical spread. The BCWS station layer
(`WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP`) holds 285 stations, of which five lie
within 50 km and sixteen within 100 km, spanning 630 to 2,423 m. There is even a station named
DARKWOODS at 1,657 m, 14.5 km from the centroid at 49.3576 N, 116.9503 W. The full hourly archive is
public and runs from 1987, at
`https://www.for.gov.bc.ca/ftp/HPR/external/!publish/BCWS_DATA_MART/<year>/<year>_BCWS_WX_OBS.csv`,
with an accompanying station file carrying elevation, slope and aspect. The observation files carry
`HOURLY_TEMPERATURE` and, contrary to what one might assume of a fire-weather network, they are not
restricted to fire season: the 2005 file begins at hour 2005010100 and the Kootenay stations report
roughly 2,150 hours per December to February.

Three findings then close it off.

**First, the DARKWOODS station was installed on 14 October 2014**, covering the last three months of
a seventeen-year window. It is also at longitude 116.9503 W, just east of the study bounding box.

**Second, and decisively for the pre-2008 record, a large share of BCWS temperature sensors are
censored at exactly minus 20.0 °C.** In the 2005 province-wide file there are 9,786 hourly
observations reporting exactly −20.0, against 2,947 in the whole interval between −20.0 and −19.0
and only 9,222 observations below −20.0 in the entire province for the entire year. Fifty-four of
201 reporting stations have an annual minimum of exactly −20.0. Of the stations near Darkwoods,
Norns, Nancy Greene, Pendoreille, Dewar Creek and Slocan all bottom out at precisely that value in
2005; in 2004 the Norns record is worse still, with all 394 winter hours pinned at −20.0. The
censoring has gone by 2013, where no station in the province has an annual minimum of exactly −20.0.
The archive is therefore heterogeneous in quality across the outbreak window, and it is censored
precisely in the temperature range that governs beetle overwinter mortality.

**Third, and most important, even the uncensored years show that elevation explains only part of
winter temperature, and the part it does not explain cannot be mapped.** Fitting mean and minimum
December to February temperature against station elevation for the eleven Kootenay stations with
usable 2013 records gives:

| Response | Fitted lapse | R² on elevation | Residual SD | Largest residual |
|---|---|---|---|---|
| DJF mean temperature | −2.96 °C per 1,000 m | 0.78 | 0.76 °C | 1.67 °C |
| DJF minimum temperature | −5.35 °C per 1,000 m | 0.58 | 2.23 °C | 4.29 °C |

Winter minimum temperature, the quantity that governs cold mortality, is only 58 per cent explained
by elevation. Akokli Creek at 821 m records −16.4 °C while Goatfell at 1,098 m records −25.3 °C, and
Norns at 2,423 m is barely colder than Dewar Creek 815 m below it. That 42 per cent of unexplained
variance is exactly the signal that could identify cold separately from wind, and it is exactly the
signal that eleven stations spread over 150 km cannot be interpolated onto a 25 m grid. Any attempt
to map it would use terrain position, sky view or valley depth, all DEM transforms.

**Verdict: the only network with adequate vertical spread is censored in the cold tail for the first
half of the outbreak window, has no station inside the study area until October 2014, and its
residual structure, which is the only useful part, is unmappable at this station density.**

### Reanalysis products

The reanalyses fail for a simpler reason than the downscaled climatologies: they are all coarser than
the study area, and their near-surface temperature carries no sub-grid terrain information at all.

**MERRA-2** is distributed on a 576 by 361 grid at 0.625° longitude by 0.5° latitude, about 45 by
55 km here, interpolated from a cubed-sphere model run at roughly 50 km
(https://gmao.gsfc.nasa.gov/pubs/docs/Bosilovich785.pdf). Its orography derives from GTOPO30 but is
averaged "retaining scales >= 100 km"
(https://github.com/GEOS-ESM/GMAO_Shared/blob/main/GEOS_Shared/GEOS_TopoGet.F90), and 2 m
temperature is a Monin-Obukhov blend of ground and lowest-level potential temperature with no
elevation term. Applying the published grid formula, **no MERRA-2 longitude node falls inside 117.0
to 117.3 W at all.**

**ERA5** runs at 31 km on an N320 reduced Gaussian grid, published at 0.25°
(https://confluence.ecmwf.int/display/CKB/ERA5%3A+data+documentation). Its SRTM30-based orography is
filtered with a 30 km filter scale and a spectral taper
(https://www.ecmwf.int/sites/default/files/elibrary/2016/16648-part-iv-physical-processes.pdf), and
2 m temperature is a Monin-Obukhov interpolation between skin and lowest model level, again with no
elevation term.

**ERA5-Land** is the case worth stating precisely, because it is commonly assumed to be
terrain-resolving and it is not, in either direction. It runs at 9 km, forced by ERA5 at 31 km, and
the correction reads: "air temperature, humidity, and pressure are corrected for the altitude
differences **between ERA5 and ERA5-Land grids** ... air temperature is adjusted for the altitude
differences using a daily environmental lapse rate (ELR) field derived from ERA5 lower troposphere
temperature vertical profiles" (https://essd.copernicus.org/articles/13/4349/2021/). The target is
ERA5-Land's own 9 km model orography, not an external fine DEM; no DEM is named in the paper or in
the CDS documentation. So ERA5-Land is disqualified twice over: what terrain structure it has is a
lapse-rate transform, and that structure is 9 km, which over a 16 by 17.5 km study area is about
three cells. The gain is real but bounded, at 10 per cent lower MAE for daily maximum temperature
against 2,941 western US stations (same source).

**NARR** ran at 32.46 km, and screen temperature is a postprocessed diagnostic that was deliberately
not assimilated because doing so degraded rawinsonde fits
(https://journals.ametsoc.org/downloadpdf/journals/bams/87/3/bams-87-3-343.pdf).

**Canada does publish a regional reanalysis covering BC, and it does not help.** RDRS / CaSR runs at
0.09°, about 10 km (https://hess.copernicus.org/articles/25/4917/2021/hess-25-4917-2021.pdf), with
v3.1 covering 1980 to 2024 forced by ERA5
(https://hpfx.collab.science.gc.ca/~scar700/rcas-casr/dataset_specifics.html). Station temperature
does reach the system through the CaLDAS optimal interpolation, but elevation enters that only as a
vertical correlation weight, `b(Δz) = exp[-(Δz/h)²]` with h of 800 m, controlling how much a station
influences a grid point; the analysed value remains valid at the model's mean orography and no lapse
rate moves it to a finer surface
(https://collaboration.cmc.ec.gc.ca/cmc/cmoi/product_guide/docs/tech_notes/technote_hrdps-700_caldas-400_20240611_e.pdf,
https://journals.ametsoc.org/downloadpdf/journals/apme/38/6/1520-0450_1999_038_0726_agaosd_2.0.co_2.pdf).

**HRDPS is the only operational Canadian product with genuine 2.5 km terrain, and it has no history.**
It runs at 0.0225° with orography from GMTED2010 at 7.5 arc seconds, RC5-filtered onto the 2.5 km
grid; the version note even singles out the elimination of a spurious "ghost mountain in British
Columbia" present in the older USGS database
(https://collaboration.cmc.ec.gc.ca/cmc/cmoi/product_guide/docs/tech_notes/technote_hrdps-700_20240611_e.pdf).
But the datamart retains only 30 days (https://eccc-msc.github.io/open-data/msc-datamart/readme_en/)
and the only multi-year holding is CaSPAr's rolling archive from May 2017. **A 2.5 km temperature
history over the Kootenays for 1999 to 2015 does not exist as a ready product.** Note also that
ECCC's own scorecards flag 2 m temperature as degraded in spring and summer in version 7.0.0, with a
Mountain West panel called out.

### Land surface temperature

Assessed separately; see the table in §3 and the discussion in §4.

## 2.6 Cold-air pooling, and why the elevation relation is misspecified rather than merely noisy

The manuscript's Discussion already asserts that temperature "is not a linear function of elevation
in a landscape with cold-air pooling." That assertion is well supported, and the supporting
literature is stronger than the manuscript currently uses.

Daly and colleagues state the physics plainly: cold air drains into valleys and depressions to form
pools hundreds of metres thick, producing inversions in which "temperature sharply increases, rather
than decreases, with elevation," with wintertime increases of 2.5 to 3.0 °C per 100 m "not uncommon"
(https://prism.oregonstate.edu/pubs/link/2008_daly-etal_ijoc.pdf). That is a positive gradient
roughly four times the magnitude of the standard environmental lapse rate, with the sign reversed.
The same paper gives the profile shape that matters here: cold in the valley bottom, a strong
increase to an inversion top near mid-slope, then a decrease above, "resulting in temperatures at the
highest elevations approaching those in the valley bottoms." Winter minimum temperature is therefore
non-monotone and roughly unimodal in elevation, which is a misspecification of the linear elevation
term rather than noise around it. PRISM handles this with an explicit two-layer atmosphere and a
topographic index for pooling susceptibility, with the inversion top set from rawinsonde profiles at
roughly 200 to 300 m above ground level (same source), which is precisely the terrain-based
downscaling the task request rules out.

Strachan and Daly supply the limits statement: PRISM systematically overpredicts nighttime cooling on
steep slopes because "most of PRISM's source stations are located in flat terrain or valley bottoms,
which are conducive to local cold air pooling," while sloping sites "are likely to be more closely
coupled to the free atmosphere," and they conclude that success "is largely dependent on the
availability of stations in a variety of topographic positions. Cold-air pooling, in general, remains
a challenge for temperature modeling in mountain environments"
(https://prism.oregonstate.edu/pubs/link/2017_strachan-daly_j-geophys-res-atmos.pdf). This is the
same station-geography problem documented in §2, arriving from the other direction.

For British Columbia specifically, Stahl, Moore, Floyer, Asplin and McKendry compared twelve
interpolation methods for daily temperature across the province and found monthly gradients ranging
from 0.9 to 6 °C per 1,000 m for minimum temperature, smallest from December to February, with the
January maximum-temperature gradient at one station pair actually positive, indicating frequent
inversions or cold-air ponding
(https://blogs.ubc.ca/ianmckendry/files/2015/01/Comparison-of-approaches-for-spatial-interpolation-of-daily-air-temperature-in-a-large-region-with-complex-topography-and-highly-variable-station-density.pdf).
Their conclusion is directly applicable: methods that compute local lapse rates "should therefore not
be applied in the absence of sufficient high-elevation data," since "an appropriate observation
network that includes high-elevation stations is indispensable." Darkwoods does not have one. The
Cariboo Alpine Mesonet reports the same seasonal signature within BC, with lapse rates of 6.6 °C per
km in summer falling to 2.7 °C per km in winter
(https://essd.copernicus.org/articles/10/1655/2018/), consistent with the 2.96 °C per km fitted from
BCWS stations in §2.

Two further points bear on the design. Rupp and colleagues at the HJ Andrews forest found gradients
spanning −10 to over 60 °C per km, nighttime inversion frequency above 45 per cent at cross-valley
scale, persistent inversions exceeding fifteen days in December and January, and, critically, that
cold pools form "much more often in valleys ~1 to 2 km wide than previously estimated from basin-wide
(~10-km scale) measurements"
(https://andrewsforest.oregonstate.edu/pubs/pdf/pub5160.pdf). The scale at which pooling operates is
finer than any gridded product available here. And a temperate-forest study in Vermont and New
Hampshire found cold-air pooling at 19 to 43 per cent seasonal occurrence and, decisively for the
ecological stakes, "inverted forest composition patterns across slopes with more cold-adapted
species, namely conifers, at low instead of high elevations"
(https://pmc.ncbi.nlm.nih.gov/articles/PMC10985370/). Cold-driven biotic zonation can run backwards
relative to elevation.

Two honest gaps. First, no peer-reviewed study quantifies inversion frequency, cold-pool depth or
thermal-belt elevation specifically for the South Selkirks, the West Kootenay or the Creston valley;
the evidence above is by analogy from the Cascades, the Cariboo and New England. Second, and more
awkward for the identification argument, this literature establishes that cold limitation is
non-monotone in elevation, which is the first half of a case that cold and wind might be separable,
but it does not establish that wind exposure is monotone in elevation, and it supplies no local
cold-pool geometry. On the retrieved evidence the non-monotonicity is real; the claim that it is
strong enough at Darkwoods to break the confound is not supported and should not be made. Note also
one operational report that cuts directly at the manuscript's assumption: Alberta Agriculture
records that in 2009 "−40 °C temperatures were recorded at weather stations in several valley bottoms
of west-central Alberta but the temperature at higher elevations on the hillside, where the
beetle-attacked trees were, was significantly warmer"
(https://www1.agric.gov.ab.ca/$department/deptdocs.nsf/all/formain15814/$file/MPBColdTemperaturesFacts-Jan2010.pdf).
This is agency grey literature from a different region, but it is on point: the coldest measured
minima sat below the beetles, not above them.

## 3. Product-by-product assessment

Every row below was verified against a page or data file retrieved during this scoping; sources are
in §8 and §9. Four unretrievable papers are flagged at the end of §9.

| Product | Native resolution | Is fine-scale temperature structure terrain-derived? | Coverage over South Selkirks | Verdict |
|---|---|---|---|---|
| ECCC daily/hourly station archive | Point | No, genuine observation | 13 stations within 50 km active 1999 to 2015, all 435 to 1,039 m; zero above 1,200 m within 150 km | **Reject.** No vertical spread in the window. |
| ECCC AHCCD | Point | No | 23 stations in region, all 457 to 940 m except one dead since 1967 | **Reject.** Fewer stations than the raw archive, same valley bias. |
| BC Automated Snow Pillow (ASWS) | Point | No | 3 within 50 km at 1,650, 1,930 and 2,100 m; hourly archive only 2011-10 to 2016-01 | **Reject as predictor, retain as plausibility check.** Right elevations, far too few, wrong period. |
| BC Wildfire Service stations | Point | No | 5 within 50 km, 16 within 100 km, 630 to 2,423 m; hourly from 1987 | **Reject as predictor.** Best spread available, but censored at −20.0 °C pre-2008, none in-area before Oct 2014, residual field unmappable. |
| ERA5 | 31 km, published 0.25° | No sub-grid terrain at all; orography 30 km filtered | Roughly one to two cells | **Reject.** Coarser than the study area. |
| ERA5-Land | 9 km | Lapse correction targets ERA5-Land's **own 9 km orography**, not a fine DEM | About three cells | **Reject.** Disqualified twice: what terrain structure exists is a lapse transform, and it is 9 km. |
| MERRA-2 | 0.625° x 0.5°, ~45 by 55 km | No; orography averaged retaining scales >= 100 km | **No longitude node falls inside the study box** | **Reject.** |
| NARR | 32.46 km | No; 2 m temperature a postprocessed diagnostic, not assimilated | One to two cells | **Reject.** |
| RDRS / CaSR, ECCC regional | 0.09°, ~10 km | No; CaLDAS uses elevation only as an OI correlation weight, valid at model mean orography | Two to three cells | **Reject.** |
| HRDPS, ECCC operational | 0.0225°, 2.5 km | Yes, to 2.5 km, from GMTED2010 at 7.5 arc sec | Full coverage, **but archive starts May 2017** | **Reject.** No temperature history exists for 1999 to 2015. |
| Daymet V4 | 1 km | **Yes.** Daily refitted regression with a vertical coefficient, applied to SRTM 30 arc sec | Full coverage, 1980 to present | **Reject.** The vertical coefficient is a fitted daily lapse rate on a DEM: exactly the §1 construction. |
| TerraClimate | 1/24°, ~4 km | Inherited only; anomalies are bilinear from 0.5°, so **no sub-10 km information of its own** | Full coverage | **Reject.** The 4 km appearance is WorldClim's DEM at second hand. |
| CHELSA V2.1 | 30 arc sec, ~1 km | **Yes**, the purest case: sea-level interpolation then reprojection onto GMTED2010 | Full coverage | **Reject.** CHELSA itself warns it "can be less accurate in conditions like nighttime cold-air pooling." |
| WorldClim 2.1 | 30 arc sec, ~1 km | **Yes**, SRTM elevation as a spline covariate | Full coverage, **but a 1970 to 2000 climatology, not a time series** | **Reject.** |
| PRISM, ClimateBC | 800 m | **Yes**, with an explicit two-layer inversion model and a terrain pooling index | Full coverage | **Already ruled out in the task request, correctly.** |
| CRU TS | 0.5° | No; "elevation is not specifically included in the interpolation" | One cell | **Reject.** |
| GHCN gridded / NOAAGlobalTemp | 5° | No | One cell | **Reject.** |
| Berkeley Earth | 0.25° high resolution | Elevation is a kriging regressor, but not at sub-10 km, and the DEM is unnamed publicly | Roughly one cell | **Reject.** |
| MODIS LST (MOD11A1/MYD11A1) | 1 km (0.928 km) | Not by construction, **but** its pattern over slopes is driven by illumination, aspect, snow, canopy and view angle, all terrain-dependent; the ATBD itself says a fine DEM is needed to make it meaningful | Full coverage, heavily cloud-limited in winter; **archive closing, Terra ended Dec 2025, Aqua Aug 2026** | **Reject.** Grain equals the bootstrap block, and the cloud screen relaxes at 2,000 m, inside the zone of interest. |
| Landsat Collection 2 Level-2 Surface Temperature | 120 m (TM), 60 m (ETM+), 100 m (TIRS); all distributed at 30 m | Same terrain confounds as MODIS; algorithm also ingests reanalysis profiles and ASTER GED | 16-day revisit, very few usable winter scenes; **no nighttime product exists** | **Reject.** Mid-morning skin temperature only, the worst sampling for cold mortality. |
| Thermally sharpened LST (TsHARP, DisTrad) | 30 to 250 m | **Yes** in mountains. Flat-terrain versions sharpen on vegetation index alone, but every published mountain application adds the DEM | n/a | **Reject.** Reintroduces the exact confound. |
| ECOSTRESS L2T LSTE | ~70 m gridded | Same terrain confounds as MODIS | 49.3 °N is inside coverage, but **launched June 2018**, after the outbreak window | **Reject.** Wrong period. |

## 4. Why land surface temperature does not rescue the design

Land surface temperature is the most interesting candidate because it is genuinely a radiometric
measurement rather than a model field draped over terrain, so its fine-scale pattern is observed
rather than imposed. Four objections defeat it here, and they compound.

It is the wrong variable. LST over closed conifer canopy is canopy skin temperature, not the
under-bark phloem temperature that kills beetles and not the screen-height air temperature that
accumulates degree-days. The manuscript's mechanism runs through phloem temperature, which is
buffered by bark, by snow depth at the bole, and by canopy decoupling.

It is the wrong grain. MOD11A1 v061 delivers daytime and nighttime LST at 1 km on a daily step
(https://www.earthdata.nasa.gov/data/catalog/lpcloud-mod11a1-061), which is the same grain as the
40 by 40 cell blocks the manuscript already uses to define independent units for the spatial
bootstrap. A 1 km predictor therefore adds almost no variation within a block, and cannot increase
the number of independent observations, which the manuscript identifies as the binding constraint on
the wind coefficient. (That last step is reasoning, not citation.) Landsat thermal is genuinely
finer, but its true sensor resolution is 100 m and the 30 m distribution is cubic-convolution
resampling onto the optical grid, not information
(https://www.usgs.gov/landsat-missions/landsat-collection-2-level-2-science-products). Note also
that the Collection 2 Level-2 Surface Temperature algorithm ingests atmospheric profiles from
reanalysis, so the product is not purely observational either.

It is cloud-censored in a way that is correlated with the mechanism, and the bias is measured, not
merely suspected. Usable LST retrievals are clear-sky retrievals, and clear calm winter nights are
precisely the nights that produce the strongest inversions and the deepest cold pools. Westermann et
al. 2012 state the mechanism outright, that cold surface temperatures occur under clear skies and
warm ones under overcast, so "this leads to an overrepresentation of cold temperature in averages
computed from remotely sensed LST measurements," and measure winter-mean biases of −1.4 to −6.1 K
(https://epic.awi.de/id/eprint/25719/1/Westermann%2B11d.pdf). Ermida et al. 2019, using
cloud-transparent passive microwave LST as reference, measure a global nighttime clear-sky bias of
about −2 K attributed to "the increased radiative cooling for clear-sky situations"
(https://hal.science/hal-03786341/document). Kindstedt et al. 2022 in the St. Elias Mountains find
median LST minus air temperature of −8.4 and −8.9 °C in winter against −1.0 and −1.1 °C in summer
(https://tc.copernicus.org/articles/16/3051/2022/). The duty cycle is poor: Parajka and Blöschl
found clouds obscured 63.1 per cent of Austria on average, and that "in November, December and
January clouds, typically, obscure most of Austria on more than 25 days in a month"
(https://hess.copernicus.org/articles/10/679/2006/).

That same paper adds a second limb that cuts the other way and makes things worse rather than
better. "In summer (May to July), typically, cloud cover increases with elevation while in winter
cloud cover tends to decrease with elevation due to winter inversions." In an alpine winter the
missing pixels concentrate in the valleys, under the stratus that forms in the cold pool. The
surviving sample is therefore biased toward inverted nights **and** toward the ridges and slopes
standing above the valley cloud. Both limbs corrupt exactly the inference one would want to make
about topographic cold sinks. Compounding it, the MODIS cloud mask is known to fail over
snow-covered mountains, with Stillinger et al. 2019 measuring MOD09GA cloud-mask precision of 0.166
against manually delineated Landsat scenes in the western US and Himalaya
(https://pmc.ncbi.nlm.nih.gov/articles/PMC6988483/).

**And there is a documented artefact that falls inside the elevation band the manuscript is about.**
The MOD11 Collection 6 user guide states that MOD11A1 admits a pixel at "a confidence >=95% over land
<= 2000m or >= 66% over land > 2000m"
(https://lpdaac.usgs.gov/documents/118/MOD11_User_Guide_V6.pdf). The cloud screen is deliberately
relaxed above 2,000 m. The study area spans 650 to 2,430 m, so that threshold discontinuity sits
inside the analysis domain, roughly 100 m above the 1,900 m elevation at which attack halves. The
extra high-elevation retrievals are admitted under a weaker cloud test, so they are
disproportionately cloud-contaminated and therefore cold-biased, precisely where the signal lives. A
predictor whose missingness and whose bias both change discontinuously at an elevation inside the
zone of interest is worse than no predictor.

Most damagingly, its spatial structure is terrain-dependent anyway, and the retrieval algorithm's own
design document concedes it. The MODIS LST ATBD states that "only the first order of topographic
information, i.e., the elevation of the surface, is considered ... In rugged areas where high
resolution DEM is not available, it is difficult to accurately estimate land surface temperature in
one pixel," and that a "high-resolution DEM is an important input to make pixel-specific topographic
correction for localized radiometric effects (slope/aspect related illumination differences,
shadowing, and reflection of radiation from adjacent pixels)"
(https://modis.gsfc.nasa.gov/data/atbd/atbd_mod11.pdf). **The algorithm's authors say you need a
fine DEM to make LST meaningful in this terrain.** Adopting LST to escape the DEM therefore inverts
the dependency rather than removing it. The mechanisms are quantified elsewhere: Ehrler et al. 2024
show Swiss Alps Landsat LST has east-facing slopes consistently warmer than west-facing purely from
overpass geometry, with LST precision against the IMIS network of 4.68 K
(https://tc.copernicus.org/articles/18/5259/2024/); Minnis and Khaiyer 2000, viewing one scene from
up to three geostationary satellites, measured daytime skin temperatures differing by up to 6 K from
viewing geometry alone (https://www-pm.larc.nasa.gov/data/sgp/reference/khaiyer.paper.pdf).

Daytime LST in mountains is therefore close to a radiation-load map. Nighttime LST avoids the
illumination problem and is the least bad option, with Lo Vecchio et al. 2026 finding nighttime
products substantially more temporally coherent against 78 high-elevation Swiss radiometers
(https://www.nature.com/articles/s41598-026-63971-5), but it is the most cloud-limited and it
measures canopy skin temperature under exactly the conditions where canopy decouples from air.
Rautiainen et al. 2024 put a number on that decoupling: regressing near-surface on free-air
temperature, "under heavy snow the slope approaches 0.0"
(https://tc.copernicus.org/articles/18/403/2024/). Escaping a DEM transform by adopting a surface
whose pattern is driven by slope, aspect and snow is not an escape.

Two further practical points close the file on the satellite route. **Landsat Collection 2 produces
no nighttime Surface Temperature at all.** Both product guides state that scenes "must contain both
sunlit optical and thermal data" because NDVI and NDSI are required to temporally adjust the ASTER
GED emissivity, "therefore, nighttime acquisitions cannot be processed to Surface Temperature"
(https://www.usgs.gov/landsat-missions/landsat-collection-2-level-2-science-products). Landsat ST is
a mid-morning skin temperature only, which is the worst possible sampling for overwinter cold
mortality and the time of day at which LST most closely approximates a pure radiation-load map. And
the MODIS archive is now closing: Terra was to generate the full product suite only to the end of
mission in December 2025 and Aqua to August 2026, with both orbits drifting substantially beforehand
(https://nsidc.org/data/user-resources/data-announcements/ongoing-changes-terra-and-aqua-orbits-impacting-modis-snow-and-sea-ice-products).

Finally, and worth carrying into the manuscript, **nobody has solved this.** No published study drives
a bark beetle cold-mortality or phenology model from satellite LST. Régnière and Bentz built the
supercooling-point model on measured phloem temperature
(https://research.fs.usda.gov/treesearch/43493); PHENIPS derives bark temperature from "a digital
elevation model used for interpolation of temperature and solar radiation"
(https://www.sciencedirect.com/science/article/abs/pii/S0378112707004057). Both reach the beetle
through a DEM. Goodsman et al. 2024, validating a mountain pine beetle winter mortality model in
Banff, report that "the spatial prediction of relative mortality observed across the study area in
Banff National Park was poor, likely because the mountainous terrain presents a difficult prediction
challenge when under-bark temperatures are not directly observed"
(https://doi.org/10.3390/f15081425). That is a peer-reviewed statement that this exact problem is
unresolved in this exact terrain, and it is the single best citation for the Limitations paragraph.

## 5. Alternative identification strategies

### 5.1 Aspect and radiation load: partially works, and is cheap

The logic is sound and the manuscript is well placed to exploit it. Cold limitation acting through
degree-day accumulation should be aspect-asymmetric, because radiation load at a given elevation is
much higher on south and southwest aspects. Wind exposure should not be aspect-asymmetric in that
way; it should relate to convexity and to upwind horizon angle relative to the prevailing direction.
These are different functionals of the same DEM, they are not collinear with elevation, and at a
given elevation band they vary substantially. The manuscript currently carries Elevation, Slope,
TWI, RIX, Wind and TPI600, and has **no aspect or heat-load term at all**, even though the inherited
terrain set already includes Beers-transformed aspect compound indices. Adding a heat-load index
and a directional shelter index costs nothing but compute:

- Heat load, following McCune and Keon, as a function of slope, aspect and latitude, or the simpler
  Beers transform already available in the inherited surfaces.
- Directional exposure, the Winstral maximum upwind slope `Sx`, computed as the maximum slope from
  each cell to any cell along a search vector in the prevailing wind azimuth. Negative values are
  exposed, positive sheltered (https://smrf.readthedocs.io/en/latest/user_guide/wind_models.html).
  This is a far better specification of "wind disrupts the pheromone plume" than a downscaled mean
  speed, and it is the natural response to the manuscript's own complaint about the Global Wind
  Atlas.

Now the scepticism, which is substantial. First, both terms are DEM transforms, so this is not
identification by independent measurement; it is identification by assumed functional form. It works
only if radiation load really is the right proxy for the thermal constraint and upwind horizon
really is the right proxy for exposure. That is an assumption, not a design, and it must be stated
as one. Second, aspect separates wind from the **degree-day** half of cold limitation only. It
cannot separate wind from the **overwinter minimum** half, because a −35 °C synoptic outbreak is
cold on every aspect. Third, aspect is itself confounded with snow retention, host vigour and stand
structure, and Hadley 1994, already cited in the manuscript, is the standing warning that the
obvious aspect prediction for this beetle came out backwards. Fourth, in a landscape with a strong
prevailing wind, aspect and exposure are correlated, which erodes the separation the strategy
depends on.

**Verdict: worth doing, materially improves the paper, and honestly reported it identifies a
radiation-load effect distinct from a shelter effect rather than resolving cold against wind.** Do
not oversell it. It is a partial answer to half of the confound.

### 5.2 The time dimension: does not work

The idea is that cold limitation should track interannual winter severity while topographic wind
exposure is static, so a year-resolved model could separate them. It fails, for reasons that stack
up past rescue.

The identifying variation is landscape-uniform. A severe winter is severe across the whole 280 km²
study area. To make the year effect interact with elevation, so that a cold year suppresses attack
more at 2,000 m than at 1,200 m, you need year-specific temperature that varies **spatially**, and
the only spatially varying temperature you can construct is lapse rate times DEM. The strategy
therefore collapses back into §1's trap rather than escaping it.

The response is the wrong kind of variable. The manuscript rasterises first-attack year, which is an
epidemic-spread quantity. During 1999 to 2015 the BC outbreak built, expanded and collapsed as host
was depleted, and an elevational advance of the attack front is exactly what pure population growth
and dispersal predict with no climate signal at all. Attribution of a late-window upslope advance to
warming rather than to host depletion below is not available from these data.

The year label is not the year of the cold event. Aerial overview survey detects red attack, which
lags successful attack by roughly a year, so the mortality year and the survey year are offset and
the offset is not exact.

Power is absent. Seventeen years, of which perhaps two or three carry a notable cold event, against
the roughly two dozen independent 1 km blocks the manuscript reports for the host-present model, and
requiring a year by elevation interaction. The wind main effect already fails to clear zero; an
interaction estimated from the same data will be far noisier.

**Verdict: this cannot identify the two effects and should not be attempted. Say so plainly in the
Discussion rather than listing it as future work.**

### 5.3 The plausibility check that is actually worth running

There is a cheap, decisive-in-one-direction test that neither strategy above provides, and the BCWS
archive supports it. The classical mountain pine beetle cold-mortality threshold is severe: larvae
are freeze-avoiding, supercooling points fall through winter, and roughly −40 °C is the temperature
at which outbreaks are terminated by winter mortality, with the killing variable being under-bark
phloem temperature rather than air temperature
(https://www.fs.usda.gov/rm/pubs_journals/2022/rmrs_2022_bentz_b001.pdf,
https://www.sciencedirect.com/science/article/abs/pii/S0022191007000534). Alberta Agriculture's
operational guidance gives −37 °C under bark for 50 per cent mortality in midwinter, while noting
that −20 °C in autumn or spring, before hardening or after dehardening, also kills
(https://www1.agric.gov.ab.ca/$department/deptdocs.nsf/all/formain15814/$file/MPBColdTemperaturesFacts-Jan2010.pdf).

Against that, the observed winter minima at Norns, the 2,423 m station 49 km away and the highest in
the region, are −27.7 °C in 2008, −24.7 °C in 2009 and −28.4 °C in 2013, with the earlier years
censored at the −20.0 sensor floor and therefore unusable. Dewar Creek at 1,608 m records −27.9,
−24.5 and −28.0 in the same years. On this evidence the high-elevation zone at Darkwoods does not
approach the classical midwinter lethal threshold in the years that can be checked.

If that holds up, it changes what the manuscript should say. The cold confound would not be
overwinter freeze mortality, which appears not to bind at these elevations, but the degree-day and
voltinism constraint, which certainly does bind and which the manuscript already names alongside it.
That is a better-posed confound and, importantly, it is the aspect-sensitive one, which is what makes
§5.1 worth running. Treat this as a hypothesis to be tested with saved code, not as a result: three
years is a thin basis, Norns is on a different massif, the pre-2008 record is censored, and phloem
temperature under snow and bark is not air temperature at a fire-weather screen.

## 6. Bottom line and next action

**No temperature surface exists, at any extent relevant to this study, whose fine-scale spatial
structure over the South Selkirks is independent of the digital elevation model used to build the
terrain predictors.** This is not a gap in the catalogue that better searching would close. Of
sixteen gridded products surveyed, only four carry any genuine sub-10 km temperature structure at
all, and every one of the four obtains it by regression or lapse rate onto an external DEM: Daymet on
SRTM, CHELSA on GMTED2010, WorldClim on SRTM, and HRDPS on GMTED2010. That is not a coincidence of
product design. Terrain is the only information available at that scale, so any product that resolves
it has necessarily imposed it. The rest, every reanalysis included, stops at its own model orography
and is coarser than the study area: MERRA-2 does not have a single longitude node inside the study
box, ERA5-Land's much-cited elevation correction targets its own 9 km orography rather than a fine
DEM, and HRDPS, the one Canadian product with real 2.5 km terrain, has no archive before May 2017 and
so cannot cover the outbreak window at all. Meanwhile the station networks that could in principle
supply an empirical alternative have no vertical spread inside the study area during the window,
with every ECCC station ever operated inside the bounding box sitting between 457 and 760 m against
a 654 to 2,430 m landscape. The one network with real vertical spread, BC Wildfire Service, is
censored at −20.0 °C through the first half of the window and has no in-area station until October
2014. And the empirical-versus-artefact distinction that the task request rightly asked about does
not rescue the design: a lapse rate fitted to real thermometers, applied to a DEM, produces a raster
that is perfectly collinear with elevation and adds no degrees of freedom. Only the residual carries
information, and eleven stations spread over 150 km cannot map a residual onto 168 km² at 25 m.

**The recommendation is to stop looking for a temperature surface and do three things instead.**

1. **Add a heat-load or Beers-transformed aspect term and a Winstral `Sx` directional shelter term
   to the host-present model.** Both come free from the DEM already in hand, the model currently
   contains no aspect information at all, and together they test radiation load against directional
   exposure, which is a sharper and more defensible version of the mechanism than mean wind speed.
   Report it as identification by assumed functional form, not as resolution of the confound.
2. **Run the cold-threshold plausibility check in §5.3 as saved pipeline code,** pulling the BCWS
   hourly archive for the local stations across 1999 to 2015, excluding the −20.0 censored records
   explicitly, and reporting whether the high-elevation zone ever approaches the lethal threshold.
   If it does not, the Discussion can narrow the confound from overwinter mortality to degree-day
   accumulation, which is a real strengthening of the paper at low cost.
3. **Rewrite the Limitations paragraph as in §7 and drop the temperature surface from the future-work
   list.** Item 1 of the task request should be closed as investigated and infeasible rather than
   carried forward, and the effort redirected to item 2, ordinal severity modelling, which is
   tractable and which Krawchuk explicitly asks for.

The manuscript's existing framing survives this intact. It already reports the hypothesis as
supported in direction and unresolved in magnitude, and already states that separating exposure from
cold requires a temperature surface that is not itself an elevation transform. This memo confirms
that no such surface exists, which converts a hedge into a documented negative result, and a
documented negative result is a stronger thing to publish than a hedge.

## 7. Suggested Limitations text

> Separating wind exposure from cold limitation on this gradient would require a temperature surface
> whose fine-scale spatial structure is independent of the digital elevation model from which the
> terrain predictors are derived. We searched for one and conclude that none exists at this extent.
> Gridded climatologies resolve the sub-kilometre scale by downscaling coarse fields over terrain, so
> their fine-scale temperature variation is the terrain; this is true of PRISM-derived products,
> ClimateBC, Daymet and ERA5-Land alike, the last of which obtains its finer grid precisely by
> lapse-rate correction of ERA5 to a higher-resolution orography. Satellite land surface temperature
> is a genuine radiometric observation, but it measures canopy skin rather than phloem temperature,
> its 1 km MODIS grain matches the block size at which we already treat observations as independent,
> and its spatial pattern over slopes is governed by radiation load, snow cover and view angle, all
> of which are terrain functions; the MODIS retrieval documentation states that a high-resolution
> digital elevation model is itself a necessary input for topographic correction in rugged terrain,
> and the Landsat surface temperature product has no nighttime form at all. That this is a general
> difficulty rather than a local one is confirmed by Goodsman et al., who found spatial prediction of
> beetle winter mortality poor in the mountainous terrain of Banff National Park precisely because
> under-bark temperatures are not directly observed. Station observations offer no alternative here:
> within 150 km of
> the study area no Environment and Climate Change Canada station above 1,200 m reported during the
> 1999 to 2015 window, and every station ever operated inside the study bounding box lies between
> 457 and 760 m, against a landscape spanning 654 to 2,430 m. A lapse rate fitted to those stations
> would be empirical rather than a downscaling artefact, but applying it to the elevation model
> returns a raster collinear with elevation by construction, so it could not identify a temperature
> effect separately from an elevation effect. Only the departure of observed temperature from the
> elevation relation carries independent information, and that departure is substantial, with
> elevation explaining roughly three-fifths of the variance in winter minimum temperature among
> regional high-elevation stations, but it cannot be mapped onto a 25 m grid from a handful of
> stations without reintroducing terrain as the interpolator. We therefore report the high-elevation
> suppression as a refugium whose mechanism is unresolved between wind exposure and thermal
> limitation, and we note that this is a structural limit of the available observing network rather
> than a shortcoming of the present analysis.

## 8. Sources retrieved

Station inventories and archives queried directly during this scoping:

- ECCC climate station inventory, OGC API: `https://api.weather.gc.ca/collections/climate-stations/items`
- ECCC AHCCD stations, OGC API: `https://api.weather.gc.ca/collections/ahccd-stations/items`
- AHCCD dataset record: https://open.canada.ca/data/en/dataset/9c4ebc00-3ea4-4fe0-8bf2-66cfe1cddd1d
- BC ASWS station locations, WFS: `https://openmaps.gov.bc.ca/geo/pub/WHSE_WATER_MANAGEMENT.SSL_SNOW_ASWS_STNS_SP/ows`
- BC ASWS archive record and hourly air temperature file: https://open.canada.ca/data/en/dataset/5e7acd31-b242-4f09-8a64-000af872d68f and `http://www.env.gov.bc.ca/wsd/data_searches/snow/asws/data/TA_Archive.csv`
- BCWS station locations, WFS: `https://openmaps.gov.bc.ca/geo/pub/WHSE_LAND_AND_NATURAL_RESOURCE.PROT_WEATHER_STATIONS_SP/ows`
- BCWS hourly observation archive, 1987 to present: `https://www.for.gov.bc.ca/ftp/HPR/external/!publish/BCWS_DATA_MART/`
- BCWS Datamart and API guide v2.0, June 2023: https://www2.gov.bc.ca/assets/gov/public-safety-and-emergency-services/wildfire-status/prepare/bcws_datamart_and_api_v2_1.pdf
- PCIC Provincial Climate Data Set portal, which aggregates BC networks: https://services.pacificclimate.org/met-data-portal-pcds/app/ and https://www.uvic.ca/pcic/data-analysis-tools/data-portal/station-data/index.php

## 9. Product documentation and literature

Verified by retrieval during this scoping. Where a claim in this memo is reasoning rather than
citation it is marked as such in the text.

**ERA5-Land elevation correction, the decisive citation for the table in §3.** Munoz-Sabater et al.
2021, Earth System Science Data 13: 4349, https://essd.copernicus.org/articles/13/4349/2021/.
ERA5-Land runs at 9 km, "matching the ECMWF triangular-cubic-octahedral (TCo1279) operational grid,"
and is forced by ERA5 fields at "about 31 km" interpolated to 9 km, after which "air temperature is
adjusted for the altitude differences using a daily environmental lapse rate (ELR) field derived from
ERA5 lower troposphere temperature vertical profiles." The entire resolution gain from 31 km to 9 km
in the near-surface thermodynamic state is therefore an orography-driven lapse correction. This is
the property that disqualifies it, and it is the clearest published example of the general mechanism
the manuscript's Discussion describes.

**The other gridded products.** MERRA-2 file specification,
https://gmao.gsfc.nasa.gov/pubs/docs/Bosilovich785.pdf, and the GEOS topography module retaining
scales of 100 km and above,
https://github.com/GEOS-ESM/GMAO_Shared/blob/main/GEOS_Shared/GEOS_TopoGet.F90. ERA5 documentation,
https://confluence.ecmwf.int/display/CKB/ERA5%3A+data+documentation, and IFS Documentation Part IV
on orography filtering and the 2 m temperature diagnostic,
https://www.ecmwf.int/sites/default/files/elibrary/2016/16648-part-iv-physical-processes.pdf. NARR,
Mesinger et al. 2006 BAMS,
https://journals.ametsoc.org/downloadpdf/journals/bams/87/3/bams-87-3-343.pdf. RDRS, Gasset et al.
2021 HESS, https://hess.copernicus.org/articles/25/4917/2021/hess-25-4917-2021.pdf, with the CaSR
version table at https://hpfx.collab.science.gc.ca/~scar700/rcas-casr/dataset_specifics.html and the
CaLDAS technical note at
https://collaboration.cmc.ec.gc.ca/cmc/cmoi/product_guide/docs/tech_notes/technote_hrdps-700_caldas-400_20240611_e.pdf.
HRDPS 7.0.0 technical note,
https://collaboration.cmc.ec.gc.ca/cmc/cmoi/product_guide/docs/tech_notes/technote_hrdps-700_20240611_e.pdf,
and the 30 day datamart retention, https://eccc-msc.github.io/open-data/msc-datamart/readme_en/.
Daymet V4, Thornton et al. 2021, https://daymet.ornl.gov/files/Thornton_Daymet_V4_submitted_2021-01-20.pdf,
naming the SRTM near-global 30 arc second DEM V2.1 and the daily refitted vertical regression
coefficient. TerraClimate, Abatzoglou et al. 2018, https://pmc.ncbi.nlm.nih.gov/articles/PMC5759372/,
conceding it "may not adequately resolve microclimate features, particularly in complex terrain,"
with the Climatology Lab flagging "unrealistic extrapolation of winter inversions into high
elevations," https://www.climatologylab.org/terraclimate.html. CHELSA V2.1 file specification,
https://os.zhdk.cloud.switch.ch/envidat-doi/10.16904_envidat.228/chelsa_file_specification.pdf, with
the cold-air pooling caveat at https://www.chelsa-climate.org/models/chelsa. WorldClim 2.1,
https://www.worldclim.org/data/worldclim21.html. CRU TS, Harris et al. 2020,
https://www.osti.gov/pages/biblio/1624279. NOAAGlobalTemp v6.1.0,
https://www.ncei.noaa.gov/data/noaa-global-surface-temperature/v6.1/access/gridded/. Berkeley Earth
method, https://static.berkeleyearth.org/papers/Methods-GIGS-1-103.pdf.

**Cold-air pooling and the two-layer atmosphere.** Daly et al. 2008, International Journal of
Climatology, https://prism.oregonstate.edu/pubs/link/2008_daly-etal_ijoc.pdf. Strachan and Daly 2017,
JGR Atmospheres, https://prism.oregonstate.edu/pubs/link/2017_strachan-daly_j-geophys-res-atmos.pdf.

**BC lapse rates and station density.** Stahl, Moore, Floyer, Asplin and McKendry 2006, Agricultural
and Forest Meteorology 139: 224,
https://www.sciencedirect.com/science/article/abs/pii/S0168192306001638, full text at
https://blogs.ubc.ca/ianmckendry/files/2015/01/Comparison-of-approaches-for-spatial-interpolation-of-daily-air-temperature-in-a-large-region-with-complex-topography-and-highly-variable-station-density.pdf.
Déry et al. 2018, Cariboo Alpine Mesonet, Earth System Science Data 10: 1655,
https://essd.copernicus.org/articles/10/1655/2018/.

**Inversion frequency and scale.** Rupp, Shafer, Daly, Jones and Frey 2020, JGR Atmospheres 125,
https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2020JD032686, full text
https://andrewsforest.oregonstate.edu/pubs/pdf/pub5160.pdf. Cold-air pooling and inverted forest
composition, https://pmc.ncbi.nlm.nih.gov/articles/PMC10985370/.

**Decoupling and microrefugia, for framing.** Dobrowski 2011, Global Change Biology 17: 1022,
https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1365-2486.2010.02263.x. Lundquist, Pepin and
Rochford 2008, an algorithm for mapping cold-air pooling from a DEM,
https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2008jd009879. Note the irony of the last one
for this paper: the standard method for mapping cold-air pooling is itself a terrain transform.
**Caution:** the full texts of Dobrowski 2011 and Lundquist and Cayan 2007 could not be retrieved
during this scoping, both returning access errors, so their wording has not been verified. Do not
quote them without obtaining the papers.

**Beetle cold tolerance.** Régnière and Bentz 2007, Journal of Insect Physiology 53: 559,
https://www.sciencedirect.com/science/article/abs/pii/S0022191007000534. Bentz et al. 2022, RMRS,
https://www.fs.usda.gov/rm/pubs_journals/2022/rmrs_2022_bentz_b001.pdf. Alberta Agriculture
operational guidance on cold thresholds and the 2009 inversion episode,
https://www1.agric.gov.ab.ca/$department/deptdocs.nsf/all/formain15814/$file/MPBColdTemperaturesFacts-Jan2010.pdf.
**Caution:** the Safranyik and Carroll 2006 chapter itself could not be retrieved, and secondary
sources gave stage-specific lethal thresholds that could not be verified against it. The manuscript
already cites this chapter; the numbers should not be quoted from a summary.

**Land surface temperature products.** MOD11A1 v061, 1 km daily, day and night bands with QC_Day,
QC_Night and clear-sky coverage fields, validation at stage 2,
https://www.earthdata.nasa.gov/data/catalog/lpcloud-mod11a1-061. Landsat Collection 2 Level-2 Science
Products, https://www.usgs.gov/landsat-missions/landsat-collection-2-level-2-science-products; TIRS
native acquisition is 100 m, resampled by cubic convolution to the 30 m optical grid during Level-1
processing, and the surface temperature algorithm ingests ASTER GED emissivity plus atmospheric
profiles from reanalysis.

**LST cloud bias, terrain effects and the beetle precedent.** MOD11 Collection 6 user guide, source
of the 2,000 m cloud-confidence threshold,
https://lpdaac.usgs.gov/documents/118/MOD11_User_Guide_V6.pdf. MODIS LST ATBD, conceding that a
high-resolution DEM is a necessary input in rugged terrain,
https://modis.gsfc.nasa.gov/data/atbd/atbd_mod11.pdf. MODIS validation status and the 4 to 11 K
cloud-contamination caveat, https://modis-land.gsfc.nasa.gov/ValStatus.php?ProductID=MOD11. Terra and
Aqua end of mission, https://nsidc.org/data/user-resources/data-announcements/ongoing-changes-terra-and-aqua-orbits-impacting-modis-snow-and-sea-ice-products.
Westermann et al. 2012, https://epic.awi.de/id/eprint/25719/1/Westermann%2B11d.pdf. Ermida et al.
2019, https://hal.science/hal-03786341/document. Kindstedt et al. 2022,
https://tc.copernicus.org/articles/16/3051/2022/. Parajka and Blöschl 2006, source of both the
Austrian cloud statistics and the winter cloud-decreases-with-elevation result,
https://hess.copernicus.org/articles/10/679/2006/. Stillinger et al. 2019 on cloud-mask failure over
snow, https://pmc.ncbi.nlm.nih.gov/articles/PMC6988483/. Ehrler et al. 2024 on aspect bias from
overpass geometry, https://tc.copernicus.org/articles/18/5259/2024/. Minnis and Khaiyer 2000 on
view-angle bias, https://www-pm.larc.nasa.gov/data/sgp/reference/khaiyer.paper.pdf. Rautiainen et al.
2024 on snow decoupling, https://tc.copernicus.org/articles/18/403/2024/. De Frenne et al. 2019 on
forest microclimate buffering, https://www.nature.com/articles/s41559-019-0842-1. Lo Vecchio et al.
2026 on nighttime product coherence, https://www.nature.com/articles/s41598-026-63971-5. Laskin et
al. 2016, the closest positive analogue, https://www.mdpi.com/2072-4292/8/8/658. Bartkowiak et al.
2019, an Alpine LST downscaling that uses the DEM as a predictor, https://doi.org/10.3390/rs11111319.
**Goodsman et al. 2024, the key citation for the Limitations paragraph,**
https://doi.org/10.3390/f15081425. PHENIPS,
https://www.sciencedirect.com/science/article/abs/pii/S0378112707004057. Régnière and Bentz
supercooling model built on measured phloem temperature,
https://research.fs.usda.gov/treesearch/43493.

**Directional wind shelter.** Winstral maximum upwind slope `Sx`,
https://smrf.readthedocs.io/en/latest/user_guide/wind_models.html.

**Could not be retrieved, so not relied on.** Gelaro et al. 2017 on MERRA-2 (HTTP 403), so MERRA-2
claims rest on GMAO documentation rather than the BAMS paper. Dutra et al. 2020 (HTTP 402), so the
exact atmospheric layer over which ERA5-Land's lapse rate is regressed is unverified beyond the ESSD
phrase "lower troposphere temperature vertical profiles". Fick and Hijmans 2017 (HTTP 402), so
WorldClim's SRTM attribution rests on worldclim.org. Dobrowski 2011 and Lundquist and Cayan 2007,
access errors. Safranyik and Carroll 2006, not retrieved; the manuscript already cites it and its
thresholds should not be quoted from a summary. Also note two live access traps: caspar-data.ca
refused connections during this scoping and its GitHub wiki now returns 404, and
chelsa-climate.org/downloads/ returns 404, so use the envicloud links from the CHELSA home page.
