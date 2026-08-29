---
title: "Testing the wind disruption hypothesis for beetle refugia"
subtitle: "Stand density, terrain shape and flight-window wind as competing controls on mountain pine beetle attack (Dendroctonus ponderosae) in the Selkirk Mountains of British Columbia"
author:
  - name: Seamus Murphy
    orcid: 0000-0002-1792-0351
    email: seamusrobertmurphy@gmail.com
# Journal of Applied Entomology requires exactly six keywords and states that they
# "should not include words in the title". The title carries testing, wind, disruption,
# hypothesis, beetle and refugia, so none of those may appear here. The earlier set
# broke that rule three times over.
keywords:
  - Dendroctonus ponderosae
  - Landsat time series
  - stand density
  - geomorphometry
  - temporal resolution
  - pheromone communication

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
# Journal of Applied Entomology requires APA 6th: "References should be prepared
# according to the Publication Manual of the American Psychological Association (6th
# edition)". Both drafts carried the Springer style until 2026-08-28, and apa-6th-edition.csl
# had been sitting unused in 04.references since 20 August. Note that apa.csl in the same
# folder is APA FIFTH edition despite its name.
csl: ../04.references/apa-6th-edition.csl
df-print: kable
---

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



::: {#tbl-inventory .cell tbl-cap='The datasets this study combines, with the structure and resolution of each. Every count is read from the files at render time. Spatial resolution is the grid the variable is analysed on; temporal resolution is the interval at which it varies. Note that the response varies every 16 days, the inventory once a year and the terrain not at all, which is the asymmetry the wind analysis turns on.'}
::: {.cell-output-display}


|Dataset                    |Source                                         |Variables                                                       |Spatial resolution          |Temporal resolution            |Period                      |                     n|
|:--------------------------|:----------------------------------------------|:---------------------------------------------------------------|:---------------------------|:------------------------------|:---------------------------|---------------------:|
|Beetle disturbance, annual |Landsat 5 and 8 Collection 2 Level-2           |Moderate-to-high disturbance, binary, from NDMI                 |30 m                        |1 year                         |2005-2014, excluding 2012   |               8 years|
|Beetle disturbance, 16-day |Landsat 5 and 8 Collection 2 Level-2           |Moderate-to-high disturbance, binary, from NDMI                 |30 m                        |16 days, the sensor's repeat   |2006-2014                   |             60 epochs|
|Stand structure            |VRI Historical, BC Data Catalogue              |Basal area, volume, stems, quadratic mean diameter, age, height |Polygon, rasterised to 30 m |1 year, projected to each year |2005-2014                   |           9 snapshots|
|Terrain                    |NRCan High Resolution DEM, indices by SAGA GIS |29 geomorphometric surfaces incl. radiation, exposure, landform |30 m                        |Static                         |n/a                         |           29 surfaces|
|Station wind               |Environment and Climate Change Canada          |Speed and direction                                             |4 to 7 valley stations      |1 hour                         |2005-2014, May to September | 236079 hourly records|
|Terrain-resolved wind      |MicroMet over the DEM, driven by station wind  |Weighting factor, modified speed, diverted direction            |30 m                        |16 days, and 1 year            |2005-2014                   |     16 direction bins|
|Modelling table, annual    |Assembled by 38-assemble-model-data.R          |Response and every covariate, one row per cell-year             |30 m                        |1 year                         |2005-2014, excluding 2012   |     122700 cell-years|
|Modelling table, 16-day    |Assembled by 45-epoch-model-data.R             |Response and every covariate, one row per cell-epoch            |30 m                        |16 days                        |2006-2014                   |     71127 cell-epochs|


:::
:::



# Abstract {.unnumbered}


::: {.cell}

:::


Refugia from mountain pine beetle (*Dendroctonus ponderosae* Hopkins) are hypothesised to
form where stands are thin enough for wind to disrupt the pheromone plume coordinating mass
attack. The hypothesis names topographic shading, low host density and few large-diameter
hosts, and none has been fitted. We tested all three over 5,573 ha of the Selkirk
Mountains, British Columbia, at 30 m across 914 m of relief, using Landsat
at its 16-day repeat: 59 epochs across 8 outbreak years,
71,127 cell-epochs. Predictors were inventory stand structure,
29 geomorphometric surfaces, solar radiation computed separately for the
flight window and the growing season, and a terrain-resolved wind field from the MicroMet
model driven by hourly station data for each epoch's own sixteen days.

The wind-disruption mechanism was supported. Stand density interacted negatively with wind,
-0.094 for stem density (p < 0.001) and -0.041 for standing
volume (p < 0.001), and both survived a within-season spread term carrying
+0.672. Host held through standing volume, +0.381,
and attack peaked at
45.9 per cent at 25 to 30 cm
diameter, the source-sink threshold. Topographic shading failed on its surrogate: growing-season
radiation did not survive selection, and northness, which correlates
-0.834 with it, is +0.382, so shaded ground
carries more attack.

Temporal resolution decided the outcome. With one map a year, the same wind field, covariates
and threshold gave +0.031 (p = 0.036), the opposite sign. Two further
specification tests showed why proxies mislead here: flight-window radiation cut the density
by terrain-exposure interaction from +0.311 to +0.221 without changing its
sign, and previous-year pressure left valley depth at 0.50 of its value
while mid-slope position moved to 1.32. A wind test aggregated to the year answers a different question from the one
the mechanism poses, and answers it wrongly.

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins) has killed more lodgepole pine
(*Pinus contorta* Douglas ex Loudon) in British Columbia than any other agent on record
[@taylor2003; @sambaraju2021]. An outbreak never kills a landscape evenly. The patches that survive carry the forest's
structure and seed into whatever comes next, and those patches have a name: disturbance
refugia, places buffered from disturbance over time [@krawchuk2020]. Finding a refugium is
not the same as explaining one. Explanation needs a mechanism that ties survival to
something measurable on the ground, such as terrain, soil or the structure of the stand
itself [@cartwright2018].

