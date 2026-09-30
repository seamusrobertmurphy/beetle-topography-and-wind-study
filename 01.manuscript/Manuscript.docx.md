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
# Agricultural and Forest Entomology asks for the Harvard system, "(Martinez, 1985;
# Martinez & Lawrence, 1985; Martinez et al., 1988)", an alphabetical list with every
# author, the article title and the journal title in full, read from the guidelines print
# of 2026-09-16. APA 7th prints exactly that, so the style file is the Citation Style
# Language repository's apa.csl, fetched 2026-09-16. The Springer and APA 6th files stay
# in 04.references but nothing reads them.
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

**Correspondence.** Seamus Murphy, TÜV SÜD, 2187 Comox Ave, Comox, British Columbia V9M 1P5, Canada. seamusrobertmurphy@gmail.com. ORCID 0000-0002-1792-0351.

**Keywords.** Mountain pine beetle, Disturbance refugia, Curculionidae, Scolytinae, British Columbia, thinning, dispersal, topography

**Data availability statement.** Public datasets were used in this analysis. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance, stand structure was derived from British Columbia's provincial Vegetation Resources Inventory, terrain from the Natural Resources Canada High Resolution Digital Elevation Model [@nrcan2017] and wind from Environment and Climate Change Canada hourly station records. All derived data and the complete analysis code that reproduce every number, table and figure in this article are at <https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study> and will be deposited in the Dryad Digital Repository, with a DOI, with the revised manuscript. The study's classifier was trained on the 28 field plots of beetle-killed basal area established in July and August 2020 in the Darkwoods Conservation Area by Murphy, Leslie, Wilson and Banks [@murphy2026], whose plot locations, killed-basal-area measurements and Landsat classifications of red-stage mortality were used with the permission of those authors; that study and its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks, are acknowledged as the source of the ground truth on which every attack map in this article rests.

**Conflict of interest statement.** The author has no conflict of interest to declare. The author was the lead author of the earlier study on the same ground [@murphy2026], and the field plots on which the classifier in this article was trained were collected under that study with its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks. Those data are used here with their agreement, there is no dispute over the ownership of any data presented, and every contribution to the present article has been attributed by authorship or acknowledgement.

**Author contributions.** Seamus Murphy conceived and designed the present study, assembled the datasets, wrote the analysis code, performed the analysis, prepared the figures and tables, and wrote and revised the manuscript, which is every CRediT role. The 28 field plots of beetle-killed basal area and the Landsat classifications of red-stage mortality were produced under the earlier study by Murphy, Leslie, Wilson and Banks [-@murphy2026], and the co-authors of that study contributed to the field data collection and the ground-truthing that this article reuses but took no part in the design, analysis or writing of the present article.

{{< pagebreak >}}

# Abstract {.unnumbered}

1. Disturbance refugia from mountain pine beetle (*Dendroctonus ponderosae*) outbreaks have been proposed in thin stands of small trees, on shaded ground and where wind disrupts the aggregation pheromone, but little is known about how they act together at the interval over which attack and wind vary.
2. This study mapped red-stage attack in 47 sixteen-day Landsat periods over eight outbreak years across 5,573 ha of the Selkirk Mountains, British Columbia, with a classifier validated on field plots, and modelled it on annual forest inventory, terrain and a terrain-resolved wind field, entering attack nearby and earlier first.
3. Attack was clustered within a median of 750 m with a median kernel bandwidth of 67 m, and attack nearby in the previous period and year dominated every model.
4. Beside those terms attack rose with stand basal area (+0.242 log-odds per standard deviation, p < 0.001) and on open ground, while tree diameter and shading had no protective effect. Wind interacted with standing volume in the direction plume disruption predicts, but wind did not lower attack detectably within thin stands.
5. Refugia here were stands with little host, and terrain and wind added small, scale-dependent modifiers to an outbreak whose spread was mostly contagion.

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins [Coleoptera: Curculionidae: Scolytinae]) has impacted more lodgepole pine (*Pinus contorta* Douglas ex Loudon) stands across British Columbia than any other disturbance event on record [@taylor2003; @sambaraju2021]. The outbreak was eruptive, in that host defences constrained the beetle while its populations were low and stopped constraining it once stand densities passed a threshold [@boone2011efficacy; @raffa2008cross] and warming raised its survival across the west of the continent [@bentz2010climate; @sambaraju2012climate]. Where the outbreak went once it had erupted has been modelled at the landscape scale for two decades. In British Columbia it began in the west-central interior and spread east, with further eruptions in disjunct areas of the south [@aukema2006landscape]. The presence of outbreaking populations within 18 km in the same year and within 6 km in the two years before explained more of its movement than climate did [@aukema2008]. Dispersal under the canopy over tens of metres carried most of the spread once an area was infested, while transport above the canopy started infestations in new ground [@robertson2007mountain; @chen2011mountain]. Models of the same kind in the western United States and in Saskatchewan entered weather, topography, previous attack and stand attributes together [@chapman2012spatiotemporal; @preisler2012climate; @simard2011what; @walter2013; @kunegel2020factors], and stand structure alone mapped susceptibility across the region [@shore2000susceptibility; @hicke2008mapping]. Where elevation entered a model of red attack, its sign followed the host's distribution rather than the beetle's preference [@wulder2006red]. Mortality never fell evenly, and the stands that survive supply the structure and seed from which the next forest develops, and are termed disturbance refugia, places buffered from disturbance over time [@krawchuk2020]. A refugium is explained by a mechanism linking survival to a measurable property of the site [@cartwright2018]. @krawchuk2020 proposed such a mechanism, that refugia could occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" (p. 239). These are three testable claims. Topographic shading reduces attack by relieving water stress on cool ground. Low host density reduces attack by admitting the wind that disperses the aggregation pheromone. A scarcity of large-diameter hosts reduces attack by limiting brood production, because stems under 25 cm in diameter are sinks for the beetle and stems above it are sources [@carroll2004bionomics], and attack cannot occur where the host is absent, so a cell without pine is not a refugium [@cartwright2018]. Two of the three act through terrain. This study fitted the three together on one landscape, following @cartwright2018, who modelled the controls on an insect refugium in stands of low basal area, and @maher2021, who tested refugia from this beetle on transects at alpine treeline.

