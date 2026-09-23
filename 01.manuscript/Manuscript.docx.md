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


**Running title.** Terrain, wind and mountain pine beetle refugia

**Correspondence.** Seamus Murphy, TÜV SÜD, 2187 Comox Ave, Comox, British Columbia V9M 1P5, Canada. seamusrobertmurphy@gmail.com. ORCID 0000-0002-1792-0351.

**Keywords.** Mountain pine beetle, Disturbance refugia, Curculionidae, Scolytinae, British Columbia, thinning, dispersal, topography

**Data availability statement.** Public datasets were used in this analysis. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance, stand structure was derived from British Columbia's provincial Vegetation Resources Inventory, terrain from the Natural Resources Canada High Resolution Digital Elevation Model [@nrcan2017] and wind from Environment and Climate Change Canada hourly station records. All derived data and the complete analysis code that reproduce every number, table and figure in this article are at <https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study> and will be deposited in the Dryad Digital Repository, with a DOI, with the revised manuscript. The study's classifier was trained on the 28 field plots of beetle-killed basal area established in July and August 2020 in the Darkwoods Conservation Area by Murphy, Leslie, Wilson and Banks [@murphy2026], whose plot locations, killed-basal-area measurements and Landsat classifications of red-stage mortality were used with the permission of those authors; that study and its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks, are acknowledged as the source of the ground truth on which every attack map in this article rests.

**Conflict of interest statement.** The author has no conflict of interest to declare. The author was the lead author of the earlier study on the same ground [@murphy2026], and the field plots on which the classifier in this article was trained were collected under that study with its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks. Those data are used here with their agreement, there is no dispute over the ownership of any data presented, and every contribution to the present article has been attributed by authorship or acknowledgement.

**Author contributions.** Seamus Murphy conceived and designed the present study, assembled the datasets, wrote the analysis code, performed the analysis, prepared the figures and tables, and wrote and revised the manuscript, which is every CRediT role. The 28 field plots of beetle-killed basal area and the Landsat classifications of red-stage mortality were produced under the earlier study by Murphy, Leslie, Wilson and Banks [-@murphy2026], and the co-authors of that study contributed to the field data collection and the ground-truthing that this article reuses but took no part in the design, analysis or writing of the present article.

{{< pagebreak >}}

# Abstract {.unnumbered}



1. Disturbance refugia from mountain pine beetle (*Dendroctonus ponderosae*) outbreaks have been hypothesised by @krawchuk2020 to form where tree defences remain effective, on shaded ground that spares trees water stress or in thin stands with few large hosts where wind may disrupt the aggregation pheromone.
2. All three were tested across 5,573 ha of the Selkirk Mountains, British Columbia, using 59 sixteen-day Landsat epochs over eight outbreak years with annualized forest inventory, geomorphometric variables and a terrain-resolved MicroMet wind field from hourly station records, entered with stand density so that a terrain main effect could be told apart from a density by wind interaction.
3. Wind disruption was supported conditionally, in that attack fell where a thin stand and strong flight-period wind coincided, the density-by-wind interaction -0.049 for stem density (p < 0.001) and -0.017 for standing volume (p < 0.05), both remaining after within-season contagion entered the model.
4. Terrain acted differently. Leeward ground had more attack as a main effect, -0.267, independent of stand density, and open gentle ground more still, sky view +0.285, the pattern expected where wind-borne beetles settle as the flow slows. Attack responded to host size as a threshold, peaking at 31.5 per cent in the 25 to 30 cm quadratic mean diameter class.
5. The shade hypothesis failed, since north-facing slopes showed more attack (+0.384). Refugia are therefore proposed to lie on warm, windward ground in thin stands during windy flight periods, and the terrain ruggedness signal of the companion study resolves into shelter and openness.

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins [Coleoptera: Curculionidae: Scolytinae]) has impacted more lodgepole pine (*Pinus contorta* Douglas ex Loudon) stands across British Columbia than any other disturbance event on record [@taylor2003; @sambaraju2021]. The outbreak was eruptive, in that host defences constrained the beetle while its populations were low and stopped constraining it once stand densities passed a threshold [@boone2011efficacy; @raffa2008cross] and warming raised its survival across the west of the continent [@bentz2010climate; @sambaraju2012climate]. Where the outbreak went once it had erupted has been modelled at the landscape scale for two decades. In British Columbia it began in the west-central interior and spread east, with further eruptions in disjunct areas of the south [@aukema2006landscape]. The presence of outbreaking populations within 18 km in the same year and within 6 km in the two years before explained more of its movement than climate did [@aukema2008]. Dispersal under the canopy over tens of metres carried most of the spread once an area was infested, while transport above the canopy started infestations in new ground [@robertson2007mountain; @chen2011mountain]. Models of the same kind in the western United States and in Saskatchewan entered weather, topography, previous attack and stand attributes together [@chapman2012spatiotemporal; @preisler2012climate; @simard2011what; @walter2013; @kunegel2020factors], and stand structure alone mapped susceptibility across the region [@shore2000susceptibility; @hicke2008mapping]. Where elevation entered a model of red attack, its sign followed the host's distribution rather than the beetle's preference [@wulder2006red]. Mortality never fell evenly, and the stands that survive supply the structure and seed from which the next forest develops, and are termed disturbance refugia, places buffered from disturbance over time [@krawchuk2020]. A refugium is explained by a mechanism linking survival to a measurable property of the site [@cartwright2018]. @krawchuk2020 proposed such a mechanism, that refugia could occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" (p. 239). These are three testable claims. Topographic shading reduces attack by relieving water stress on cool ground. Low host density reduces attack by admitting the wind that disperses the aggregation pheromone. A scarcity of large-diameter hosts reduces attack by limiting brood production, because stems under 25 cm in diameter are sinks for the beetle and stems above it are sources [@carroll2004bionomics], and attack cannot occur where the host is absent, so a cell without pine is not a refugium [@cartwright2018]. Two of the three act through terrain. This study fitted the three together on one landscape, following @cartwright2018, who modelled the controls on an insect refugium in stands of low basal area, and @maher2021, who tested refugia from this beetle on transects at alpine treeline.

