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

Refugia from mountain pine beetle (*Dendroctonus ponderosae*) are thought to form where
stands are thin enough for wind to break up the pheromone plume that coordinates mass
attack. It names three mechanisms, shading, low host density and few large-diameter hosts,
and none has been fitted. We tested all three over 5,573 ha of the Selkirk
Mountains, British Columbia, at 30 m and Landsat's 16-day repeat, 59 epochs across
8 outbreak years, with wind from a terrain-resolved field driven hourly. Stand density interacted negatively with wind,
-0.094 for stem density and -0.041 for standing volume, both surviving a
within-season spread term. Host held through standing volume, attack peaking at
45.9 per cent at 25 to 30 cm.
Shading failed: shaded ground carried more attack, not less. Resolution decided it. One map
a year, same wind field and covariates, gave +0.031, the opposite sign.


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

The study area is 5,573 ha of the Selkirk Mountains in southeastern British
Columbia, 61,923 cells at 30 m in EPSG:3153, spanning 830 to
1,744 m (Figure 1). The grid and the perimeter are the parent study's
[@murphy2026], anchored on the 2015 Mt Midgeley fire and expanded to the elevation band that
site occupies, because 480 ha cannot carry the stand-density contrast the mechanism runs on.

The response is moderate-to-high beetle disturbance, classified from Landsat normalised
difference moisture index by the parent study's method. It covers 8 outbreak
years, 2006 to 2014, excluding 2012, the one year flown only by
Landsat 7 with its scan-line corrector off. Pooled prevalence is
12.5 per cent over 122,700 cell-years (Appendix S3). Years
are never unioned: unioning destroys the year-to-year spread this study measures.

Stand structure comes from the provincial Vegetation Resources Inventory (Appendix S4). Six
attributes carry the mechanism and the stem-size threshold: basal area, crown closure, live
stems per hectare, quadratic mean diameter over stems 12.5 cm and up, stand age, and
susceptible pine basal area. Terrain is 29 geomorphometric surfaces computed
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
a repackaged terrain index, correlating +0.153 with the
windward-leeward index.

45 candidate variables in six groups, one per pathway, passed a four-stage selection
required to retain at least one variable from each group, so a collinearity filter could not
delete a hypothesis. Fitting used a class-balanced sample of 47,328 cell-years,
because an unbalanced fit at 12 per cent prevalence reports the
intercept rather than the covariates. Four annual logistic models each add one claim to the
last: host size, shading and landform (M0), stand density (M1), terrain shape, exposure and
flight radiation (M2), and the interactions (M3). Two further annual models add previous-year
attack and 90 m neighbourhood pressure after the autologistic design used for this province
(M4), and replace station wind with the terrain-resolved field (M5). The 16-day models (E1,
E2) refit the same covariates over 59 epochs, E2 adding the previous epoch of the
same season. Model comparison is in Appendix S2.

# Results

Every pathway earns its place. AIC falls 498 when stand density
enters, 744 more with terrain and flight radiation, and
1,065 more with the interactions.

Stand density does not behave as one variable (Table 1). Standing volume carries
+0.381 log-odds per standard deviation, but live stems per hectare
carries -0.099 and crown closure -0.183, both
negative and both far from zero (p = < 1e-16). As a main effect the density
pathway is mixed, and standing wood in large stems is the only measure of it that points the
way the mechanism predicts. That is a weaker reading than it first appears, because the
mechanism's prediction is not about a main effect at all.

Radiation enters once. Flight-window direct radiation carries
+0.487, which is the thermal gate on flight. Growing-season radiation
did not survive selection, so the shading pathway is carried by northness, with which it
correlates -0.834. Northness is +0.382:
shaded, north-facing ground carries more attack, against the prediction. Terrain predicts
attack independently of both, the windward-leeward index at +0.358 and
elevation at +0.329, while terrain ruggedness is -0.036 and not
distinguishable from zero (p = 0.124).