The claim that a thin stand admits wind that disrupts attack is older than the refugia hypothesis and rests on the thinning trials of the 1970s and 1980s. Thinned stands of lodgepole and ponderosa pine lost fewer trees to the beetle wherever the comparison was made [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying], and two explanations were offered. @waring1985modifying attributed the effect to vigour, having shown that trees released from competition grew and resisted attack. @bartos1989 attributed it to microclimate, having measured higher wind, light and temperature in a thinned stand before the residual trees could have gained vigour, a pheromone trap catch there of 5 per cent of the adjacent unthinned stand's, and 2 per cent of trees killed against 16. @amman1988susceptibility found the same low infestation in partially cut stands whose residual trees had not grown, while partial cutting warmed the bark by day [@schmid1992bark; @bartos1994effects]. A tracer gas standing in for pheromone diluted fastest in the most open of three canopies [@thistle2004surrogate; @edburg2010simple]. Within a stand the beetle's own behaviour complicated the picture, since wide spacing did not stop attacks switching between trees in thinned plots [@preisler1993colonization], attack probability rose with stocking and tree size [@anhold1987potential; @negron2018biological], and the response to lures depended on population density [@klutsch2020density]. @cartwright2018 and @krawchuk2020 restated the microclimate explanation as a refugia mechanism, and @powell2014 gave its converse as a condition for outbreak. Stand density was therefore kept in every model fitted here, since a model that removes it and then reads a terrain coefficient as a wind effect has removed the pathway it set out to test. On the same reasoning, ground exposed to the wind and periods of stronger flight-period wind should both have less attack [@krawchuk2020; @jones2019]. Two constraints set the interval over which such a wind term can be measured. Flight is confined to a temperature window, between 19 and 41 degrees C, on bright afternoons when "peak flight is in the early to mid-afternoon" [@mccambridge1971; @gray1972; @safranyik2006chap1; @bleiker2016flight]. A daily or monthly mean wind therefore averages across many hours in which no beetle flies, and radiation during the flight window is a different quantity from the season's total, which is the quantity the shading pathway concerns. Mass attack is also a threshold phenomenon, the irruption threshold being "the population density at which endemic populations may transition towards the epidemic state" [@cooke2025; @howe2022; @trzcinski2009intrinsic]. Attack in one year is thus not independent of attack in the year before, which is why previous-year and neighbourhood pressure enter the models, and an environmental variable regulates that threshold rather than adding to attack. A wind effect through the plume is then expected as an interaction with host density and not as a main effect. Shade and vigour both predict less attack on cool ground by routes this design cannot separate, since cool sites slow development [@sambaraju2021] while water stress does not act on defence in one direction [@netherer2021]. Where attack was traced against site moisture and aspect, the beetle reached south-facing and drier ground first [@kaiser2012ecohydrology; @nelson2007environmental].

Where a dispersing beetle comes down changes what a terrain main effect can mean. @hynum1980 monitored landing on lodgepole pine with landing traps and found that beetles "were unable to distinguish between hosts, dead hosts and nonhosts during landing". Where a beetle lands is decided by its transport rather than by the tree beneath it, and a beetle descending from transport above the canopy arrives as a wind-borne particle, which is how @byers2000 simulated dispersal through a forest. @giroday2011 set out what follows, that landscape features "provide impactive surfaces for interception of insects" and that settlement rises "in areas where wind speed is reduced". The ground where the flow slows, the lee of ridges and sheltered slopes, is where such a beetle should come to rest, which is the pattern the wind shelter index of @plattner2004 was built to predict for snow. Deposition and plume disruption thus make different predictions, and the difference is what this design can test. Deposition acts before any host is chosen and predicts a main effect of terrain shelter that does not depend on stand density, whereas plume disruption acts on an aggregation already under way and predicts an interaction between stand density and wind with no requirement that shelter act alone. A terrain coefficient read without this distinction is assigned to a mechanism it may not belong to. Landform enters for a different reason, in that infested groups are reported in draws and gullies and deep snow insulates overwintering brood [@safranyik2006chap1]. Elevation enters as a composite of temperature, snowpack, season length and host distribution that this design cannot separate [@sambaraju2021; @amman1973population], and its weight among the predictors of attack changed through the course of an outbreak elsewhere [@walter2013].