The claim that a thin stand admits wind that disrupts attack is older than the refugia hypothesis and rests on the thinning trials of the 1970s and 1980s. Thinned stands of lodgepole and ponderosa pine lost fewer trees to the beetle wherever the comparison was made [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying], and two explanations were offered. @waring1985modifying attributed the effect to vigour, having shown that trees released from competition grew and resisted attack. @bartos1989 attributed it to microclimate, having measured higher wind, light and temperature in a thinned stand before the residual trees could have gained vigour, a pheromone trap catch there of 5 per cent of the adjacent unthinned stand's, and 2 per cent of trees killed against 16. @amman1988susceptibility found the same low infestation in partially cut stands whose residual trees had not grown, while partial cutting warmed the bark by day [@schmid1992bark; @bartos1994effects]. A tracer gas standing in for pheromone diluted fastest in the most open of three canopies [@thistle2004surrogate; @edburg2010simple]. Within a stand the beetle's own behaviour complicated the picture, since wide spacing did not stop attacks switching between trees in thinned plots [@preisler1993colonization], attack probability rose with stocking and tree size [@anhold1987potential; @negron2018biological], and the response to lures depended on population density [@klutsch2020density]. @cartwright2018 and @krawchuk2020 restated the microclimate explanation as a refugia mechanism, and @powell2014 gave its converse as a condition for outbreak. Stand density was therefore kept in every model fitted here, since a model that removes it and then reads a terrain coefficient as a wind effect has removed the pathway it set out to test. On the same reasoning, ground exposed to the wind and periods of stronger flight-period wind should both have less attack [@krawchuk2020; @jones2019]. Two constraints set the interval over which such a wind term can be measured. Flight is confined to a temperature window, between 19 and 41 degrees C, on bright afternoons when "peak flight is in the early to mid-afternoon" [@mccambridge1971; @gray1972; @safranyik2006chap1; @bleiker2016flight]. A daily or monthly mean wind therefore averages across many hours in which no beetle flies, and radiation during the flight window is a different quantity from the season's total, which is the quantity the shading pathway concerns. Mass attack is also a threshold phenomenon, the irruption threshold being "the population density at which endemic populations may transition towards the epidemic state" [@cooke2025; @howe2022; @trzcinski2009intrinsic]. Attack in one year is thus not independent of attack in the year before, which is why previous-year and neighbourhood pressure enter the models, and an environmental variable regulates that threshold rather than adding to attack. A wind effect through the plume is then expected as an interaction with host density and not as a main effect. Shade and vigour both predict less attack on cool ground by routes this design cannot separate, since cool sites slow development [@sambaraju2021] while water stress does not act on defence in one direction [@netherer2021]. Where attack was traced against site moisture and aspect, the beetle reached south-facing and drier ground first [@kaiser2012ecohydrology; @nelson2007environmental].

Where a dispersing beetle comes down changes what a terrain main effect can mean. @hynum1980 monitored landing on lodgepole pine with landing traps and found that beetles "were unable to distinguish between hosts, dead hosts and nonhosts during landing". Where a beetle lands is decided by its transport rather than by the tree beneath it, and a beetle descending from transport above the canopy arrives as a wind-borne particle, which is how @byers2000 simulated dispersal through a forest. @giroday2011 set out what follows, that landscape features "provide impactive surfaces for interception of insects" and that settlement rises "in areas where wind speed is reduced". The ground where the flow slows, the lee of ridges and sheltered slopes, is where such a beetle should come to rest, which is the pattern the wind shelter index of @plattner2004 was built to predict for snow. Deposition and plume disruption thus make different predictions, and the difference is what this design can test. Deposition acts before any host is chosen and predicts a main effect of terrain shelter that does not depend on stand density, whereas plume disruption acts on an aggregation already under way and predicts an interaction between stand density and wind with no requirement that shelter act alone. A terrain coefficient read without this distinction is assigned to a mechanism it may not belong to. Landform enters for a different reason, in that infested groups are reported in draws and gullies and deep snow insulates overwintering brood [@safranyik2006chap1]. Elevation enters as a composite of temperature, snowpack, season length and host distribution that this design cannot separate [@sambaraju2021; @amman1973population], and its weight among the predictors of attack changed through the course of an outbreak elsewhere [@walter2013].