A terrain index is partly an insolation measurement. Fitted without flight-window radiation,
stand density interacts with terrain exposure at +0.311. With radiation in the model
that interaction falls to +0.221 (p = < 1e-16) and density interacts with
radiation at -0.144. On a range whose prevailing bearing is
258 degrees the windward slopes face west, which are also the slopes
taking afternoon sun, so about a third of the apparent exposure effect was the sun. The
remainder is not, and it stays positive, which is the wrong sign for pheromone disruption.
That is the annual answer, and the next paragraph shows it is an artefact of the calendar.

Temporal resolution decided the outcome (Figure 2). At 16 days, stand density interacts with
terrain-resolved wind at -0.094 for stem density (p = < 1e-16) and
-0.041 for standing volume (p = 4.91e-07), both negative, which is the
mechanism's signature: a dense stand is worth less where and when the wind blows harder. Both
survive entering the previous epoch of the same season, which carries
+0.672, so the result is not the outbreak's own spread wearing a wind
coefficient, and they discriminate at 0.668 and
0.756 respectively. With one map a year, the same wind field,
covariates and classification
threshold give +0.031 (p = 0.0364), the opposite sign. Nothing about the
landscape or the wind product changed between the two. What changed is that an annual
response can only ask whether windy summers carry less attack than calm ones, and a summer
contains both windy and calm weeks.

Attack also recurs where it was, by a margin that changes how every other coefficient reads.
Entering persistence and 90 m spread separately gives +0.873 and
+0.950 and raises discrimination from 0.799 to
0.888. Which environmental terms survive is the informative part.
Ruggedness keeps 0.61 of its value, a term describing a condition a cell has
whether or not the beetle was there. The landform terms are not stable: valley depth keeps
0.50 while mid-slope position moves to 1.32,
growing rather than shrinking. Part of what the landform terms measured was where the
outbreak had already been.

Host coded as diameter holds as a threshold rather than a slope. Attack peaks in the 25 to
30 cm class at 45.9 per cent,
stepping up from 36.3 per cent
below the 25 cm source-sink boundary of @carroll2004bionomics and falling to
17.0 per cent above 40 cm
(Appendix S5). The linear coefficient is negative, -0.422, because a
straight line through a humped response returns the slope of its falling limb.

# Conclusions

Of the three mechanisms @krawchuk2020 name, two hold at the resolution the sensor and the
insect share and one does not. Host density holds in the conditional form the mechanism
specifies rather than as a bare main effect, which is the important distinction: as main
effects the three density measures disagree in sign, but what a dense canopy buys shrinks as
the wind rises, and that is the claim. Large-diameter host holds as a threshold at 25 to
30 cm. Topographic shading fails, and it fails on a surrogate: growing-season radiation did
not survive selection, so the pathway is carried by northness, which correlates
-0.834 with it. Northness tests aspect, and aspect
carries more than shade, so this is the least secure of the three verdicts.

The methodological finding is the more transferable one, and it has three parts. A terrain
index is not an environmental measurement: entering flight-window radiation cut the density
by terrain-exposure interaction from +0.311 to +0.221. A landform variable in
a spreading outbreak records the outbreak's own history: entering previous-year pressure left
valley depth at 0.50 of its value while mid-slope position moved to
1.32, against 0.61 for ruggedness. And an annual response cannot test a mechanism that operates over weeks: the
same wind field, covariates and threshold gave +0.031 annually against
-0.094 at sixteen days. A test that aggregates past the flight period is not a
weaker version of the right test. It is a different question, and this study answers it in
the opposite direction.

Since no previous study has fitted a wind term at all, nothing establishes the resolution at
which one should be fitted. Our answer is that it must be no coarser than the flight period.
For managers reading refugia maps built from annual disturbance products, that matters
directly: a map that shows no wind signal may be showing the calendar rather than the
landscape.

