---
# The manuscript's own title, unchanged. It is 57 characters, inside the 95-character
# cap Frontiers in Ecology and the Environment sets in its "Titles and Abstracts"
# section, so nothing in the guidelines requires it to be rewritten.
#
# The subtitle is dropped, and only the subtitle. The guidelines make no provision for
# one, and title plus subtitle is 233 characters against the 95-character cap. The
# subtitle's content is carried by the abstract's first two sentences instead.
title: "Testing the wind disruption hypothesis for beetle refugia"
author:
  - name: Seamus Murphy
    orcid: 0000-0002-1792-0351
    email: seamusrobertmurphy@gmail.com
keywords:
  - Beetle refugia
  - Mountain pine beetle
  - Stand density
  - Geomorphometry
  - Wind exposure
  - Pheromone disruption

date: today
keep-md: true

format:
  docx:
    prefer-html: true
    reference-doc: ../04.references/style-formal.docx
    highlight-style: pygments
    number-sections: true
  html:
    page-layout: full
    toc: true
    number-sections: true
    embed-resources: true
    toc-title: ""
    toc-location: right
    toc-depth: 3
    theme:
      - ../04.references/style.scss
      - cosmo
    code-fold: false
    code-tools: true
    code-link: true
    grid:
      body-width: 1100px
      margin-width: 220px

execute:
  eval: true
  echo: false
  warning: false
  message: false
  error: false
  comment: NA

always_allow_html: true
engine: knitr
citeproc: true
editor: visual
bibliography: ../04.references/references-beetle.bib
csl: ../04.references/frontiers-in-ecology-and-the-environment.csl
df-print: kable
---


::: {.cell}

:::


<!-- SHARED COMPUTATIONAL PREAMBLE. Included by every live draft; do not edit it in a
     draft, because a draft cannot include a copy it has edited.

     This is the whole analysis: the data reads, the variable selection, every model fit,
     the accessors the prose reads coefficients through, and the guards. It ran to about
     600 lines and was duplicated in full across four manuscript files, so a change to a
     model in one of them silently gave that draft different coefficients from its
     siblings. On 2026-08-28 the drafts had already diverged on five separate additions.

     Paths are relative to 01.manuscript/, which is where the including document sits. -->



::: {.cell}

:::



<!-- Computation runs here, in one block, because the Abstract below is computed
     from the results and knitr evaluates inline expressions in document order.
     Every chunk keeps its own label, code and comments; only its position moved. -->


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::





# Abstract {.unnumbered}

Refugia from mountain pine beetle (*Dendroctonus ponderosae*) are hypothesised to form
where tree defences hold: on shaded ground that spares trees water stress, or in thin stands
with few large hosts, where wind may disrupt the aggregation pheromone. None has been fitted
spatially. We tested all three over 5,573 ha of the Selkirk Mountains, British
Columbia, at 30 m across 59 sixteen-day Landsat epochs and 8 outbreak
years, with a terrain-resolved wind field from hourly station records. Wind disruption held,
conditionally. Stand density interacted negatively with wind, -0.049 for stem
density and -0.017 for standing volume, both surviving a within-season spread term;
neither protected alone. A refugium here is a conjunction of stand and weather, not a fixed
place. Host held as a threshold, attack peaking at 39.7 per cent at
25 to 30 cm. Shading failed backwards: shaded ground carried more attack.


::: {.cell}

:::


# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins) has killed more lodgepole pine
(*Pinus contorta* Douglas ex Loudon) in British Columbia than any other agent on record
[@taylor2003; @sambaraju2021]. Where a landscape is not killed uniformly, the surviving
patches shape what the forest becomes, and the framework for them is disturbance refugia,
places buffered from disturbance over time [@krawchuk2020]. Explaining refugia rather than
locating them needs mechanistic links to terrain, soil and stand structure [@cartwright2018].

@krawchuk2020 proposed such a mechanism: refugia could occur "in areas with cooler
temperatures (eg from topographic shading) that protect trees from water stress; in areas
with lower host density, allowing for greater wind disruption of beetle pheromone
communication and more vigorous tree growth and chemical defenses; and in areas with fewer
large-diameter host trees". Three mechanisms, two of them terrain, and none has been fitted
spatially. Of the studies our screen retained, only a companion study on this landscape
enters a wind term, and its response is conifer regeneration rather than attack [@murphy2026].

