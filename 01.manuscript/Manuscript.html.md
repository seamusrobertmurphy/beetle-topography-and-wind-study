---
title: "Testing the wind disruption and disturbance refugia hypothesis for mountain pine beetle outbreaks (*Dendroctonus ponderosae*)"
subtitle: "Terrain, stand density and flight-period wind as controls on attack in the Selkirk Mountains of British Columbia"
author:
  - name: Seamus Murphy
    orcid: 0000-0002-1792-0351
    email: seamusrobertmurphy@gmail.com
    corresponding: true
    affiliations:
      - name: TÜV SÜD
        address: 2187 Comox Ave
        city: Comox
        postal-code: V9M 1P5
        region: British Columbia
        country: Canada
keywords:
  - mountain pine beetle
  - forest disturbance
  - insect outbreaks
  - Landsat time series
  - refugia
  - British Columbia

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
# Journal of Pest Science cites "by name and year in parentheses", (Thompson 1990), and
# lists references in the Springer Basic author-date form with full DOI links. The style
# file is the Zotero repository's springer-basic-author-date.csl, fetched 2026-09-01. The
# journal was Journal of Applied Entomology until 2026-09-01, which wanted APA 6th; that
# file stays in 04.references but nothing reads it.
csl: ../04.references/springer-basic-author-date.csl
df-print: kable
---


::: {.cell}

:::


<!-- THE PIPELINE. Every step that builds a variable this manuscript reports, as live
     chunks, in order. The document reproduces the study from raw imagery to fitted model
     when run from the top: there is no code anywhere outside this manuscript.

     Chunks carry eval: false. Set on 2026-08-31, because running them inside a render
     exhausts memory on an 8 GB machine: the stage loads 53 Landsat rasters over a
     1739 by 1695 grid, trains an SVM and holds several covariate stacks at once, and two
     renders were killed by the operating system before reaching the document. The code is
     here, in the manuscript, and nothing in the study is built anywhere else. To rebuild
     the inputs from raw imagery, set eval to true and run with Earth Engine credentials
     and SAGA GIS on a machine with headroom. The document itself fits every model live
     from the tables in 02.inputs/beetle/model-data, so every number it reports is still
     computed at render time.

     They are also echo: false, to match the rest of the submission. Printing 160 kB of
     code into the article would swamp it. -->


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



::: {.cell}

:::






::: {.cell}

:::


# Author contributions {.unnumbered}

Murphy conceived and designed the study, collected and assembled datasets, performed analysis and drafted the manuscript.

# Acknowledgements {.unnumbered}

This work used no external funding. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance distributed by the United States Geological Survey; stand structure from the British Columbia Data Catalogue; terrain from Natural Resources Canada; and wind from Environment and Climate Change Canada. The author thanks those agencies for maintaining the open archives the study rests on.

{{< pagebreak >}}

# Abstract {.unnumbered}



Disturbance refugia from mountain pine beetle (*Dendroctonus ponderosae* Hopkins) outbreaks have been hypothesised by @krawchuk2020 to form where tree defences remain effective, on shaded ground that spares trees water stress or in thin stands with few large hosts where wind may disrupt the aggregation pheromone, and none has been fitted spatially. All three were tested across 5,573 ha of the Selkirk Mountains, British Columbia, using 59 sixteen-day Landsat epochs over eight outbreak years with annualized forest inventory, geomorphometric variables and a terrain-resolved MicroMet wind field from hourly station records. Wind disruption was supported conditionally, in that attack fell where a thin stand and strong flight-period wind coincided, the density-by-wind interaction -0.049 for stem density (p < 0.001) and -0.017 for standing volume (p < 0.05), both holding against within-season contagion. Terrain acted differently. Leeward ground had more attack as a main effect, -0.267, independent of stand density, and open gentle ground more still, sky view +0.285, which is the pattern expected if wind-borne beetles, which land without discriminating hosts, settle where the flow slows. Attack responded to host size as a threshold, peaking at 31.5 per cent in the 25 to 30 cm quadratic mean diameter class. The shade hypothesis failed, since north-facing slopes showed more attack (+0.384). Refugia are therefore proposed to lie on warm, windward ground in thin stands during windy flight periods, and the terrain ruggedness signal of the companion study resolves into shelter and openness.

# Keywords {.unnumbered}

Mountain pine beetle, forest disturbance, insect outbreaks, Landsat time series, refugia, British Columbia

```{=html}
<!-- Journal of Pest Science asks for "4 to 6 keywords which can be used for indexing
     purposes" and sets no rule against title words. Quarto's docx writer puts the YAML
     `keywords` field into the file's core properties only, where no editor sees it, so
     they are printed here as well. The two lists must be kept identical. -->
```

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins [Coleoptera: Curculionidae: Scolytinae]) has impacted more lodgepole pine (*Pinus contorta* Douglas ex Loudon) stands across British Columbia than any other disturbance event on record [@taylor2003; @sambaraju2021]. However, mortality is not distributed evenly across a landscape, and the stands that survive supply the structure and seed from which the next forest develops. Such stands are termed disturbance refugia, places buffered from disturbance over time [@krawchuk2020]. Locating a refugium does not explain it, and explanation requires a mechanism linking survival to a measurable property of the site, such as terrain, soil or stand structure [@cartwright2018].

@krawchuk2020 proposed such a mechanism, that refugia could occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" (p. 239). These are three testable claims. Topographic shading reduces attack by relieving water stress on cool ground. Low host density reduces attack by admitting the wind that disperses the aggregation pheromone. A scarcity of large-diameter hosts reduces attack by limiting brood production. Two of the three act through terrain, and none has been fitted spatially. The one field test of refugia from this beetle since, by @maher2021, concerns a fourth mechanism, the krummholz growth form of whitebark pine at alpine treeline, surveyed on transects rather than fitted spatially. Of the prior work cited here, only @murphy2026 enters a wind term, in a companion study on this same landscape whose response is conifer regeneration rather than beetle attack.

Previous research is associated with this study's investigations and its ground truth data, which modelled the density of conifer seedlings after the 2015 Mt Midgeley fire on the same ground [@murphy2026]. That model entered distance to seed source, fire severity, the red and grey stages of the beetle outbreak, aspect, wind and terrain ruggedness, because topography was expected to act as "both disturbance modifier and regeneration filter", and terrain ruggedness was retained among the eight covariates the final model kept, with a coefficient of +0.626 (p < 0.001) for all seedlings that was the largest positive terrain effect in that study. A ruggedness coefficient records that the shape of the ground matters without saying which property of that shape the organism responds to, because a ruggedness index sums how much elevation changes around a cell and nothing more. The present study takes the beetle outbreak that the earlier model treated as a covariate and makes it the response, and it replaces the single ruggedness index with the four terrain properties the beetle's biology points to, exposure to the prevailing wind, openness to the sky, position on the slope and depth of the valley, so that the effect of relief found in the earlier study can be separated into its parts.

The wind mechanism concerns conditions inside the canopy rather than in open air, in that @cartwright2018, the only prior study designed to model the controls on an insect refugium, located refugia in stands of low basal area and reasoned that "thinner stands also increase wind penetration, helping to disperse beetle pheromones and disrupt chemical communications needed to coordinate attacks", while @powell2014 state the converse as a condition for outbreak, that "higher local host density, which minimizes pheromone plume dispersion, reduces wind, and promotes successful switching to nearby hosts, positively influences outbreak propensity". Stand density is therefore kept in every model fitted here, because a model that removes it and then reads a terrain coefficient as a wind effect has removed the pathway it set out to test.

Terrain acts on attack through more than airflow, because emergence and flight "are not directly dependent on chemical cues but mainly driven by temperature and wind conditions" [@netherer2021], and flight is itself confined to a temperature window, between 19 and 41 degrees C and mostly between 22 and 32, with most flights occurring "on bright sunny days, and peak flight is in the early to mid-afternoon" [@mccambridge1971; @safranyik2006chap1]. Radiation during the flight window is therefore a different quantity from radiation accumulated across the season, and it is the seasonal quantity that the shading pathway concerns. Light, temperature and wind are less three competing explanations than one set of correlated conditions, because stand density governs "tree vigour and within-stand microclimate, which in turn influence success of bark beetle dispersal, host selection, attack or brood development" [@safranyik2006chap1], and @bartos1989 set the two halves of that pairing against each other in their own title, microclimate against tree vigour. Cool sites also slow development enough to push the beetle onto a two-year cycle [@sambaraju2021], and water stress does not act on defence in one direction, since conifer terpene synthesis rises with moderate stress and falls under severe drought [@netherer2021], so shade and vigour both predict less attack on cool ground by routes this design cannot separate.