@krawchuk2020 proposed such a mechanism: refugia could occur "in areas with cooler
temperatures (eg from topographic shading) that protect trees from water stress; in areas
with lower host density, allowing for greater wind disruption of beetle pheromone
communication and more vigorous tree growth and chemical defenses; and in areas with fewer
large-diameter host trees". That is three mechanisms, two of which act through terrain. None has been fitted to a map.
Of the studies our screen retained, one enters a wind term at all, and it is a companion
study on this same landscape whose response is conifer regeneration rather than beetle
attack [@murphy2026].

The wind half is a claim about canopy, not open air. @cartwright2018 is the one retained study designed
to model what controls an insect refugium, and it located refugia in stands of low basal
area, reasoning that "thinner stands also increase wind penetration, helping to disperse
beetle pheromones and disrupt chemical communications needed to coordinate attacks." @powell2014 state the converse as the
condition for outbreak: "higher local host density, which minimizes pheromone plume
dispersion, reduces wind, and promotes successful switching to nearby hosts, positively
influences outbreak propensity." A model that controls stand density out and then reads a
terrain coefficient as a wind effect has removed the pathway it set out to test.

Terrain acts through more than airflow. Flight has a temperature window: the beetle flies
between 19 and 41 degrees C, and mostly between 22 and 32, and "most flights occur on bright sunny days, and peak flight is in
the early to mid afternoon" [@safranyik2006chap1; @mccambridge1971]. Radiation during the
flight window is therefore a different quantity from radiation across the season, and the
season quantity is the one the shading pathway concerns. Light, temperature and wind are not
competing explanations but one bundle. Stand density governs "tree vigour and within-stand
microclimate, which in turn influence success of bark beetle dispersal, host selection, attack
or brood development" [@safranyik2006chap1]; @bartos1989 set the two halves of that bundle
against each other in their own title, microclimate against tree vigour. A third route leads
to the same place. Cool sites slow development enough to push the beetle onto a two-year
cycle [@sambaraju2021]. So shade and vigour both predict less attack on cool ground, by
routes this design cannot separate.

Two further constraints decide what a wind term can be measured over, and both are
temporal rather than spatial. The first is the day. @gray1972 recorded emergence in
*D. ponderosae* against ambient temperature and found that on days whose maximum stayed
within optimal limits, emergence "began when temperatures rose above 20' C, then increased
in the morning hours with increasing temperatures, and ceased in the afternoon at about the
same threshold temperature", with "Peak emergence occurred between 11 a. m. and 2 p. m.
when 61 percent (232 out of 379) of the beetles were collected". They also record "the
sharp decline in activity which occurred when ambient temperatures exceeded 30' C". Flight
is therefore gated at both ends and confined to a few hours, and a daily or monthly mean
wind speed averages across hours in which no beetle is flying.

The second is the season, and it is a population constraint rather than an individual one.
Mass attack is a threshold phenomenon: @howe2022 conclude that "a combination of
stand-level spatial aggregation, behavioral shifts, and higher quality of attainable hosts
defines a critical threshold beyond which continual population growth becomes
self-driving", and @cooke2025 define the irruption threshold as "the population density at
which endemic populations may transition towards the epidemic state". @carroll2004bionomics
place the same argument on the thermal side, requiring "thermal environments conducive to
overwintering survival and with sufficient heat accumulation to maintain a synchronous
univoltine life cycle". Two things follow for this design. Attack in one year is not
independent of attack in the year before, which is why previous-year and neighbourhood
pressure enter the models. And an environmental variable that acts on this system acts by
regulating that threshold rather than by adding to attack: @cooke2025 report that "in every
study where an Allee effect was demonstrated, investigators also identified at least one
extrinsic environmental factor (e.g., winter weather, summer drought, microclimatic effect)
that was regulating its strength". A wind effect on mass attack is therefore expected as an
interaction with host density, which is what this study fits, and not as a main effect.

How far the insect travels decides what a wind variable can be measured over, and the
distances are larger than a within-stand argument implies. @jackson2008 tracked mountain
pine beetle on weather radar during the 2005 emergence in central British Columbia and
confirmed the returns by towing a capture net behind an aircraft through the volume the
radar was watching. They found beetles "at altitudes up to more than 800 m above the forest
canopy", estimated that those in flight above the canopy "may move 30--110
km$\cdot$day$^{-1}$", and put the instantaneous density at a mean of 4950 and a maximum of
18\,600 beetles per hectare. @ainslie2010 reproduced that above-canopy dispersion with an
atmospheric dispersion model driven by the same radar. An insect carried in the lower
atmosphere at those heights meets the weather of the whole period. It does not meet the
breeze inside one stand during the few hours it happens to leave the bark. The wind variable
in this study is named and measured accordingly.

No product reports the wind the hypothesis concerns, an instantaneous below-canopy speed at
flight height during the flight period. Gridded climatologies report a long-run mean at 10 m
over open ground and are downscaled over a digital elevation model, making them partly a
transform of the terrain offered alongside them [@badger2014; @davis2023]. Nor does the
literature state the interval over which wind should be summarised. We therefore take wind
from station observations of each 16-day period, modify it over the terrain with the MicroMet
model [@liston2006], and test the response at Landsat's own 16-day repeat rather than annually.

@tbl-hypotheses gives the direction expected of each attribute and the reasoning behind it.
This study asks five questions. Does stand density predict moderate-to-high disturbance, as
the pheromone mechanism requires? Does topographic shading predict it, against the competing
microclimate and adaptive-seasonality arguments? Does terrain shape predict it once density
and radiation are already in the model? Is the density effect conditional on wind, which is
the form the mechanism actually takes? And how much of the answer depends on the interval the
response is measured over?