This study grew out of a companion study of conifer regeneration after the 2015 Mt Midgeley fire on the same ground [@murphy2026], which fitted point process models of seedling intensity to distance from seed source, burn severity, beetle mortality, aspect, wind and terrain ruggedness. The present study took from it the 28 field plots of 20 by 20 m in which beetle-killed basal area was measured, its 30 m Landsat grid and its perimeter. In that model terrain ruggedness was the largest terrain effect on seedling intensity, +0.626 (P < 0.001), a coefficient that says the shape of the ground governed what survived without saying which property of that shape the beetle responded to. The present study turned the beetle outbreak that model treated as a covariate into the response and replaced the single ruggedness index with the four terrain properties the beetle's biology names, exposure to the prevailing wind, openness to the sky, position on the slope and depth of the valley. The landscape models cited above entered terrain as elevation, slope and aspect and weather as temperature and precipitation. A machine-learning model of the Alberta outbreak entered a July to August mean daily wind speed from stations [@ramazi2021outbreaks], and the transport models of the beetle's flight above the canopy resolved the wind over terrain without the stand beneath it [@jackson2008; @ainslie2010]. This study entered a terrain-resolved wind field at the sixteen-day interval of the response together with stand density, so that a terrain main effect could be told apart from a density by wind interaction, which are the two signatures deposition and plume disruption predict.

The study addressed three questions. Do the three mechanisms @krawchuk2020 named, stand density, topographic shading and the scarcity of large hosts, predict red-stage attack once host, terrain and previous attack are in the model? Does wind act on attack through stand density, which is the form plume disruption takes, and only where wind varies in time? Does terrain shelter act as a main effect, which is what deposition of wind-borne beetles predicts, or only through stand density, which is what plume disruption predicts?

# Methods

## Literature review


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


The literature the Introduction rests on was assembled under a written protocol frozen by commit before the first query ran, with a review question for each of the three study questions and a fourth asking whether the study's design had a precedent. Two indexes and the author's reading store were searched on 23 September 2026 with terms drawn from the title and keywords, one round of citation chasing ran from eight central papers, and titles were screened against the criteria of the protocol, which admitted any year and any peer-reviewed or agency source on the beetle. The searches returned 1,636 records, 1,257 after duplicates were removed, of which 198 were retained and 35 were read in full. One reader screened and read, and a record without an accessible full text was used from its abstract alone, which the synthesis records.

## Study area


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


The study area covered 5,573 ha of the Selkirk Mountains in southeastern British Columbia, 61,923 cells of 30 m spanning 830 to 1,744 m, 914 m of relief, on the grid of the parent study, so that results compared directly with it. The perimeter was centred on the 2015 Mt Midgeley fire, the parent study's site, and extended beyond its 480 ha of burned area to take in the range of stand density the pheromone mechanism needed. The extension was constrained rather than arbitrary. The burn was buffered by 5 km and the buffer was then cut to the elevation band of the parent study's site, so that the ground added was comparable to the ground it was added to. Table S1 lists the datasets the study combined and the spatial and temporal resolution of each. Those resolutions were uneven, and the analysis depended on that unevenness. The response was measured every sixteen days, the inventory once a year and the station winds every hour, and the terrain was measured once.

*@fig-study-area near here*

## Beetle disturbance


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


The response was red-stage beetle attack in each sixteen-day period from 1 May to 22 September of the outbreak years 2006 to 2014, excluding 2012, when Landsat 7 was the only sensor and its scan-line corrector had failed. The index and baseline followed @murphy2026, who mapped red-stage mortality on this ground as the fall in the normalised difference moisture index (NDMI) against the 2005 pre-outbreak image and validated the map against 28 field plots of 20 by 20 m in which beetle-killed pine was confirmed from pitch tubes, frass and gallery architecture and measured as the fraction of plot basal area killed. Sixteen days is the Landsat revisit interval. NDMI was composited as the median of the cloud-masked Collection 2 Level-2 scenes in each period, from Landsat 5 for 2005 to 2011 and from Landsat 8 for 2013 and 2014 after the band-pass adjustment of @roy2016, and each period was differenced against the same period of 2005, so that the seasonal rise and fall of leaf moisture did not enter the difference.

The fall in NDMI that counted as attack was set by a classifier trained on two classes of Landsat pixel. The attacked class was the four pixels nearest the centre of each of the 28 field plots, 112 pixels. The undisturbed class was the 84 points of forest without beetle mortality that @murphy2026 digitised on the 2020 Landsat 8 scene, which fell in 68 distinct 30 m cells of the study grid. Each pixel entered with its deepest annual fall in NDMI against 2005. Random forest, a radial support vector machine and gradient boosting were compared under Monte Carlo cross-validation, 100 random splits that each held out a quarter of the groups of each class, a group being the four pixels of one field plot or the undisturbed pixels within one 100 m block, so that neighbouring pixels never fell on both sides of a split. The model with the highest mean kappa set the cut, the fall in NDMI at which its prediction changed class, and a cell was classed as attacked in a period where its fall reached the cut. Periods in which the imagery saw less than a tenth of the perimeter were dropped, which left 47 periods over eight years (Table S2). The undisturbed pixels came from one patch of about 230 by 455 m, so the cross-validation measured separation of the field plots from that patch rather than from undisturbed forest across the landscape.

*@fig-spread near here*

## Flight-period wind


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


The flight window was 1 July to 15 August and the hours 12:00 to 17:00. Neither bound was chosen from these data. The dates were the flight period @safranyik2006chap1 give for this region, and the hours followed their "peak flight is in the early to mid afternoon" together with the 11:00 to 14:00 emergence peak of @gray1972. The window was checked against 236,079 hourly station records from May to September of the study years (Figure S1). Inside it, 89.5 per cent of afternoon hours fell within the 19 to 41 degrees C flight range against 51.4 per cent outside it, and mean wind peaked in the same hours as temperature.