Two further constraints determine the interval over which a wind term can be measured, and both are temporal rather than spatial. The first operates within the day, in that @gray1972 recorded emergence in *D. ponderosae* against ambient temperature and found that emergence "began when temperatures rose above 20° C" and "ceased in the afternoon at about the same threshold temperature", that "Peak emergence occurred between 11 a. m. and 2 p. m.", and that there was a "sharp decline in activity which occurred when ambient temperatures exceeded 30° C", so flight is limited at both ends and confined to a few hours of the afternoon, and a daily or monthly mean wind speed averages across many hours in which no beetle is flying.

The second constraint operates across the season and belongs to the population rather than to the individual, because mass attack is a threshold phenomenon, in that @howe2022 conclude that "a combination of stand-level spatial aggregation, behavioral shifts, and higher quality of attainable hosts defines a critical threshold beyond which continual population growth becomes self-driving", @cooke2025 define the irruption threshold as "the population density at which endemic populations may transition towards the epidemic state", and @carroll2004bionomics place the same argument on the thermal side, requiring "thermal environments conducive to overwintering survival and with sufficient heat accumulation to maintain a synchronous univoltine life cycle". Two consequences follow for the present design, the first being that attack in one year is not independent of attack in the year before, which is why previous-year and neighbourhood pressure enter the models, and the second being that an environmental variable acts on this system by regulating that threshold rather than by adding to attack [@cooke2025], so a wind effect on mass attack through the plume is expected as an interaction with host density and not as a main effect.

A third consideration concerns where a dispersing beetle comes down, and it changes what a terrain main effect can mean, because @hynum1980 monitored landing on lodgepole pine with landing traps and found that the beetle "is not attracted to lodgepole pine" before the first gallery is started and that beetles "were unable to distinguish between hosts, dead hosts and nonhosts during landing", so where a beetle lands is decided by its transport rather than by the tree beneath it. Within a stand that transport is short and follows the wind, in that @safranyik1989 predicted the directional distribution of dispersing beetles from hourly wind direction, and @safranyik1992 recaptured most released beetles near 3 m above the ground and estimated that "only 0.2 % of the marked beetles dispersed above the stand canopy", whereas above the canopy the transport is long, because @jackson2008 observed beetles by radar to more than 800 m above the forest, and @chen2017 describe long-distance dispersal as three phases, "the ascent, transport, and descent", whose mechanisms "are poorly known", with unstable air under the canopy during emergence that "would help loft beetles above the forest canopy". A beetle descending from that transport arrives as a wind-borne particle, and @giroday2011 set out what follows, that landscape features "provide impactive surfaces for interception of insects", that a heavier airborne object is more likely to "impact a surface rather than be swept around the obstacle into lee-ward eddies", and that settlement rises "in areas where wind speed is reduced", so the ground where the flow slows, the lee of ridges and sheltered slopes, is where such a beetle should come to rest, which is the pattern the wind shelter index of @plattner2004 was built to predict for snow.

Deposition and plume disruption therefore make different predictions, and the difference is what this design can test, since deposition acts before any host is chosen and predicts a main effect of terrain shelter that does not depend on stand density, whereas plume disruption acts on an aggregation already under way and predicts an interaction between stand density and wind with no requirement that shelter act alone, so a terrain coefficient read without this distinction is assigned to a mechanism it may not belong to.

No available product reports the quantity the plume hypothesis concerns, an instantaneous wind speed below the canopy at flight height during the flight period, because gridded wind climatologies report a long-term mean at 10 m over open ground and are downscaled over a digital elevation model, which makes them in part a function of the terrain variables offered alongside them [@badger2014; @davis2023]. Wind was therefore taken from station observations of each 16-day period, modified over the terrain with the MicroMet model of @liston2006, and the response was measured at Landsat's own 16-day repeat, which is the finest interval the sensor and the flight period share.

@tbl-hypotheses sets out the direction expected of each attribute and the reasoning behind it, and the study addressed five questions. Does stand density predict moderate-to-high disturbance, as the pheromone mechanism requires? Does topographic shading predict it, against the competing microclimate and adaptive-seasonality arguments? Does terrain shape predict it once density and radiation are already in the model? Is the density effect conditional on wind, which is the form plume disruption takes? Does terrain shelter act as a main effect, which is what deposition of wind-borne beetles predicts, or only through stand density, which is what plume disruption predicts?