Why a plume should matter at all is a population argument. A lodgepole pine resists a
single beetle through resin flow and an induced response that saturates the phloem with
terpenes, so overwhelming that defence takes the near-simultaneous arrival of many
individuals. Arrival is coordinated chemically, pioneer females oxidising a host
monoterpene to *trans*-verbenol while arriving males release *exo*-brevicomin, and
colonisation is normally complete within one to two days [@safranyik2006chap1]. Because
that signal is airborne it is in principle susceptible to wind, and that susceptibility is
the premise under test. Stem size sets a second constraint: bark thickness, phloem
thickness and moisture retention all rise with diameter, and @carroll2004bionomics put the
consequence as a threshold, pine at or below 25 cm being on average beetle sinks and larger
trees sources.

The wind half is a claim about canopy, not open air. @cartwright2018 found insect refugia in
stands of low basal area: "thinner stands also increase wind penetration, helping to disperse
beetle pheromones and disrupt chemical communications needed to coordinate attacks."
@powell2014 state the converse as the condition for outbreak, "higher local host density,
which minimizes pheromone plume dispersion, reduces wind, and promotes successful switching
to nearby hosts". A model that controls stand density out and then reads a terrain
coefficient as a wind effect has removed the pathway it set out to test.

Terrain also acts through heat. Flight is thermally gated at 19 to 41 degrees C, and "most
flights occur on bright sunny days, and peak flight is in the early to mid afternoon"
[@safranyik2006chap1; @mccambridge1971]. Radiation during the flight window is therefore a
different quantity from radiation across the season, and the season quantity is the one the
shading pathway concerns. Cool sites also push the beetle toward a two-year cycle
[@sambaraju2021], so shading and tree vigour predict the same sign by independent routes
[@bartos1989].

No product reports the wind the hypothesis concerns, an instantaneous below-canopy speed at
flight height during the flight period. Gridded climatologies report a long-run mean at 10 m
over open ground, downscaled over a digital elevation model, which makes them partly a
transform of the terrain offered alongside them [@badger2014; @davis2023]. Nor does the
literature state the interval over which wind should be summarised. We therefore take wind
from station observations of each 16-day period, modify it over the terrain, and test the
response at Landsat's own 16-day repeat rather than annually. Appendix S1 gives the direction
expected of every attribute entered and the reasoning behind it.

# Methods

@tbl-inventory sets out the datasets this study combines and the resolution of each.
The asymmetry it shows is the one the analysis turns on: the response varies every sixteen
days, the inventory once a year, the station wind every hour, and the terrain not at all.