Four limits stay attached. Flight-window radiation and terrain exposure are not separable
here, correlating -0.599, so the positive flight
radiation coefficient is consistent with the thermal gate and with exposure alike, and the
annual density by exposure interaction stays positive after radiation enters. The wind
field is modelled from station data rather than measured on the ridge, so what is established
is that the modelled field behaves as the mechanism requires, not that the air did. The
inventory postdates part of the outbreak, which is the likeliest reason total basal area
discriminates below chance at
0.516. And every conclusion rests on one
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
![The study area over the British Columbia Freshwater Atlas, with Kootenay Lake and the Kootenay River to the east. (a) Elevation, with the 2015 Mt Midgeley burn that anchors the perimeter outlined in red. (b) Terrain ruggedness index. (c) Stand basal area from the Vegetation Resources Inventory, the density term the pheromone-disruption mechanism runs through. The study perimeter is the grey outline and contours are at 250 m. The base map is Esri World Shaded Relief, desaturated to grey, so the ground the analysis excludes is still visible: the hole inside the perimeter is the summit ridge above the 1744 m ceiling and the ragged outer edge is the valley floor below the 830 m floor. Contours are at 200 m. Every panel carries its own north arrow and the same numerical scale, 1:250,000, which holds at a printed panel width of 66 mm. Coordinates are EPSG:3153, NAD83(CSRS) / BC Albers.](beetle-topography-wind-study-short-short_files/figure-docx/figure-1-1.png)
:::
:::



::: {.cell}
::: {.cell-output-display}
![**Figure 2.** The refugia mechanism as fitted at 16 days. (a) Predicted probability of moderate-to-high disturbance against terrain-resolved epoch wind, at the 10th and 90th percentiles of stem density, all other terms at their means; the lines cross, so wind raises attack in thin stands and lowers it in dense ones, which is the interaction. (b) The same for standing volume. (c) Coefficients of the 16-day model, with and without the within-season spread term. (d) Epoch prevalence against epoch mean wind, one point per epoch.](beetle-topography-wind-study-short-short_files/figure-docx/figure-2-1.png)
:::
:::



::: {.cell tbl-cap='**Table 1.** The terms the three mechanisms turn on, and the specification contrasts the paper rests on. Coefficients are log-odds per standard deviation on a class-balanced sample. The annual models are M3, M3 without flight-window radiation, and M5; the 16-day models are E1 and E2. The three mechanisms are those of Krawchuk et al. (2020). Growing-season direct radiation did not survive variable selection, so the shading pathway is represented by northness.'}
::: {.cell-output-display}


|                            |Term                                         |   Beta|     z|        p|
|:---------------------------|:--------------------------------------------|------:|-----:|--------:|
|Mechanism 1: shading        |Northness (shading surrogate)                | +0.382|  23.2|  < 1e-16|
|Mechanism 2: host density   |Standing volume                              | +0.381|  15.6|  < 1e-16|
|                            |Live stems per hectare                       | -0.099|  -5.4| 8.29e-08|
|                            |Crown closure                                | -0.183|  -9.0|  < 1e-16|
|Mechanism 3: host size      |Quadratic mean diameter                      | -0.422| -18.4|  < 1e-16|
|                            |Susceptible pine basal area                  | +0.459|  32.4|  < 1e-16|
|Terrain                     |Flight-window direct radiation               | +0.487|  17.2|  < 1e-16|
|                            |Terrain ruggedness index                     | -0.036|  -1.5|    0.124|
|                            |Windward-leeward index                       | +0.358|  12.4|  < 1e-16|
|                            |Elevation                                    | +0.329|  18.2|  < 1e-16|
|Radiation and exposure      |Density x terrain exposure, no radiation     | +0.311|  19.2|  < 1e-16|
|                            |Density x terrain exposure, with radiation   | +0.221|  10.6|  < 1e-16|
|Resolution decides the sign |Density x wind, annual (M5)                  | +0.031|   2.1|   0.0364|
|                            |Stem density x wind, 16-day (E1)             | -0.094| -11.7|  < 1e-16|
|                            |Standing volume x wind, 16-day (E1)          | -0.041|  -5.0| 4.91e-07|
|                            |Standing volume x wind, 16-day with lag (E2) | -0.039|  -2.7|  0.00726|


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
|M0 host size + shading + landform | 49,547| 2,307| 0.416|    128.3| 0.346| 0.173|    0.523| 0.771|0.211       |
|M1 + stand density                | 49,049| 1,809| 0.412|    127.3| 0.342| 0.170|    0.518| 0.775|0.223       |
|M2 + terrain and flight radiation | 48,305| 1,065| 0.409|    126.2| 0.336| 0.167|    0.510| 0.784|0.237       |
|M3 + interactions                 | 47,240|     0| 0.404|    124.7| 0.327| 0.163|    0.498| 0.798|0.256       |


