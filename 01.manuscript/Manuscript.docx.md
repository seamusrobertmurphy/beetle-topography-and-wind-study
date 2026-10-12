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
  - disturbance refugia
  - Curculionidae
  - Scolytinae
  - British Columbia
  - thinning
  - dispersal
  - topography

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
  echo: true
  warning: false
  message: false
  error: false
  comment: NA

always_allow_html: true
engine: knitr
citeproc: true
editor: visual
bibliography: ../04.references/references-beetle.bib
# Agricultural and Forest Entomology asks for the Harvard system, so the style file is 
# the Citation Style Language repository's apa.csl, fetched 2026-09-16. The Springer and 
# APA 6th files stay in 04.references
csl: ../04.references/apa.csl
df-print: kable
---


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


**Running title.** Terrain, wind and mountain pine beetle refugia

**Correspondence.** Seamus Murphy, TÜV SÜD, 2187 Comox Ave, Comox, British Columbia V9M 1P5, Canada. seamusrobertmurphy\@gmail.com. ORCID 0000-0002-1792-0351.

**Keywords.** Mountain pine beetle, Disturbance refugia, Curculionidae, Scolytinae, British Columbia, thinning, dispersal, topography

**Data availability statement.** Landsat Collection 2 surface reflectance, the British Columbia Vegetation Resources Inventory, the Natural Resources Canada High Resolution Digital Elevation Model [@nrcan2017] and Environment and Climate Change Canada hourly station records are public. The derived data and the analysis code that reproduce every number, table and figure are at <https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study> and will be deposited in the Dryad Digital Repository with the revised manuscript. The 28 field plots of @murphy2026 were used with the permission of its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks.

**Conflict of interest statement.** The author declares no conflict of interest. The field plots used to train the classifier were collected under an earlier study the author led [@murphy2026] and are used with its co-authors' agreement.

**Author contributions.** Seamus Murphy conceived and designed the study, assembled the data, wrote the code, performed the analysis and wrote the manuscript. The field plots and the Landsat classifications of red-stage mortality came from @murphy2026, whose co-authors took no part in the present article.

**Acknowledgements.** This work used no external funding. The author thanks the United States Geological Survey, the British Columbia Data Catalogue, Natural Resources Canada and Environment and Climate Change Canada for the open archives the study used.

{{< pagebreak >}}

# Abstract {.unnumbered}

1.  Disturbance refugia from mountain pine beetle (*Dendroctonus ponderosae*) outbreaks have been proposed in thin stands of small trees, on shaded ground and where wind disrupts the aggregation pheromone, but little is known about how these mechanisms act together once attack nearby and earlier is taken into account.
2.  This study mapped red-stage attack in nine outbreak years and 47 sixteen-day Landsat periods across 5,573 ha of the Selkirk Mountains, British Columbia, with a classifier validated on field plots, and modelled it on annual forest inventory, terrain and a terrain-resolved wind field, entering the previous year's attack first.
3.  Attack was clustered in every year, with positive spatial autocorrelation to a median of 2,640 m, and attack in and around a cell the year before dominated every model.
4.  Beside those terms attack rose with stand basal area (+0.167 log-odds per standard deviation, p < 0.001) and peaked in stands of 25 to 30 cm mean diameter, and north-facing ground had more attack rather than less. Flight-period wind lowered attack only where the canopy was open, and the effects of terrain shelter and openness did not survive a latent spatial field.
5.  Refugia on this landscape were stands with little host, and terrain and wind added small, scale-dependent modifiers to an outbreak whose spread was mostly contagion.

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins \[Coleoptera: Curculionidae: Scolytinae\]) is a bark beetle native to the pine forests of western North America, where lodgepole pine (*Pinus contorta* var. *latifolia* Engelm. ex S. Watson) is its main host through most of its range [@safranyik2006chap1; @cooke2026mountain]. Endemic populations persist in weakened and suppressed trees, and outbreaks occur infrequently followed by sharp population declines [@safranyik2006chap1; @raffa2008cross]. After 1976, when the Pacific Decadal Oscillation of Ocean temperatures entered its warm phase, extreme winter cold that kills the brood under the bark became rarer across the province [@maciasfauria2009], and carried by wind, the outbreak then crossed the northern Rocky Mountains [@giroday2012].

In north-central Colorado and southern Wyoming, mapped from Landsat images for 1996 to 2011, tree mortality rarely reached 100 per cent even in a major outbreak [@meddens2014]. Places within stands where more trees survive are considered disturbance refugia, which @krawchuk2020 defined as locations disturbed less severely or less frequently than the landscape around them, noting that "few studies have explicitly identified refugia from insect outbreaks" (p. 235). They proposed that refugia from this beetle may occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" [@krawchuk2020, p. 239]. In southern Oregon, refugia mapped from Landsat imagery during a severe outbreak in 2009 were "associated with topographically shaded slopes, convergent environments such as valleys, areas of relatively low soil bulk density, and in thinner forest stands" [@cartwright2018, p. 1].

In experimental stands of lodgepole pine, trees contained a few attacking beetles but died once the bark held more than about 40 beetle galleries per square metre [@raffa1983], and over three to six years tree defences made no difference once beetle numbers in a stand passed a critical threshold [@boone2011efficacy]. Once an outbreak is under way, whether a tree is killed therefore depends more on how many beetles are nearby than on its own defences. Populations become outbreaks once they can kill the average large tree in a stand [@shore2006], and lodgepole pines larger than 25 cm in diameter, whose thicker phloem feeds more larvae, produce on average more beetles than attack them [@carroll2004bionomics; @safranyik2010]. When marked beetles were released in a mature lodgepole pine stand, most were caught 3 m above the ground and only 0.2 per cent rose above the canopy [@safranyik1992]. Within a stand beetles fly under the crowns, downwind until they meet the scent of an attacked tree and then upwind towards it [@safranyik1989; @carroll2004bionomics], and new clusters of attack appeared 30 to 50 m from those of the year before [@robertson2007mountain]. On the Chilcotin Plateau an outbreak in a 12 km cell was best predicted by outbreaks in the neighbouring cells that year or in the same cell in the two years before [@aukema2008], and tree by tree in the Cypress Hills of Saskatchewan, infestations nearby in the previous year were the strongest single predictor of attack in every phase of the outbreak [@kunegel2020factors].