::: {#tbl-inventory .cell tbl-cap='The datasets this study combines, with the structure and resolution of each. Every count is read from the files at render time. Spatial resolution is the grid the variable is analysed on; temporal resolution is the interval at which it varies. Note that the response varies every 16 days, the inventory once a year and the terrain not at all, which is the asymmetry the wind analysis turns on.'}
::: {.cell-output-display}


|Dataset                    |Source                                         |Variables                                                       |Spatial resolution          |Temporal resolution            |Period                      |                      n|
|:--------------------------|:----------------------------------------------|:---------------------------------------------------------------|:---------------------------|:------------------------------|:---------------------------|----------------------:|
|Beetle disturbance, annual |Landsat 5 and 8 Collection 2 Level-2           |Moderate-to-high disturbance, binary, from NDMI                 |30 m                        |1 year                         |2006-2014, excluding 2012   |                8 years|
|Beetle disturbance, 16-day |Landsat 5 and 8 Collection 2 Level-2           |Moderate-to-high disturbance, binary, from NDMI                 |30 m                        |16 days, the sensor's repeat   |2006-2014, excluding 2012   |              59 epochs|
|Stand structure            |VRI Historical, BC Data Catalogue              |Basal area, volume, stems, quadratic mean diameter, age, height |Polygon, rasterised to 30 m |1 year, projected to each year |2005-2014                   |            9 snapshots|
|Terrain                    |NRCan High Resolution DEM, indices by SAGA GIS |29 geomorphometric surfaces incl. radiation, exposure, landform |30 m                        |Static                         |n/a                         |            29 surfaces|
|Station wind               |Environment and Climate Change Canada          |Speed and direction                                             |4 to 7 valley stations      |1 hour                         |2005-2014, May to September | 236,079 hourly records|
|Terrain-resolved wind      |MicroMet over the DEM, driven by station wind  |Weighting factor, modified speed, diverted direction            |30 m                        |16 days, and 1 year            |2005-2014                   |      16 direction bins|
|Modelling table, annual    |Assembled by 38-assemble-model-data.R          |Response and every covariate, one row per cell-year             |30 m                        |1 year                         |2006-2014, excluding 2012   |     111,707 cell-years|
|Modelling table, 16-day    |Assembled by 45-epoch-model-data.R             |Response and every covariate, one row per cell-epoch            |30 m                        |16 days                        |2006-2014, excluding 2012   |     66,302 cell-epochs|


:::
:::



The study area is 5,573 ha of the Selkirk Mountains in southeastern British
Columbia, 61,923 cells at 30 m in EPSG:3153, spanning 830 to
1,744 m (Figure 1). The grid and the perimeter are the parent study's
[@murphy2026], anchored on the 2015 Mt Midgeley fire and expanded to the elevation band that
site occupies, because 480 ha cannot carry the stand-density contrast the mechanism runs on.

The response is moderate-to-high beetle disturbance, classified from Landsat normalised
difference moisture index by the parent study's method. It covers 8 outbreak
years, 2006 to 2014, excluding 2012, the one year flown only by
Landsat 7 with its scan-line corrector off. Pooled prevalence is
12.9 per cent over 111,707 cell-years (Appendix S3). Years
are never unioned: unioning destroys the year-to-year spread this study measures.

Stand structure comes from the provincial Vegetation Resources Inventory (Appendix S4). Six
attributes carry the mechanism and the stem-size threshold: basal area, crown closure, live
stems per hectare, quadratic mean diameter over stems 12.5 cm and up, stand age, and
susceptible pine basal area. We described terrain with 29 geomorphometric surfaces, computed
with SAGA GIS over the full elevation model and clipped afterwards, so a search radius near
the boundary sees real ground. They cover exposure, shape, landform and aspect, the last
entering as northward and eastward components and as the heat load index of @mccune2002. Radiation is computed twice, because two mechanisms need it:
flight-window insolation over 1 July to 15 August restricted to 12:00 to 17:00, the hours
@safranyik2006chap1 identify as the flight peak, and growing-season insolation as the
whole-day total from 1 May to 30 September. A single annual index cannot separate them, the
flight-window surface spanning a
7-fold range here
against 2.6-fold for the
season total.


::: {.cell}

:::


Station wind interpolated from four to seven valley stations is nearly flat within a year, so
wind is also computed as a field varying in space, using the MicroMet model of @liston2006.
Its wind component is seven equations rather than a program, implemented directly. Terrain
slope, azimuth and curvature give a weighting factor $W_w = 1 + \gamma_s\Omega_s +
\gamma_c\Omega_c$ with $\gamma_s = \gamma_c = 0.5$, a modified speed $W_t = W_wW$, and a
direction diversion $\theta_d = -0.5\,\Omega_s\sin[2(\xi-\theta)]$. $W_w$ depends on
direction and not speed, so it is computed once for each of 16 direction bins and each hourly
observation multiplied by the surface for its own bin; nothing is averaged before the terrain
acts on it. The field varies 1.9 to
2.8 km/h across the grid within a year, and is not
a repackaged terrain index, correlating +0.148 with the
windward-leeward index.

45 candidate variables in six groups, one per pathway, passed a four-stage selection
required to retain at least one variable from each group, so a collinearity filter could not
delete a hypothesis. Fitting used a class-balanced sample of 46,359 cell-years,
because an unbalanced fit at 13 per cent prevalence reports the
intercept rather than the covariates. Four annual logistic models each add one claim to the
last: host size, shading and landform (M0), stand density (M1), terrain shape, exposure and
flight radiation (M2), and the interactions (M3). Two further annual models add previous-year
attack and 90 m neighbourhood pressure after the autologistic design used for this province
(M4), and replace station wind with the terrain-resolved field (M5). The 16-day models (E1,
E2) refit the same covariates over 59 epochs, E2 adding the previous epoch of the
same season. Model comparison is in Appendix S2.

# Results

Every pathway earns its place. AIC falls 457 when stand density
enters, 743 more with terrain and flight radiation, and
534 more with the interactions.

Stand basal area carries the density pathway (Table 1), at +0.504 log-odds per
standard deviation (p = < 0.001). Live stems per hectare carries
+0.051 in the same direction, while crown closure alone runs the
other way at -0.125 (p = < 0.001). Standing volume does not
survive selection once each year carries its own inventory. As main effects the density
measures therefore disagree, which is a weaker reading than it first appears, because the
mechanism's prediction is not about a main effect at all.

Radiation enters once. Flight-window direct radiation carries
+0.497, which is the thermal gate on flight. Growing-season radiation
did not survive selection, so the shading pathway is carried by northness, with which it
correlates -0.824. Northness is +0.305:
shaded, north-facing ground carries more attack, against the prediction. Terrain predicts
attack independently of both, the windward-leeward index at +0.394 and
elevation at +0.337, while terrain ruggedness is -0.005 and not
distinguishable from zero (p = 0.848).

A terrain index is partly an insolation measurement. Fitted without flight-window radiation,
stand density interacts with terrain exposure at -0.068. With radiation in the model
that interaction falls to -0.040 (p = 0.098) and density interacts with
radiation at +0.103. On a range whose prevailing bearing is
258 degrees the windward slopes face west, which are also the slopes
taking afternoon sun, so about two fifths of the apparent exposure effect was the sun. What
remains is not distinguishable from zero, so the annual model neither supports the mechanism
nor rejects it. The next paragraph shows why.

Temporal resolution decided the outcome (Figure 2). At 16 days, stand density interacts with
terrain-resolved wind at -0.049 for stem density (p = < 0.001) and
-0.017 for standing volume (p = 0.038), both negative, which is the
mechanism's signature: a dense stand is worth less where and when the wind blows harder. Both
survive entering the previous epoch of the same season, which carries
+0.704, so the result is not the outbreak's own spread wearing a wind
coefficient, and they discriminate at 0.673 and
0.762 respectively. With one map a year, the same wind field,
covariates and classification
threshold give +0.031 (p = 0.087), the opposite sign. Nothing about the
landscape or the wind product changed between the two. What changed is that an annual
response can only ask whether windy summers carry less attack than calm ones, and a summer
contains both windy and calm weeks.

Attack also recurs where it was, by a margin that changes how every other coefficient reads.
Entering persistence and 90 m spread separately gives +0.901 and
+1.001 and raises discrimination from 0.801 to
0.900. Which environmental terms survive is the informative part, and
the landform terms do not: valley depth keeps 0.18 of its value while
mid-slope position moves to 1.35, growing rather than shrinking. Part
of what the landform terms measured was where the outbreak had already been.

Host coded as diameter holds as a threshold rather than a slope. Attack peaks in the 25 to
30 cm class at 39.7 per cent,
stepping up from 26.4 per cent
below the 25 cm source-sink boundary of @carroll2004bionomics and falling to
15.7 per cent above 40 cm
(Appendix S5). The linear coefficient is negative, -0.362, because a
straight line through a humped response returns the slope of its falling limb.

# Conclusions

Of the three mechanisms @krawchuk2020 name, two hold at the resolution the sensor and the
insect share and one does not. Host density holds in the conditional form the mechanism
specifies rather than as a bare main effect, which is the important distinction: as main
effects the three density measures disagree in sign, but what a dense canopy buys shrinks as
the wind rises, and that is the claim. Large-diameter host holds as a threshold at 25 to
30 cm. Topographic shading fails, and it fails on a surrogate: growing-season radiation did
not survive selection, so the pathway is carried by northness, which correlates
-0.824 with it. Northness tests aspect, and aspect
carries more than shade, so this is the least secure of the three verdicts.

The methodological finding is the more transferable one, and it has three parts. A terrain
index is not an environmental measurement: entering flight-window radiation cut the density
by terrain-exposure interaction from -0.068 to -0.040. A landform variable in
a spreading outbreak records the outbreak's own history: entering previous-year pressure left
valley depth at 0.18 of its value while mid-slope position moved to
1.35. And an annual response cannot test a mechanism that operates over weeks: the
same wind field, covariates and threshold gave +0.031 annually against
-0.049 at sixteen days. A test that aggregates past the flight period is not a
weaker version of the right test. It is a different question, and this study answers it in
the opposite direction.

Since no previous study has fitted a wind term at all, nothing establishes the resolution at
which one should be fitted. Our answer is that it must be no coarser than the flight period.
For managers reading refugia maps built from annual disturbance products, that matters
directly: a map that shows no wind signal may be showing the calendar rather than the
landscape.

Four limits stay attached. Flight-window radiation and terrain exposure are not separable
here, correlating -0.595, so the positive flight
radiation coefficient is consistent with the thermal gate and with exposure alike, and the
annual density by exposure interaction is not distinguishable from zero once radiation
enters. The wind field is modelled from station data rather than measured on the ridge, so
what is established is that the modelled field behaves as the mechanism requires, not that
the air did. Matching the inventory to its own year is what lets basal area carry the density
pathway at all, at a univariate
0.603; held at the 2025 composite it is
indistinguishable from chance. And every conclusion rests on one
mountain range over 8 years and 59 epochs.

# Open research

This study complies with the Ecological Society of America's Open Research Policy. Every
dataset is public and none was collected by the authors. Beetle disturbance is classified
from Landsat Collection 2 Level-2 surface reflectance. Stand structure is the provincial
Vegetation Resources Inventory layer `VEG_COMP_LYR_R1_POLY`, retrieved from the British
Columbia Data Catalogue web feature service. Terrain derives from the Natural Resources
Canada High Resolution Digital Elevation Model [@nrcan2017], with geomorphometry computed by
SAGA GIS. Wind is Environment and Climate Change Canada hourly station data. All processing
scripts and the derived model tables that reproduce every number reported here will be
deposited in Dryad on acceptance, and are available to reviewers on request.


::: {.cell}
::: {.cell-output-display}
![Landscape, terrain and stand surfaces across the study area, all EPSG:3153 at 30 m over Esri World Shaded Relief. (a) elevation; (b) terrain ruggedness index; (c) windward-leeward index at the prevailing bearing; (d) flight-window direct radiation, the thermal gate on flight; (e) growing-season direct radiation, the shading pathway; (f) the MicroMet wind weighting factor at the prevailing bearing; (g) stand basal area; (h) quadratic mean diameter, whose 25 cm source-sink threshold falls near the midpoint of the scale; (i) live stems per hectare. The white outline is the study perimeter and the red outline the 2015 Mt Midgeley burn. Contours are at 200 m. Every panel carries its own north arrow and the same numerical scale, 1:150,000, which holds at a printed panel width of 66 mm.](beetle-topography-wind-study-short-short_files/figure-docx/figure-1-1.png)
:::
:::



::: {.cell}
::: {.cell-output-display}
![**Figure 2.** The refugia mechanism as fitted at 16 days. (a) Predicted probability of moderate-to-high disturbance against terrain-resolved epoch wind, at the 10th and 90th percentiles of stem density, all other terms at their means; the lines cross, so wind raises attack in thin stands and lowers it in dense ones, which is the interaction. (b) The same for standing volume. (c) Coefficients of the 16-day model, with and without the within-season spread term. (d) Epoch prevalence against epoch mean wind, one point per epoch.](beetle-topography-wind-study-short-short_files/figure-docx/figure-2-1.png)
:::
:::



::: {.cell tbl-cap='**Table 1.** The terms the three mechanisms turn on, and the specification contrasts the paper rests on. Coefficients are log-odds per standard deviation on a class-balanced sample. The annual models are M3, M3 without flight-window radiation, and M5; the 16-day models are E1 and E2. The three mechanisms are those of Krawchuk et al. (2020). Growing-season direct radiation did not survive variable selection, so the shading pathway is represented by northness.'}
::: {.cell-output-display}


|                            |Term                                         |   Beta|      z|       p|
|:---------------------------|:--------------------------------------------|------:|------:|-------:|
|Mechanism 1: shading        |Northness (shading surrogate)                | +0.305|  19.79| < 0.001|
|Mechanism 2: host density   |Standing volume                              |       |       |      NA|
|                            |Live stems per hectare                       | +0.051|   3.01|   0.003|
|                            |Crown closure                                | -0.125|  -5.80| < 0.001|
|Mechanism 3: host size      |Quadratic mean diameter                      | -0.362| -14.47| < 0.001|
|                            |Susceptible pine basal area                  | +0.536|  35.25| < 0.001|
|Terrain                     |Flight-window direct radiation               | +0.497|  16.49| < 0.001|
|                            |Terrain ruggedness index                     | -0.005|  -0.19|   0.848|
|                            |Windward-leeward index                       | +0.394|  13.31| < 0.001|
|                            |Elevation                                    | +0.337|  18.44| < 0.001|
|Radiation and exposure      |Density x terrain exposure, no radiation     | -0.068|  -3.71| < 0.001|
|                            |Density x terrain exposure, with radiation   | -0.040|  -1.65|   0.098|
|Resolution decides the sign |Density x wind, annual (M5)                  | +0.031|   1.71|   0.087|
|                            |Stem density x wind, 16-day (E1)             | -0.049|  -5.89| < 0.001|
|                            |Standing volume x wind, 16-day (E1)          | -0.017|  -2.07|   0.038|
|                            |Standing volume x wind, 16-day with lag (E2) | -0.039|  -2.68|   0.007|


:::
:::


# Supporting information {.unnumbered}

Five components accompany this paper and are supplied as stand-alone documents at
submission. They are reproduced below for review.

## Appendix S1


::: {.cell tbl-cap='**Appendix S1.** Landscape attributes entered in this study, the direction expected of each, and the reasoning behind that expectation.'}
::: {.cell-output-display}


|Attribute                                          |Expected                       |Rationale                                                                                                                                               |
|:--------------------------------------------------|:------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------|
|Stand basal area, volume, crown closure, stems     |positive                       |Denser canopy holds the pheromone plume together; thinner stands admit wind that disperses it [@krawchuk2020; @cartwright2018; @powell2014].            |
|Quadratic mean diameter                            |positive above 25 cm           |Trees under 25 cm are beetle sinks, over 25 cm are sources [@carroll2004bionomics].                                                                     |
|Lodgepole pine cover and basal area                |positive                       |Attack cannot occur where the host is absent; a cell without pine is not a refugium [@cartwright2018].                                                  |
|Flight-period direct radiation                     |positive                       |Flight is gated between 19 and 41 degrees C and peaks on bright afternoons, so sunlit slopes are reachable [@safranyik2006chap1; @mccambridge1971].     |
|Growing-season direct radiation                    |negative                       |Shading cools, relieving water stress and funding defence, and cool sites also push the beetle toward a two-year cycle [@krawchuk2020; @sambaraju2021]. |
|Terrain exposure to wind                           |negative                       |Wind disrupts the pheromone plume, so exposed ground should carry less attack [@krawchuk2020].                                                          |
|Terrain ruggedness                                 |uncertain                      |The strongest terrain term in the companion study on this landscape, but fitted there against regeneration rather than attack [@murphy2026].            |
|Convergence, wetness, valley depth, slope position |positive in convergent terrain |Infested groups gather in draws and gullies, and deep snow insulates overwintering brood [@safranyik2006chap1].                                         |
|Flight-period wind speed                           |negative                       |The mechanism acts during dispersal, and no study specifies the interval, so it is taken at the flight period [@krawchuk2020; @jones2019].              |
|Elevation                                          |uncertain                      |A composite of temperature, snowpack, season length and host distribution that this design cannot separate [@sambaraju2021].                            |


:::
:::


## Appendix S2


::: {.cell tbl-cap='Model comparison. Each model adds one pathway to the previous. AIC ranks on likelihood and a parameter penalty; the remaining columns are predictive error on the fitted probabilities. RMSE is the root mean squared error and is the square root of the Brier score; RMSE (%) expresses it against the prevalence of the response. Brier skill is the improvement over predicting the prevalence for every cell, where 0 is no better than the base rate. MAPE and Theil\'s U are not reported: both divide by the observed value, which is zero for the majority class of a binary response, so both are undefined without discarding that class.'}
::: {.cell-output-display}


|Model                             |    AIC|  ΔAIC|  RMSE| RMSE (%)|   MAE| Brier| Log loss|   AUC|Brier skill |
|:---------------------------------|------:|-----:|-----:|--------:|-----:|-----:|--------:|-----:|:-----------|
|M0 host size + shading + landform | 46,964| 1,734| 0.407|    131.5| 0.333| 0.166|    0.506| 0.776|0.224       |
|M1 + stand density                | 46,507| 1,277| 0.405|    130.6| 0.329| 0.164|    0.501| 0.783|0.234       |
|M2 + terrain and flight radiation | 45,764|   534| 0.401|    129.5| 0.323| 0.161|    0.493| 0.792|0.247       |
|M3 + interactions                 | 45,230|     0| 0.399|    128.7| 0.319| 0.159|    0.487| 0.800|0.257       |


:::
:::


## Appendix S3


::: {.cell tbl-cap='**Appendix S3.** Moderate-to-high beetle disturbance by year inside the study perimeter.'}
::: {.cell-output-display}


|Year |  Cells| Moderate-to-high (%)|
|:----|------:|--------------------:|
|2006 | 13,224|                  4.9|
|2007 | 13,225|                  6.0|
|2008 | 13,285|                 19.2|
|2009 | 13,556|                 12.4|
|2010 | 13,538|                 16.5|
|2011 | 14,944|                 13.5|
|2013 | 14,943|                 14.4|
|2014 | 14,992|                 15.2|


:::
:::


## Appendix S4


::: {.cell tbl-cap='Stand structure across the study perimeter, from the Vegetation Resources Inventory. n is cell-years. SD is the standard deviation of the landscape; SE is the standard error of the mean and is small by construction at this n, so it is not precision about any one cell. Skewness and kurtosis are the bias-corrected third and fourth standardised moments; kurtosis is excess, so 0 is Gaussian.'}
::: {.cell-output-display}


|Attribute                           |       n|   Mean|     SD|    SE| Median|   Min|     Max| Skewness| Kurtosis|
|:-----------------------------------|-------:|------:|------:|-----:|------:|-----:|-------:|--------:|--------:|
|Stand basal area (m2/ha)            | 111,707|  35.56|  11.60| 0.035|  37.39|  0.98|   62.43|    -1.01|    +1.42|
|Crown closure (%)                   | 111,707|  50.10|  13.54| 0.041|  50.00|  3.00|   70.00|    -1.74|    +3.37|
|Live stems (n/ha)                   | 111,707| 772.75| 312.80| 0.936| 775.00| 23.00| 4600.00|    +1.70|   +19.51|
|Quadratic mean diameter (cm)        | 111,707|  27.38|   6.40| 0.019|  26.95| 13.55|   58.90|    +0.73|    +1.24|
|Stand age (years)                   | 111,707| 115.46|  20.88| 0.062| 116.00| 22.00|  237.00|    -0.78|    +1.97|
|Stand height (m)                    | 111,707|  26.97|   6.27| 0.019|  27.90|  7.00|   40.30|    -0.26|    +0.23|
|Standing volume (m3/ha)             | 111,707| 272.33| 131.38| 0.393| 281.47|  0.82|  586.61|    +0.01|    -0.35|
|Lodgepole pine cover (%)            | 111,707|  20.11|  23.93| 0.072|  10.00|  0.00|  100.00|    +1.45|    +1.56|
|Susceptible pine basal area (m2/ha) | 111,707|   7.07|   8.85| 0.026|   4.00|  0.00|   48.30|    +1.63|    +2.63|


:::
:::


## Appendix S5


::: {.cell tbl-cap='Moderate-to-high beetle disturbance by quadratic mean diameter class, on the balanced sample. The 25 cm boundary is the source-sink threshold of the species\' bionomics. Intervals are Wilson score intervals on the class proportion. Note that 30 m cells in a spreading outbreak are not independent, so the accompanying tests are anti-conservative.'}
::: {.cell-output-display}


|QMD class (cm) |      n| Attacked| Attacked (%)| 95% CI (%)|
|:--------------|------:|--------:|------------:|----------:|
|<15            |    436|      113|         25.9|  22.0-30.2|
|15-20          |  4,325|    1,057|         24.4|  23.2-25.7|
|20-25          |  9,934|    2,627|         26.4|  25.6-27.3|
|25-30          | 19,090|    7,576|         39.7|  39.0-40.4|
|30-40          | 10,903|    2,724|         25.0|  24.2-25.8|
|>40            |  1,671|      262|         15.7|  14.0-17.5|


:::
:::


# References