:::
:::


## Appendix S3


::: {.cell tbl-cap='**Appendix S3.** Moderate-to-high beetle disturbance by year inside the study perimeter.'}
::: {.cell-output-display}


|Year |  Cells| Moderate-to-high (%)|
|:----|------:|--------------------:|
|2006 | 15,339|                  4.5|
|2007 | 15,340|                  5.6|
|2008 | 15,340|                 20.2|
|2009 | 15,340|                 11.5|
|2010 | 15,322|                 15.5|
|2011 | 15,340|                 13.3|
|2013 | 15,339|                 14.2|
|2014 | 15,340|                 15.1|


:::
:::


## Appendix S4


::: {.cell tbl-cap='Stand structure across the study perimeter, from the Vegetation Resources Inventory. n is cell-years. SD is the standard deviation of the landscape; SE is the standard error of the mean and is small by construction at this n, so it is not precision about any one cell. Skewness and kurtosis are the bias-corrected third and fourth standardised moments; kurtosis is excess, so 0 is Gaussian.'}
::: {.cell-output-display}


|Attribute                           |       n|   Mean|     SD|    SE| Median|   Min|     Max| Skewness| Kurtosis|
|:-----------------------------------|-------:|------:|------:|-----:|------:|-----:|-------:|--------:|--------:|
|Stand basal area (m2/ha)            | 122,700|  35.18|  11.84| 0.034|  37.06|  2.08|   64.26|    -0.77|    +0.49|
|Crown closure (%)                   | 122,700|  45.32|  13.55| 0.039|  48.00|  4.00|   60.00|    -1.31|    +1.29|
|Live stems (n/ha)                   | 122,700| 670.00| 256.78| 0.733| 686.00| 64.00| 1614.00|    +0.33|    +1.22|
|Quadratic mean diameter (cm)        | 122,700|  30.13|   7.19| 0.021|  30.32| 13.48|   62.35|    +0.54|    +1.39|
|Stand age (years)                   | 122,700| 125.22|  26.47| 0.076| 124.00| 20.00|  184.00|    -1.39|    +3.48|
|Stand height (m)                    | 122,700|  28.07|   6.05| 0.017|  29.00|  7.70|   41.60|    -0.70|    +1.79|
|Standing volume (m3/ha)             | 122,700| 283.40| 129.22| 0.369| 292.90|  0.90|  620.32|    +0.00|    -0.02|
|Lodgepole pine cover (%)            | 122,700|  17.36|  22.82| 0.065|  10.00|  0.00|  100.00|    +1.63|    +2.09|
|Susceptible pine basal area (m2/ha) | 122,700|   5.45|   7.03| 0.020|   3.24|  0.00|   31.67|    +1.52|    +1.86|


:::
:::


## Appendix S5


::: {.cell tbl-cap='Moderate-to-high beetle disturbance by quadratic mean diameter class, on the balanced sample. The 25 cm boundary is the source-sink threshold of the species\' bionomics. Intervals are Wilson score intervals on the class proportion. Note that 30 m cells in a spreading outbreak are not independent, so the accompanying tests are anti-conservative.'}
::: {.cell-output-display}


|QMD class (cm) |      n| Attacked| Attacked (%)| 95% CI (%)|
|:--------------|------:|--------:|------------:|----------:|
|<15            |    736|      232|         31.5|  28.3-35.0|
|15-20          |  2,371|      564|         23.8|  22.1-25.5|
|20-25          |  7,058|    2,559|         36.3|  35.1-37.4|
|25-30          | 14,634|    6,717|         45.9|  45.1-46.7|
|30-40          | 18,902|    4,639|         24.5|  23.9-25.2|
|>40            |  3,627|      617|         17.0|  15.8-18.3|


:::
:::


# References