Wind entered as a field that varied across the terrain at 30 m, computed with the MicroMet model of @liston2006, whose terrain adjustment weights each hourly station observation by the slope in the wind direction and the curvature of the ground. The adjustment depends on direction and not on speed, so it was computed once for each of 16 sectors of 22.5 degrees and each hourly observation was multiplied by the surface for its own sector. Slope and curvature were computed over an elevation model extending beyond the perimeter, so that the curvature length scale of 600 m was defined at the edge of the study area. Hourly speed and direction from Environment and Climate Change Canada stations within 150 km were combined as vector components, and each sixteen-day period was summarised by its mean wind and by the share of hours below 5 km/h, both over the flight hours of 12:00 to 17:00. Across periods the mean flight-hour wind ran from 4.0 to 8.6 km/h and within a period it varied across the grid by up to 5.1 km/h.

## Stand structure


::: {.cell}

:::


Stand structure came from the provincial Vegetation Resources Inventory, taking for each study year the snapshot the province published for that year, depleted for harvest and projected for growth to it, rasterised to the 30 m grid. Six of its attributes covered the mechanisms, total basal area, crown closure, live stems per hectare, quadratic mean diameter over stems of 12.5 cm and larger, stand age and susceptible pine basal area, formed as basal area times the pine share of cover, with stand height and standing volume. The 2007 snapshot omitted basal area and live stems, so the 2006 snapshot stood in for it. The inventory is a projected operational product rather than a census, and a polygon interpreted from late-outbreak photography described a stand the beetle had already attacked, so basal area and pine cover were post-attack over part of the study window (@tbl-vri).

*@tbl-vri near here*

## Geomorphometry


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


Terrain was described by surfaces computed with SAGA GIS over the full reprojected elevation model and clipped afterwards, so that a search radius near the boundary still fell on measured ground. The set separated the single ruggedness index of @murphy2026 into the properties the beetle's biology points to, while ruggedness itself was kept as a candidate so that the separation was tested against it rather than assumed.

Radiation was computed twice because two mechanisms require different quantities. Flight-window radiation was the direct and diffuse total over 1 July to 15 August restricted to 12:00 to 17:00, the hours identified as the flight peak [@safranyik2006chap1], while growing-season radiation was the whole-day total from 1 May to 30 September, the shading quantity the first mechanism of @krawchuk2020 concerns. A single annual heat index cannot separate the two, flight-window direct radiation spanning a 15-fold range here against 2.9-fold for the season total.

Exposure entered as the windward-leeward index, effective air flow height, the wind exposition index and the wind shelter index of @plattner2004, which is "the maximum gradient within a given radius in upwind direction", with topographic openness and sky view. Shape entered as ruggedness, topographic position, convergence, slope, curvature and geomorphon class, a landform class read from the horizons visible around a cell, and landform as wetness, valley depth and height above the valley floor, because infested groups are reported in draws and gullies and deep snow insulates overwintering brood [@safranyik2006chap1; @kautz2023]. Aspect entered as its northward and eastward components with the heat load index of @mccune2002. Every candidate is listed in Table S3.

## Spatial pattern


::: {.cell}

:::


Spatial pattern was described before any model was fitted, with the point pattern methods of @murphy2026. In each period the attacked cells were treated as a point pattern inside the window of cells the imagery saw. Clustering was tested against random relabelling, in which the same number of cells was drawn at random from the cells seen in that period, 999 times, because the cells sit on a 30 m grid inside a window with holes and a continuous null would misstate distances on it. Three statistics were compared with that null, the Clark-Evans aggregation index [@clark1954distance], the mean nearest-neighbour distance and the L function, the variance-stabilised form of Ripley's K [@ripley1977], against a global envelope [@baddeley2015]. The largest distance at which the observed L function lay above the envelope was taken as the clustering range of that period. The kernel bandwidth of each period was chosen by likelihood cross-validation over 20 to 300 m, the procedure @murphy2026 used to set the bandwidth of their Cox process model. Both distances were estimated before any model was fitted and both entered the models, the bandwidth as the scale of a neighbourhood term and the clustering range as the range of the latent spatial field.

## Model building


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::


Models were built in the order of @aukema2008, who "determined an appropriate spatial neighborhood structure(s) and time lag(s) to account for spatial and temporal dependencies" before any environmental variable entered, then tested each environmental variable alone beside those terms and built the full model by backward elimination. Every model was a logistic regression of attack in a cell and period with a fixed effect for each period. Within each period the model table took every attacked cell up to 2,000 and the same number of unattacked cells, so that the period effect absorbed the sampling rate and every other coefficient was unaffected by it.

The dependence terms were the cell's own state in the previous period of the same season and in the same period of the previous outbreak year, and the share of cells attacked around it in each. That share was measured two ways, within a fixed radius of 42, 90, 150, 210, 510 or 1,050 m, and weighted by a Gaussian kernel whose standard deviation was the likelihood cross-validated bandwidth of the period the share was taken from. All candidates were compared on AIC, so that the bandwidth was tested against the fixed radii rather than assumed. The environmental variables were then entered one at a time beside the chosen dependence terms, each standardised so that its coefficient was the change in log-odds per standard deviation, and tested against the dependence-only model by likelihood ratio, the screen @murphy2026 used against the intercept-only model. Variables that passed at p < 0.05 were grouped where their absolute correlation reached 0.75, keeping the member with the largest likelihood-ratio statistic, and removed one at a time until every variance inflation factor was below 5. An elastic net with the dependence terms unpenalised [@zou2005; @friedman2010] was fitted beside the elimination and is reported with it (Table S4), and the final model was reached by removing terms one at a time while AIC fell.