Cold is the largest single effect of weather on the beetle's numbers, and where summers are too cool for the brood to develop in one year, as at high elevations, mortality is severe and mass attack less successful [@safranyik2006chap1; @logan2001]. In Colorado and southern Wyoming the outbreak began in several separate places, which suggested drought as a regional trigger [@chapman2012spatiotemporal], and in Oregon and Washington, once beetle numbers nearby were accounted for, winter minimum temperature and drought had the largest effects on whether an outbreak grew large [@preisler2012climate]. Within a landscape temperature follows the sun on each slope, and in the Morice Timber Supply Area of north-central British Columbia the most intense infestations were found early on warmer slopes facing south and west [@nelson2007environmental]. Elsewhere terrain entered as elevation, slope and aspect, whose effects followed the phase of the outbreak and the host. In Colorado the best predictors of red attack changed "from forest susceptibility to dispersal to host availability" as the outbreak grew [@walter2013, p. 317], and in western Montana the odds of red stage attack rose with elevation because lodgepole pine grew higher than the Douglas-fir around it [@wulder2006red].

Thinned lodgepole and ponderosa pine stands across the western United States lost fewer trees to the beetle [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness]. @mitchell1983thinning attributed this to the vigour of the remaining trees, while @bartos1989, in the Uinta Mountains of Utah, proposed microclimate, having measured more light, warmth and wind in a thinned stand than in the unthinned stand beside it, a wind difference that doubled to at least 3.2 km/h between 4 and 6 p.m., when most beetles flew. In crowded stands, however, trees grow slowly and have thin phloem, so adding trees can raise attack in an open stand and lower it in a crowded one [@shore2006].

Wind can lower attack by breaking up the pheromone plume, the trail of scent downwind of an attacked tree, which @krawchuk2020 called "wind disruption of beetle pheromone communication" (p. 239), most of all in open stands, where more wind reaches the trunks [@bartos1989]. Wind can also concentrate attack, because "alterations in wind speed may cause increased settlement in areas where wind speed is reduced" [@giroday2011, p. 1098], and the first beetles to arrive were "unable to distinguish between hosts, dead hosts and nonhosts during landing" [@hynum1980] and judged a tree only after landing [@safranyik2010], so ground sheltered from the wind should receive more attack whatever the stand. Both effects act only during flight, which peaks in the early to mid afternoon [@safranyik2006chap1] and stops in winds above about 2 metres per second [@carroll2004bionomics], and studies of flight above the canopy resolved wind over terrain but not within the stand [@jackson2008; @ainslie2010].

Few studies had tested these mechanisms together while accounting for attack nearby. This study mapped red-stage attack, trees whose needles had turned red in the year after they were attacked, across part of the Selkirk Mountains of southeastern British Columbia from the 28 field plots of an earlier study on the same ground [@murphy2026], once a year to test the refugia mechanisms and every sixteen days to test wind. It asked three questions, the first whether stand density, shading by terrain and the scarcity of large trees predicted attack once attack nearby was in the model, the second whether wind during flight lowered attack more in open stands than in closed ones, as disruption of the pheromone plume predicted, and the third whether ground sheltered from the afternoon wind, or facing away from it, had more attack whatever the stand, as deposition predicted.


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


# Methods

## Site terrain


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


The study area covered 5,573 ha on the eastern face of the Selkirk Mountains in southeastern British Columbia, above the Creston valley where the Kootenay River enters the south arm of Kootenay Lake (@fig-spread), from 830 to 1,744 m in elevation. It was centred on the 480 ha burned by the 2015 Mt Midgeley fire [@murphy2026] and extended 5 km beyond the burn within the same band of elevation, to take in the range of stand density the pheromone mechanism needed. Along the latitude of its centre the ground fell from 2,072 m to 531 m within 7.6 km (Figure S3). The area held 61,923 cells of 30 m on the grid of @murphy2026. Attack was mapped once a year for the questions on refugia and every sixteen days for the wind test, the inventory once a year, the station winds every hour and the terrain once overall (Table S1).


::: {.cell}

:::