This study grew out of a companion study of conifer regeneration after the 2015 Mt Midgeley fire on the same ground [@murphy2026], which fitted point process models of seedling intensity to distance from seed source, burn severity, beetle mortality, aspect, wind and terrain ruggedness. The present study took from it the 28 field plots of 20 by 20 m in which beetle-killed basal area was measured, its 30 m Landsat grid and its perimeter. In that model terrain ruggedness was the largest terrain effect on seedling intensity, +0.626 (P < 0.001), a coefficient that says the shape of the ground governed what survived without saying which property of that shape the beetle responded to. The present study turned the beetle outbreak that model treated as a covariate into the response and replaced the single ruggedness index with the four terrain properties the beetle's biology names, exposure to the prevailing wind, openness to the sky, position on the slope and depth of the valley. The landscape models cited above entered terrain as elevation, slope and aspect and weather as temperature and precipitation. A machine-learning model of the Alberta outbreak entered a July to August mean daily wind speed from stations [@ramazi2021outbreaks], and the transport models of the beetle's flight above the canopy resolved the wind over terrain without the stand beneath it [@jackson2008; @ainslie2010]. This study entered a terrain-resolved wind field at the sixteen-day interval of the response together with stand density, so that a terrain main effect could be told apart from a density by wind interaction, which are the two signatures deposition and plume disruption predict.

The study addressed three questions. Do the three mechanisms @krawchuk2020 named, stand density, topographic shading and the scarcity of large hosts, predict moderate-to-high disturbance once host, terrain and previous attack are in the model? Does wind act on attack through stand density, which is the form plume disruption takes, and only where wind varies in time? Does terrain shelter act as a main effect, which is what deposition of wind-borne beetles predicts, or only through stand density, which is what plume disruption predicts?

# Methods

## Literature review

The literature the Introduction rests on was assembled under a written protocol frozen by commit before the first query ran, with a review question for each of the three study questions and a fourth asking whether the study's design had a precedent. Two indexes and the author's reading store were searched on 23 September 2026 with terms drawn from the title and keywords, one round of citation chasing ran from eight central papers, and titles were screened against the criteria of the protocol, which admitted any year and any peer-reviewed or agency source on the beetle. The searches returned 1,636 records, 1,257 after duplicates were removed, of which 198 were retained and 34 were read in full. One reader screened and read, and a record without an accessible full text was used from its abstract alone, which the synthesis records.

## Study area

The study area covered 5,573 ha of the Selkirk Mountains in southeastern British Columbia, 61,923 cells of 30 m spanning 830 to 1,744 m, 914 m of relief, on the grid of the parent study, so that results compared directly with it. The perimeter was centred on the 2015 Mt Midgeley fire, the parent study's site, and extended beyond its 480 ha of burned area to take in the range of stand density the pheromone mechanism needed. The extension was constrained rather than arbitrary. The burn was buffered by 5 km and the buffer was then cut to the elevation band of the parent study's site, so that the ground added was comparable to the ground it was added to. Table S1 lists the datasets the study combined and the spatial and temporal resolution of each. Those resolutions were uneven, and the analysis depended on that unevenness. The response was measured every sixteen days, the inventory once a year and the station winds every hour, and the terrain was measured once.


::: {.cell}

:::


*@fig-study-area near here*

## Beetle disturbance and flight-period wind

The response was red-stage beetle attack in each of eight outbreak years, 2006 to 2014 excluding 2012, mapped by the method of @murphy2026 over the study perimeter. That study mapped red-stage mortality from Landsat surface reflectance as the change in the normalised difference moisture index (NDMI) between the pre-outbreak scene, its pre-disturbance baseline, and one scene in each later year, and validated the map against 28 field plots of 20 by 20 m in which beetle-killed pine was confirmed from pitch tubes, frass and gallery architecture and measured as the fraction of plot basal area killed. NDMI was chosen from four candidate indices, the other three being tasselled-cap wetness, greenness and brightness, because it separated attacked from unattacked plots most cleanly, predicted killed basal area most closely and classified red stage most accurately (kappa = 0.750, overall accuracy 0.824). The full diagnostics are reported there. Scenes were dated 7 to 31 August in every year but 2014, because red needles are fully expressed by the end of the first summer after attack and a near-anniversary date holds leaf phenology and sun angle constant between the two images being differenced. The present study kept that baseline, that index and that season, building each annual image as the median of the cloud-masked Landsat scenes from 1 June to 31 August, with Landsat 5 for 2005 to 2011 and Landsat 8 for 2013 and 2014 rescaled to the Landsat 5 range over forest that showed no attack, and subtracting the pre-outbreak NDMI from each later year. Each year was mapped separately with water masked, and the years were never merged, so that the year-to-year variation the study measured was kept. Annual prevalence inside the perimeter ran from 3.9 to 18.6 per cent, pooled 9.7 per cent over 111,707 cell-years (Table S2), and @fig-first-attack shows where the outbreak arrived first and how much of the perimeter it reached each year.


::: {.cell}

:::


*@fig-first-attack near here*