::: {#tbl-hypotheses .cell tbl-cap='Landscape attributes entered in this study, the direction expected of each, and the reasoning behind that expectation.'}
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


# Materials

## Study area


The study area is 5,573 ha of the Selkirk Mountains in southeastern British
Columbia, 61,923 cells at 30 m, spanning 830 to
1,744 m and 914 m of relief.

The coordinate reference system is EPSG:3153, NAD83(CSRS) / BC Albers. This is the parent study's
grid, adopted so that results are directly comparable to it: "All disturbance and covariate
rasters were aligned to a common 30 m grid in EPSG:3153, the native resolution of the
Landsat-derived dNBR and dNDMI products", and "The plot anchor was georeferenced with a
handheld GPS receiver in EPSG:3153" [@murphy2026].

The perimeter is anchored on the 2015 Mt Midgeley fire, 480 ha, which is the
parent study's site. That study reports its site as spanning "elevations from 830 to 1744 m
a.s.l."; the digital elevation model used here returns 856 to
1,744 m inside the same perimeter, which reproduces the statement. The present
study expands beyond that hard boundary, because 480 ha cannot carry the stand-density
contrast the pheromone mechanism runs on. It does not expand arbitrarily: the perimeter is the
burn buffered 5 km and then cut to the elevation band the parent's site occupies, so the
added ground is ecologically the same kind of ground. Without that cut a 1 km buffer already
reaches the Kootenay Lake surface at 534 m, which is not a site elevation.


::: {.cell}
::: {.cell-output-display}
![Landscape, terrain and stand surfaces across the study area, all EPSG:3153 at 30 m over Esri World Shaded Relief. (a) elevation; (b) terrain ruggedness index; (c) windward-leeward index at the prevailing bearing; (d) flight-window direct radiation, the thermal gate on flight; (e) growing-season direct radiation, the shading pathway; (f) the MicroMet wind weighting factor at the prevailing bearing; (g) stand basal area; (h) quadratic mean diameter, whose 25 cm source-sink threshold falls near the midpoint of the scale; (i) live stems per hectare. The white outline is the study perimeter and the red outline the 2015 Mt Midgeley burn. Contours are at 200 m. Every panel carries its own north arrow and the same numerical scale, 1:150,000, which holds at a printed panel width of 66 mm.](beetle-topography-wind-study-short_files/figure-html/fig-study-area-1.png){#fig-study-area width=2250}
:::
:::




## Beetle disturbance


The response is annual moderate-to-high beetle disturbance, classified from Landsat
normalised difference moisture index by the method of the parent study and rebuilt for this
project. It covers 8 outbreak years, 2006 to 2014,
excluding 2012, the one year covered only by Landsat 7, which has flown with its scan-line
corrector off since May 2003. Annual prevalence inside the perimeter runs
4.5 to 20.2 per
cent, pooled 12.5 per cent over 122,700 cell-years.

Years are never unioned. Unioning destroys the year-to-year spread this study measures, and
the union layer over the wider grid reached 73 per cent of the landscape, which is not
credible for a beetle outbreak.

The provincial aerial overview survey is not used as a response and supplies no training
label. It is retained only as a visual check.


::: {#tbl-prevalence .cell tbl-cap='Moderate-to-high beetle disturbance by year inside the study perimeter.'}
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


## Stand structure


Stand structure comes from the provincial Vegetation Resources Inventory layer
`VEG_COMP_LYR_R1_POLY`, retrieved by web feature service over the perimeter. Six attributes
carry the mechanism and the stem-size threshold: total basal area, crown closure, live stems per
hectare, quadratic mean diameter over stems 12.5 cm and up, stand age, and susceptible pine
basal area formed as total basal area times the pine share of cover.

78.3 per cent of cell-years sit at or above the
25 cm source-sink threshold.


::: {#tbl-vri .cell tbl-cap='Stand structure across the study perimeter, from the Vegetation Resources Inventory. n is cell-years. SD is the standard deviation of the landscape; SE is the standard error of the mean and is small by construction at this n, so it should not be read as precision about any one cell. Skewness and kurtosis are the bias-corrected third and fourth standardised moments; kurtosis is excess, so 0 is Gaussian and positive is heavy-tailed.'}
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


The inventory is a projected operational product, not a census, and its polygons here carry
reference years spanning several decades. A polygon interpreted from late-outbreak
photography describes a stand the beetle had already worked through, so basal area and pine
cover are post-attack for part of the window. There is no unattacked vintage, so this is
reported rather than corrected, and @sec-limits returns to it.

## Geomorphometry

Terrain is described by 29 geomorphometric surfaces computed with SAGA GIS
over the full reprojected elevation model and clipped afterwards, so a search radius near the
boundary sees real ground.

Radiation is computed twice because two mechanisms need it. Flight-window insolation is direct
and diffuse radiation over 1 July to 15 August restricted to 12:00 to 17:00, the hours
@safranyik2006chap1 identify as the flight peak; growing-season insolation is the whole-day
total from 1 May to 30 September, the shading quantity @krawchuk2020's first mechanism
concerns. A single annual heat index cannot separate them: flight-window direct radiation
spans a 7-fold range
here against 2.6-fold for
the season total.

Exposure enters as the windward-leeward index and effective air flow height at the prevailing
bearing, the omnidirectional wind exposition index, the wind shelter index and topographic
openness. Shape enters as terrain ruggedness, vector ruggedness, topographic position and its
multi-scale form, convergence, slope, curvature and geomorphon class. Landform enters as
topographic wetness, valley depth, height above the valley floor, normalised height and
mid-slope position, because infested groups are reported in draws and gullies and deep snow
insulates overwintering brood [@safranyik2006chap1]. Aspect enters as its northward and
eastward components with the heat load index of @mccune2002.

One distinction matters. The strongest aspect statements in @safranyik2006chap1 concern the
aspect of the bole, not the slope, and are within-tree effects a 30 m raster cannot measure.
Nothing here tests them.

## Terrain-resolved wind {#sec-micromet}


::: {.cell}

:::


Station wind interpolated from four to seven valley stations is nearly flat within a year, so
wind is also computed as a field varying in space, using the MicroMet model of @liston2006.
WindNinja, the usual tool, ships no macOS binary. MicroMet's wind component is seven equations
rather than a program, implemented directly with the paper's equation numbers against each.

Terrain slope $\beta$ and slope azimuth $\xi$ come from the elevation model (@liston2006,
their equations 12 and 13). Curvature $\Omega_c$ is a cell's elevation minus the mean of the
two opposite cells one curvature length scale away, taken on four direction lines and
averaged (their equation 14); the length scale is estimated as the first lag at which
elevation autocorrelation falls below 0.5, which is 600 m here. Writing $\theta$ for the
wind bearing, the slope in the wind direction is

$$\Omega_s = \beta \cos(\theta - \xi)$$ {#eq-slope}

with $\Omega_s$ and $\Omega_c$ each scaled to $[-0.5,\,0.5]$. The terrain weighting factor
applied to the observed speed $W$ is

$$W_w = 1 + \gamma_s \Omega_s + \gamma_c \Omega_c, \qquad \gamma_s = \gamma_c = 0.5$$ {#eq-weight}

giving the terrain-modified speed

$$W_t = W_w W$$ {#eq-speed}

and a diversion of the wind direction of

$$\theta_d = -\tfrac{1}{2}\, \Omega_s \sin\!\left[2(\xi - \theta)\right].$$ {#eq-divert}

By @eq-weight, $W_w$ depends on direction and not on speed, so it is computed once for each of 16 direction bins
and each hourly observation multiplied by the surface for its own bin; nothing is averaged
before the terrain acts on it. Over all bins $W_w$ runs 0.60 to
1.38. Speed and direction combine as components because averaging
degrees across the 360/0 line is meaningless. The field varies
1.9 to
2.8 km/h across the grid within a year, and is not a
repackaged terrain index: it correlates +0.153 with the
windward-leeward index and +0.124 with flight
radiation. Its strongest association is with elevation,
+0.326.

## Flight-window wind

The flight window is 1 July to 15 August and the hours 12:00 to 17:00, and neither bound
was chosen from these data. The dates are the flight period @safranyik2006chap1 give for
this region; the hours follow their "peak flight is in the early to mid afternoon" and
@gray1972's 11:00 to 14:00 emergence peak, taken here to the later side because emergence
precedes the flight it initiates. Because the window is fixed a priori it can be checked
against the landscape's own climate, and @fig-flight-window does that. Across
236,079 hourly station records from May to September of the nine study years,
89.5 per cent of afternoon hours inside the window fall within
the 19 to 41 degrees C flight gate, against 51.4 per cent
outside it, and the afternoon mean is 26.0 against
19.2 degrees C. The window therefore roughly doubles the share
of hours in which flight is thermally possible. It is worth noting what the same figure
shows about wind: mean speed peaks in the same hours as temperature, at
10.4 km/h in mid-afternoon against
4.6 km/h at dawn, so the hours the beetle can fly are also the
windiest of the day. That is a coincidence of timing the mechanism depends on and no
annual summary can express.

Station wind is Environment and Climate Change Canada hourly records, reduced only at the
last step into monthly means for June, July and August and four flight-window metrics for
1 July to 15 August: mean speed, the 95th percentile, and the fractions of hours below
5 km h and above 15 km h.

Hourly readings buy detail, not independent observations. With one map a year, every hour
of wind collapses into one of 8 numbers per metric, so the model has only
8 distinct wind values to work with and a wind coefficient rests on those
alone. Its standard error will look small and should not be believed. Stand
density varies cell to cell; a season's wind does not. That asymmetry is why the annual
models report an interaction rather than a main effect, and why the response was rebuilt at
16 days.


::: {.cell}
::: {.cell-output-display}
![The flight window against the landscape's own climate, from hourly Environment and Climate Change Canada station records for May to September of the nine study years. The window, 1 July to 15 August, is the shaded band; it is taken from the bionomics and is not fitted to these data. (a) Mean afternoon temperature by day of year, with the 19 to 41 degrees C flight gate and the 22 to 32 degrees C peak band marked. (b) The share of afternoon hours falling inside the flight gate, day by day. (c) The diurnal curve: mean temperature and the share of all hours inside the gate, by hour, with the 12:00 to 17:00 restriction shaded. (d) Mean wind speed by hour, on the same axis, showing that the hours the beetle can fly are also the windiest of the day.](beetle-topography-wind-study-short_files/figure-html/fig-flight-window-1.png){#fig-flight-window width=2250}
:::
:::


# Methods

## Variable selection {#sec-selection}


The candidate set is 45 variables in six groups, one group per pathway the review
names: stand density, host quality, terrain exposure to wind, terrain shape, landscape
context, and flight-window wind. Selection proceeds in four
stages and is required to retain at least one variable from each pathway, so that a
collinearity filter cannot silently delete a hypothesis the review established.

Fitting uses a class-balanced sample of 47,328 cell-years, 4,000 of each
class per year. Landscape prevalence is about 12 per cent, and an
unbalanced fit at that prevalence reports the intercept rather than the covariates.

## Models


Every model is a logistic regression of moderate-to-high disturbance $y_{it}$ in cell $i$
and year $t$ on standardised covariates,

$$\operatorname{logit}\Pr(y_{it}=1) = \alpha + \mathbf{x}_{it}^{\top}\boldsymbol{\beta}
+ \gamma_{g(i)} + \sum_{k} \delta_k\, z_{k,it}$$ {#eq-model}

where $\gamma_{g(i)}$ is the effect of the geomorphon landform class $g$ of cell $i$ and the
$z_{k,it}$ are the interaction terms. Coefficients are therefore log-odds per standard
deviation. Four models are fitted, each adding one claim to the last, so that every term's
contribution is visible as a change in fit rather than asserted.

M0 carries Krawchuk's first and third mechanisms together with landform context: host size,
topographic shading, and the terrain that governs where cold air and snow collect. M1 adds
stand density, the second of Krawchuk's mechanisms, which is objective 1. M2 adds terrain shape,
terrain exposure to wind, and flight-window radiation, which are objectives 3 and 4. M3 adds
the interactions objective 4 requires: stand density by terrain exposure, by flight-window
radiation, and by flight-window wind.

# Results {#sec-results}



::: {#tbl-aic .cell tbl-cap='Model comparison, panel A of the model table. Each model adds one pathway to the previous. AIC ranks on likelihood and a parameter penalty; the remaining columns are predictive error on the fitted probabilities. RMSE is the root mean squared error and is the square root of the Brier score; RMSE (%) expresses it against the prevalence of the response. Brier skill is the improvement over predicting the prevalence for every cell, where 0 is no better than the base rate. MAPE and Theil\'s U are not reported: both divide by the observed value, which is zero for the majority class of a binary response, so both are undefined without discarding that class.'}
::: {.cell-output-display}


|Model                             |    AIC|  ΔAIC|  RMSE| RMSE (%)|   MAE| Brier| Log loss|   AUC|Brier skill |
|:---------------------------------|------:|-----:|-----:|--------:|-----:|-----:|--------:|-----:|:-----------|
|M0 host size + shading + landform | 49,547| 2,307| 0.416|    128.3| 0.346| 0.173|    0.523| 0.771|0.211       |
|M1 + stand density                | 49,049| 1,809| 0.412|    127.3| 0.342| 0.170|    0.518| 0.775|0.223       |
|M2 + terrain and flight radiation | 48,305| 1,065| 0.409|    126.2| 0.336| 0.167|    0.510| 0.784|0.237       |
|M3 + interactions                 | 47,240|     0| 0.404|    124.7| 0.327| 0.163|    0.498| 0.798|0.256       |


:::
:::



::: {#tbl-m3 .cell tbl-cap='Full model M3, panel B of the model table: continuous terms, ordered by absolute effect. Coefficients are log-odds per standard deviation on a class-balanced sample, so the intercept is not landscape prevalence. SE is the standard error of the coefficient. The geomorphon landform classes are also in this model and are not reported here.'}
::: {.cell-output-display}


|Term                                        |   Beta|    SE|      z|       p|
|:-------------------------------------------|------:|-----:|------:|-------:|
|Flight-window direct radiation (kWh/m2)     | +0.487| 0.028|  17.21| < 0.001|
|Susceptible pine basal area (m2/ha)         | +0.459| 0.014|  32.40| < 0.001|
|Quadratic mean diameter (cm)                | -0.422| 0.023| -18.35| < 0.001|
|Northness                                   | +0.382| 0.016|  23.19| < 0.001|
|Standing volume (m3/ha)                     | +0.381| 0.024|  15.61| < 0.001|
|Windward-leeward index                      | +0.358| 0.029|  12.37| < 0.001|
|Elevation (m)                               | +0.329| 0.018|  18.20| < 0.001|
|Live stems x Windward-leeward index         | +0.221| 0.021|  10.63| < 0.001|
|Stand age (years)                           | +0.218| 0.018|  11.89| < 0.001|
|July mean wind (km/h)                       | +0.215| 0.012|  17.84| < 0.001|
|Valley depth (m)                            | -0.193| 0.022|  -8.70| < 0.001|
|Crown closure (%)                           | -0.183| 0.020|  -9.02| < 0.001|
|Live stems x Flight-window direct radiation | -0.144| 0.017|  -8.58| < 0.001|
|June mean wind (km/h)                       | +0.107| 0.012|   8.66| < 0.001|
|Live stems (n/ha)                           | -0.099| 0.018|  -5.36| < 0.001|
|Topographic wetness index                   | +0.073| 0.019|   3.74| < 0.001|
|Mid-slope position                          | +0.063| 0.013|   4.69| < 0.001|
|Vector ruggedness measure                   | -0.043| 0.019|  -2.21|   0.027|
|Topographic position index                  | +0.040| 0.023|   1.77|   0.076|
|Profile curvature                           | -0.038| 0.012|  -3.04|   0.002|
|Terrain ruggedness index                    | -0.036| 0.023|  -1.54|   0.124|
|Convergence index                           | -0.029| 0.014|  -2.07|   0.038|
|Live stems x June mean wind                 | -0.001| 0.013|  -0.12|   0.905|


:::
:::


Every pathway earns its place: AIC falls 498 when stand density
enters, 744 more with terrain and flight radiation, and
1,065 more with the interactions (@tbl-aic).

The three measures of stand density do not agree. Standing volume carries
+0.381 log-odds per standard deviation, stem count
-0.099, and crown closure -0.183
(p < 0.001). The last two are negative, so as main effects the three
density measures disagree in sign. Only standing volume rises with attack, which is the
direction a plume-holding canopy implies.
Total basal area did not survive selection, its univariate discrimination being
0.516. What predicts attack is standing wood
in large stems, not how many stems there are.

Radiation enters once. Flight-window direct radiation carries +0.487,
which is the thermal gate on flight. Growing-season radiation did not survive selection, so
the shading pathway is carried by northness, with which it correlates
-0.834. Northness is +0.382: shaded,
north-facing ground carries more attack, against the prediction.

Terrain predicts attack independently of both. The windward-leeward index is
+0.358 and elevation +0.329, while ruggedness is -0.036
and not distinguishable from zero (p = 0.124), the vector ruggedness measure agreeing
in sign at -0.043.
Ruggedness takes the opposite sign to the parent study's, whose response is seedling
establishment rather than attack [@murphy2026].

Fitted without flight-window radiation, stand density interacts with terrain exposure at
+0.311, which reads as a wind result pointing the wrong way. With radiation in the
model that interaction is +0.221 (p < 0.001) and density interacts with
radiation at -0.144. On a range whose prevailing bearing is
258 degrees the windward slopes face west, which are also the slopes
taking afternoon sun, so part of the apparent exposure effect was the sun. Not all of it:
the interaction stays positive and far from zero, which is the wrong sign for pheromone
disruption.


::: {.cell}
::: {.cell-output-display}
![The refugia mechanism as fitted. (a) Predicted probability of moderate-to-high disturbance against terrain-resolved epoch wind, at the 10th and 90th percentiles of stem density, all other terms held at their means; the lines cross, so wind raises attack in thin stands and lowers it in dense ones, which is the interaction. (b) The same for standing volume. (c) Coefficients of the 16-day model, with and without the within-season spread term. (d) Epoch prevalence against epoch mean wind, one point per epoch.](beetle-topography-wind-study-short_files/figure-html/fig-interaction-1.png){#fig-interaction width=2700}
:::
:::


## Wind as a measurement {#sec-micromet-result}


::: {#tbl-micromet-model .cell tbl-cap='The wind terms under two specifications, both with previous-year pressure in the model. M4 carries station wind, which is flat within a year and identified only across years. M5 carries the terrain-resolved MicroMet field, which varies within the year and is identified in space.'}
::: {.cell-output-display}


|Model                    |Term                                     |Beta   |     z|       p|
|:------------------------|:----------------------------------------|:------|-----:|-------:|
|M4 station wind          |June mean wind (km/h)                    |-0.002 | -0.09|   0.926|
|M4 station wind          |Live stems x June mean wind              |+0.020 |  1.16|   0.247|
|M5 terrain-resolved wind |MicroMet flight-window wind (km/h)       |+0.467 | 28.44| < 0.001|
|M5 terrain-resolved wind |Live stems x MicroMet flight-window wind |+0.031 |  2.09|   0.036|


:::
:::


This section reports the same wind field at the annual resolution the study first used, and
it is retained because the contrast with the 16-day models is the paper's methodological
result.

The terrain-resolved field carries +0.467 log-odds per standard deviation
(z = 28.44, p < 0.001) when the response is one map per year. Windier ground
carries more moderate-to-high disturbance. The interaction the mechanism turns on is
+0.031 (z = 2.09, p = 0.036), positive where the
pheromone-disruption mechanism requires negative.

At 16 days the same wind field, the same covariates and the same classification threshold
give -0.094 and -0.041. Nothing about the landscape or the
wind product changed between the two. What changed is that an annual response can only ask
whether windy summers carry less attack than calm ones, and a summer contains both windy and
calm weeks. Averaging across them destroys exactly the contrast the mechanism operates on.

The station terms behave the same way and for the same reason. In this specification they
collapse to jun at -0.002, which carries no flight-window information at all.

The lesson generalises past this dataset. The mechanism concerns a plume that persists for
minutes, acting on a flight period of weeks. A test that aggregates the response to a year is
not a weaker version of the right test; it is a different question, and this study answers it
in the opposite direction.

## Previous-year pressure {#sec-autologistic}

Attack recurs where it was, by a margin that changes how every other coefficient reads. A cell
attacked one year is between
16
and
139
times more likely to be attacked the next. Entering persistence and 90 m spread separately,
after the autologistic design used for this province, gives +0.873 and
+0.950, raising discrimination from 0.799 to
0.888.

Which environmental terms survive is the informative part. Ruggedness keeps 0.61
of its value, a term describing a condition a cell has whether or not the beetle was there.
The landform terms are not stable: valley depth keeps 0.50 while mid-slope
position moves to 1.32, growing rather than shrinking. Part of what
the landform terms measured was where the outbreak had already been, which is the same
failure the terrain-wind index showed against radiation, one level up.

## Host as diameter {#sec-diameter}



::: {#tbl-qmd .cell tbl-cap='Moderate-to-high beetle disturbance by quadratic mean diameter class, on the balanced sample. The 25 cm boundary is the source-sink threshold of the species\' bionomics. Intervals are Wilson score intervals on the class proportion, which is why they are asymmetric in the smallest class. Note that 30 m cells in a spreading outbreak are not independent, so the tests reported beneath this table are anti-conservative.'}
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


Coding host as diameter changes the picture cover alone gives. Attack peaks in the
25 to 30 cm class at
45.9 per cent and falls away
above it, to 24.5 per cent at 30
to 40 cm and 17.0 per cent above 40
(@tbl-qmd). The step across the 25 cm source-sink boundary is from
36.3 to
45.9 per cent.

In the full model diameter carries -0.422 per standard deviation
(z = -18.35). It is negative because the relationship is not monotone: a
linear term fitted through a humped response returns the slope of its falling limb, which
is the larger part of the range. The class table, not the coefficient, is the result here,
and the point stands, because a stand's cover says nothing about whether its stems can
produce brood.

The pattern is not an artefact of the class boundaries. Across all six classes attack
depends on diameter class, $\chi^2$ = 2271.7 on 5 degrees of
freedom, p < 0.001, with Cramer's V = 0.219. The step
across the 25 cm source-sink boundary specifically, from the 20 to 25 class to the 25 to 30
class, is +9.6 percentage points, 95 per cent confidence
interval 8.3 to 11.0, p
< 0.001. With 47,328 cells a chi-square is significant on
trivial differences, which is why the effect size is quoted beside it, and 30 m cells in a
spreading outbreak are not independent, so both p-values are anti-conservative.

The smallest class is not evidence. It holds 736 cells
against 14,634 in the modal class, and a stand below
15 cm quadratic mean diameter in an inventory whose vintage postdates the outbreak is more
likely a stand the beetle already stripped of large stems than a stand attacked at that
size.

# Discussion

## Radiation, not wind

The clearest result of this study is methodological, and it changes what a terrain variable
in this literature is allowed to be taken for.

Fitted with a terrain-wind index and no radiation, stand density interacts with terrain
exposure at +0.311, and the natural reading is a wind effect. Add flight-window
radiation and that interaction becomes +0.221, p < 0.001, while density by
radiation appears at -0.144. About a third of the apparent
exposure effect was the sun. The rest was not, and what survives keeps the sign the
mechanism forbids.

That is not a peculiarity of this dataset. A windward-leeward index and an afternoon
radiation surface are both functions of slope and aspect, and on a range whose prevailing
flight-window bearing is 258 degrees the windward slopes are the
west-facing ones, which are also the slopes that take afternoon sun during the flight peak.
Any study that enters a terrain-derived wind index without a radiation term on the same
clock will attribute radiation to wind.

## What survives

@krawchuk2020 name three mechanisms. At the resolution the sensor and the insect share, two
of the three hold and the third does not.

Host density holds, and it holds in the way the mechanism specifies rather than as a bare
main effect. Standing volume predicts disturbance at +0.381, and
its interaction with wind is -0.041 while stem density's is -0.094. The
claim was never that dense stands are attacked more; it was that a dense canopy holds a
plume together, and that what a dense canopy buys should shrink as the wind rises. Both
halves are present.

Large-diameter host holds as a threshold rather than a slope. Attack peaks at
45.9 per cent in the 25 to 30 cm
class, at the source-sink boundary of @carroll2004bionomics, and falls away on both sides.

Topographic shading does not hold, and it fails on a stand-in rather than on the quantity
the mechanism actually names. Growing-season radiation did not survive variable selection, so the
pathway is carried by northness, which correlates -0.834
with it. Northness is +0.382, so shaded ground carries more attack where the
mechanism requires less. Northness tests aspect, and aspect carries more than shade, so this
is the least secure of the three verdicts; the water-stress pathway @krawchuk2020 describe is
not measured here at all.

## The wind claim

The mechanism holds, and the reason earlier specifications rejected it is temporal
resolution rather than anything about the landscape.

At Landsat's own 16-day cadence, stand density interacts with terrain-resolved wind at
-0.094 for stem density and -0.041 for standing volume, both negative,
at p < 0.001 and p < 0.001 respectively. A dense stand is worth
less where and when the wind blows harder, which is what @krawchuk2020 predict. The result
survives entering the previous epoch of the same season, so it is not the outbreak's own
spread wearing a wind coefficient.

Every coarser specification in this study rejected the same mechanism. With one map a year
and station wind, the interaction was +0.020 on eight annual values, right sign and
weak identification. With one map a year and the terrain-resolved field it was
+0.031, wrong sign. The difference is not the wind product and not the covariate
set, both of which are shared: it is that a single annual map forces the comparison to be
made between summers, and a summer is not the unit the insect flies in.

That has a consequence beyond this paper. The mechanism concerns a plume that persists for
minutes over a flight period of weeks. Any test that aggregates the response to a year is
testing whether windy years have less attack than calm years, which is a different and much
weaker question, and it will answer no. The literature has never fitted a wind term at all,
so nothing in it establishes the resolution at which one should be fitted; this study's
answer is that it must be at least as fine as the flight period itself.

Two limits stay attached to the claim. The interaction is small, roughly a tenth of the
standing volume main effect. And the wind field, though it varies in space, is still
terrain-modified station data rather than measurement on the ridge, so what is established
is that the modelled wind field behaves as the mechanism requires, not that the air did.

## Ruggedness and regeneration

The two papers now share a grid, a landscape and a terrain covariate set, and they disagree
on the sign of ruggedness: -0.036 for beetle attack here against a positive
coefficient for conifer regeneration there [@murphy2026]. Read together they describe a
landscape in which rugged ground both resists the disturbance and shelters the recovery from
it. That is a coherent picture, not a contradiction, and it is only visible because the two
studies were fitted on the same grid in EPSG:3153.

## What stays confounded

Elevation is among the largest terms in the model, +0.329, and elevation is not
one thing. It carries temperature, snowpack, growing-season length and the distribution of
lodgepole pine, and this design cannot take them apart. Reporting the elevation coefficient
as a result would be reporting a composite.

The same caution now applies in reverse to every terrain term in the model. Radiation took
about a third of one terrain interaction. There is no guarantee that some further unmeasured
environmental surface would not take the rest, or another.

# Conclusions

The wind-disruption mechanism proposed by @krawchuk2020 holds on this landscape, at the
resolution the sensor and the insect share. Across 59 sixteen-day epochs, stand
density interacts negatively with terrain-resolved wind, -0.094 for stem density
and -0.041 for standing volume, and both survive a within-season spread term. A
dense canopy is worth less to the beetle where and when the wind blows harder, which is what
a plume-disruption mechanism requires.

Of the three mechanisms that proposal names, two hold. Host density holds through standing
volume rather than crown closure or stem count, which run the other way as main effects, and
large-diameter host holds as a threshold at 25 to 30 cm rather than as a slope, at the
source-sink boundary of @carroll2004bionomics. Topographic shading does not hold, and it
fails on a surrogate: growing-season radiation did not survive selection, so the pathway is
carried by northness, +0.382, which correlates
-0.834 with it.

The methodological finding travels further than the ecological one, and it has three parts.

First, a terrain index is partly a measurement of sunlight. Adding flight-window radiation
to the model cut the density by terrain-exposure interaction from +0.311 to
+0.221, without changing its sign. A landform variable in a spreading outbreak records the outbreak's own history:
entering previous-year pressure left valley depth at 0.50 of its value
while mid-slope position moved to 1.32, against 0.61 for
ruggedness. Third, an annual response cannot test a mechanism
that operates over weeks. The same wind field, the same covariates and the same threshold
gave +0.031 at annual resolution and -0.094 at sixteen days.

Since no previous study has fitted a wind term at all [@krawchuk2020; @cartwright2018], there
is no precedent establishing the resolution at which one should be fitted. This study's answer
is that it must be no coarser than the flight period, and that a test which aggregates past it
will reject a mechanism that is there.

# Limitations {#sec-limits}

**Radiation and exposure are not separable in the flight window.** The prevailing bearing is
258 degrees, so windward slopes face west and take afternoon sun.
Flight-window radiation correlates -0.599 with the
windward-leeward index. Its positive coefficient is consistent with the thermal gate and with
exposure raising attack, and this design cannot choose between them.

**The shading mechanism is tested on a surrogate.** Growing-season direct radiation did not
survive variable selection, so the pathway is carried by northness, which correlates
-0.834 with it. Northness tests aspect, aspect carries
more than shade, and the water-stress pathway @krawchuk2020 describe is not measured here.
Growing-season radiation is at least separable from wind exposure,
-0.015, which is the one thing it establishes.

**The wind field is modelled, not measured.** MicroMet modifies station observations over the
terrain. What is established is that the modelled field behaves as the mechanism requires,
not that the air did.

**The inventory postdates part of the outbreak.** Polygons interpreted after the beetle
passed describe the stand it left. Total basal area discriminates below chance,
0.516, most likely for this reason.

**The response is classified, not observed.** Disturbance is inferred from Landsat moisture
indices trained on plots cut from those indices, so reported accuracy measures separability
rather than agreement with ground mortality.

**One landscape, one outbreak.** Every conclusion is conditioned on a single mountain range
over 8 years and 59 epochs.

# Acknowledgements

This work used no external funding. Beetle disturbance was classified from Landsat
Collection 2 Level-2 surface reflectance distributed by the United States Geological
Survey; stand structure from the British Columbia Data Catalogue; terrain from Natural
Resources Canada; and wind from Environment and Climate Change Canada. The author
thanks those agencies for maintaining the open archives the study rests on.

# Conflict of interest

The author declares no conflict of interest.

# Ethics statement

This study used only publicly archived remote sensing, inventory and meteorological
data. No animals, human participants or protected material were involved, so no ethics
approval was required.

# Author contributions

**Seamus Murphy:** conceptualisation; data curation; formal analysis; investigation;
methodology; software; validation; visualisation; writing, original draft; writing,
review and editing.

# Data availability

Every dataset used here is public and none was collected by the author. Beetle disturbance
is classified from Landsat Collection 2 Level-2 surface reflectance. Stand structure is the
provincial Vegetation Resources Inventory layer `VEG_COMP_LYR_R1_POLY`, retrieved from the
British Columbia Data Catalogue web feature service by
`02.inputs/beetle-classification/34-fetch-vri.py`. Terrain derives from the Natural
Resources Canada High Resolution Digital Elevation Model [@nrcan2017], with geomorphometry
computed by SAGA GIS in `37-geomorphometry.R`. Wind is Environment and Climate Change Canada
hourly station data, retrieved by `30-wind-hourly-metrics.R` and `36-wind-direction.R`.

All derived data and the complete analysis code that reproduce every number, table and
figure in this article are archived at Dryad under
doi:PLACEHOLDER-DRYAD-DOI, and are mirrored at
<https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study>.

<!-- BLOCKING BEFORE SUBMISSION. Journal of Applied Entomology mandates data sharing and
     states that data "made available on request or uploaded as supplementary files, are
     not accepted", and that a link with a DOI must sit above the references. The Dryad
     deposit has not been made, so the DOI above is a placeholder and the submission
     cannot go in until it is minted. Wiley pays the Dryad archiving charge for papers
     published in this journal. Include the "Private for Peer Review" link here and in
     the cover letter once the deposit exists. -->

# Figure legends

**Figure 1.** The study area, all panels EPSG:3153 at 30 m, with the 2015 Mt Midgeley
burn outlined in red and Kootenay Lake and the Kootenay River from the British Columbia
Freshwater Atlas. (a) elevation; (b) terrain ruggedness index; (c) stand basal area from
the Vegetation Resources Inventory.

**Figure 2.** The predictor surfaces, all EPSG:3153 at 30 m. (a) flight-window direct
radiation; (b) growing-season direct radiation; (c) the MicroMet wind weighting factor at
the prevailing bearing; (d) terrain ruggedness; (e) stand basal area; (f) quadratic mean
diameter.

**Figure 3.** The refugia mechanism as fitted. (a) Predicted probability of
moderate-to-high disturbance against terrain-resolved epoch wind, at the 10th and 90th
percentiles of stem density, all other terms held at their means. (b) The same for
standing volume. (c) Coefficients of the 16-day model, with and without the within-season
spread term. (d) Epoch prevalence against epoch mean wind, one point per epoch.


::: {.cell}
::: {.cell-output .cell-output-stdout}

```
R version 4.4.1 (2024-06-14)
Platform: aarch64-apple-darwin20
Running under: macOS 15.7.7

Matrix products: default
BLAS:   /opt/local/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRblas.0.dylib 
LAPACK: /opt/local/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

locale:
[1] en_CA.UTF-8/en_CA.UTF-8/en_CA.UTF-8/C/en_CA.UTF-8/en_CA.UTF-8

time zone: America/Vancouver
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] ggnewscale_0.5.2 e1071_1.7-17     ggspatial_1.1.10 tidyterra_1.1.0 
 [5] patchwork_1.3.2  ranger_0.18.0    car_3.1-5        carData_3.0-6   
 [9] mgcv_1.9-4       nlme_3.1-168     knitr_1.51       ggplot2_4.0.2   
[13] tidyr_1.3.2      dplyr_1.2.0      sf_1.1-0         terra_1.9-1     

loaded via a namespace (and not attached):
 [1] s2_1.1.9            generics_0.1.4      class_7.3-23       
 [4] KernSmooth_2.23-26  lattice_0.22-9      pROC_1.19.0.1      
 [7] digest_0.6.39       magrittr_2.0.4      evaluate_1.0.5     
[10] grid_4.4.1          RColorBrewer_1.1-3  fastmap_1.2.0      
[13] jsonlite_2.0.0      Matrix_1.7-5        Formula_1.2-5      
[16] DBI_1.3.0           purrr_1.2.1         viridisLite_0.4.3  
[19] scales_1.4.0        codetools_0.2-20    abind_1.4-8        
[22] cli_3.6.5           rlang_1.1.7         units_1.0-1        
[25] splines_4.4.1       withr_3.0.2         yaml_2.3.12        
[28] otel_0.2.0          tools_4.4.1         vctrs_0.7.2        
[31] R6_2.6.1            proxy_0.4-29        lifecycle_1.0.5    
[34] classInt_0.4-11     htmlwidgets_1.6.4   pkgconfig_2.0.3    
[37] pillar_1.11.1       gtable_0.3.6        data.table_1.18.2.1
[40] glue_1.8.0          Rcpp_1.1.1          xfun_0.57          
[43] tibble_3.3.1        tidyselect_1.2.1    farver_2.1.2       
[46] htmltools_0.5.9     labeling_0.4.3      rmarkdown_2.30     
[49] wk_0.9.5            compiler_4.4.1      S7_0.2.1           
```


:::
:::


# References