The three questions were tested as additions to the final model. The mechanisms of @krawchuk2020 were tested term by term, stand density as live stems, standing volume and basal area, large hosts as quadratic mean diameter, and shading as growing-season radiation and northness. Plume disruption was tested as the interactions of stem density and standing volume with mean flight-hour wind. Calm share correlated -0.94 with mean wind, so by the correlation rule of the screen only the mean entered. Deposition was tested as the main effects of the wind shelter index of @plattner2004 and sky view, with their interactions with density tested next. Each set was compared with the model without it by likelihood ratio, and each interaction was read as the slope of one term at one standard deviation below and above the mean of the other.

Two checks tested the scale of the inference. The final model was refitted with a Gaussian process smooth of easting and northing, a latent spatial field of the kind the Cox process model of @murphy2026 carried [@wood2017], with a Matérn correlation whose range was set to the median clustering range of the L functions, 750 m, and Moran's I [@moran1950] of the deviance residuals was computed within each period on the eight nearest sampled cells, with and without the field. The final model's environmental terms were also refitted with the cell coarsened from 30 m to 90, 270 and 990 m, a coarse cell being attacked if any 30 m cell inside it was, the definition of presence @aukema2008 used on 12 km cells, with the dependence terms rebuilt at each grain from the cell's own state and the share of its eight neighbours attacked.

# Results {#sec-results}

## Classifier accuracy

The radial support vector machine classified red-stage attack most accurately, with kappa 0.859 ± 0.081 (95 per cent interval 0.682 to 1.000) and overall accuracy 0.934 ± 0.037 over 100 splits held out by plot and block (@tbl-classifier). The three models differed by less than one standard deviation of the splits. The cut it set was a fall in NDMI of 0.0616 or more against 2005. The share of cells classed as attacked varied between periods from 5.6 to 57.4 per cent (Table S2, @fig-spread).

## Clustered attack

Attack was clustered in almost every period. The mean distance from an attacked cell to its nearest attacked neighbour was 82 per cent of the random-relabelling expectation in the median period, and shorter than in all 999 relabellings in 46 of 47 periods. The L function lay above its global envelope in 45 periods, to a median distance of 750 m (range 90 to 1,500 m), and the likelihood cross-validated bandwidth had a median of 67 m (@fig-clustering).

## Dependence terms

Attack in a cell depended on attack nearby and before, by a margin that set the scale of everything after it. On the 46,124 cell-periods with a predecessor in the season and in the previous year, AIC fell from 63,232 with the period effect alone to 44,152 with the four dependence terms (@tbl-dependence). The neighbourhood share weighted by a kernel at each period's own bandwidth fitted as well as the best fixed radius within the season and better than every fixed radius between years. Within the season its AIC was 44,555 against 44,556 for the best radius, 90 m, a difference too small to separate them, and between years it was 45,588 against 45,615 for 90 m, so the two kernel shares were the dependence terms carried into every later model. Among the fixed radii the fit worsened as the radius grew beyond 90 m. In the final model the odds of attack were 6.3 times higher in a cell attacked in the same period of the previous year and 2.2 times higher in a cell attacked in the previous period.

## Environmental terms

Beside the dependence terms, 33 of 39 environmental variables improved the fit at p < 0.05 (Table S3). The largest likelihood-ratio statistics were for position in the terrain, with less attack high above the valley floor, -0.201 log-odds per standard deviation, and more at higher elevation, +0.205, followed by sky view, +0.188, crown closure, +0.171, and basal area, +0.160. After the collinearity screen and backward elimination the final model kept 11 environmental terms (@tbl-final). Attack was higher in older stands, +0.118 (p < 0.001), under closed canopy, +0.130 (p < 0.001), with more susceptible pine basal area, +0.064 (p < 0.001), at higher elevation and on wetter ground, and it was lower high above the valley floor, -0.178 (p < 0.001). The environmental terms lowered AIC from 36,822 for the dependence terms alone to 36,250, while AUC rose only from 0.848 to 0.853.

Of the three mechanisms of @krawchuk2020, stand density was supported through the amount of host rather than the number of stems. Added to the final model, basal area entered at +0.242 (p < 0.001) and standing volume at +0.131 (p < 0.001), whereas live stems, +0.026 (p = 0.137), and quadratic mean diameter, +0.015 (p = 0.550), could not be told from zero, so the scarcity of large hosts was not supported. Shading was not supported either. Growing-season radiation entered at -0.001 (p = 0.962), and north-facing ground had more attack rather than less, +0.039 (p = 0.011).

## Wind and density

Stand density and flight-hour wind interacted [likelihood-ratio χ²(2) = 13.18, p = 0.001], through standing volume at +0.041 (p = 0.008) rather than stems at +0.020 (p = 0.154). The direction was the one plume disruption predicts. In stands one standard deviation below the mean of volume, attack fell with flight-hour wind, -0.089 log-odds per standard deviation of wind, while in stands one standard deviation above it the slope was -0.008. Neither slope could be told from zero on its own (p = 0.130 and p = 0.904), so the interaction described a difference between thin and dense stands in how wind acted, not a protective effect of wind that could be shown within thin stands alone (@fig-interaction).

## Terrain shelter

Terrain openness acted as a main effect and not through density. Added to the final model, the wind shelter index and sky view improved the fit [likelihood-ratio χ²(2) = 10.97, p = 0.004], through sky view at +0.060 (p = 0.002) while the shelter index was +0.026 (p = 0.085), so open, gently sloping ground had more attack. Their interactions with density did not improve the fit [likelihood-ratio χ²(4) = 8.59, p = 0.072], which is the pattern deposition predicts and plume disruption does not.

## Spatial field