The flight window was 1 July to 15 August and the hours 12:00 to 17:00. Neither bound was chosen from these data, which is what multi-year phenology studies of forest insects do when they fix activity windows from monitoring rather than from the response [@pawson2021]. The dates were the flight period @safranyik2006chap1 give for this region. The hours followed their "peak flight is in the early to mid afternoon" together with the 11:00 to 14:00 emergence peak of @gray1972, taken to the later side because emergence precedes the flight it starts.

The window was checked against the station climate, 236,079 hourly records from May to September of the nine study years (Figure S1). Inside it, 89.5 per cent of afternoon hours fell within the 19 to 41 degrees C flight range against 51.4 per cent outside it, and mean wind peaked in the same hours as temperature, at 10.4 km/h in mid-afternoon against 4.6 km/h at dawn, so the hours in which the beetle could fly were also the windiest of the day.

Station wind from Environment and Climate Change Canada entered hour by hour, and the terrain adjustment described next acted on each observation rather than on a mean. Wind was then summarised by sixteen-day epoch, the interval at which the response was measured and the finest at which wind varied within a season as well as between seasons.


## Terrain-resolved wind {#sec-micromet}


::: {.cell}

:::


Station wind interpolated from four to seven valley stations was nearly flat within a year, so wind was also computed as a field varying in space with the MicroMet model of @liston2006, whose wind component is seven equations implemented directly from the source paper and set out in Methods S1. The terrain weighting factor depends on direction and not on speed. It was computed once for each of 16 wind direction sectors of 22.5 degrees, the sixteen points of the compass, and each hourly observation was multiplied by the surface for its own sector, so that nothing was averaged before the terrain acted on it. Over all sectors the factor ran from 0.60 to 1.38.

Speed and direction were combined as vector components. The resulting field varied from 1.9 to 2.8 km/h across the grid within a year. It was not a terrain index under another name, correlating +0.148 with the windward-leeward index and +0.123 with flight-window radiation, while its strongest association was with elevation at +0.320.

## Stand structure

Stand structure came from the provincial Vegetation Resources Inventory layer VEG_COMP_LYR_R1_POLY, retrieved within the perimeter. Six of its attributes covered the mechanism and the stem-size threshold, total basal area, crown closure, live stems per hectare, quadratic mean diameter over stems of 12.5 cm and larger, stand age, and susceptible pine basal area, formed as total basal area times the pine share of cover.

Every model was fitted on annualized stand structure. Each cell-year took the inventory snapshot the province published for that year, depleted for harvest and projected for growth to it, so the host terms varied in time as well as in space. One year was substituted, because the 2007 inventory dataset omitted basal area and live stems variables, so the 2006 record stood in for 2007 rather than an average derived from 2006 and 2008 records. The inventory is itself a projection, so an average would produce a stand structure the province never published, whereas the 2006 record is one it did. Cell-years at or above the 25 cm source-sink threshold made up 67.1 per cent of the sample (@tbl-vri).

*@tbl-vri near here*

The inventory is a projected operational product rather than a census, and its polygons here had reference years spanning several decades. A polygon interpreted from late-outbreak photography described a stand the beetle had already attacked, and basal area and pine cover were post-attack over part of the study window. Unattacked vintages were not reported in this study, and the limit this places on the results is taken up in the Discussion.

## Geomorphometry

Terrain was described by surfaces computed with SAGA GIS over the full reprojected elevation model and clipped afterwards, so that a search radius near the boundary still fell on measured ground. The set separated the single ruggedness index of @murphy2026 into the properties the beetle's biology points to, while ruggedness itself was kept as a candidate so that the separation was tested against it rather than assumed.

Radiation was computed twice because two mechanisms require different quantities. Flight-window radiation was the direct and diffuse total over 1 July to 15 August restricted to 12:00 to 17:00, the hours identified as the flight peak [@safranyik2006chap1], while growing-season radiation was the whole-day total from 1 May to 30 September, the shading quantity the first mechanism of @krawchuk2020 concerns. A single annual heat index cannot separate the two, flight-window direct radiation spanning a 7-fold range here against 2.6-fold for the season total.

Exposure entered as the windward-leeward index, effective air flow height, the wind exposition index and the wind shelter index of @plattner2004, which is "the maximum gradient within a given radius in upwind direction", with topographic openness and sky view. Shape entered as ruggedness, topographic position, convergence, slope, curvature and geomorphon class, a landform class read from the horizons visible around a cell, and landform as wetness, valley depth and height above the valley floor, because infested groups are reported in draws and gullies and deep snow insulates overwintering brood [@safranyik2006chap1; @kautz2023]. Aspect entered as its northward and eastward components with the heat load index of @mccune2002. Every candidate is listed in Table S3.

## Beetle refugia modelling