::: {.cell}
::: {.cell-output-display}
![The study area and its red-stage attack. (a) Regional setting over the Copernicus 30 m elevation model. The red fill is the study perimeter, 5,573 ha, the black box the window of the 1 m lidar, the orange outline the 2017 lidar project, the green dashed box the regional wind domain, the blue grid the ERA5-Land reanalysis at 0.1 degree, the yellow triangles the seven hourly stations within 150 km, the black line the profile of Figure S3, and the long dash the Canada and United States border. (b) The first year each cell was attacked, with the 2015 Mt Midgeley burn in red. (c) The share of the perimeter attacked each year, black, and in each sixteen-day period, grey, the periods of each summer joined.](Manuscript_files/figure-docx/fig-spread-1.png){#fig-spread}
:::
:::


Stand structure came from British Columbia's Vegetation Resources Inventory, the snapshot published in each study year, rasterised to the 30 m grid (@tbl-variables). The attributes were basal area, crown closure, live stems per hectare, quadratic mean diameter of stems of 12.5 cm and larger, stand age, stand height, standing volume and susceptible pine basal area, the product of basal area and pine cover. The 2007 snapshot omitted basal area and live stems, so the 2006 snapshot stood in for it. The inventory is a projection rather than a census, and polygons interpreted from photographs taken late in the outbreak described stands the beetle had already attacked.

Terrain was computed in SAGA GIS from an elevation model extending beyond the perimeter, so that search radii near the edge fell on measured ground, and split terrain ruggedness into the properties of the ground the beetle's biology concerns, with ruggedness kept as a candidate. Exposure was measured by the windward-leeward index, effective air flow height, the wind exposition index, topographic openness, sky view, the wind shelter index of @plattner2004 and geomorphon class, which assigns each cell a landform such as ridge, slope or valley. Landform was measured by wetness, valley depth and height above the valley floor, because groups of infested trees are "frequently associated with draws and gullies" [@safranyik2006chap1, p. 41]. Aspect entered as northness, eastness and a heat load index. Radiation was computed for the flight window, 1 July to 15 August from 12:00 to 17:00, and for the growing season, 1 May to 30 September, over which shading can protect trees from water stress [@krawchuk2020]. Table S3 lists the variables that entered the models with the mechanism each represents.

## Beetle outbreak


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


The response for the first and third questions was red-stage attack in each outbreak year from 2006 to 2014, measured, following @murphy2026, as the fall in the normalised difference moisture index (NDMI) from its value in 2005, when the outbreak began. NDMI tracks the moisture of the canopy and is used to detect forest disturbance in Landsat time series [@jin2005], and @murphy2026 validated their map of the burn site against 28 field plots of 20 by 20 m, in which beetle-killed pine was confirmed from pitch tubes, frass and the pattern of the egg galleries.

Each year was mapped from the median of cloud-masked Collection 2 Level-2 Landsat 5 and 8 scenes of 1 June to 31 August, differenced against 2005 and resampled by nearest neighbour onto the 30 m grid of @murphy2026, with Landsat 8 converted to the Landsat 5 scale by the coefficients of @roy2016 and matched to the Landsat 5 range over undisturbed forest. With lakes and rivers masked, attack covered from 9.9 to 20.7 per cent of the perimeter by year (Table S2, @fig-spread).

No Landsat 5 or Landsat 8 images were taken in the summer of 2012, so its map was drawn from the median of the summer's Landsat 7 scenes, which filled most of the strips that the failed scan-line corrector left in each one [@wulder2011continuity]. The index was put on the Landsat 5 scale by a line fitted on stable forest in 2010, when both satellites flew.

The response for the second question was red-stage attack in each sixteen-day period, the Landsat revisit interval, from 1 May to 22 September of the same years, with NDMI as the median of the period's scenes differenced against the same period of 2005, so that the seasonal course of leaf moisture did not enter the difference. Periods in which the imagery saw less than a tenth of the perimeter were dropped, leaving 47 periods over eight years (Table S5).

The fall in NDMI that counted as attack was set by a classifier trained on the four pixels nearest the centre of each field plot, 112 pixels, against the 84 points of undisturbed forest that @murphy2026 digitised on the 2020 Landsat 8 scene, which fell in 68 distinct cells, each pixel entering with its deepest annual fall in NDMI against 2005. Random forest, a radial support vector machine and gradient boosting were scored over 100 splits, each holding out a quarter of the field plots and of the 100 m blocks of undisturbed pixels. The radial support vector machine was the most accurate, with kappa 0.859 ± 0.081 and overall accuracy 0.934 (Table S10; Table S6), and its cut, a fall in NDMI of 0.0616 against 2005, was applied to the annual and sixteen-day differences. The undisturbed pixels came from one patch of about 230 by 455 m, so the cross-validation measured how well the plots were separated from that patch rather than from undisturbed forest across the landscape.

Wind was summarised over the afternoon flight hours, 12:00 to 17:00, the flight period @safranyik2006chap1 identified for this region (p. 18), which overlaps the emergence peak of 11:00 to 14:00 that @gray1972 recorded in eastern Washington. Across 236,079 hourly station records from May to September, 89.5 per cent of afternoon hours between 1 July and 15 August fell within the 19 to 41 degrees C in which beetles fly [@mccambridge1971], against 51.4 per cent in the rest of the season (Figure S18).



Hourly speed and direction from Environment and Climate Change Canada stations within 150 km were combined as vector components, adjusted for terrain with the MicroMet model of @liston2006, which weights each observation by the slope in the wind direction and the curvature of the ground, and interpolated to the grid by inverse distance weighting. Each sixteen-day period was summarised by its mean flight-hour wind, which ran from 4.0 to 8.6 km/h between periods, and each year by its mean wind of June and of July.


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


## Wind and lift

Wind over the terrain was modelled with WindNinja 4.0.0 [@forthofer2014], driven by the hourly ERA5-Land reanalysis [@munozsabater2021] for every flight hour of June to August 2005 to 2014 with its slope winds on, at 90 m over the study area, at 30 m and 10 m for each flight window, and at 500 m and 1 km over the surrounding valleys for checking against stations. Each cell received the mean speed, corrected by the model's loss of speed on flat ground, a factor of 1.63 at 90 m, the share of hours in which the air moved upslope, and the slope updraft. At the valley stations the modelled direction erred by about 60 degrees (Table S10), so these terms were read as each slope's exposure to the regional flow, and the valley wind was taken from 28 provincial stations (Figure S4).

Convective lift, the speed of rising air in the afternoon, was the Deardorff velocity scale from the ERA5-Land sensible heat flux and the ERA5 boundary layer height, scaled by each slope's share of the flight-window sun. Back-trajectories from HYSPLIT on the North American Regional Reanalysis traced the air over the site twelve hours back from 14:00 on every flight day of 2005 to 2013, and the share of their endpoints over red attack in the provincial and US Forest Service surveys entered the models as a source term. Sun on each slope was recomputed with r.sun in GRASS GIS under each hour's cloud, afternoon air temperature with microclima, refitted to Landsat land surface temperature, and the Landsat land surface temperature of the flight window and the roughness, north-facing share and spread of position of the 1 m lidar terrain within each cell entered as further terms.

These terms were read at the scales the beetle's flight allows. Beetles that rise above the canopy travel on the wind, an estimated 30 to 110 km in a day [@jackson2008], so the terrain wind, the lift and the trajectories described which slopes the above-canopy stream reached. Within a stand a surrogate pheromone fell to about a tenth of its concentration within 10 m [@thistle2004surrogate, as read by @brush2024spread], an effect that entered the models only through attack in and around the cell. The wind terms were therefore read as predictors of where beetles arrived and not of where they settled, and each entered the models from the same period or flight window of the previous summer, one term to a specification (Table S3).

## Model design


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


Before any model was fitted, the spatial pattern of attack was described on each annual map, with attack present or absent in each cell. The join count [@moran1948] counted pairs of neighbouring attacked cells among the eight around each cell, and Moran's I [@moran1950] was computed in distance classes of 60 m out to 6 km as a correlogram [@legendre1989], both against 999 random permutations of the attacked cells among the cells mapped that year. The range of positive autocorrelation was the first distance class at which Moran's I no longer exceeded the permuted values at p ≤ 0.05.

The annual models were built in the order @aukema2008 used, in which they first "determined an appropriate spatial neighborhood structure(s) and time lag(s) to account for spatial and temporal dependencies" (p. 351) and only then entered environmental variables. The first dependence term was the cell's own state in the previous outbreak year, and the second the share of cells attacked around it in that year within 42, 90, 150, 210, 510 or 1,050 m, excluding the cell itself, with the radius chosen on AIC (Table S7). Each year contributed up to 4,000 attacked and 4,000 unattacked cells, because at a landscape prevalence near one cell in ten an unbalanced fit would report its intercept rather than its covariates.

The 52 environmental variables were grouped by mechanism (@tbl-variables) and entered four logistic regressions in sequence, each adding one mechanism to the one before, and each was scored on its full fit, under ten-fold cross-validation on 1 km blocks and on a blind test that fitted the years to 2012 and predicted 2013 and 2014 (Table S9). Every model included the geomorphon class of the cell, and every continuous term was standardised, so that each coefficient was a change in log-odds per standard deviation. The sequence was fitted on all nine years without the dependence terms and on the eight years with a previous map without and with them, so that the change in each environmental term once attack nearby entered could be read directly. Before the final model was read, each candidate was screened on the years with a previous map by a likelihood ratio test of the variable added alone to the two dependence terms, by its variance inflation against the main effects of M3, and by its coefficient in an elastic net [@zou2005] that entered every candidate together with the dependence terms unpenalised, and its distribution was tested by the Shapiro-Wilk test on 5,000 cell-years (@tbl-variables).

Each annual model took the form

$$\operatorname{logit}\,\Pr(y_{it} = 1) = \alpha + \mathbf{x}_{it}^{\top}\boldsymbol{\beta} + \gamma_{g(i)} + \sum_{k} \delta_k\, z_{k,it} + \rho_1\, y_{i,t-1} + \rho_2\, \bar{y}_{i,t-1}$$ {#eq-annual}

where $y_{it}$ was attack in cell $i$ in year $t$, $\mathbf{x}_{it}$ the standardised environmental terms of the model with coefficients $\boldsymbol{\beta}$, $\gamma_{g(i)}$ the effect of the geomorphon class of the cell, $z_{k,it}$ the interactions of basal area with the wind shelter index, the July wind and the flight-window radiation that entered in M3, $y_{i,t-1}$ the cell's own attack in the previous outbreak year and $\bar{y}_{i,t-1}$ the share of cells attacked within 150 m of it in that year. The last two terms were the dependence terms, present only in the fits over the eight years with a previous map.

The first and third questions were answered with these annual models, the third by comparing the main effect of the wind shelter index with its interaction with basal area, in M3 with and without flight-window radiation. Each interaction was read as the slope of one term at one standard deviation either side of the mean of the other. Attack was also tabulated by quadratic mean diameter class, with Wilson intervals, a chi-square test across classes and a two-proportion test across 25 cm, the diameter @carroll2004bionomics gave as the boundary between beetle sinks and sources.

The second question was tested on the sixteen-day maps, on which wind varied between periods within a season as well as between years. Attack in a period was regressed on 15 stand and terrain variables, mean flight-hour wind, the geomorphon class and the interactions of wind with stand structure (E1), and E2 added the cell's own state in the previous period and the share attacked within 90 m around it, chosen on AIC, with each period contributing up to 2,000 cells of each class. Because the red crowns of a period recorded the flight of the previous summer, every wind test was also run with the wind of the same period one year earlier.

The sixteen-day models took the form

$$\operatorname{logit}\,\Pr(y_{ip} = 1) = \alpha + \mathbf{x}_{ip}^{\top}\boldsymbol{\beta} + \gamma_{g(i)} + \theta\, w_{ip} + \sum_{k} \delta_k\, s_{k,ip}\, w_{ip} + \rho_1\, y_{i,p-1} + \rho_2\, \bar{y}_{i,p-1}$$ {#eq-period}

where $y_{ip}$ was attack in cell $i$ in period $p$, $w_{ip}$ the flight-hour wind of the period, from the stations or from the terrain wind model, or the wind of the same period of the previous summer, $s_{k,ip}$ the stand terms it interacted with, and the last two terms the dependence terms of E2, which E1 lacked.

Residual autocorrelation was measured as Moran's I of the deviance residuals within each year. M3 with the dependence terms was then refitted with a Gaussian process smooth of easting and northing [@wood2017], its range set to the median range of positive autocorrelation, 2,640 m, and on cells coarsened to 90, 270 and 990 m with the dependence terms rebuilt at each grain, a coarse cell counting as attacked if any 30 m cell inside it was, as @aukema2008 defined their 12 km cells.

The refit under the spatial field took the form

$$\operatorname{logit}\,\Pr(y_{it} = 1) = \eta_{it} + f(e_i, n_i)$$ {#eq-field}

where $\eta_{it}$ was the linear predictor of @eq-annual with the dependence terms and $f$ a Gaussian process smooth of the easting $e_i$ and northing $n_i$ of the cell, with a Matérn covariance at that range and 200 basis functions.

Further terms were tested beside M3 and E2 and are described in the Supporting Information. These were valley and ridge flatness, canopy height from lidar, winter minimum temperature, station pressure, and attack upwind and downwind of each cell weighted by winter survival.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::






























# Results {#sec-results}

Across the 5,573 ha perimeter and the nine outbreak years from 2006 to 2014, attack was clustered in every year, with 3.2 to 5.8 times as many neighbouring pairs of attacked cells as random permutation produced and positive autocorrelation to a median of 2,640 m (Figure S17). Attack in the cell and within 150 m the year before dominated every model it entered. A cell attacked the year before had 9.1 times the odds of attack, and the two terms raised the area under the receiver operating characteristic curve (AUC) of M3 from 0.814 to 0.890. Of the 31 candidate variables, 28 improved the fit by likelihood ratio test once the dependence terms were in the model, the elastic net kept 16, and the largest variance inflation among the main effects of M3 was 2.9 (@tbl-variables; Table S13). Each estimate below is a change in log-odds per standard deviation with the dependence terms in the model unless stated otherwise.


::: {#tbl-variables .cell tbl-cap='Descriptive statistics and screening of red-stage attack and the variables of M3 over the 72,000 sampled cell-years before standardisation. Mean, standard deviation (SD) and skewness over the sample, Shapiro-Wilk W on 5,000 cell-years, and the screening on the years with a previous map, β the slope of the variable added alone to the two dependence terms, the deviance it explained and the p-value of the likelihood ratio test. The landform class was screened as a whole by the same likelihood ratio test. Table S3 defines each variable. * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001.'}
::: {.cell-output-display}


|Covariate                                   |      Mean|      SD|  Skew|     W|       β| Deviance|   LR-test|
|:-------------------------------------------|---------:|-------:|-----:|-----:|-------:|--------:|---------:|
|Red-stage attack (%), 2006 to 2014          |      14.6|    3.65| +0.30|      |        |         |          |
|Susceptible pine basal area (m² ha⁻¹)       |      8.47|    10.3| +1.31| 0.804| +0.3329|   886.97| 0.001****|
|Stand age (years)                           |       113|    25.4| +1.30| 0.893| +0.0923|    85.93| 0.001****|
|Quadratic mean diameter (cm)                |      26.5|    6.11| +1.10| 0.934| -0.0141|     2.19|     0.139|
|Sky view factor                             |      88.3|    4.86| -0.47| 0.984| +0.4119| 1,362.54| 0.001****|
|Northness                                   |     0.214|   0.685| -0.45| 0.886| +0.0435|    18.26| 0.001****|
|Elevation (m)                               |     1,400|     276| -0.54| 0.906| +0.7528| 3,987.76| 0.001****|
|Stand basal area (m² ha⁻¹)                  |      35.3|    12.4| -0.78| 0.915| +0.1961|   371.10| 0.001****|
|Wind shelter index                          |        21|    29.8| +1.70| 0.597| +0.0650|    43.04| 0.001****|
|Topographic position index                  |      3.12|    16.1| -0.51| 0.977| +0.1393|   201.48| 0.001****|
|Convergence index                           |     0.538|    8.81| -0.07| 0.974| +0.0668|    41.60| 0.001****|
|Profile curvature                           | 0.0000622| 0.00227| -0.06| 0.992| +0.0457|    21.34| 0.001****|
|Flight-window direct radiation (kWh/m²)     |       140|    37.6| -0.15| 0.993| +0.2147|   469.53| 0.001****|
|July mean wind (km/h)                       |      7.17|   0.576| +0.25| 0.916| +0.2349|   501.58| 0.001****|
|June mean wind (km/h)                       |      7.18|   0.508| -0.28| 0.948| +0.0526|    17.97| 0.001****|
|Landform class, seven classes against slope |          |        |      |      |        |   139.51| 0.001****|


:::
:::


## Refugia mechanisms

The first question asked whether stand density, shading by terrain and the scarcity of large trees predicted attack once attack nearby was in the model. The refugia hypothesis predicted less attack in thin stands, on ground shaded by terrain and in stands without large trees. Density and shade moved as predicted and host size did not. Attack rose with stand basal area, +0.167 (p < 0.001), so the thinnest stands had the least attack. The term was +0.276 without the dependence terms (p < 0.001), +0.200 under the spatial field (p < 0.001) and +0.094 at a 270 m grain (p = 0.026), and basal area lowered AIC by 478 when it entered, more than any other step of the sequence (@tbl-final; @fig-coefficients; Table S9). Crown closure gave the same direction in the sixteen-day model, +0.129 (p < 0.001), while live stems per hectare, which counted small trees as well as large, ran the other way, -0.043 (p < 0.001). The sun of the flight window raised attack in dense stands and not in thin ones, by +0.133 (p < 0.001) one standard deviation above the mean basal area against +0.037 (p = 0.070) one below it.

Ground shaded by terrain had less attack. Sky view, the share of the sky a cell saw, entered at +0.170 (p < 0.001) and the direct sun of the flight window at +0.085 (p < 0.001), so attack rose with open sky and with sun, as the hypothesis predicted. Northness ran against it. Ground facing north had more attack, +0.073 (p < 0.001), and the term grew under the spatial field to +0.133 (p < 0.001), while sky view fell under the field to +0.037 (p = 0.285) and was -0.003 at a 270 m grain (p = 0.945). Shade by terrain therefore protected ground at 30 m once attack nearby was in the model, and the protection did not survive the field, whereas the warmth of a south face protected nothing at any grain.

The hypothesis predicted less attack where large trees were few, so attack rising with tree size. Attack instead fell with quadratic mean diameter, -0.136 (p < 0.001), and -0.069 under the field (p < 0.001). By diameter class, attack rose from 48.1 per cent of the balanced sample at 20 to 25 cm to 56.4 per cent at 25 to 30 cm and fell to 46.6 per cent at 30 to 40 cm and 35.4 per cent above 40 cm \[χ²(5) = 980.1, p < 0.001, Cramér's V = 0.117\], a step of 8.2 percentage points across the 25 cm source threshold (95 per cent confidence interval 7.3 to 9.1, p < 0.001). The stands of the largest trees held the least pine, 0.4 m² ha⁻¹ of susceptible pine basal area against 10.1 at 25 to 30 cm, and susceptible pine basal area itself entered at +0.090 (p < 0.001). Host size therefore acted as a threshold at 25 cm and not as the gradient the hypothesis described. Elevation had the largest coefficient of any environmental term, +0.636 (p < 0.001).


::: {#tbl-final .cell tbl-cap='Regression estimates of red-stage attack by model, in log-odds per standard deviation of each continuous term, with the landform classes in every model as log-odds against slope, the most common class, ridge including the shoulder cells and a class of fewer than 30 cells not estimated. M0 held host size, shading and landform, M1 added stand basal area, M2 terrain exposure, shape and flight-window radiation, and M3 the interactions, over the nine years; M3 was refitted with the dependence terms over the eight years with a previous map, and with a latent spatial field. Performance is the AUC and RMSE of the full fit, the RMSE ratio of the test folds over the training folds under ten-fold cross-validation on 1 km blocks, and Theil\'s U bias. * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001.'}
::: {.cell-output-display}


|Term                                      |            M0|            M1|            M2|            M3| M3 + dependence|    M3 + field|
|:-----------------------------------------|-------------:|-------------:|-------------:|-------------:|---------------:|-------------:|
|Susceptible pine basal area               |     +0.272***|     +0.195***|     +0.191***|     +0.186***|       +0.090***|        +0.032|
|Stand age                                 |     +0.118***|     +0.101***|     +0.101***|     +0.102***|        +0.035**|        +0.029|
|Quadratic mean diameter                   |     -0.097***|     -0.249***|     -0.250***|     -0.250***|       -0.136***|     -0.069***|
|Sky view                                  |     +0.420***|     +0.381***|     +0.387***|     +0.369***|       +0.170***|        +0.037|
|Northness                                 |     +0.128***|     +0.077***|     +0.100***|     +0.105***|       +0.073***|     +0.133***|
|Elevation                                 |     +0.934***|     +0.945***|     +0.941***|     +0.940***|       +0.636***|     +1.199***|
|Stand basal area                          |              |     +0.279***|     +0.273***|     +0.276***|       +0.167***|     +0.200***|
|Wind shelter index                        |              |              |     -0.069***|     -0.073***|         -0.032*|     +0.096***|
|Topographic position                      |              |              |        -0.022|        -0.011|          +0.012|        +0.023|
|Convergence                               |              |              |     -0.049***|     -0.049***|          -0.006|        +0.011|
|Profile curvature                         |              |              |     -0.074***|     -0.071***|         -0.029*|        -0.002|
|Flight-window radiation                   |              |              |     +0.062***|     +0.078***|       +0.085***|     +0.215***|
|July wind                                 |              |              |              |     +0.064***|       +0.224***|     +0.209***|
|June wind                                 |              |              |              |     +0.049***|       +0.061***|     +0.064***|
|Attack in the cell, previous year         |              |              |              |              |       +2.208***|     +2.282***|
|Attack within 150 m, previous year        |              |              |              |              |       +2.216***|     +0.905***|
|Basal area × shelter                      |              |              |              |      -0.030**|          -0.000|        +0.009|
|Basal area × July wind                    |              |              |              |        +0.004|        +0.039**|       +0.034*|
|Basal area × radiation                    |              |              |              |     +0.066***|       +0.048***|        -0.018|
|Landform class, against slope             |              |              |              |              |                |              |
|Slope, 38,898 cells, 14 per cent attacked |     reference|     reference|     reference|     reference|       reference|     reference|
|Spur, 11,796 cells, 18 per cent attacked  |     -0.107***|      -0.059**|        -0.012|        -0.011|         +0.080*|        +0.031|
|Hollow, 8,751 cells, 12 per cent attacked |       +0.071*|        +0.036|        -0.024|        -0.028|          +0.057|        +0.049|
|Valley, 1,609 cells, 11 per cent attacked |        +0.013|        -0.069|      -0.200**|      -0.210**|          -0.002|        +0.054|
|Ridge, 665 cells, 24 per cent attacked    |     -0.626***|     -0.528***|     -0.453***|     -0.447***|          +0.038|        +0.068|
|Peak, 32 cells, 42 per cent attacked      |        -0.475|        -0.368|        -0.284|        -0.268|          +0.063|        +0.456|
|Footslope, 1 cell, 89 per cent attacked   | not estimated| not estimated| not estimated| not estimated|   not estimated| not estimated|
|AUC                                       |         0.804|         0.807|         0.808|         0.809|           0.890|              |
|RMSE                                      |         0.423|         0.422|         0.421|         0.421|           0.365|              |
|RMSE ratio                                |         1.003|         1.000|         1.005|         1.008|           0.998|              |
|Theil's U bias                            |        0.0000|        0.0001|        0.0001|        0.0001|          0.0000|              |


:::
:::



::: {.cell}
::: {.cell-output-display}
![Odds ratios of the environmental terms of M3 per standard deviation, with 95 per cent confidence intervals, without the dependence terms over the nine years, open circles, and with them over the eight years with a previous map, filled circles. Terms are ordered by their odds ratio with the dependence terms, and the dashed line marks no effect.](Manuscript_files/figure-docx/fig-coefficients-1.png){#fig-coefficients}
:::
:::


## Wind and openness

The second question asked whether wind during flight lowered attack more in open stands than in closed ones, as disruption of the pheromone plume predicted, so that the wind term should be negative in open stands and weaker or positive in closed ones. It was, with the terrain wind of the previous summer in the sixteen-day model. The speed itself was -0.014 at the mean crown closure (p = 0.271), its interaction with crown closure was +0.071 (p < 0.001), and the wind effect was -0.085 (p < 0.001) in stands one standard deviation below the mean crown closure and +0.056 (p = 0.003) one above it (Figure S16; Table S4). The wind at 10 m gave the same pattern, an interaction of +0.070 (p < 0.001) with a wind effect of -0.030 (p = 0.073) in open stands and +0.110 (p < 0.001) in closed ones. Wind also lowered attack in stands of small trees and not in stands of large ones, -0.055 (p = 0.002) one standard deviation below the mean diameter against +0.026 (p = 0.125) above it.

The station wind interpolated from the valleys did not show the effect. The wind of the same period raised attack, +0.116 (p < 0.001), as did the previous summer's, +0.088 (p < 0.001), and its interaction with crown closure could not be distinguished from zero (p = 0.963). In the annual models the July station wind raised attack, +0.224 (p < 0.001), by +0.185 (p < 0.001) in stands one standard deviation below the mean basal area and +0.263 (p < 0.001) one above it, the same order as the sixteen-day result but with no fall in attack at any density.

## Shelter and deposition

The third question asked whether ground sheltered from the afternoon wind, or facing away from it, had more attack whatever the stand, as deposition predicted. The wind shelter index was higher on slopes facing the prevailing wind, so the prediction was a negative coefficient and no interaction with basal area. Both held, and the first was weak. The index entered at -0.032 (p = 0.043), from -0.073 without the dependence terms (p < 0.001), and its interaction with basal area could not be distinguished from zero (p = 0.971), so the effect did not depend on the stand. It was -0.025 at a 90 m grain (p = 0.175) and changed sign under the spatial field, to +0.096 (p < 0.001), with residual Moran's I still at a median of 0.345 under the field. The terrain wind gave the same direction more strongly. The shelter index at each cell's own modelled wind direction entered at -0.051 (p < 0.001) in the annual model and -0.064 (p < 0.001) in the sixteen-day model, the share of flight hours in which the wind blew upslope at -0.057 (p < 0.001) over sixteen days and -0.003 (p = 0.804) annually, and the slope updraft, the wind pushed up the face, at -0.103 (p < 0.001) over sixteen days and -0.029 (p = 0.050) annually, falling most steeply on ridges and spurs, -0.029 (p < 0.001). The faces that met the south-west afternoon wind had the least attack, 10 per cent of cells facing south and 12 per cent facing south-west against 23 per cent facing west and 19 per cent facing north-west (@fig-flight-paths). Ridges and valleys had less attack than slopes without the dependence terms, -0.447 (p < 0.001) and -0.210 (p = 0.003), and neither differed from slopes once attack nearby was in the model (p = 0.697 and p = 0.978; @tbl-final).


::: {.cell}
::: {.cell-output-display}
![The afternoon air over the site and the attack it met, 1 July to 15 August. (a) HYSPLIT paths of the air over the 12 h before 14:00 on each flight day of 2005 to 2013, with the mean path in black. (b) The share of the annual maps of 2006 to 2014 on which each cell was attacked, with ridges in black and the modelled flight-hour wind as arrows. (c) The slope updraft of that wind, red where it rose and blue where it sank. (d) The share of cells attacked by the direction the ground faced, with the mean updraft above each bar. The red outline is the study perimeter.](Manuscript_files/figure-docx/fig-flight-paths-1.png){#fig-flight-paths}
:::
:::


The remaining terms, surface temperature, the lidar terrain, convective lift, the back-trajectories, pressure, valley and ridge flatness, cold-air pooling, canopy height, winter cold, the upwind sources and the maps of 2012, were fitted beside M3 and E2 and none entered the final models (Tables S11 and S12).

# Discussion

Attack in a 30 m cell was predicted first by attack in and around it the year before, the order @aukema2008 followed on the Chilcotin Plateau, where temperature still "contributed to explaining outbreak probabilities" once neighbouring and earlier outbreaks were in the model (p. 348). The best neighbourhood here was 150 m, close to the 140 m within which previous attack raised red attack above its background in Colorado [@walter2013], and the outbreak was in the phase in which "almost all new mortality was associated with intensification of existing outbreaks, not expansion" [@meddens2014, p. 83]. The three refugia mechanisms that @krawchuk2020 proposed were therefore tested as modifiers of an outbreak that spread mostly by contagion, and the novelty of the study lay in testing the three together on one landscape at 30 m with that dependence in the model, which few earlier studies had done. Density and shade by terrain moved as the hypothesis predicted and host size did not, wind lowered attack only in open stands and only over sixteen-day periods, and ground facing the afternoon wind had the least attack.

## Refugia mechanisms

Beside contagion, attack rose with the amount of host, the basis of the stand susceptibility rating used in British Columbia, which is built on "the percentage of susceptible pine by basal area", pine age and stand density [@safranyik2010, p. 429; @shore2000susceptibility], so the refugia this landscape showed were thin stands with little pine, as in thinning trials in which stands reduced in basal area lost fewer trees [@mitchell1983thinning; @fettig2007effectiveness; @hood2016fortifying]. The amount of host is itself a product of forest history, because within climatically suitable areas "forest age-class structure will be the primary factor influencing host susceptibility and outbreak severity" [@taylor2003, p. 42]. Live stems ran the other way because a stand of many stems was a crowded stand, in which trees grow slowly and have thin phloem [@shore2006], so the count of stems measured the size of the trees more than the amount of host.

Shade by terrain protected ground once attack nearby was in the model, through the sky view and the sun of the flight window, which was the mechanism @krawchuk2020 proposed, cooler ground that protects trees from water stress, although the effect was lost under the spatial field and at a 270 m grain, so it was a property of the slope at the scale of a stand and not of the landscape. The faces that were cooler by aspect did not share it. North-facing ground had more attack, the reverse of the Morice Timber Supply Area, where the most intense infestations were found early on warmer slopes facing south and west [@nelson2007environmental], although its surface was 3.4 °C cooler in the late morning. Two observations of the beetle's flight point to heat during flight rather than water stress. The heaviest attacks on a bole are "usually found on the northern aspect" [@safranyik2006chap1, p. 18], and in the Black Hills "The decreased number of attacks during midday coincides with the period of highest mean temperatures" [@schmid1991bark, p. 1445], so the sunlit afternoon faces may have been too hot for landing beetles while the ground shaded by terrain was too cool for the brood, where summers too cool for development in one year make mass attack less successful [@safranyik2006chap1; @logan2001].

Attack peaked in stands of 25 to 30 cm quadratic mean diameter, just above the 25 cm at which lodgepole pines change on average from beetle sinks to beetle sources [@carroll2004bionomics], because thicker phloem feeds more brood, from an average of 16 beetles to 94 as phloem thickened from 2.3 to 5.8 mm [@amman1972]. Attack fell in stands of larger trees because those stands held little pine, not because the beetle avoided large trees [@shore2006], and epidemics also "often deplete the large diameter pine component of stands" [@shore2006, p. 110]. The scarcity of large trees therefore made a refugium only below 25 cm, where the trees could not feed a brood, and above 30 cm the refugium was the absence of pine. Elevation had the largest coefficient in every model, against the historical decline of mortality with elevation [@shore2006], but on this range the higher ground also held the pine, as in western Montana [@wulder2006red], and milder winters after 1976 had favoured outbreaks at height [@maciasfauria2009].

## Wind and openness

Wind lowered attack where the canopy was open and raised it where the canopy was closed, so the stand property through which wind acted was crown closure. That was the mechanism @bartos1989 proposed in the Uinta Mountains of Utah, where a thinned stand was windier than the unthinned stand beside it by 3.2 km/h or more in the late afternoon and, in a recently thinned stand, "canopy density usually is insufficient to trap the pheromone and move it horizontally to attract other beetles" (p. 9), and a tracer gas released in place of pheromone was diluted fastest in the most open of three canopies [@thistle2004surrogate]. The effect appeared with the terrain wind over sixteen-day periods and not with the station wind interpolated from the valleys, which varied between periods and years but hardly between cells, so the test needed a wind that differed from one slope to the next within a season. In the annual models wind raised attack everywhere, more so where basal area was greater. Wind above the canopy carries beetles into new stands [@jackson2008; @chen2017], which predicts more attack with wind where large hosts stand under a closed canopy, and under epidemic pressure pheromones from attacked trees nearby "may override the positive benefits of increased spacing and improved tree growth derived from partial cutting" [@schmid2005, p. 9]. For management the two readings agree, since a stand opened by thinning was protected by the wind only during flight and least where attacked trees stood close.

## Shelter and deposition

The afternoon air reached the site from the south-west, from 193 to 256 degrees, and the least attack fell on the faces that met it, 10 per cent of cells on south-facing and 12 per cent on south-west-facing ground against 23 per cent on west-facing and 19 per cent on north-west-facing ground. This was the reverse of most studies of aspect, in which attack favoured southern slopes [@walter2013; @nelson2007environmental], and of the Peace River region, where beetles "tend to accumulate on windward sides of barriers" [@giroday2011, p. 1107]. Beetles released by @safranyik1989 "climbed towards the tree tops, and usually tracked to the north or northeast, generally crosswind and downwind" (p. 508), and "bark beetles do not fly in winds that exceed their maximum flight speed" [@carroll2004bionomics, pp. 22-23]. These observations suggest that the afternoon wind lifted beetles up the south and south-west faces, carried them over the ridges and set them down on the north and west faces beyond, where the wind slackened. That would explain the least attack on the windward faces, the fall in attack where the wind was pushed up the slope, steepest on ridges and spurs, and a shelter effect that did not depend on the stand, as deposition predicted and plume disruption did not, and it matches the reading @kunegel2020factors gave of a north-facing onset in the Cypress Hills, where "the dominant winds in Cypress Hills come from the south-west" (p. 9). Deposition also depends on the stand, since in simulations of beetles flying through forest, dispersal downwind shortened as trunks became denser [@byers2000]. The shelter index taken at one fixed bearing was small, was lost at a 90 m grain and changed sign under the spatial field, so it described where attack clustered as much as a property of the slope, and a refugium defined at 30 m and one defined at 1 km were different things, the concern for scale that @aukema2008 raised. No study had compared beetles landing on the windward and lee faces of the same ridge, and the test of this hypothesis would be a record of wind and of landing beetles on the slopes themselves.

## Limits and management

The response was classified rather than observed, and the classifier's accuracy measured its separation of the field plots from undisturbed forest rather than agreement with ground mortality across the landscape [@meddens2013]. The inventory postdated part of the outbreak, the terrain wind took its direction from the reanalysis and gave about half the speed measured on the valley floor, and the study covered one mountain range over nine outbreak years. For management, the refugia this landscape showed were stands with little host, the structure that thinning and a younger age structure produce, which terrain maps alone could not locate. Partial cutting substantially lowers the susceptibility of lodgepole pine stands [@mata2003; @shore2000susceptibility], but in ponderosa pine it "may be ineffective for partially cut parcels of \<10 acres if the partially cut stands are surrounded by unmanaged susceptible stands" [@schmid2005], which the dominance of attack nearby supported, and @six2014management found the field evidence that thinning protects stands during an outbreak weaker than policy had assumed.

{{< pagebreak >}}


::: {.cell tbl-cap='Stand structure over the 72,000 sampled cell-years, from the annual Vegetation Resources Inventory snapshots. SD was the standard deviation, SE the standard error of the mean, and Skew and Kurt. the bias-corrected skewness and excess kurtosis.'}

:::



::: {.cell tbl-cap='Accuracy of the three red-stage classifiers over repeated random splits that held out a quarter of the field plots and of the 100 m blocks of undisturbed pixels, as mean and standard deviation with the 2.5th and 97.5th percentiles of the splits. The model with the highest mean kappa set the cut used on every map.'}

:::



::: {.cell tbl-cap='Red-stage attack by quadratic mean diameter class on the balanced annual sample, with Wilson 95 per cent intervals and the mean susceptible pine and total basal area of each class. The 25 cm boundary was the source-sink threshold of the species\' bionomics. The sample held equal numbers of attacked and unattacked cells in each year, so the percentages compared classes and were not landscape rates.'}

:::



::: {.cell}

:::





::: {.cell tbl-cap='Agreement of the red-stage classifier and the terrain wind with independent measurements. The classifier was scored over 100 held-out splits, and wind speed over the flight hours of June to August 2005 to 2014 at four valley stations, corrected as in the models. Bias was the predicted less the measured mean speed in km/h, RMSE the root mean square error, Theil\'s U bias the share of the mean squared error due to that difference, and direction error the mean absolute difference in degrees.'}

:::







::: {.cell tbl-cap='Dependence terms compared on AIC over 63,968 cell-years with a previous map. Own state was attack in the cell the year before, and the share was the proportion of cells attacked within each radius.'}

:::



::: {.cell tbl-cap='The annual models, each adding one mechanism, over the nine years without and the eight years with a previous map without and with the dependence terms. M0 held host size, shading and landform, M1 added basal area, M2 terrain exposure, shape and flight-window radiation, and M3 the interactions of basal area with wind shelter, July wind and radiation. Cross-validation (CV) used ten folds of 1 km blocks, and the blind test fitted the years to 2012 and predicted 2013 and 2014. The RMSE ratio was the test-fold over the training-fold root mean square error, and Theil\'s U bias the share of the mean squared error due to the difference of the means.'}

:::





::: {.cell}

:::



::: {.cell}

:::


{{< pagebreak >}}

# References {.unnumbered}

::: {#refs}
:::