A latent spatial field lowered AIC from 36,250 to 35,382 and changed which terrain terms could be told from zero (@tbl-final). Stand age, susceptible pine basal area, crown closure and northness held, whereas height above the valley floor moved from -0.178 to +0.007 and wetness and stand height lost significance, so the valley terms described where attack clustered as much as a property of the ground. The field did not remove the fine-scale dependence among neighbouring cells, since the median Moran's I of the residuals within a period moved only from 0.312 to 0.285, and it remained significant at p < 0.05 in 100 per cent of periods.

## Across grains

The inference held at 90 m and weakened beyond it (@fig-grain). With the dependence terms rebuilt at each grain, elevation, crown closure, susceptible pine basal area and stand age remained positive and significant at 270 m, elevation at +0.239 (p < 0.001), while height above the valley floor lost significance and northness reversed sign to -0.115. At 990 m, 91 per cent of coarse cells held an attacked cell and no environmental term could be told from zero.

# Discussion

## Dependence first

Attack in a 30 m cell was predicted first by attack in the cells around it, in the previous sixteen-day period and in the same period of the previous year, and every environmental term was read beside those terms rather than instead of them. That order was the one @aukema2008 argued for, having found that outbreaking populations within 18 km in the same year and within 6 km in the two years before explained more of the outbreak's movement across British Columbia than climate did. The scale here was far finer and the pattern the same. Dispersal under the canopy over tens of metres carried most of the spread once a stand was infested [@robertson2007mountain; @chen2011mountain; @safranyik1992], and the bandwidth of the red-stage cells, a median of 67 m, was the landscape trace of that short-range dispersal, since a neighbourhood term weighted at that bandwidth fitted as well as the best of six fixed radii. Models of the western United States that entered previous attack beside weather and stand attributes found the same ordering [@chapman2012spatiotemporal; @preisler2012climate]. The consequence for every other result was that the environmental terms added little discrimination once dependence was in the model, AUC rising from 0.848 to 0.853, so the refugia mechanisms were tested as small modifiers of an outbreak whose spread was mostly contagion.

## Host and density

Attack rose with the amount of host, basal area, standing volume, susceptible pine basal area and stand age, and not with the number of stems or their diameter. Stands with little host were therefore the refugia this landscape showed, which agrees with the susceptibility rating of @shore2000susceptibility, built on age, density and pine basal area, and with the thinning trials in which stands reduced in basal area lost fewer trees [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying]. The absence of a diameter effect did not match the source-sink boundary of @carroll2004bionomics, under which stems below 25 cm produce too few brood to sustain a population. The inventory records the quadratic mean diameter of a polygon, not the distribution of stem sizes within it, and once populations were eruptive the beetle attacked smaller hosts as well [@boone2011efficacy; @raffa2008cross], so a stand-level mean may be too coarse a measure of that threshold at the height of an outbreak.

## Wind and density

The interaction of standing volume with flight-hour wind took the direction plume disruption predicts, with attack falling as wind rose in stands of low volume and not in dense ones. That was the pattern @bartos1989 measured at the stand scale, where a thinned stand had higher wind and a pheromone trap catch of 5 per cent of the adjacent unthinned stand's, and the one the tracer plumes of @thistle2004surrogate imply, which diluted fastest in the most open canopy. The effect was small, and within thin stands alone wind could not be shown to lower attack. Two features of the design limited what it could detect. The wind field was station wind adjusted for terrain, varying across the grid by a few kilometres per hour, whereas the contrast @bartos1989 measured was inside the canopy between managed and unmanaged stands, a difference the inventory and a terrain model cannot resolve. The timing also did not align, because the foliage of an attacked tree stays green "usually until May and June of the year following attack" [@safranyik2006chap1, p. 11], so red crowns seen in a sixteen-day period recorded the flight of the previous summer. The result was consistent with plume disruption and too weak to establish it.

## Terrain and landing

Open ground had more attack as a main effect, and openness did not act through stand density. Sky view factor, high on gentle, open ground, entered at +0.060, while its interactions with density added nothing. That was the signature deposition predicts, since a beetle descending through slowing air settles where the flow decelerates [@byers2000], and @giroday2011 found landscape features that met the wind acting as surfaces that intercepted dispersing beetles. It was also a pattern that faster development on warm, open ground would produce [@sambaraju2021], and no beetle was tracked to the ground here. Shading was not supported. North-facing ground had more attack at 30 m, the reverse of the prediction that cool ground relieves water stress, and the sign reversed at 270 m, so aspect here measured something other than shade, most likely where lodgepole pine grew on this range [@kaiser2012ecohydrology; @nelson2007environmental]. Attack was highest in valley bottoms, the draws and gullies where infested groups are commonly reported [@safranyik2006chap1], but that term vanished under a spatial field.

## Scale of inference

The environmental results depended on the scale at which they were read, which is the concern @aukema2008 raised in choosing 12 km cells. A latent spatial field removed the valley and wetness terms while the host terms held, so part of what the terrain terms measured was where attack happened to cluster. The field did not remove the fine-scale dependence among neighbouring cells, and the p-values in every model were therefore optimistic. The host terms and elevation held to 270 m, while at about 1 km nearly every cell held an attacked cell and nothing could be told from zero, and @walter2013 found the weight of the predictors of infestation changing through the course of an outbreak. A refugium defined at 30 m and one defined at 1 km were therefore different objects, and this study supported the first mainly through the amount of host.

## Limits and management