Candidates were grouped by pathway, stand density, host size, topographic shading, flight-window radiation, terrain exposure to wind, terrain shape, landform and flight-window wind. Selection ran over four stages and was required to keep at least one variable from each pathway, so that a filter could not silently remove a hypothesis the Introduction established. Candidates whose univariate logistic fit was not significant at 0.01 left first. Clusters at an absolute correlation of 0.75 then kept their member with the highest univariate area under the receiver operating characteristic curve (AUC), variables were removed until every variance inflation factor was below 5, and a lasso penalty chosen by ten-fold cross-validation at the one-standard-error rule, the selection @murphy2026 used, removed the rest, with the highest-ranked survivor of each pathway exempt. Table S3 gives every candidate and the stage at which it left. The 15 variables that entered the models, 8 of them terrain, are listed in @tbl-variables with the direction expected of each. Fitting used a class-balanced sample of 42,791 cell-years, 4,000 of each class per year, because landscape prevalence was about 10 per cent and an unbalanced fit at that prevalence would report the magnitude of the intercept rather than the effect of the covariates.


::: {.cell}

:::


*@tbl-variables near here*

Every model was a logistic regression of moderate-to-high disturbance $y_{it}$ in cell $i$ and year $t$ on standardised covariates,

$$\operatorname{logit}\Pr(y_{it}=1) = \alpha + \mathbf{x}_{it}^{\top}\boldsymbol{\beta}
+ \gamma_{g(i)} + \sum_{k} \delta_k\, z_{k,it}$$ {#eq-model}

where $\gamma_{g(i)}$ was the effect of the geomorphon landform class $g$ of cell $i$ and the $z_{k,it}$ were the interaction terms, so that every coefficient was a change in log-odds per standard deviation of its variable. Four annual models were fitted in sequence, each adding one mechanism to the one before, M0 host size, shading and landform, M1 stand density, M2 terrain shape, terrain exposure and flight-window radiation, and M3 the interactions of stand density with terrain exposure, flight-window radiation and flight-window wind. They were compared on AIC and on predictive error on the fitted probabilities. M0 to M2 answered the first question and M3 the second at the annual scale. The sixteen-day models answered the second question again where wind varied within a season, the scale at which the plume mechanism acts. The sixteen-day response was a fall in NDMI of 0.080 or more against the same sixteen-day epoch of the 2005 pre-outbreak imagery, over nine epochs from May in each of the eight years. It was regressed on the same covariates as the annual models, with the epoch wind of the terrain-resolved field replacing the annual wind terms, together with its interactions with stem density and standing volume. The model was then refitted with the previous epoch's attack entered twice, as the cell's own state and as the share of cells attacked within 90 m, the radius at which previous attack predicted current attack most strongly of those tested, so that the interaction was read against within-season spread. The third question compared the coefficient of terrain shelter on its own, from M2 and M3, with the coefficient of the shelter by density interaction from M3. Deposition predicts the first present and the second absent, whereas plume disruption predicts the second present whether or not the first is.

# Results {#sec-results}

## The three mechanisms

*@tbl-aic near here*

Each mechanism improved the fit when it entered. AIC fell by 298 when stand density entered, by a further 322 with terrain and flight-window radiation, and by a further 562 with the interactions (@tbl-aic).

*@tbl-m3 near here*

Stand basal area was the density term the penalty kept. It entered at +0.430 log-odds per standard deviation, an odds ratio of 1.537, so a stand one standard deviation above the mean in basal area had 53.7 per cent higher odds of moderate-to-high disturbance (p < 0.001), the direction a canopy that keeps the pheromone plume together implies. Live stems and crown closure left at the penalty stage (Table S3), and crown closure is in any case recorded by the inventory to a ceiling of 60 per cent.

*@tbl-qmd near here*

Host size acted as a threshold rather than a gradient. Attack peaked in the 25 to 30 cm class at 31.5 per cent and fell above it, to 22.4 per cent at 30 to 40 cm and 13.2 per cent above 40 (@tbl-qmd). The step across the 25 cm source-sink boundary ran from 21.5 to 31.5 per cent, +10.0 percentage points (95 per cent confidence interval 8.9 to 11.1, P < 0.001). In the full model diameter was -0.341 per standard deviation (z = -15.37), negative because a linear term fitted through a humped response returned the slope of its falling limb, so the class table rather than the coefficient was the result here. Across all six classes attack depended on diameter class [$\chi^2$ = 678.2 on 5 degrees of freedom, P < 0.001, Cramer's V = 0.126], while 30 m cells in a spreading outbreak were not independent, so both P-values were anti-conservative.

Topographic shading was not supported. Radiation entered the model once, as direct radiation during the flight window, at +0.319, the term that represents the temperature limit on flight, while growing-season radiation did not survive selection, so northness, which correlated -0.824 with it, stood in for the shading pathway. Northness entered at +0.384, so shaded, north-facing ground had more attack rather than less, against the prediction.

## Wind through stand density in time

Stand density interacted negatively with terrain-resolved wind, the form the pheromone mechanism predicted. Attack fell where a thin stand and strong wind coincided, the interaction being -0.049 for stem density (p < 0.001) and -0.017 for standing volume (p < 0.05). Expressed as odds, each standard deviation of the epoch wind regime multiplied the contribution of stem density by 0.952, a reduction of 4.8 per cent. Both interactions remained after the previous epoch of the same season was entered, so neither was the outbreak's own spread appearing as a wind coefficient.

Wind alone gave no protection. Its main effect was +0.022, marginally more attack rather than less, and the density terms were positive, so a thin stand in still air showed no reduction either and the mechanism appeared only where the two coincided. The interaction was refitted under four definitions of the wind window, and the stem-density interaction was negative under all four and distinguishable from zero under three (Table S4).

*@fig-interaction near here*

Attack recurred where it had already occurred, by a margin large enough to change how every other coefficient should be read. A cell attacked in one year was between 9 and 88 times more likely to be attacked in the next. Entering persistence and 90 m neighbourhood spread separately, following the autologistic design used for this province, gave +0.725 and +0.692 and raised discrimination from 0.774 to 0.857.

The result that mattered was which environmental terms remained after that term entered. Sky view moved from +0.317 to +0.225 and the wind shelter index from -0.260 to -0.215, both describing conditions a cell had whether or not the beetle was ever present. Conversely, the shape terms were less stable, convergence moving from -0.081 to -0.045 and profile curvature from -0.064 to -0.036. Part of what the landform terms measured was thus where the outbreak had already been, the same failure the terrain-wind index showed against radiation.

## Terrain shelter alone or through density

Terrain predicted attack after stand structure and radiation were in the model, through shelter and openness rather than ruggedness, since neither terrain ruggedness nor the windward-leeward index survived selection (Table S3). The wind shelter index as computed here rose on slopes that faced the prevailing wind, correlating +0.71 with that orientation, and it entered at -0.267 (p < 0.001), so leeward ground had more attack and windward ground less. Sky view factor, the share of the sky visible from a cell, which is high on gentle, open, upper ground, entered at +0.285 (p < 0.001), so open, sheltered ground had the most attack. The two valley terms, valley depth and height above the valley floor, left at the penalty stage once sky view and elevation were in the model. Elevation entered at +0.381. Of the shape terms, convergence entered at -0.077 and profile curvature at -0.059, while topographic position was not distinguishable from zero (p = 0.521). The landform classes are in Table S5.


The third question was tested by fitting the full model twice. Without flight-window radiation, stand density interacted with terrain shelter at +0.055, which on its own would read as plume disruption acting through terrain. With radiation in the model, that interaction shrank to +0.023 and was no longer distinguishable from zero (p = 0.371), while density interacted with radiation at +0.073. On a range whose prevailing bearing was 258 degrees the windward slopes faced west, and those were also the slopes that took the afternoon sun, so 59 per cent of the apparent shelter interaction was radiation and the remainder was too small to support a claim. The shelter coefficient itself did not move between the two fits. Shelter therefore acted alone, as deposition predicts, and not through stand density, as plume disruption would require.


::: {.cell}

:::


# Discussion

## Wind and density

The density by wind interaction took the form the thinning literature predicted and was small. Attack fell where a thin stand and strong flight-period wind coincided, at -0.049 log-odds per standard deviation for stem density, roughly a tenth of the stand basal area main effect, and it held after within-season spread entered. That was the pattern @bartos1989 measured at the stand scale, where thinning raised wind, light and temperature and lowered the pheromone trap catch to 5 per cent of the unthinned stand's before any gain in vigour. It is also the pattern the tracer plumes of @thistle2004surrogate imply, which diluted fastest in the most open canopy. Two results pointed the other way. @preisler1993colonization found that wide spacing did not stop attacks switching between neighbouring trees once a thinned plot was entered. Wind alone gave no protection here, its main effect being +0.022, so wind acted only through the canopy that kept the plume together and only in the weeks when it was strong. The size of the effect was closer to the field record than to the strength of the claim in the refugia literature. Thinning reduced mortality from about half of the pines to almost none in the ponderosa pine trial of @hood2016fortifying and from 16 to 2 per cent in lodgepole pine [@bartos1989]. Those were contrasts of managed against unmanaged stands, whereas here the density range was the one an unmanaged landscape offered and the wind was terrain-modified station data rather than measurement on the ridge. What was established was that the modelled wind field behaved as the mechanism required, not that the air itself did. For management the result gave an upper limit. Thinning to the basal area the susceptibility rating targets [@shore2000susceptibility; @fettig2007effectiveness] could be expected to lower attack on windward ground during windy flight periods and to do little on sheltered lee slopes, which is where the terrain result placed the beetles.

## Terrain and landing

Terrain acted on attack as a main effect of shelter and openness that did not depend on stand density. Leeward ground had more attack, -0.267 on an index that rose windward, and open gently sloping ground more still, sky view +0.285, while the shelter by density interaction fell by 59 per cent when flight-window radiation entered and could not then be told from zero. Read with the dispersal record, that was where beetles came down rather than where they chose to attack. A beetle descending through slowing air settled where the flow decelerated, as @byers2000 simulated and as the shelter index of @plattner2004 predicted for snow. @giroday2011 found the same for landscape features that intercept a plume of insects, though in the Peace River region those surfaces were the southwest-facing open slopes that met a westerly wind rather than the lee. Impaction on faces that met the wind and settlement where it slowed were both deposition, and which one a landscape showed may have depended on how much of its relief a descending beetle cleared. The reading was an interpretation rather than an observation. No beetle was tracked to the ground here, sky view factor also set diffuse radiation, and open upper ground warmed first, so the same pattern would have followed from faster development as readily as from deposition [@sambaraju2021]. The aspect result told the same story from the other side. North-facing ground had more attack, +0.384, where the shading mechanism required less. That agreed with the watershed record of @kaiser2012ecohydrology, in which the beetle reached south-facing and drier positions first, and with the hot spots of @nelson2007environmental, which lay on warm south and west aspects in the early years of this province's outbreak, so shaded ground here was not the refugium the hypothesis named but the ground the outbreak reached last. Northness tested aspect, and aspect measured more than shade, so this was the least secure of the three verdicts, and the water-stress pathway @krawchuk2020 described was not measured.

## Host size

Attack peaked at 31.5 per cent in the 25 to 30 cm class and fell on both sides, which is the source and sink boundary of @carroll2004bionomics read as a landscape pattern. Larger stems were the preferred and the better-defended hosts while populations were low, and those defences stopped mattering once stand densities crossed the eruptive threshold [@boone2011efficacy], which is consistent with the class above 40 cm, the oldest and sparsest stands here, taking less attack than the class at the threshold. The susceptibility rating of @shore2000susceptibility, which weights age, density and pine basal area, predicted basal area killed as a straight line, and the mapping of @hicke2008mapping applied the same structure across the western United States. The present result added that the diameter term was a step rather than a slope.

## Measurement lessons

Two measurement results extended beyond this landscape. The first was that a terrain wind index was in part a measurement of incident radiation, flight-window radiation having moved the density by shelter interaction from +0.055 to +0.023. A shelter index and an afternoon radiation surface were both functions of slope and aspect, and on a range whose prevailing flight-window bearing was 258 degrees the slopes that met the wind were the west-facing ones, which also took the afternoon sun during the flight peak. Any study entering a terrain wind index without a radiation term over the same hours would attribute radiation to wind, and the same confound is present in the temperature terms of the regional models [@preisler2012climate; @creeden2014climate]. The second was that a landform variable in a spreading outbreak recorded in part where the outbreak had already been, previous-year attack having moved convergence from -0.081 to -0.045 while sky view moved only from +0.317 to +0.225. That was the cell-scale form of the dependence @aukema2008 found on attack within 18 km in the same year and within 6 km in the two years before, and of the finding of @walter2013 that the predictors of infestation changed through an outbreak. The terms that remained described conditions a cell had whether or not the beetle was ever present, and the terms that moved described its shape.

## Limits and management

Elevation was among the largest terms in the model at +0.381 and was not a single quantity, since it combined temperature, snowpack, growing-season length and the distribution of lodgepole pine in a way this design could not separate. Three limits lay outside the model. The inventory postdated part of the outbreak, since polygons interpreted after the beetle passed described the stand it left, and total basal area discriminated only weakly on its own, a univariate AUC of 0.601. The response was classified rather than observed, from 28 plots inside one burn, so the reported accuracy measured how well the classification reproduced those plots and not agreement with ground mortality elsewhere. Every conclusion rested on one mountain range across eight years. For pest management the result meant that refugia could not be mapped from terrain alone, and that the map had two layers. A stand's exposure to the prevailing wind set how many beetles arrived, and its density during the windy weeks of the flight period set how many of those succeeded, by the modest margin the interaction measured. A review of harvesting for outbreak suppression found the field evidence for that effect weaker than policy assumed [@six2014management].

# References {.unnumbered}

::: {#refs}
:::

{{< pagebreak >}}

# Acknowledgements {.unnumbered}

This work used no external funding. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance distributed by the United States Geological Survey; stand structure from the British Columbia Data Catalogue; terrain from Natural Resources Canada; and wind from Environment and Climate Change Canada. The author thanks those agencies for maintaining the open archives the study rests on.

{{< pagebreak >}}

# Tables {.unnumbered}


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


{{< pagebreak >}}

::: {#tbl-variables .cell tbl-cap='The variables that entered the models after selection, the pathway each served, and the direction expected of it from the mechanism named in the Introduction. AUC was the area under the receiver operating characteristic curve of the univariate fit, with the asterisks beside it marking its significance, * P ≤ 0.05, ** P ≤ 0.01, *** P ≤ 0.001, **** P ≤ 0.0001.'}
::: {.cell-output-display}


|Variable                                |Pathway                              |Expected                            | Univariate AUC|
|:---------------------------------------|:------------------------------------|:-----------------------------------|--------------:|
|Elevation (m)                           |Landform                             |uncertain                           |      0.682****|
|Susceptible pine BA (m² ha⁻¹)           |Host size                            |positive                            |      0.678****|
|Stand basal area (m² ha⁻¹)              |Stand density                        |positive                            |      0.601****|
|Sky view factor                         |Topographic shading                  |positive, as main effect            |      0.686****|
|Stand age (years)                       |Host size                            |positive                            |      0.571****|
|July mean wind (km/h)                   |Flight-window wind, stations         |negative                            |      0.563****|
|Northness                               |Topographic shading                  |negative                            |      0.586****|
|Quadratic mean diameter (cm)            |Host size                            |positive above 25 cm                |      0.510****|
|June mean wind (km/h)                   |Flight-window wind, stations         |negative                            |      0.534****|
|Wind shelter index                      |Terrain exposure to wind             |negative, the index rising windward |      0.526****|
|MicroMet flight-window wind (km/h)      |Flight-window wind, terrain-resolved |negative                            |      0.580****|
|Topographic position index              |Terrain shape                        |more attack in convergent terrain   |      0.585****|
|Flight-window direct radiation (kWh/m2) |Flight-window radiation              |positive                            |      0.561****|
|Convergence index                       |Terrain shape                        |more attack in convergent terrain   |      0.530****|
|Profile curvature                       |Terrain shape                        |more attack in convergent terrain   |      0.514****|


:::
:::


{{< pagebreak >}}

::: {#tbl-aic .cell tbl-cap='Comparison of the four annual models, each adding one mechanism to the one before. RMSE was the root mean squared error and MAE the mean absolute error, both on the fitted probabilities, and AUC the area under the receiver operating characteristic curve. Brier skill was the improvement over predicting the prevalence for every cell, where 0 was no better than that base rate.'}
::: {.cell-output-display}


|Model                          |    AIC|  ΔAIC|  RMSE|   MAE|   AUC| Brier skill|
|:------------------------------|------:|-----:|-----:|-----:|-----:|-----------:|
|M0 host size, shading, terrain | 41,269| 1,182| 0.396| 0.315| 0.758|       0.166|
|M1 + stand density             | 40,971|   884| 0.394| 0.312| 0.761|       0.175|
|M2 + terrain, flight radiation | 40,649|   562| 0.393| 0.309| 0.767|       0.182|
|M3 + interactions              | 40,087|     0| 0.390| 0.305| 0.778|       0.193|


:::
:::


{{< pagebreak >}}

::: {#tbl-m3 .cell tbl-cap='Coefficients of the full annual model M3, continuous terms ordered by absolute size. Each coefficient was the change in log-odds per standard deviation of its variable, fitted on a class-balanced sample, so the intercept was not the landscape prevalence. SE was the standard error and z the Wald statistic. Significance was marked * P ≤ 0.05, ** P ≤ 0.01, *** P ≤ 0.001, **** P ≤ 0.0001. The geomorphon landform classes of the same model were reported in Table S5.'}
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


{{< pagebreak >}}

::: {#tbl-qmd .cell tbl-cap='Moderate-to-high beetle disturbance by quadratic mean diameter class, on the balanced sample. The 25 cm boundary was the source-sink threshold of the species\' bionomics. Intervals were Wilson score intervals on the class proportion, which is why they were asymmetric in the smallest class. Because 30 m cells in a spreading outbreak were not independent, the tests reported in the text were anti-conservative.'}
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


{{< pagebreak >}}

::: {#tbl-geomorphon .cell}

:::


{{< pagebreak >}}

# Figures {.unnumbered}


::: {.cell}
::: {.cell-output-display}
![Landscape, terrain and stand surfaces across the study area, all EPSG:3153 at 30 m over Esri World Shaded Relief. (a) elevation; (b) terrain ruggedness index; (c) windward-leeward index at the prevailing bearing; (d) flight-window direct radiation, the thermal limit on flight; (e) growing-season direct radiation, the shading pathway; (f) the MicroMet wind weighting factor at the prevailing bearing; (g) stand basal area; (h) quadratic mean diameter, whose 25 cm source-sink threshold fell near the midpoint of the scale; (i) live stems per hectare. The white outline marked the study perimeter and the red outline the 2015 Mt Midgeley burn, with contours at 200 m.](Manuscript_files/figure-docx/fig-study-area-1.png){#fig-study-area}
:::
:::


{{< pagebreak >}}

::: {.cell}
::: {.cell-output-display}
![Spread of moderate-to-high beetle disturbance across the study perimeter. (a) The first year in which each cell entered the moderate-to-high class, over shaded relief with the perimeter in white and the 2015 Mt Midgeley burn in red; cells never classed as attacked showed the relief alone. The panel was built from the eight annual maps for display, and those maps were fitted separately and never merged for analysis. (b) The share of perimeter cells classed moderate-to-high in each year.](Manuscript_files/figure-docx/fig-first-attack-1.png){#fig-first-attack}
:::
:::


{{< pagebreak >}}


{{< pagebreak >}}

::: {.cell}
::: {.cell-output-display}
![The refugia mechanism as fitted in the sixteen-day models. (a) Predicted probability of moderate-to-high disturbance against terrain-adjusted epoch wind at the 10th and 90th percentiles of stem density, with all other terms held at their means. The lines crossed, so wind raised attack in thin stands and lowered it in dense ones, which was the interaction. (b) The same for standing volume, where the interaction was a fifth the size and flattened the dense-stand line without reversing it, so the lines converged rather than crossed over the observed range. (c) Coefficients of the sixteen-day model with and without the within-season spread term, where the shift of a term between the two fits was the part of it that the spread term absorbed. (d) Prevalence in each epoch against its mean wind, one point per epoch, with years distinguished by shape and shade so that the panel remained legible in black and white.](Manuscript_files/figure-docx/fig-interaction-1.png){#fig-interaction}
:::
:::



::: {.cell}

:::





::: {.cell}

:::