::: {#tbl-hypotheses .cell tbl-cap='Landscape attributes entered in this study, the direction expected of each, and the reasoning behind that expectation.'}
::: {.cell-output-display}


|Attribute                                     |Expected                       |Rationale                                                                                                                                                                              |
|:---------------------------------------------|:------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Stand BA, volume, crown closure, stems        |positive                       |Denser canopy holds the pheromone plume together; thinner stands admit wind that disperses it [@krawchuk2020; @cartwright2018; @powell2014].                                           |
|Quadratic mean diameter                       |positive >25cm                 |Trees under 25 cm are beetle sinks, over 25 cm are sources [@carroll2004bionomics].                                                                                                    |
|Lodgepole pine cover and BA                   |positive                       |Attack cannot occur where the host is absent; a cell without pine is not a refugium [@cartwright2018].                                                                                 |
|Flight-period direct radiation                |positive                       |Flight is confined to 19 to 41 degrees C and peaks on bright afternoons, so sunlit slopes are reachable [@safranyik2006chap1; @mccambridge1971].                                       |
|Growing-season direct radiation               |negative                       |Shading cools, relieving water stress and sustaining defence, and cool sites also push the beetle toward a two-year cycle [@krawchuk2020; @sambaraju2021].                             |
|Terrain exposure to wind                      |negative                       |Wind disrupts the pheromone plume, so exposed ground should have less attack [@krawchuk2020].                                                                                          |
|Terrain shelter and sky view                  |positive, as main effect       |Beetles land without discriminating hosts after wind-borne transport, so sheltered, open ground should receive more landings whatever the stand [@hynum1980; @jackson2008; @chen2017]. |
|Terrain ruggedness                            |uncertain                      |The strongest terrain term in the companion study on this landscape, but fitted there against regeneration rather than attack [@murphy2026].                                           |
|Convergence, wetness, valley & slope position |positive in convergent terrain |Infested groups gather in draws and gullies, and deep snow insulates overwintering brood [@safranyik2006chap1].                                                                        |
|Flight-period wind speed                      |negative                       |The mechanism acts during dispersal, and no study specifies the interval, so it is taken at the flight period [@krawchuk2020; @jones2019].                                             |
|Elevation                                     |uncertain                      |A composite of temperature, snowpack, season length and host distribution that this design cannot separate [@sambaraju2021].                                                           |


:::
:::


# Materials and methods

## Study area

The study area covered 5,573 ha of the Selkirk Mountains in southeastern British Columbia, 61,923 cells of 30 m spanning 830 to 1,744 m, which is 914 m of relief, on the grid of the parent study, EPSG:3153, NAD83(CSRS) / BC Albers, so that results compared directly with it. The perimeter was centred on the 2015 Mt Midgeley fire, 480 ha, which was the parent study's site, and extended beyond it because 480 ha did not contain the stand-density contrast the pheromone mechanism requires. The extension was constrained rather than arbitrary, in that the perimeter was the burn buffered by 5 km and then cut to the elevation band the parent study's site occupies, so that the added ground was comparable to it. @tbl-inventory sets out the datasets the study combined and the resolution of each, and the analysis depended on the unevenness it shows, in that the response varied every sixteen days, the inventory once a year, the station winds every hour, and the terrain not at all.


::: {#tbl-inventory .cell tbl-cap='The datasets this study combined, with the structure and resolution of each. Spatial resolution was the grid on which a variable was analysed and temporal resolution the interval at which it varied. The response varied every 16 days, the inventory once a year, the station wind every hour and the terrain not at all, which was the unevenness the wind analysis depended on.'}
::: {.cell-output-display}


|Dataset                 |Source                                                    |Variables                                               |Spatial           |Temporal             |Period                  |                      n|
|:-----------------------|:---------------------------------------------------------|:-------------------------------------------------------|:-----------------|:--------------------|:-----------------------|----------------------:|
|Beetle attack (Annual)  |Landsat 5 and 8 Collection 2 Level-2                      |Moderate-to-high NDMI binary                            |30 m              |1 year               |2006-2014, (excl. 2012) |                8 years|
|Beetle attack (/16-day) |Landsat 5 and 8 Collection 2 Level-2                      |Moderate-to-high NDMI binary                            |30 m              |16 days              |2006-2014, (excl. 2012) |              59 epochs|
|Stand structure         |VRI Historical, BC Data Catalogue                         |BA, volume, stems, quadratic mean diameter, age, height |30 m (rasterised) |1 year, projected-yr |2005-2014               |              9 windows|
|Terrain                 |NRCan High-Res DEM, SAGA indices                          |Geomorphons (incl. radiation, exposure, landform)       |30 m              |Static               |n/a                     |               8 fitted|
|Station wind            |Env. & Climate Change Canada                              |Speed and direction                                     |4 to 7 stations   |1 hour               |2005-2014, May-Sept     | 236,079 hourly records|
|Terrain-resolved wind   |DEM-conditioned MicroMet wind field of station data       |Weighting factor, modified speed, diverted direction    |30 m              |16 days, & 1 year    |2005-2014               |     16 sectors (22.5°)|
|Model frame (Annual)    |Rows joined above, (one row / cell-year)                  |Response & covariates, one row per cell-year            |30 m              |1 year               |2006-2014, (excl. 2012) |     111,707 cell-years|
|Model frame (/16-day)   |Rows joined above per Landsat pass (one row / cell-epoch) |Response & covariates, one row per cell-epoch           |30 m              |16 days              |2006-2014, (excl. 2012) |     66,302 cell-epochs|


:::
:::



::: {.cell}
::: {.cell-output-display}
![Landscape, terrain and stand surfaces across the study area, all EPSG:3153 at 30 m over Esri World Shaded Relief. (a) elevation; (b) terrain ruggedness index; (c) windward-leeward index at the prevailing bearing; (d) flight-window direct radiation, the thermal limit on flight; (e) growing-season direct radiation, the shading pathway; (f) the MicroMet wind weighting factor at the prevailing bearing; (g) stand basal area; (h) quadratic mean diameter, whose 25 cm source-sink threshold fell near the midpoint of the scale; (i) live stems per hectare. The white outline marked the study perimeter and the red outline the 2015 Mt Midgeley burn, with contours at 200 m.](Manuscript_files/figure-html/fig-study-area-1.png){#fig-study-area width=2250}
:::
:::


## Beetle disturbance

The response was moderate-to-high beetle disturbance in each of eight outbreak years, 2006 to 2014 excluding 2012, the one year covered only by Landsat 7, which has flown with its scan-line corrector off since May 2003. It was classified from Landsat imagery by a support vector machine trained on the 28 ground plots of @murphy2026, in which the basal area of pine killed by the beetle was measured on 20 m plots centred within 60 by 60 m quadrants of four Landsat cells so that no plot straddled a cell edge, following the plot-to-pixel protocols of @carlson2017 and @lentile2006. Plots were labelled low, moderate or high by tertiles of killed basal area, at 8.9 and 26.8 square metres per hectare, with undisturbed forest as the unaffected class, and the classifier separated moderate or high from the rest on the changes in NDVI, NBR and tasselled-cap wetness against 2005, taken in the year of each plot's deepest NDMI decline. Accuracy was estimated by leaving one plot out at a time, because a held-out quarter of 38 plots was too small to trust, and was 0.737, kappa 0.475. Each year was then predicted over the perimeter with water masked, and the years were never merged into one layer, because merging destroys the year-to-year variation this study measured and because the merged layer over the wider grid reached 73 per cent of the landscape, a figure not credible for a beetle outbreak. Annual prevalence inside the perimeter ran from 3.9 to 18.6 per cent, pooled 9.7 per cent over 111,707 cell-years (@tbl-prevalence), and @fig-first-attack shows where the outbreak arrived first and how much of the perimeter it reached each year. The provincial aerial overview survey supplied no training label and was retained only as a visual check.


::: {#tbl-prevalence .cell tbl-cap='Moderate-to-high beetle disturbance by year inside the study perimeter.'}
::: {.cell-output-display}


|Year |  Cells| Moderate-to-high (%)|
|:----|------:|--------------------:|
|2006 | 13,224|                  4.2|
|2007 | 13,225|                  3.9|
|2008 | 13,285|                 18.6|
|2009 | 13,556|                  7.3|
|2010 | 13,538|                 13.5|
|2011 | 14,944|                  9.8|
|2013 | 14,943|                 10.0|
|2014 | 14,992|                  9.7|


:::
:::



::: {.cell}
::: {.cell-output-display}
![Spread of moderate-to-high beetle disturbance across the study perimeter. (a) The first year in which each cell entered the moderate-to-high class, over shaded relief with the perimeter in white and the 2015 Mt Midgeley burn in red; cells never classed as attacked showed the relief alone. The panel was built from the eight annual maps for display, and those maps were fitted separately and never merged for analysis. (b) The share of perimeter cells classed moderate-to-high in each year.](Manuscript_files/figure-html/fig-first-attack-1.png){#fig-first-attack width=2250}
:::
:::


## Stand structure

Stand structure data were derived from the provincial Vegetation Resources Inventory layer VEG_COMP_LYR_R1_POLY, retrieved within the perimeter, and six of its attributes covered the mechanism and the stem-size threshold, namely total basal area, crown closure, live stems per hectare, quadratic mean diameter over stems of 12.5 cm and larger, stand age, and susceptible pine basal area, formed as total basal area times the pine share of cover.

Every model was fitted on annualized stand structure, in that each cell-year took the inventory snapshot the province published for that year, depleted for harvest and projected for growth to it, so the host terms varied in time as well as in space. One year was substituted, because the 2007 inventory dataset omitted basal area and live stems variables, so the 2006 record stood in for 2007 rather than an average derived from 2006 and 2008 records. The inventory is itself a projection, so an average would produce a stand structure the province never published, whereas the 2006 record is one it did. Cell-years at or above the 25 cm source-sink threshold made up 67.1 per cent of the sample (@tbl-vri).


::: {#tbl-vri .cell tbl-cap='Stand structure across the study perimeter, from the Vegetation Resources Inventory, over 111,707 cell-years. SD was the standard deviation of the landscape and SE the standard error of the mean. Skew and Kurt. were the bias-corrected skewness and excess kurtosis.'}
::: {.cell-output-display}


|Attribute                                                                                                                                                            |   Mean|     SD|   SE#| Median|   Min|     Max|  Skew|  Kurt.|
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|------:|------:|-----:|------:|-----:|-------:|-----:|------:|
|Stand basal area (m² ha⁻¹)                                                                                                                                           |  35.56|  11.60| 0.035|  37.39|  0.98|   62.43| -1.01|  +1.42|
|Crown closure (%)                                                                                                                                                    |  50.10|  13.54| 0.041|  50.00|  3.00|   70.00| -1.74|  +3.37|
|Live stems (n/ha)                                                                                                                                                    | 772.75| 312.80| 0.936| 775.00| 23.00| 4600.00| +1.70| +19.51|
|Quadratic mean diameter (cm)                                                                                                                                         |  27.38|   6.40| 0.019|  26.95| 13.55|   58.90| +0.73|  +1.24|
|Stand age (years)                                                                                                                                                    | 115.46|  20.88| 0.062| 116.00| 22.00|  237.00| -0.78|  +1.97|
|Stand height (m)                                                                                                                                                     |  26.97|   6.27| 0.019|  27.90|  7.00|   40.30| -0.26|  +0.23|
|Standing volume (m³ ha⁻¹)                                                                                                                                            | 272.33| 131.38| 0.393| 281.47|  0.82|  586.61| +0.01|  -0.35|
|Lodgepole pine cover (%)                                                                                                                                             |  20.11|  23.93| 0.072|  10.00|  0.00|  100.00| +1.45|  +1.56|
|Susceptible pine BA (m² ha⁻¹)                                                                                                                                        |   7.07|   8.85| 0.026|   4.00|  0.00|   48.30| +1.63|  +2.63|
|# Note the standard error is small because it is computed over 111,707 cell-years, and it measures the precision of the landscape mean, rather than of any one cell. |       |       |      |       |      |        |      |       |


:::
:::


The inventory is a projected operational product rather than a census, and its polygons here had reference years spanning several decades, so a polygon interpreted from late-outbreak photography described a stand the beetle had already attacked, and basal area and pine cover were post-attack over part of the study window. Unattacked vintages were not reported in this study, and the potential limitations of these assumptions are explored further in the Discussion section below.

## Geomorphometry

Terrain was described by surfaces computed with SAGA GIS over the full reprojected elevation model and clipped afterwards, so that a search radius near the boundary still fell on measured ground. The set separated the single ruggedness index of @murphy2026 into the properties the beetle's biology points to, and ruggedness itself was kept as a candidate so that the separation was tested against it rather than assumed.

Radiation was computed twice because two mechanisms require different quantities, in that flight-window radiation was the direct and diffuse total over 1 July to 15 August restricted to 12:00 to 17:00, the hours identified as the flight peak [@safranyik2006chap1], while growing-season radiation was the whole-day total from 1 May to 30 September, which is the shading quantity the first mechanism of @krawchuk2020 concerns, and a single annual heat index cannot separate the two, flight-window direct radiation spanning a 7-fold range here against 2.6-fold for the season total.

Exposure entered as the windward-leeward index and effective air flow height at the prevailing bearing, the wind exposition index over all directions, the wind shelter index of @plattner2004, which is "the maximum gradient within a given radius in upwind direction", and topographic openness. Shape entered as terrain ruggedness, vector ruggedness, topographic position and its multi-scale form, convergence, slope, curvature and geomorphon class. Landform entered as topographic wetness, valley depth, height above the valley floor, normalised height and mid-slope position, because infested groups are reported in draws and gullies and deep snow insulates overwintering brood [@safranyik2006chap1], and because slope was one of the two site variables that best explained symptom abundance after attack by the European spruce bark beetle [@kautz2023]. Aspect entered as its northward and eastward components with the heat load index of @mccune2002.

## Terrain-resolved wind {#sec-micromet}


::: {.cell}

:::


Station wind interpolated from four to seven valley stations was nearly flat within a year, so wind was also computed as a field varying in space with the MicroMet model of @liston2006, whose wind component is seven equations implemented directly from the source paper with its equation numbers given below.

Terrain slope $\beta$ and slope azimuth $\xi$ came from the elevation model, equations 12 and 13 of @liston2006. Curvature $\Omega_c$ is a cell's elevation minus the mean of the two opposite cells one curvature length scale away, taken on four direction lines and averaged, their equation 14, and the length scale was estimated as the first lag at which elevation autocorrelation fell below 0.5, which was 600 m here. Assigning $\theta$ to wind bearing, slope in the wind direction was computed as follows

$$\Omega_s = \beta \cos(\theta - \xi)$$ {#eq-slope}

with $\Omega_s$ and $\Omega_c$ each scaled to $[-0.5,\,0.5]$. The terrain weighting factor applied to the observed speed $W$ was derived using

$$W_w = 1 + \gamma_s \Omega_s + \gamma_c \Omega_c, \qquad \gamma_s = \gamma_c = 0.5$$ {#eq-weight}

This provided the basis for calculation of the terrain-modified speed using

$$W_t = W_w W$$ {#eq-speed}

and a diversion of wind direction computed as

$$\theta_d = -\tfrac{1}{2}\, \Omega_s \sin\!\left[2(\xi - \theta)\right].$$ {#eq-divert}

By @eq-weight, $W_w$ depends on direction and not on speed, so it was computed once for each of 16 wind direction sectors of 22.5 degrees, the sixteen points of the compass, and each hourly observation was multiplied by the surface for its own sector, so that nothing was averaged before the terrain acted on it, and over all sectors $W_w$ ran from 0.60 to 1.38.

Speed and direction were combined as vector components, because averaging degrees across the 360 to 0 discontinuity is not meaningful. The resulting field varied from 1.9 to 2.8 km/h across the grid within a year and was not a terrain index under another name, correlating +0.148 with the windward-leeward index and +0.123 with flight-window radiation, its strongest association being with elevation at +0.320.

## Flight-window wind

The flight window was 1 July to 15 August and the hours 12:00 to 17:00, and neither bound was chosen from these data, which is what multi-year phenology studies of forest insects do when they fix activity windows from monitoring rather than from the response [@pawson2021]. The dates were the flight period @safranyik2006chap1 give for this region, and the hours followed their "peak flight is in the early to mid afternoon" together with the 11:00 to 14:00 emergence peak of @gray1972, taken to the later side because emergence precedes the flight it starts.

Considering this as a fixed window, these assumptions were assessed against climate data. @fig-flight-window presents time series of 236,079 hourly station records between May to September of the nine study years, which included 89.5 per cent of afternoon hours inside the window that fell within the 19 to 41 degrees C flight range, against 51.4 per cent outside it. In addition, the afternoon mean was 26.0 against 19.2 degrees C, so the window roughly doubled the share of hours in which flight was thermally possible. The same figure shows the same daily pattern in wind, where mean speed peaked in the same hours as temperature, at 10.4 km/h in mid-afternoon against 4.6 km/h at dawn. This suggests that the hours the beetle can fly were also the windiest of the day, which effectively supports the flight and spread mechanisms.

Station wind was derived from the hourly record provided by Environment and Climate Change Canada, and it entered the analysis hour by hour, before any averaging, so that the terrain adjustment acted on each observation rather than on a mean. The choice of summarising interval is key to how much evidence a wind coefficient carries. Summarised by season, the wind of a whole summer becomes one number, so a coefficient fitted to seasons is estimated from eight values, one per year, while stand density is measured on every cell. Summarised by sixteen-day epoch, wind varies within each summer as well as between summers, which gives the density by wind interaction enough variation to be estimated. The response was therefore measured at the sixteen-day interval.


::: {.cell}
::: {.cell-output-display}
![The flight window against the landscape's own climate, from hourly Environment and Climate Change Canada station records for May to September of the nine study years. The shaded band marked the window, 1 July to 15 August, taken from the bionomics and not fitted to these data. (a) Mean afternoon temperature by day of year, with the 19 to 41 degrees C flight range and the 22 to 32 degrees C peak band marked. (b) The share of afternoon hours inside the flight range, day by day. (c) Mean temperature and the share of all hours inside the flight range, by hour, with the 12:00 to 17:00 restriction shaded. (d) Mean wind speed by hour on the same axis, showing that the hours in which the beetle could fly were also the windiest of the day.](Manuscript_files/figure-html/fig-flight-window-1.png){#fig-flight-window width=2250}
:::
:::


## Variable selection {#sec-selection}

The candidate set ranged across stand density, host quality, terrain exposure to wind, terrain shape, landscape context and flight-window wind, one group for each pathway the Introduction names, and the terrain exposure group held the shelter and openness indices that inform the beetle flight and wind deposition question. Selection was applied over four stages and was required to retain at least one variable from each pathway, so that a filter could not silently remove a hypothesis the Introduction established. The first stage dropped any candidate whose univariate logistic fit was not significant at 0.01, the second clustered the survivors at an absolute correlation of 0.75 and kept the member of each cluster with the highest univariate AUC, the third removed variables until every variance inflation factor was below 5, and the fourth fitted a lasso penalty chosen by ten-fold cross-validation at the one-standard-error rule, the selection the parent study used, with the highest-ranked survivor of each pathway exempt from the penalty. @tbl-selection gives every candidate and the stage at which it left, and 15 variables entered the models, of which 8 described the terrain.


::: {#tbl-selection .cell tbl-cap='Variable selection. Every candidate with its pathway, its univariate AUC, the stage at which it left, and for the survivors of the inflation stage the lasso coefficient at the chosen penalty. Protected marked the highest-ranked survivor of each pathway, which the penalty could not remove. AUC was the area under the receiver operating characteristic curve of the univariate fit, and the asterisks beside it marked the significance of that fit, * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001.'}
::: {.cell-output-display}


|Candidate                                       |Pathway   | Univariate AUC|Stage        | Lasso coefficient|Protected |
|:-----------------------------------------------|:---------|--------------:|:------------|-----------------:|:---------|
|Elevation (m)                                   |landform  |      0.682****|retained     |            +0.336|yes       |
|Susceptible pine BA (m² ha⁻¹)                   |hostsize  |      0.678****|retained     |            +0.427|yes       |
|Stand basal area (m² ha⁻¹)                      |density   |      0.601****|retained     |            +0.347|yes       |
|Sky view factor                                 |shading   |      0.686****|retained     |            +0.315|yes       |
|Stand age (years)                               |hostsize  |      0.571****|retained     |            +0.068|          |
|July mean wind (km/h)                           |wind_t    |      0.563****|retained     |            +0.249|yes       |
|Northness                                       |shading   |      0.586****|retained     |            +0.314|          |
|Quadratic mean diameter (cm)                    |hostsize  |      0.510****|retained     |            -0.124|          |
|June mean wind (km/h)                           |wind_t    |      0.534****|retained     |            -0.025|          |
|Wind shelter index                              |wind_geo  |      0.526****|retained     |            -0.205|yes       |
|MicroMet flight-window wind (km/h)              |wind_mm   |      0.580****|retained     |            +0.253|yes       |
|Topographic position index                      |shape     |      0.585****|retained     |            -0.168|yes       |
|Flight-window direct radiation (kWh/m2)         |flightsun |      0.561****|retained     |            +0.206|yes       |
|Convergence index                               |shape     |      0.530****|retained     |            -0.016|          |
|Profile curvature                               |shape     |      0.514****|retained     |            -0.010|          |
|Height above valley floor (m)                   |landform  |      0.646****|penalty      |            +0.000|          |
|Live stems (n/ha)                               |density   |      0.602****|penalty      |            +0.000|          |
|Valley depth (m)                                |landform  |      0.617****|penalty      |            +0.000|          |
|Mid-slope position                              |landform  |      0.517****|penalty      |            +0.000|          |
|Crown closure (%)                               |density   |      0.524****|penalty      |            +0.000|          |
|Vector ruggedness measure                       |shape     |      0.600****|penalty      |            +0.000|          |
|Terrain ruggedness index                        |shape     |      0.648****|inflation    |                  |          |
|Normalised height                               |landform  |      0.584****|inflation    |                  |          |
|Flight-window mean wind (km/h)                  |wind_t    |      0.558****|inflation    |                  |          |
|Eastness                                        |shading   |      0.549****|inflation    |                  |          |
|Effective air flow height                       |wind_geo  |      0.682****|collinearity |                  |          |
|Lodgepole pine cover (%)                        |hostsize  |      0.656****|collinearity |                  |          |
|Slope (degrees)                                 |shape     |      0.645****|collinearity |                  |          |
|Positive openness                               |wind_geo  |      0.636****|collinearity |                  |          |
|Wind exposition index                           |wind_geo  |      0.563****|collinearity |                  |          |
|Standing volume (m³ ha⁻¹)                       |density   |      0.555****|collinearity |                  |          |
|Flight-window windy hours (share above 15 km/h) |wind_t    |      0.548****|collinearity |                  |          |
|Flight-window calm hours (share below 5 km/h)   |wind_t    |      0.547****|collinearity |                  |          |
|Multi-scale topographic position                |shape     |      0.540****|collinearity |                  |          |
|August mean wind (km/h)                         |wind_t    |      0.534****|collinearity |                  |          |
|Plan curvature                                  |shape     |      0.528****|collinearity |                  |          |
|solar_flight_diffuse                            |flightsun |      0.528****|collinearity |                  |          |
|Windward-leeward index                          |wind_geo  |      0.522****|collinearity |                  |          |
|Growing-season total radiation (kWh/m2)         |shading   |      0.517****|collinearity |                  |          |
|Growing-season direct radiation (kWh/m2)        |shading   |      0.516****|collinearity |                  |          |
|Flight-window 95th percentile wind (km/h)       |wind_t    |          0.527|univariate   |                  |          |
|Stand height (m)                                |hostsize  |          0.507|univariate   |                  |          |
|Topographic wetness index                       |landform  |         0.506*|univariate   |                  |          |
|Negative openness                               |wind_geo  |          0.501|univariate   |                  |          |
|Heat load index                                 |shading   |          0.499|univariate   |                  |          |


:::
:::


Model fitting used a class-balanced sample of 42,791 cell-years, 4,000 of each class per year, because landscape prevalence was about 10 per cent and an unbalanced fit at that prevalence would report the magnitude of the intercept rather than the effect of the covariates in question.

## Models

Every model was a logistic regression of moderate-to-high disturbance $y_{it}$ in cell $i$ and year $t$ on standardised covariates,

$$\operatorname{logit}\Pr(y_{it}=1) = \alpha + \mathbf{x}_{it}^{\top}\boldsymbol{\beta}
+ \gamma_{g(i)} + \sum_{k} \delta_k\, z_{k,it}$$ {#eq-model}

where $\gamma_{g(i)}$ was the effect of the geomorphon landform class $g$ of cell $i$ and the $z_{k,it}$ were the interaction terms, so that every coefficient was a change in log-odds per standard deviation of its variable. Four annual models were fitted in sequence, each adding one mechanism to the one before, so that the contribution of each mechanism appeared as a change in fit rather than as an assertion. M0 held the mechanisms that do not involve stand density, host size, topographic shading, and the landform terms that govern where cold air and snow collect. M1 added stand density, which answered the first question. M2 added terrain shape, terrain exposure to wind and flight-window radiation, which answered the second and third questions. M3 added three interactions with stand density, by terrain exposure, by flight-window radiation and by flight-window wind, which answered the fourth question at the annual scale. The models were compared on AIC and on predictive error on the fitted probabilities.

The fifth question was examined by comparing two estimates from these models, the coefficient of terrain shelter on its own, from M2 and M3, and the coefficient of the shelter by density interaction, from M3. Deposition predicts that the first is present and the second absent, whereas plume disruption predicts that the second is present whether or not the first is. The sixteen-day models described under flight-window wind answered the fourth question again where wind varied within a season, which is the scale at which the plume mechanism acts.

# Results {#sec-results}


::: {#tbl-aic .cell tbl-cap='Comparison of the four annual models, each adding one mechanism to the one before. AIC ranked the models on likelihood with a penalty for the number of parameters, and the remaining columns measured how far the fitted probabilities fell from the observed classes. RMSE was the root mean squared error and MAE the mean absolute error, both on the fitted probabilities, and AUC the area under the receiver operating characteristic curve. Brier skill was the improvement over predicting the prevalence for every cell, where 0 was no better than that base rate.'}
::: {.cell-output-display}


|Model                          |    AIC|  ΔAIC|  RMSE|   MAE|   AUC| Brier skill|
|:------------------------------|------:|-----:|-----:|-----:|-----:|-----------:|
|M0 host size, shading, terrain | 41,269| 1,182| 0.396| 0.315| 0.758|       0.166|
|M1 + stand density             | 40,971|   884| 0.394| 0.312| 0.761|       0.175|
|M2 + terrain, flight radiation | 40,649|   562| 0.393| 0.309| 0.767|       0.182|
|M3 + interactions              | 40,087|     0| 0.390| 0.305| 0.778|       0.193|


:::
:::



::: {#tbl-m3 .cell tbl-cap='Coefficients of the full annual model M3, continuous terms ordered by absolute size. Each coefficient was the change in log-odds per standard deviation of its variable, fitted on a class-balanced sample, so the intercept was not the landscape prevalence. SE was the standard error and z the Wald statistic. Significance was marked * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001. The geomorphon landform classes of the same model were reported in @tbl-geomorphon.'}
::: {.cell-output-display}


|Term                                              |       Beta|    SE|      z|
|:-------------------------------------------------|----------:|-----:|------:|
|Stand basal area (m² ha⁻¹)                        | +0.430****| 0.024|  18.20|
|Northness                                         | +0.384****| 0.015|  24.85|
|Elevation (m)                                     | +0.381****| 0.016|  24.18|
|Susceptible pine BA (m² ha⁻¹)                     | +0.343****| 0.015|  23.65|
|Quadratic mean diameter (cm)                      | -0.341****| 0.022| -15.37|
|Flight-window direct radiation (kWh/m2)           | +0.319****| 0.023|  13.98|
|July mean wind (km/h)                             | +0.286****| 0.014|  20.95|
|Sky view factor                                   | +0.285****| 0.023|  12.60|
|Wind shelter index                                | -0.267****| 0.021| -12.48|
|Stand age (years)                                 | +0.201****| 0.018|  11.31|
|Convergence index                                 | -0.077****| 0.015|  -5.07|
|Stand basal area x July mean wind                 | -0.077****| 0.016|  -4.81|
|Stand basal area x Flight-window direct radiation |  +0.073***| 0.020|   3.58|
|Profile curvature                                 | -0.059****| 0.014|  -4.10|
|June mean wind (km/h)                             |    +0.030*| 0.014|   2.20|
|Stand basal area x Wind shelter index             |     +0.023| 0.025|   0.89|
|Topographic position index                        |     -0.015| 0.023|  -0.64|


:::
:::



::: {#tbl-geomorphon .cell tbl-cap='Geomorphon landform classes in the full annual model M3, as coefficients against the reference class, slope, the most common class on the perimeter. Cells was the number of perimeter cells in each class and Attacked the share of those cells classed moderate-to-high over all years. Flat and pit did not occur on the perimeter. Significance was marked * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001.'}
::: {.cell-output-display}


|Class                                                                                                                                                                                                                            |  Cells| Attacked (%)|       Beta|    SE|
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------:|------------:|----------:|-----:|
|slope (reference)                                                                                                                                                                                                                | 72,262|          9.6|           |      |
|spur                                                                                                                                                                                                                             | 22,050|         12.6|    -0.075*| 0.035|
|hollow                                                                                                                                                                                                                           | 12,988|          6.0|     -0.091| 0.053|
|valley                                                                                                                                                                                                                           |  2,963|          3.8| -0.676****| 0.121|
|ridge#                                                                                                                                                                                                                           |  1,276|         11.0| -1.160****| 0.119|
|peak                                                                                                                                                                                                                             |    168|         22.6|    -0.523*| 0.227|
|# Ridge includes the 16 shoulder cells on the perimeter. No shoulder cell was classed as attacked in any year, so the class could not be estimated on its own and was counted with ridge, its neighbour on the geomorphon scale. |       |             |           |      |


:::
:::


Each mechanism improved the fit when it entered. AIC fell by 298 when stand density entered, by a further 322 with terrain and flight-window radiation, and by a further 562 with the interactions (@tbl-aic).

Stand basal area was the density term the penalty kept. It entered at +0.430 log-odds per standard deviation, an odds ratio of 1.537, so a stand one standard deviation above the mean in basal area had 53.7 per cent higher odds of moderate-to-high disturbance (p < 0.001), which is the direction a canopy that holds the pheromone plume together implies. Live stems and crown closure left at the penalty stage (@tbl-selection), and crown closure is in any case recorded by the inventory to a ceiling of 60 per cent.

Radiation entered the model once, as direct radiation during the flight window, at +0.319, the term that represents the temperature limit on flight. Growing-season radiation did not survive selection, so northness, which correlated -0.824 with it, stood in for the shading pathway. Northness entered at +0.384, so shaded, north-facing ground had more attack rather than less, against the prediction.

Terrain predicted attack after stand structure and radiation were in the model, and it did so through shelter and openness rather than through ruggedness, because neither terrain ruggedness nor the windward-leeward index survived selection (@tbl-selection). The wind shelter index as computed here rose on slopes that faced the prevailing wind, correlating +0.71 with that orientation, and it entered at -0.267 (p < 0.001), so leeward ground had more attack and windward ground less. Sky view factor, which is high on gentle, open, upper ground, entered at +0.285 (p < 0.001), so open, sheltered ground had the most attack, and the two valley terms, valley depth and height above the valley floor, left at the penalty stage once sky view and elevation were in the model. Elevation entered at +0.381. Of the shape terms, convergence entered at -0.077 and profile curvature at -0.059, and topographic position was not distinguishable from zero (p = 0.521). The landform classes are in @tbl-geomorphon.

The fifth question was tested by fitting the full model twice. Without flight-window radiation, stand density interacted with terrain shelter at +0.055, which on its own would read as plume disruption acting through terrain. With radiation in the model, that interaction shrank to +0.023 and was no longer distinguishable from zero (p = 0.371), while density interacted with radiation at +0.073, because on a range whose prevailing bearing was 258 degrees the windward slopes faced west, and those were also the slopes that took the afternoon sun, so 59 per cent of the apparent shelter interaction was radiation and the remainder was too small to support a claim. The shelter coefficient itself did not move between the two fits. Shelter therefore acted alone, as deposition predicts, and not through stand density, as plume disruption would require.


::: {.cell}
::: {.cell-output-display}
![The refugia mechanism as fitted in the sixteen-day models. (a) Predicted probability of moderate-to-high disturbance against terrain-adjusted epoch wind at the 10th and 90th percentiles of stem density, with all other terms held at their means. The lines crossed, so wind raised attack in thin stands and lowered it in dense ones, which was the interaction. (b) The same for standing volume, where the interaction was a fifth the size and flattened the dense-stand line without reversing it, so the lines converged rather than crossed over the observed range. (c) Coefficients of the sixteen-day model with and without the within-season spread term, where the shift of a term between the two fits was the part of it that the spread term absorbed. (d) Prevalence in each epoch against its mean wind, one point per epoch, with years distinguished by shape and shade so that the panel remained legible in black and white.](Manuscript_files/figure-html/fig-interaction-1.png){#fig-interaction width=2700}
:::
:::


## Density and wind

Stand density interacted negatively with terrain-resolved wind, which was the form the pheromone mechanism predicted, in that attack fell where a thin stand and strong wind coincided, the interaction being -0.049 for stem density (p < 0.001) and -0.017 for standing volume (p < 0.05). Expressed as odds, each standard deviation of the epoch wind regime multiplied the contribution of stem density by 0.952, a reduction of 4.8 per cent. Both interactions held after the previous epoch of the same season was entered, so neither was the outbreak's own spread appearing as a wind coefficient.

Wind alone gave no protection, because its main effect was +0.022, marginally more attack rather than less, and the density terms were positive, so that a thin stand in still air showed no reduction either and the mechanism appeared only where the two coincided.

## Previous-year pressure {#sec-autologistic}

Attack recurred where it had already occurred, by a margin large enough to change how every other coefficient should be read, in that a cell attacked in one year was between 9 and 88 times more likely to be attacked in the next. Entering persistence and 90 m neighbourhood spread separately, following the autologistic design used for this province, gave +0.725 and +0.692, raising discrimination from 0.774 to 0.857.

The result that mattered was which environmental terms held after that term entered. Sky view moved from +0.317 to +0.225 and the wind shelter index from -0.260 to -0.215, both describing conditions a cell had whether or not the beetle was ever present, whereas the shape terms were less stable, convergence moving from -0.081 to -0.045 and profile curvature from -0.064 to -0.036. Part of what the landform terms measured was therefore where the outbreak had already been, which was the same failure the terrain-wind index showed against radiation.

## Host as diameter {#sec-diameter}


::: {#tbl-qmd .cell tbl-cap='Moderate-to-high beetle disturbance by quadratic mean diameter class, on the balanced sample. The 25 cm boundary was the source-sink threshold of the species\' bionomics. Intervals were Wilson score intervals on the class proportion, which is why they were asymmetric in the smallest class. Because 30 m cells in a spreading outbreak were not independent, the tests reported beneath this table were anti-conservative.'}
::: {.cell-output-display}


|QMD class (cm) |      n| Attacked| Attacked (%)| 95% CI (%)|
|:--------------|------:|--------:|------------:|----------:|
|<15            |    395|      111|         28.1|  23.9-32.7|
|15-20          |  4,101|      783|         19.1|  17.9-20.3|
|20-25          |  9,286|    1,998|         21.5|  20.7-22.4|
|25-30          | 17,119|    5,391|         31.5|  30.8-32.2|
|30-40          | 10,247|    2,291|         22.4|  21.6-23.2|
|>40            |  1,643|      217|         13.2|  11.7-14.9|


:::
:::


Coding host as diameter changed the picture that cover alone gave, because attack peaked in the 25 to 30 cm class at 31.5 per cent and fell above it, to 22.4 per cent at 30 to 40 cm and 13.2 per cent above 40 (@tbl-qmd), the step across the 25 cm source-sink boundary running from 21.5 to 31.5 per cent.

In the full model diameter was -0.341 per standard deviation (z = -15.37), negative because the relationship was not monotone, since a linear term fitted through a humped response returned the slope of its falling limb, which was the larger part of the range. The class table rather than the coefficient was therefore the result here, and the interpretation stood, because a stand's cover said nothing about whether its stems could produce brood.

The pattern was not an artefact of the class boundaries, in that across all six classes attack depended on diameter class, $\chi^2$ = 678.2 on 5 degrees of freedom, p < 0.001, with Cramer's V = 0.126. The step across the 25 cm source-sink boundary specifically, from the 20 to 25 class to the 25 to 30 class, was +10.0 percentage points, 95 per cent confidence interval 8.9 to 11.1, p < 0.001. With 42,791 cells a chi-square was significant on trivial differences, which is why the effect size was quoted beside it, and 30 m cells in a spreading outbreak were not independent, so both p-values were anti-conservative.

## The wind window {#sec-window}

The wind variable was the epoch wind regime, the mean over every hourly station observation in the sixteen days an epoch covered, each hour modified over the terrain by its own bearing. It was not restricted to the flight window, and that choice followed from the way the insect was known to disperse. @jackson2008 tracked mountain pine beetle on weather radar and confirmed the returns by aerial capture, finding beetles "at altitudes up to more than 800 m above the forest canopy" and estimating that those in flight above the canopy "may move 30 to 110 km$\cdot$day$^{-1}$", at a mean density of 4,950 and a maximum of 18,600 beetles per hectare. @ainslie2010 subsequently reproduced that above-canopy dispersion with an atmospheric model. An insect carried in the boundary layer at those heights and over those distances was exposed to the atmospheric regime of the period rather than to the wind measured within a stand between noon and five, and the variable was named accordingly.

The 16-day model was refitted under four definitions of the window (@tbl-window), every hour, the 12:00 to 17:00 hours the flight peak occupied, the 11:00 to 18:00 hours that fell inside the thermal limits on this landscape more than half the time, and only those hours whose observed temperature fell inside the 19 to 41 degrees C range itself. The stem-density interaction was negative under all four definitions and distinguishable from zero under three, at -0.049 over the full regime and -0.037 and -0.041 over the two clock windows, and fell to -0.011 (p = 0.173) when the hours were restricted to those inside the thermal limits, where the standing-volume interaction was instead the larger of the two at -0.040 (p < 0.001). One of the two density terms therefore carried the interaction under every definition, but which one depended on how the window was drawn, so the mechanism did not rest on the choice while its expression through stems or through volume did.


::: {#tbl-window .cell tbl-cap='The 16-day model refitted under four definitions of the wind window. The epoch wind regime, every hour, was the definition used throughout this paper. Coefficients were log-odds per standard deviation. Significance was marked * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001. The thermal-limits row was fitted on fewer cell-epochs because two epochs had too few qualifying hours, so its row was not directly comparable with the other three.'}
::: {.cell-output-display}


|Definition                    | Cell-epochs| Wind (km/h)| Stems x wind| Volume x wind|   AUC|
|:-----------------------------|-----------:|-----------:|------------:|-------------:|-----:|
|Epoch wind regime (all hours) |      66,302|        5.01|  -0.0491****|      -0.0169*| 0.673|
|12:00-17:00                   |      66,302|        6.41|  -0.0369****|       -0.0131| 0.673|
|11:00-18:00                   |      66,302|        6.28|  -0.0413****|      -0.0173*| 0.673|
|Inside the 19-41 C range      |      64,895|        5.64|      -0.0108|   -0.0397****| 0.671|


:::
:::


# Discussion

## Two scales

The five questions resolved into one pattern, in which terrain acted on attack as a main effect of shelter and openness that did not depend on stand density, and wind acted on attack as an interaction with stand density that appeared only where wind varied in time. Deposition predicted the first and plume disruption the second, and neither mechanism produced the other's signature. The one place the two could have been confused, the density by shelter interaction, fell by 59 per cent when flight-window radiation entered and could not then be distinguished from zero, while the shelter main effect did not move, so a terrain index alone would have supported the plume mechanism on evidence that was partly sunlight.

That confusion was unlikely to be peculiar to the present dataset, because a shelter index and an afternoon radiation surface were both functions of slope and aspect, and on a range whose prevailing flight-window bearing was 258 degrees the slopes that met the wind were the west-facing ones, which were also the slopes taking afternoon sun during the flight peak. Any study entering a terrain wind index without a radiation term on the same clock would attribute radiation to wind.

## What was supported

Of the three mechanisms @krawchuk2020 proposed, two were supported and one failed. Low host density admitting the wind that disperses the aggregation pheromone was supported in the conditional form the mechanism specified rather than as a main effect, because the claim was never that dense stands were attacked more, but that a dense canopy held a plume together and that the advantage this conferred on the beetle should diminish as wind speed rose, and both halves of that prediction were present. A scarcity of large-diameter hosts was supported as a threshold rather than as a gradient, attack peaking at 31.5 per cent in the 25 to 30 cm class, at the source-sink boundary of @carroll2004bionomics, and falling away on both sides.

Topographic shading was not supported, and it failed on a surrogate rather than on the quantity the mechanism named, because growing-season radiation did not survive variable selection, so northness stood in for the pathway, the two correlating -0.824. Northness was +0.384, so that shaded ground had more attack where the mechanism required less. Northness tested aspect, and aspect measured more than shade, which made this the least secure of the three verdicts, and the water-stress pathway @krawchuk2020 described was not measured here at all.

The fifth question, which @krawchuk2020 did not pose, was answered as well, in that terrain shelter acted as a main effect and not through density, the deposition signature the companion study's ruggedness coefficient had been recording without being able to name.

## The wind claim

Stand density interacted with terrain-resolved wind at -0.049 for stem density and -0.017 for standing volume, both negative, at p < 0.001 and p = 0.039 respectively, so a dense stand conferred less advantage on the beetle where and when wind speed was higher, which was what @krawchuk2020 predicted. The result held after the previous epoch of the same season was entered, so it was not the outbreak's own spread appearing as a wind coefficient.

Two limits remained attached to the claim, in that the interaction was small, roughly a tenth of the stand basal area main effect, and the wind field remained terrain-modified station data rather than measurement on the ridge, so what was established was that the modelled wind field behaved as the mechanism required, not that the air itself did.

## Landing zones

Read with the dispersal literature, the terrain results described where beetles came down rather than where they chose to attack. @hynum1980 showed that landing was not host-directed, @jackson2008 that part of the population travelled far above the canopy, and @chen2017 that the descent phase of that transport was the least understood. A beetle descending through slowing air behaved as any wind-borne particle did and settled where the flow decelerated, in the lee of ridges and on sheltered slopes, which was what the shelter index measured and why the same index predicted where snow accumulated [@plattner2004]. Three results fitted that reading and none contradicted it, the first being that leeward ground had more attack as a main effect, -0.267, and that the effect did not detectably depend on stand density. The second was that open, gently sloping ground had more attack, sky view +0.285, and that the valley terms did not survive the penalty beside it. The third was that the density by wind interaction that plume disruption predicted appeared only in the sixteen-day models, where wind varied in time, and not through terrain, where it varied in space. Terrain shelter therefore read as a landing zone and the sixteen-day wind as plume disruption, two mechanisms at two scales rather than one.

The one prior study to read terrain this way found the opposite face of the same frame, in that @giroday2011 associated the highest infestation intensities in the Peace River region with southwest-facing open slopes and mid-slope ridges, the surfaces that met a westerly wind, after first establishment in canyons and valleys, whereas here the association was leeward and with open ground. Impaction on faces that met the wind and settlement where it slowed were both deposition, and which one a landscape showed may have depended on how much of its relief a descending beetle cleared.

The reading was an interpretation rather than an observation, because no beetle was tracked to the ground here, sky view factor also set diffuse radiation, so part of its coefficient may have been sunlight, and open upper ground warmed first, so the same pattern would have followed from faster development as readily as from deposition [@sambaraju2021]. The component reading was nonetheless what the parent study could not give, because a ruggedness index recorded that relief mattered without saying how.

## Confounded terms

Elevation was among the largest terms in the model at +0.381, but it was not a single quantity, combining temperature, snowpack, growing-season length and the distribution of lodgepole pine in a way this design could not separate, so reporting the elevation coefficient as a result would have been reporting a composite.

Three limits sat outside the model and bounded every result in it. The inventory postdated part of the outbreak, because polygons interpreted after the beetle passed described the stand it left, and total basal area discriminated only weakly on its own, a univariate AUC of 0.601. The response was classified rather than observed, from 38 plots inside one burn, so the reported accuracy measured how well the classifier reproduced those plots and not agreement with ground mortality elsewhere, and every conclusion rested on one mountain range across eight years.

## Conclusions

Terrain and wind acted on mountain pine beetle attack by two mechanisms at two scales. Across 59 sixteen-day epochs, stand density interacted negatively with terrain-resolved wind, -0.049 for stem density and -0.017 for standing volume, and both held after a within-season spread term was entered, so a dense canopy conferred less advantage on the beetle where and when wind speed was higher, which was what plume disruption required. Across the landscape, terrain shelter acted as a main effect and not through stand density, leeward ground having more attack at -0.267 whatever the stand, and open ground more still, which was what deposition of wind-borne beetles required. Sheltered open ground therefore behaved as a landing zone, and the ruggedness signal the companion study found on this landscape resolved into that surface.

Of the three mechanisms @krawchuk2020 named, two were supported. Host density was supported through stand basal area at +0.430, the one density term the penalty kept, and large-diameter host as a threshold at 25 to 30 cm rather than as a gradient, at the source-sink boundary of @carroll2004bionomics, whereas topographic shading was not supported, failing on its surrogate northness at +0.384.

Two measurement results extended beyond this landscape, in that a terrain wind index was in part a measurement of incident radiation, flight-window radiation having moved the density by shelter interaction from +0.055 to +0.023, and a landform variable in a spreading outbreak recorded in part where the outbreak had already been, previous-year attack having moved convergence from -0.081 to -0.045 while sky view moved only from +0.317 to +0.225.

For pest management the result meant that refugia could not be mapped from terrain alone, and that the map had two layers. A stand's exposure to the prevailing wind set how many beetles arrived, and its density during the windy weeks of the flight period set how many of those succeeded, so thinning could be expected to lower attack on windward ground during windy flight periods and to do little on the sheltered lee slopes where beetles came down, and only by the modest margin the interaction measured.

# References {.unnumbered}

::: {#refs}
:::

# Statements and declarations {.unnumbered}

## Funding {.unnumbered}

The author declares that no funds, grants, or other support were received during the preparation of this manuscript.

## Competing interests {.unnumbered}

The author has no relevant financial or non-financial interests to disclose.

## Ethics approval {.unnumbered}

This study used only publicly archived remote sensing, inventory and meteorological data. No animals, human participants or protected material were involved, so no ethics approval was required.

## Data availability {.unnumbered}

Every dataset used here is public and none was collected by the author. Beetle disturbance is classified from Landsat Collection 2 Level-2 surface reflectance. Stand structure is the provincial Vegetation Resources Inventory layer `VEG_COMP_LYR_R1_POLY`, retrieved from the British Columbia Data Catalogue web feature service by `02.inputs/beetle/34-fetch-vri.py`. Terrain derives from the Natural Resources Canada High Resolution Digital Elevation Model [@nrcan2017], with geomorphometry computed by SAGA GIS in `37-geomorphometry.R`. Wind is Environment and Climate Change Canada hourly station data, retrieved by `30-wind-hourly-metrics.R` and `36-wind-direction.R`.

All derived data and the complete analysis code that reproduce every number, table and figure in this article are available at <https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study>.

```{=html}
<!-- Journal of Pest Science requires a data availability statement and "strongly
     encourages" a repository deposit; it does not mandate one for data of this kind.
     The statement therefore names the public repository alone. Seamus ruled on
     2026-09-01 that no Dryad deposit is needed unless the journal states otherwise. -->
```

# Figure legends {.unnumbered}

**Figure 1.** Landscape, terrain and stand surfaces across the study area, all EPSG:3153 at 30 m over Esri World Shaded Relief. (a) elevation; (b) terrain ruggedness index; (c) windward-leeward index at the prevailing bearing; (d) flight-window direct radiation, the thermal limit on flight; (e) growing-season direct radiation, the shading pathway; (f) the MicroMet wind weighting factor at the prevailing bearing; (g) stand basal area; (h) quadratic mean diameter, whose 25 cm source-sink threshold fell near the midpoint of the scale; (i) live stems per hectare. The white outline marked the study perimeter and the red outline the 2015 Mt Midgeley burn, with contours at 200 m.

**Figure 2.** Spread of moderate-to-high beetle disturbance across the study perimeter. (a) The first year in which each cell entered the moderate-to-high class, over shaded relief with the perimeter in white and the 2015 Mt Midgeley burn in red; cells never classed as attacked showed the relief alone. The panel was built from the eight annual maps for display, and those maps were fitted separately and never merged for analysis. (b) The share of perimeter cells classed moderate-to-high in each year.

**Figure 3.** The flight window against the landscape's own climate, from hourly Environment and Climate Change Canada station records for May to September of the nine study years. The shaded band marked the window, 1 July to 15 August, taken from the bionomics and not fitted to these data. (a) Mean afternoon temperature by day of year, with the 19 to 41 degrees C flight range and the 22 to 32 degrees C peak band marked. (b) The share of afternoon hours inside the flight range, day by day. (c) Mean temperature and the share of all hours inside the flight range, by hour, with the 12:00 to 17:00 restriction shaded. (d) Mean wind speed by hour on the same axis, showing that the hours in which the beetle could fly were also the windiest of the day.

**Figure 4.** The refugia mechanism as fitted in the sixteen-day models. (a) Predicted probability of moderate-to-high disturbance against terrain-adjusted epoch wind at the 10th and 90th percentiles of stem density, with all other terms held at their means. The lines crossed, so wind raised attack in thin stands and lowered it in dense ones, which was the interaction. (b) The same for standing volume, where the interaction was a fifth the size and flattened the dense-stand line without reversing it, so the lines converged rather than crossed over the observed range. (c) Coefficients of the sixteen-day model with and without the within-season spread term, where the shift of a term between the two fits was the part of it that the spread term absorbed. (d) Prevalence in each epoch against its mean wind, one point per epoch, with years distinguished by shape and shade so that the panel remained legible in black and white.


::: {.cell}

:::



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
 [1] shape_1.4.6.1       gtable_0.3.6        xfun_0.57          
 [4] htmlwidgets_1.6.4   lattice_0.22-9      vctrs_0.7.2        
 [7] tools_4.4.1         generics_0.1.4      tibble_3.3.1       
[10] proxy_0.4-29        pkgconfig_2.0.3     Matrix_1.7-5       
[13] KernSmooth_2.23-26  data.table_1.18.2.1 RColorBrewer_1.1-3 
[16] S7_0.2.1            lifecycle_1.0.5     compiler_4.4.1     
[19] farver_2.1.2        codetools_0.2-20    htmltools_0.5.9    
[22] class_7.3-23        yaml_2.3.12         glmnet_4.1-10      
[25] Formula_1.2-5       pillar_1.11.1       classInt_0.4-11    
[28] iterators_1.0.14    wk_0.9.5            abind_1.4-8        
[31] foreach_1.5.2       tidyselect_1.2.1    digest_0.6.39      
[34] purrr_1.2.1         labeling_0.4.3      splines_4.4.1      
[37] rprojroot_2.1.1     fastmap_1.2.0       grid_4.4.1         
[40] here_1.0.2          cli_3.6.5           magrittr_2.0.4     
[43] survival_3.8-6      withr_3.0.2         scales_1.4.0       
[46] rmarkdown_2.30      otel_0.2.0          reticulate_1.45.0  
[49] png_0.1-9           evaluate_1.0.5      viridisLite_0.4.3  
[52] s2_1.1.9            rlang_1.1.7         Rcpp_1.1.1         
[55] glue_1.8.0          DBI_1.3.0           pROC_1.19.0.1      
[58] jsonlite_2.0.0      R6_2.6.1            units_1.0-1        
```


:::
:::



::: {.cell}

:::