The response was classified rather than observed. The classifier separated the field plots from one patch of undisturbed forest, so its accuracy measured that separation and not agreement with ground mortality across the landscape. The inventory postdated part of the outbreak, since polygons interpreted after the beetle passed described the stand it left. The study covered one mountain range over eight outbreak years. For management the result gave a narrow answer. Refugia on this landscape were stands with little host, which is the structure thinning produces, and terrain maps alone could not locate them. The field evidence that thinning protects stands during an outbreak is weaker than policy has assumed [@six2014management], and this study added only weak evidence that wind strengthens that protection.

# References {.unnumbered}

::: {#refs}
:::

{{< pagebreak >}}

# Acknowledgements {.unnumbered}

This work used no external funding. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance distributed by the United States Geological Survey; stand structure from the British Columbia Data Catalogue; terrain from Natural Resources Canada; and wind from Environment and Climate Change Canada. The author thanks those agencies for maintaining the open archives the study rests on.

{{< pagebreak >}}

{{< pagebreak >}}

# Tables {.unnumbered}


::: {#tbl-vri .cell tbl-cap='Stand structure over the 173,086 sampled cell-periods, from the annual Vegetation Resources Inventory snapshots. SD was the standard deviation, SE the standard error of the mean, and Skew and Kurt. the bias-corrected skewness and excess kurtosis.'}
::: {.cell-output-display}


|Attribute                             |   Mean|     SD|    SE| Median|   Min|      Max|  Skew|  Kurt.|
|:-------------------------------------|------:|------:|-----:|------:|-----:|--------:|-----:|------:|
|Stand basal area (m² ha⁻¹)            |  32.99|  14.23| 0.037|  36.12|  0.00|    93.49| -0.71|  +0.51|
|Crown closure (%)                     |  47.01|  16.91| 0.043|  50.00|  1.00|    90.00| -1.28|  +0.96|
|Live stems (n/ha)                     | 818.76| 649.74| 1.661| 770.00|  0.00| 19400.00| +6.68| +72.89|
|Quadratic mean diameter (cm)          |  26.26|   6.27| 0.016|  25.74| 13.55|    78.78| +1.10|  +2.37|
|Stand age (years)                     | 107.03|  32.31| 0.082| 108.00|  4.00|   337.00| -0.06|  +4.85|
|Stand height (m)                      |  24.90|   7.90| 0.020|  25.40|  0.00|    42.30| -0.88|  +1.46|
|Standing volume (m³ ha⁻¹)             | 251.09| 144.01| 0.374| 250.59|  0.00|   889.64| +0.15|  -0.46|
|Lodgepole pine cover (%)              |  20.19|  26.35| 0.064|  10.00|  0.00|   100.00| +1.39|  +1.09|
|Susceptible pine basal area (m² ha⁻¹) |   7.34|   9.87| 0.026|   3.42|  0.00|    48.30| +1.53|  +1.86|


:::
:::


{{< pagebreak >}}


::: {#tbl-classifier .cell tbl-cap='Accuracy of the three red-stage classifiers over repeated random splits that held out a quarter of the field plots and of the 100 m blocks of undisturbed pixels, as mean and standard deviation with the 2.5th and 97.5th percentiles of the splits. The model with the highest mean kappa set the cut used on every map.'}
::: {.cell-output-display}


|Model                         |      Accuracy|   Accuracy 95%|         Kappa|      Kappa 95%| Sensitivity| Specificity|Chosen |
|:-----------------------------|-------------:|--------------:|-------------:|--------------:|-----------:|-----------:|:------|
|gradient boosting             | 0.912 ± 0.049| 0.820 to 1.000| 0.810 ± 0.106| 0.614 to 1.000|       0.920|       0.899|       |
|random forest                 | 0.898 ± 0.046| 0.810 to 0.976| 0.778 ± 0.099| 0.585 to 0.948|       0.925|       0.854|       |
|radial support vector machine | 0.934 ± 0.037| 0.859 to 1.000| 0.859 ± 0.081| 0.682 to 1.000|       0.913|       0.968|yes    |


:::
:::


{{< pagebreak >}}


::: {#tbl-dependence .cell tbl-cap='Dependence terms compared on AIC over 46,124 cell-periods, every model carrying a fixed effect for each period. Previous period meant the preceding sixteen-day period of the same season and previous year the same period of the preceding outbreak year. Delta AIC was the difference from the lowest.'}
::: {.cell-output-display}


|Terms                                                                                                                 |  k|    AIC| Delta AIC|
|:---------------------------------------------------------------------------------------------------------------------|--:|------:|---------:|
|epoch                                                                                                                 | 32| 63,232|  19,079.7|
|epoch + previous period self                                                                                          | 33| 53,602|   9,450.3|
|epoch + previous year self                                                                                            | 33| 51,494|   7,342.3|
|epoch + previous period self + previous year self                                                                     | 34| 46,575|   2,423.1|
|epoch + previous period self + previous year self + previous period within 42 m                                       | 35| 44,848|     696.1|
|epoch + previous period self + previous year self + previous period within 90 m                                       | 35| 44,556|     404.0|
|epoch + previous period self + previous year self + previous period within 150 m                                      | 35| 44,751|     598.8|
|epoch + previous period self + previous year self + previous period within 210 m                                      | 35| 44,975|     823.3|
|epoch + previous period self + previous year self + previous period within 510 m                                      | 35| 45,726|   1,574.1|
|epoch + previous period self + previous year self + previous period within 1050 m                                     | 35| 46,152|   1,999.7|
|epoch + previous period self + previous year self + previous period within bandwidth                                  | 35| 44,555|     402.7|
|epoch + previous period self + previous year self + previous year within 42 m                                         | 35| 45,942|   1,790.0|
|epoch + previous period self + previous year self + previous year within 90 m                                         | 35| 45,615|   1,463.4|
|epoch + previous period self + previous year self + previous year within 150 m                                        | 35| 45,623|   1,471.4|
|epoch + previous period self + previous year self + previous year within 210 m                                        | 35| 45,696|   1,543.6|
|epoch + previous period self + previous year self + previous year within 510 m                                        | 35| 46,063|   1,911.5|
|epoch + previous period self + previous year self + previous year within 1050 m                                       | 35| 46,270|   2,118.2|
|epoch + previous period self + previous year self + previous year within bandwidth                                    | 35| 45,588|   1,436.2|
|epoch + previous period self + previous year self + previous period within bandwidth + previous year within bandwidth | 36| 44,152|       0.0|


:::
:::


{{< pagebreak >}}


::: {#tbl-final .cell tbl-cap='Coefficients of the final model, without and with a latent spatial field. Environmental coefficients were changes in log-odds per standard deviation and dependence coefficients were per unit of the term. Significance was marked * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001.'}
::: {.cell-output-display}


|Term                                            |   Estimate|    SE|   Odds ratio (95% CI)| With spatial field|
|:-----------------------------------------------|----------:|-----:|---------------------:|------------------:|
|Attack in the same cell, previous period        | +0.806****| 0.043|   2.24 (2.06 to 2.44)|         +0.818****|
|Attack in the same cell, previous year          | +1.846****| 0.043|   6.33 (5.82 to 6.89)|         +1.907****|
|Attack nearby at the bandwidth, previous period | +2.419****| 0.080| 11.23 (9.59 to 13.15)|         +2.078****|
|Attack nearby at the bandwidth, previous year   | +1.383****| 0.085|   3.99 (3.37 to 4.71)|         +1.223****|
|Height above valley floor (m)                   | -0.178****| 0.027|   0.84 (0.79 to 0.88)|             +0.007|
|Elevation (m)                                   | +0.085****| 0.020|   1.09 (1.05 to 1.13)|            +0.261*|
|Crown closure (%)                               | +0.130****| 0.018|   1.14 (1.10 to 1.18)|            +0.050*|
|Susceptible pine basal area (m² ha⁻¹)           |  +0.064***| 0.017|   1.07 (1.03 to 1.10)|         +0.104****|
|Normalised height                               |     +0.037| 0.021|   1.04 (1.00 to 1.08)|            +0.090*|
|Stand age (years)                               | +0.118****| 0.016|   1.12 (1.09 to 1.16)|         +0.124****|
|Live stems (n/ha)                               |     +0.026| 0.017|   1.03 (0.99 to 1.06)|             +0.026|
|Northness                                       |    +0.039*| 0.015|   1.04 (1.01 to 1.07)|            +0.073*|
|Stand height (m)                                | -0.067****| 0.016|   0.94 (0.91 to 0.97)|             -0.018|
|Topographic wetness index                       | +0.087****| 0.021|   1.09 (1.05 to 1.14)|             +0.011|
|Plan curvature                                  |     +0.026| 0.014|   1.03 (1.00 to 1.05)|             +0.009|


:::
:::


{{< pagebreak >}}

# Figures {.unnumbered}


::: {.cell}
::: {.cell-output-display}
![Landscape, terrain and stand surfaces across the study area, all EPSG:3153 at 30 m over Esri World Shaded Relief. (a) elevation; (b) terrain ruggedness index; (c) windward-leeward index at the prevailing bearing; (d) flight-window direct radiation; (e) growing-season direct radiation; (f) the MicroMet wind weighting factor at the prevailing bearing; (g) stand basal area; (h) quadratic mean diameter; (i) live stems per hectare. The white outline marked the study perimeter and the red outline the 2015 Mt Midgeley burn, with contours at 200 m.](Manuscript_files/figure-docx/fig-study-area-1.png){#fig-study-area}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Red-stage attack across the study perimeter. (a) The first year in which each cell was classed as attacked in any sixteen-day period, over shaded relief with the perimeter in white and the 2015 Mt Midgeley burn in red. The panel combines periods for display only, and every model used each period separately. (b) The share of the cells seen in each period that were classed as attacked, one point per period.](Manuscript_files/figure-docx/fig-spread-1.png){#fig-spread}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Clustering of red-stage attack. (a) The L function, as L(r) - r, in the four periods with the most attacked cells, against the global envelope of 999 random relabellings of the cells seen in that period, the grey band. (b) The clustering range, the largest distance at which the observed L function lay above the envelope, and the likelihood cross-validated bandwidth in every period.](Manuscript_files/figure-docx/fig-clustering-1.png){#fig-clustering}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Predicted probability of attack against flight-hour wind, in standard deviations, at one standard deviation below and above the mean of (a) live stems and (b) standing volume, with every other term at its mean and the period effect at the most sampled period. The model was fitted on equal numbers of attacked and unattacked cells in each period, so the level of the curves is not the landscape probability and only their slopes are read. Plume disruption predicts the lowest attack in thin, windy stands.](Manuscript_files/figure-docx/fig-interaction-1.png){#fig-interaction}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The final model's environmental coefficients refitted at four grains, with their 95 per cent confidence intervals, without the dependence terms (open circles) and with them rebuilt at each grain (filled circles).](Manuscript_files/figure-docx/fig-grain-1.png){#fig-grain}
:::
:::



::: {.cell}

:::





::: {.cell}

:::



::: {.cell}

:::



