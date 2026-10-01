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

**Correspondence.** Seamus Murphy, TÜV SÜD, 2187 Comox Ave, Comox, British Columbia V9M 1P5, Canada. seamusrobertmurphy\@gmail.com. ORCID 0000-0002-1792-0351.

**Keywords.** Mountain pine beetle, Disturbance refugia, Curculionidae, Scolytinae, British Columbia, thinning, dispersal, topography

**Data availability statement.** Public datasets were used in this analysis. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance, stand structure was derived from British Columbia's provincial Vegetation Resources Inventory, terrain from the Natural Resources Canada High Resolution Digital Elevation Model [@nrcan2017] and wind from Environment and Climate Change Canada hourly station records. All derived data and the complete analysis code that reproduce every number, table and figure in this article are at <https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study> and will be deposited in the Dryad Digital Repository, with a DOI, with the revised manuscript. The study's classifier was trained on the 28 field plots of beetle-killed basal area established in July and August 2020 in the Darkwoods Conservation Area by Murphy, Leslie, Wilson and Banks [@murphy2026], whose plot locations, killed-basal-area measurements and Landsat classifications of red-stage mortality were used with the permission of those authors; that study and its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks, are acknowledged as the source of the ground truth on which every attack map in this article rests.

**Conflict of interest statement.** The author has no conflict of interest to declare. The author was the lead author of the earlier study on the same ground [@murphy2026], and the field plots on which the classifier in this article was trained were collected under that study with its co-authors, Adrian Leslie, John Wilson and Lauren K. Banks. Those data are used here with their agreement, there is no dispute over the ownership of any data presented, and every contribution to the present article has been attributed by authorship or acknowledgement.

**Author contributions.** Seamus Murphy conceived and designed the present study, assembled the datasets, wrote the analysis code, performed the analysis, prepared the figures and tables, and wrote and revised the manuscript, which is every CRediT role. The 28 field plots of beetle-killed basal area and the Landsat classifications of red-stage mortality were produced under the earlier study by Murphy, Leslie, Wilson and Banks [-@murphy2026], and the co-authors of that study contributed to the field data collection and the ground-truthing that this article reuses but took no part in the design, analysis or writing of the present article.

{{< pagebreak >}}

# Abstract {.unnumbered}

1.  Disturbance refugia from mountain pine beetle (*Dendroctonus ponderosae*) outbreaks have been proposed in thin stands of small trees, on shaded ground and where wind disrupts the aggregation pheromone, but little is known about how these mechanisms act together once attack nearby and earlier is taken into account.
2.  This study mapped red-stage attack in eight outbreak years and 47 sixteen-day Landsat periods across 5,573 ha of the Selkirk Mountains, British Columbia, with a classifier validated on field plots, and modelled it on annual forest inventory, terrain and a terrain-resolved wind field, entering the previous year's attack first.
3.  Attack was clustered in every year, with positive spatial autocorrelation to a median of 2,610 m, and attack in and around a cell the year before dominated every model.
4.  Beside those terms attack rose with stand basal area (+0.183 log-odds per standard deviation, p < 0.001) and peaked in stands of 25 to 30 cm mean diameter, and north-facing ground had more attack rather than less. Flight-hour wind did not lower attack where stems were fewer, and the effects of terrain shelter and openness did not survive a latent spatial field.
5.  Refugia on this landscape were stands with little host, and terrain and wind added small, scale-dependent modifiers to an outbreak whose spread was mostly contagion.

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins \[Coleoptera: Curculionidae: Scolytinae\]) affected more lodgepole pine (*Pinus contorta* Douglas ex Loudon) stands across British Columbia than any other disturbance event on record [@taylor2003; @sambaraju2021; @woo2024; @cooke2026mountain]. As less forest burned, the share of the province's pine in the age classes most susceptible to the beetle rose from about 18 per cent in 1910 to 53 per cent in 1990 [@taylor2003]. Extremely low winter temperatures became rarer after 1976, and from 1959 to 2002 the area of pine killed rose with winter minimum temperature over 91.5 per cent of the beetle's range in the province [@maciasfauria2009].

Using landing traps in lodgepole pine, @hynum1980 found that the first beetles to reach a stand, known as pioneers, "were unable to distinguish between hosts, dead hosts and nonhosts during landing". Pioneers landed at random and by sight, and judged a tree only after landing, by tasting compounds in its bark [@safranyik2010]. Where they came down could therefore depend on the airflow as much as on the trees below, which was why this study tested whether ground sheltered from the wind received more attack.

A pioneer female that bored into a suitable tree turned α-pinene, a compound in its resin, into the pheromone trans-verbenol [@safranyik2006chap1]. With compounds from the tree, the pheromone drew a mass attack that was usually complete within one to two days [@safranyik2006chap1]. In experimental lodgepole pine stands, a tree contained a few attacking beetles in wounds of dead tissue but died once its bark had more than about 40 beetle tunnels, or galleries, per square metre [@raffa1983]. A beetle caught in a heavy flow of resin also failed to attract others, but the tree's ability to block this signal fell as more beetles attacked at once [@raffa1983]. @boone2011efficacy followed every lodgepole pine in six stands for three to six years and found that tree defences limited attack while beetles were few but made no difference once their numbers passed a critical threshold. Once an outbreak was under way, whether a tree was killed therefore depended more on how many beetles were nearby than on its defences.

Populations that bred mostly in weakened, injured and small trees grew into an outbreak once they could kill the average large tree in a stand [@jarvis2015; @shore2006]. This followed drought, several generations of favourable weather or the arrival of beetles from elsewhere [@shore2006]. As beetle numbers rose, they chose ever larger trees [@boone2011efficacy], whose thicker phloem, the inner bark on which the larvae fed, was better food [@safranyik2010]. On average, lodgepole pines more than 25 cm in diameter produced more beetles than attacked them, while smaller pines produced fewer [@carroll2004bionomics]. For that reason this study measured the amount of pine in each stand and the size of its trees.

When marked beetles were released in a mature lodgepole pine stand, most were caught 3 m above the ground, catches fell sharply with distance, and only 0.2 per cent of the beetles rose above the canopy [@safranyik1992]. Within a stand, beetles flew downwind under the crowns until they met the scent of an attacked tree, and then turned upwind towards it [@carroll2004bionomics; @safranyik1989]. Comparing clusters of trees attacked the year before, whose needles had turned red, with clusters attacked that year, whose needles were still green, @robertson2007mountain consistently found dispersal distances of 30 and 50 m. As an infestation grew, these clusters merged [@robertson2007mountain]. In the south of the province, where this study was set, many outbreaks erupted locally, apart from the main front that spread east from the west-central interior [@aukema2006landscape]. In an earlier outbreak on the Chilcotin Plateau, an outbreak in a 12 km cell was best predicted by outbreaks in the neighbouring cells that year or in the same cell in the two years before [@aukema2008]. This study tested the same dependence on cells of 30 m, entering the previous year's attack in each cell and in the cells around it in every model.

The minimum winter temperature determined how many of the brood, the young beetles developing under the bark, survived [@safranyik2010]. Larvae in their last stages, the usual overwintering stage, survived temperatures near minus 40 degrees C in midwinter because they had built up glycerol, a natural antifreeze, through the autumn [@carroll2004bionomics]. Cold early in winter, before the glycerol had built up, or late in winter, after it had been used, killed many larvae, while thick bark and deep snow sheltered the brood [@carroll2004bionomics]. Late-stage larvae also needed more warmth to develop than younger larvae, which kept the brood in step [@carroll2004bionomics]. East of the Rocky Mountains in Canada, the middle 70 per cent of the season's flight lasted 26 days, a synchrony the beetles needed to overwhelm trees by attacking together [@bleiker2016flight]. Where summers were too cool for the brood to develop in one year, as at high elevations, it spent two winters under the bark and mortality was severe [@safranyik2006chap1]. A two-year cycle also spread the emergence of adults over a longer period, which lowered the success of mass attack [@safranyik2006chap1; @logan2001].

Drought lowered the resistance of trees and so raised the frequency of outbreaks [@jarvis2015; @shore2006]. In Colorado and southern Wyoming from 1996 to 2010, the outbreak began in several separate places, which suggested drought as a regional trigger, and years with less precipitation than average helped it spread [@chapman2012spatiotemporal]. In Oregon and Washington over three decades, once beetle numbers nearby were accounted for, winter minimum temperature and drought in the current and previous years had the largest effects on whether an outbreak grew large [@preisler2012climate]. In helicopter surveys of the Morice Timber Supply Area of north-central British Columbia from 1995 to 2002, the most intense infestations were typically found early on warmer slopes facing south and west [@nelson2007environmental]. To represent these differences, this study measured the sun each slope received during the flight period and over the growing season, and how far each slope faced north.

Cypress Hills Interprovincial Park in Saskatchewan was surveyed tree by tree for infestation each year from 2006 to 2018 [@kunegel2020factors]. There, infestations left untreated nearby in the previous year were the most important single predictor of attack in every phase of the outbreak [@kunegel2020factors]. In the Arapaho and Roosevelt National Forests of Colorado, where red attack was mapped from Landsat images for 2003 to 2010, the best predictors of attack changed "from forest susceptibility to dispersal to host availability" as the outbreak grew [@walter2013, p. 317]. Attack there also moved from high to low elevations between 2003 and 2006 [@walter2013]. In the Lolo National Forest of western Montana, the odds of red attack rose with elevation because lodgepole pine grew higher, along ridge tops, than the Douglas-fir that dominated the area [@wulder2006red]. These studies described terrain mainly by elevation, slope and aspect, whose effects followed the phase of the outbreak and where the host grew. This study instead measured properties of terrain that could affect flight and survival, namely shelter from the wind, openness to the sky and the sun a slope received.

@krawchuk2020 defined disturbance refugia as "locations that are disturbed less severely or less frequently than other areas within the surrounding landscape" (p. 235) and noted that "few studies have explicitly identified refugia from insect outbreaks" (p. 238). They proposed that refugia from this beetle could occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" (p. 239). In southern Oregon, where refugia were mapped at 30 m from a Landsat moisture index during a severe outbreak in 2009, they were "associated with topographically shaded slopes, convergent environments such as valleys, areas of relatively low soil bulk density, and in thinner forest stands" [@cartwright2018, p. 1]. This study tested all three mechanisms of @krawchuk2020 in one landscape.

Thinned lodgepole and ponderosa pine stands lost fewer trees to the beetle in trials across the western United States [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying]. @mitchell1983thinning and @waring1985modifying attributed this to the greater vigour of the trees left after thinning. In the Uinta Mountains of Utah, @bartos1989 proposed microclimate instead, having measured more light, warmth and wind in a thinned stand than in the unthinned stand beside it. The difference in wind was 3.2 km/h or more between 4 and 6 p.m., when most beetles flew, and the thinned stand lost 2 per cent of its trees against 16 per cent [@bartos1989]. In central Oregon, thinned plots at first attracted few beetles, but once attack began, trees near attacked trees were more likely to be attacked in thinned plots than in unthinned ones [@preisler1993colonization]. The authors concluded that wide spacing did not seem to stop attacks moving from tree to tree [@preisler1993colonization]. In a survey of 94 unmanaged lodgepole pine stands in the western United States, mortality in stands of more than 80 per cent pine was low where the stand density index, a measure of crowding, was below 125, much greater between 125 and 250, and lower again above 250 [@anhold1987potential].

Wind could lower attack by breaking up the pheromone plume, the trail of scent downwind of an attacked tree, which @krawchuk2020 called "wind disruption of beetle pheromone communication" (p. 239). This predicted that wind would lower attack most in thin stands. Wind could also concentrate attack through deposition, meaning beetles settling out of the air where it slowed. @giroday2011 noted that "alterations in wind speed may cause increased settlement in areas where wind speed is reduced" (p. 1098). During the beetle's range expansion in the Peace River region of western Canada, they found that infestations established first in canyons and valleys before moving onto more open slopes [@giroday2011]. Because pioneers could not choose a host until they had landed, deposition predicted more attack on ground sheltered from the wind, whatever the stand. Both effects could act only during flight, which needed air temperatures of 19 to 41 degrees C [@mccambridge1971] and stopped in winds above about 2 metres per second, the beetle's top flying speed [@carroll2004bionomics]. Flight peaked in the early to mid afternoon [@safranyik2006chap1] during a season that began in July [@bleiker2016flight], and this study measured wind only in the afternoon hours of the flight season.

This study grew out of a study of conifer regeneration after the 2015 Mt Midgeley fire on the same ground [@murphy2026], and it used that study's 28 field plots and 30 m Landsat grid. In that study, terrain ruggedness had the largest coefficient of any variable on seedling density, +0.626 (p < 0.001), but ruggedness combined several properties of the ground and could not show which one mattered. Earlier work described wind by a seasonal station mean, as in a machine-learning model of the outbreak in the Cypress Hills [@ramazi2021outbreaks], or above the canopy rather than within the stand [@jackson2008; @ainslie2010]. This study mapped red-stage attack, meaning trees whose needles had turned red in the year after they were attacked, at 30 m across part of the Selkirk Mountains of southeastern British Columbia. Attack was mapped once a year to test the refugia mechanisms and every sixteen days to test wind, using a wind field adjusted for terrain. The study asked three questions. The first was whether stand density, shading by terrain and the scarcity of large trees predicted attack once attack nearby was in the model. The second was whether wind during flight lowered attack more in thin stands than in dense ones, as disruption of the pheromone plume predicted. The third was whether ground sheltered from the wind had more attack whatever the stand, as deposition predicted.


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

The literature in the Introduction was assembled under a written protocol, frozen before the first search, from two indexes, the author's reading store and one round of citation chasing, which returned 1,257 unique records, of which 198 were retained and 35 read in full.

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


The study area covered 5,573 ha of the Selkirk Mountains in southeastern British Columbia, 61,923 cells of 30 m from 830 to 1,744 m in elevation, on the grid of @murphy2026 so that the results compared directly with theirs. It was centred on their site, the 2015 Mt Midgeley fire, and extended beyond its 480 ha of burned area by a 5 km buffer cut to the elevation band of that site, which took in the range of stand density the pheromone mechanism needed while keeping the added ground comparable. Attack was mapped once a year for the questions on refugia and every sixteen days for the wind test, the inventory once a year, the station winds every hour and the terrain once (Table S1).

Stand structure came from the provincial Vegetation Resources Inventory, taking for each study year the snapshot the province published for that year, rasterised to the 30 m grid (@tbl-vri). The attributes were basal area, crown closure, live stems per hectare, quadratic mean diameter of stems of 12.5 cm and larger, stand age, stand height, standing volume and susceptible pine basal area, the product of basal area and pine cover. The 2007 snapshot omitted basal area and live stems, so the 2006 snapshot stood in for it. The inventory is a projection rather than a census, and polygons interpreted from late-outbreak photography described stands the beetle had already attacked.

Terrain surfaces were computed with SAGA GIS over an elevation model extending beyond the perimeter, so that search radii near the edge fell on measured ground. They separated the ruggedness index of @murphy2026 into the properties the beetle's biology points to, with ruggedness kept as a candidate so that the separation was tested rather than assumed. Exposure entered as the windward-leeward index, effective air flow height, the wind exposition index and the wind shelter index of @plattner2004, "the maximum gradient within a given radius in upwind direction", together with topographic openness and sky view. Shape entered as ruggedness, topographic position, convergence, slope, curvature and geomorphon class, and landform as wetness, valley depth and height above the valley floor, because infested groups are reported in draws and gullies and deep snow insulates overwintering brood [@safranyik2006chap1; @kautz2023]. Aspect entered as northness, eastness and the heat load index of @mccune2002. Radiation was computed twice, because flight and shading depend on different quantities, once over the flight window of 1 July to 15 August from 12:00 to 17:00 and once over the whole growing season from 1 May to 30 September, the quantity the shading mechanism of @krawchuk2020 concerns. The first varied 15-fold across the ground and the second 2.9-fold. Temperature differences between slopes at the same elevation were represented by these radiation surfaces and by northness rather than modelled, since @running1987 found that closed forest canopies "may exhibit virtually no slope related differences in surface temperature when the surface is an actively transpiring canopy" (p. 475). The variables that entered the models are listed with their mechanisms in Table S3.

@fig-study-area *near here*

@tbl-vri *near here*

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


The response for the first and third questions was red-stage attack in each of eight outbreak years, 2006 to 2011, 2013 and 2014, excluding 2012, when Landsat 7 was the only sensor and its scan-line corrector had failed. The index and baseline followed @murphy2026, who mapped red-stage mortality on this ground as the fall in the normalised difference moisture index (NDMI), an index used to detect forest disturbance in Landsat time series [@jin2005], against 2005, and validated the map against 28 field plots of 20 by 20 m in which beetle-killed pine was confirmed from pitch tubes, frass and gallery architecture. Each annual image was the median of the cloud-masked Collection 2 Level-2 scenes from 1 June to 31 August, from Landsat 5 for 2005 to 2011 and Landsat 8 for 2013 and 2014, the Landsat 8 years adjusted by the band-pass coefficients of @roy2016 and then matched to the Landsat 5 range over forest that showed no attack. Each year was mapped on its own with lakes and rivers masked, and attack covered from 9.9 to 20.7 per cent of the perimeter by year (Table S2, @fig-spread).

The response for the second question was red-stage attack in each sixteen-day period, the Landsat revisit interval, from 1 May to 22 September of the same years, NDMI being the median of the scenes in each period differenced against the same period of 2005 so that the seasonal course of leaf moisture did not enter the difference. Periods in which the imagery saw less than a tenth of the perimeter were dropped, which left 47 periods over eight years.

The fall in NDMI that counted as attack was set by a classifier trained on the four pixels nearest the centre of each field plot, 112 pixels, against the 84 points of undisturbed forest that @murphy2026 digitised on the 2020 Landsat 8 scene, which fell in 68 distinct cells. Each pixel entered with its deepest annual fall in NDMI against 2005. Random forest, a radial support vector machine and gradient boosting were compared over 100 random splits, each holding out a quarter of the field plots and of the 100 m blocks of undisturbed pixels, so that neighbouring pixels never fell on both sides of a split. The radial support vector machine classified most accurately, with kappa 0.859 ± 0.081 (95 per cent interval 0.682 to 1.000) and overall accuracy 0.934 ± 0.037, the three models differing by less than one standard deviation of the splits (@tbl-classifier). Its prediction changed class at a fall in NDMI of 0.0616 against 2005, and that cut was applied to the annual and the sixteen-day differences. The undisturbed pixels came from one patch of about 230 by 455 m, so the cross-validation measured separation of the plots from that patch rather than from undisturbed forest across the landscape.

Wind was summarised over the flight hours of 12:00 to 17:00, following the flight period @safranyik2006chap1 give for this region, where "peak flight is in the early to mid afternoon", and the 11:00 to 14:00 emergence peak of @gray1972. In 236,079 hourly station records from May to September, 89.5 per cent of afternoon hours inside the flight window fell within the 19 to 41 degrees C flight range against 51.4 per cent outside it (Figure S1). Hourly speed and direction from Environment and Climate Change Canada stations within 150 km were combined as vector components and adjusted for terrain with the MicroMet model of @liston2006, which weights each observation by the slope in the wind direction and the curvature of the ground. The adjustment depends on direction and not on speed, so it was computed once for each of 16 sectors of 22.5 degrees over an elevation model extending beyond the perimeter, with a curvature length scale of 600 m. Each period was summarised by its mean flight-hour wind and its share of flight hours below 5 km/h. Mean flight-hour wind ran from 4.0 to 8.6 km/h between periods and varied by up to 5.1 km/h across the grid within a period. The annual models took the same terrain-adjusted wind over the flight hours of 1 July to 15 August of each year, 230 hours from 6 to 9 stations a year, and the mean station wind of June and of July, interpolated to the grid by inverse distance weighting, as the wind that varied between years.

@fig-spread *near here*

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


The spatial pattern of attack was described on each annual map before any model was fitted, following @aukema2008, who treated attack as its presence or absence in the cells of a grid. The join count [@moran1948] was the number of pairs of attacked cells that were neighbours, counting the eight cells around each, and Moran's I [@moran1950] was computed in distance classes of 60 m out to 6 km as a correlogram [@legendre1989]. Both were compared with 999 random relabellings of the attacked cells among the cells mapped that year, and the range of positive autocorrelation was the first distance class at which Moran's I no longer exceeded the relabellings at p ≤ 0.05.

The annual models were built in the order of @aukema2008, who "determined an appropriate spatial neighborhood structure(s) and time lag(s) to account for spatial and temporal dependencies" before any environmental variable entered. The dependence terms were the cell's own state in the previous outbreak year, 2011 in the case of 2013, and the share of cells attacked around it that year within 42, 90, 150, 210, 510 or 1,050 m, excluding the cell itself, the radius being chosen on AIC (@tbl-dependence). Each year contributed up to 4,000 attacked and 4,000 unattacked cells, because at a landscape prevalence near one cell in ten an unbalanced fit would report its intercept rather than its covariates.

The environmental terms were 14 variables grouped by the mechanism each represented (Table S3). Four logistic regressions were fitted in sequence, each adding one mechanism to the one before, M0 host size, shading and landform, M1 stand density as basal area, M2 terrain exposure to wind, terrain shape and flight-window direct radiation, and M3 the interactions of basal area with the wind shelter index, July wind and flight-window radiation. Every model carried the geomorphon class of the cell, and every continuous term was standardised, so that a coefficient was a change in log-odds per standard deviation. The sequence was fitted on all eight years without the dependence terms, and then on the seven years with a previous map, without and with them, so that the change each environmental term underwent once attack nearby and earlier entered could be read directly. The third question compared the main effect of the wind shelter index with its interaction with basal area, in M3 fitted with and without flight-window radiation. Each interaction was read as the slope of one term at one standard deviation either side of the mean of the other. Attack was also tabulated by quadratic mean diameter class, with Wilson intervals, a chi-square test across classes and a two-proportion test across the 25 cm source-sink boundary [@carroll2004bionomics].

The second question was tested on the sixteen-day maps, where wind varied between periods within a season as well as between years. Attack in a period was regressed on 15 stand and terrain variables, mean flight-hour wind, the geomorphon class and the interactions of wind with live stems and with standing volume, first alone (E1), then with the cell's own state in the previous period and the share attacked within 90 m around it (E2), and then with the same two terms for the same period of the previous year (E3), the radii being chosen on AIC as for the annual models. Each period contributed up to 2,000 cells of each class.

Three checks tested the scale of the inference. Moran's I of the deviance residuals was computed within each year on the eight nearest sampled cells for every annual model. M3 with the dependence terms was refitted with a Gaussian process smooth of easting and northing [@wood2017], a latent spatial field of the kind the Cox process model of @murphy2026 carried, with its Matérn range set to the median range of positive autocorrelation, 2,610 m. M3 was also refitted with the cell coarsened to 90, 270 and 990 m, a coarse cell counting as attacked if any 30 m cell inside it was, the definition @aukema2008 used on their 12 km cells, with the previous year's state and the share of the eight neighbouring cells rebuilt at each grain.

# Results {#sec-results}

Attack was clustered in every year, with 3.2 to 5.3 times as many pairs of neighbouring attacked cells as random relabelling produced and positive autocorrelation to a median of 2,610 m (@fig-clustering). The previous year's attack in the cell and within 150 m, the best of six radii (@tbl-dependence), dominated every model it entered, a cell attacked the year before having 7.6 times the odds of attack, and the two terms raised the AUC of M3 from 0.805 to 0.879.

## Refugia mechanisms

Stand density was supported through the amount of host, host size acted as a threshold, and shading was not supported. Each step of the model sequence lowered AIC, most when basal area entered, by 459 (@tbl-models). Basal area entered M3 at +0.290 log-odds per standard deviation (p < 0.001) and remained positive with the dependence terms, +0.183, and under the spatial field, +0.181, as did susceptible pine basal area, whereas stand age could not be told from zero under the field (p = 0.157) (@tbl-final). Attack depended on quadratic mean diameter class [χ²(5) = 715.1, p < 0.001, Cramér's V = 0.106], peaking in the 25 to 30 cm class at 55.8 per cent of the balanced sample against 48.2 per cent at 20 to 25 cm and falling in the larger classes, whose stands held less pine (@tbl-diameter). North-facing ground had more attack, +0.112 (p < 0.001), and afternoon sun in the flight window raised attack in stands one standard deviation above the mean basal area, +0.145 (p < 0.001), and not in stands one standard deviation below it, +0.011 (p = 0.547).

## Wind and density

Flight-hour wind did not lower attack where stems were fewer. In E1 the interaction of wind with live stems was -0.012 (p = 0.034), which meant attack rose with wind at 411 stems per hectare, +0.026 (p = 0.001), and not at 1,077, +0.002 (p = 0.847). With the previous period's attack entered (E2) the interaction became +0.051 (p < 0.001) and wind raised attack at both densities (@fig-interaction). The interaction of wind with standing volume could not be told from zero in either model (p = 0.642 and p = 0.296).

## Terrain shelter

Leeward ground had slightly more attack, and once the previous year's attack was in the model the effect did not depend on density. The wind shelter index, which rose on slopes facing the prevailing wind, entered M3 at -0.066 (p < 0.001) and at -0.040 (p = 0.016) with the dependence terms, when its interaction with basal area was -0.021 (p = 0.110), and sky view entered at +0.327 (p < 0.001). Both terrain terms depended on the grain and the place, since under the spatial field sky view fell to -0.009 (p = 0.799) and the shelter index changed sign to +0.082 (p < 0.001), and the shelter index lost significance at 90 m and sky view at 270 m, while basal area remained positive at 270 m, +0.094 (p = 0.037) (@fig-grain). Residual Moran's I remained significant in every year even with the spatial field, with a median of 0.337.

# Discussion

## Contagion first

Attack in a 30 m cell was predicted first by attack in and around it the year before, and every environmental term was read beside those terms rather than instead of them. That order was the one @aukema2008 argued for, having found that outbreaking populations within 18 km in the same year and within 6 km in the two years before explained more of the outbreak's movement across British Columbia than climate did. The scale here was far finer and the pattern the same. The share attacked within 150 m the year before fitted better than any wider neighbourhood, close to the 140 m within which previous attack raised the rate of red attack above its background in Colorado [@walter2013], and it matched short-range dispersal, which "takes place under the forest canopy" and is "determined by the relative proximity of brood trees within individual stands" [@safranyik2010, p. 428]. The outbreak was already epidemic in these years, and the dominance of the dependence terms fitted that phase. @walter2013 found that distance to the previous year's infestation "increased in importance relative to other predictors" as an outbreak progressed (p. 315), and @meddens2014 found that late in an outbreak "almost all new mortality was associated with intensification of existing outbreaks, not expansion" (p. 83). The dependence terms raised AUC from 0.805 to 0.879, whereas the whole environmental sequence from M0 to M3 raised it by 0.006, so the refugia mechanisms were tested as modifiers of an outbreak whose spread was mostly contagion.

## Host and density

Attack rose with the amount of host, through basal area, susceptible pine basal area and stand age, which are the variables of the stand susceptibility rating used in British Columbia, built on "the percentage of susceptible pine by basal area", pine age and stand density together with climate [@safranyik2010, p. 429; @shore2000susceptibility]. Stands with little host were therefore the refugia this landscape showed, in agreement with the thinning trials in which stands reduced in basal area lost fewer trees [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying]. The amount of host is itself a product of forest history. @taylor2003 concluded that within climatically suitable areas "forest age-class structure will be the primary factor influencing host susceptibility and outbreak severity" (p. 42), and the area of mature lodgepole pine in British Columbia had more than tripled over the century of fire control before the outbreak [@shore2006]. Basal area here measured the amount of pine rather than crowding, because dense unmanaged stands have thinner phloem and "beetle production and subsequent tree mortality in dense, unmanaged stands tend to be less than in more open stands" [@shore2006, p. 103]. @walter2013 found red attack moving to less dense stands once an outbreak became epidemic, whereas here it rose with basal area in every model through to 2014.

Attack peaked in stands of 25 to 30 cm quadratic mean diameter. The peak sat at the source-sink boundary of @carroll2004bionomics, above which stems produced enough brood to sustain a population, and brood production rose with phloem thickness from an average of 16 to 94 beetles in the range @amman1972 tested. During epidemics the share of trees killed rises with diameter above about 10 cm [@shore2006], so the fall in attack in stands of larger trees did not reflect the beetle's preference. It reflected composition, since stands of the largest trees here held little pine, and epidemics "often deplete the large diameter pine component of stands" [@shore2006, p. 110], after which smaller trees are attacked in later years [@meddens2014].

## Elevation and climate

Elevation carried the largest coefficient in every model, with more attack on higher ground. That ran against the historical pattern, in which mortality "tends to decline with elevation" because the cool climate of high ground slows development and lowers brood survival [@shore2006, p. 103], and in which cooler summers at high elevation stretch the life cycle over two years, with severe mortality [@safranyik2006chap1]. Three readings fit the result. Host distribution was one, since where elevation entered an earlier model of red attack its sign followed the host's distribution rather than the beetle's preference [@wulder2006red]. Outbreak phase was another, since in Colorado red attack "moved from high elevations to in 2003 to low elevations in 2005 and 2006" [@walter2013, p. 316]. The third was a warming climate, which in British Columbia favoured outbreaks "by reducing the occurrence of extremely low winter temperatures province-wide" [@maciasfauria2009, p. 1] and made climates that had limited epidemics more favourable [@taylor2003]. The design could not separate the three, because on this range the higher ground also held the pine.

## Aspect and sun

North-facing ground had more attack in every model, the reverse of both the shading mechanism of @krawchuk2020 and the association of red attack with southern aspects in Colorado [@walter2013], while where attack has been traced against aspect elsewhere it reached south-facing and drier ground first [@kaiser2012ecohydrology; @nelson2007environmental]. Aspect here more likely measured where lodgepole pine grew on this range than a thermal effect. Afternoon sun in the flight window raised attack only in dense stands, which fitted the biology of flight rather than of host stress. Within the thermal range for flight, "flight propensity increases with increasing light intensity" [@safranyik2006chap1, p. 15], and in the thinned stand of @bartos1989, where more light reached the ground, pheromone traps caught 5 per cent of the beetles trapped in the two stands, which they explained by beetles sensing "the difference in light intensity or the greater air turbulence in thinned stands" and avoiding them (p. 9). Sun on a dense stand therefore helped flight without opening the canopy that holds the aggregation plume.

## Wind and density

Flight-hour wind did not lower attack where stems were fewer. The interaction of stems with wind was small, where it could be read it meant more attack in windier periods among the stands with fewer stems, the reverse of plume disruption, and once attack in the previous period entered, wind raised attack at every density. The plume mechanism rests on measurements inside the canopy, where @bartos1989 found a thinned stand windier than an unthinned one by about 1.6 km/h on average and by 3.2 km/h or more in the late afternoon, and argued that in a thinned stand the pheromone "rises through the canopy on convection currents and is dispersed above the canopy" (p. 9), while tracer plumes diluted fastest in the most open of three canopies [@thistle2004surrogate]. A stand one standard deviation below the mean here held 411 stems per hectare, which was not the open canopy those trials created, and neither the inventory nor a terrain model of station wind could resolve a contrast at that scale. Under epidemic pressure the benefit of spacing may also be lost, since in ponderosa pine the influence of pheromones from attacked trees in adjacent unmanaged stands "may override the positive benefits of increased spacing and improved tree growth derived from partial cutting" [@schmid2005, p. 9]. Wind above the canopy carries beetles into new stands [@jackson2008; @chen2017; @safranyik2010], and @safranyik1989 found that "wind speed had negligible effect on the fit of the model for relative directional distribution of beetles" within a stand, both of which predict more attack with wind rather than less, the direction the models with dependence terms showed. The foliage of an attacked tree also stays green "usually until May and June of the year following attack" [@safranyik2006chap1, p. 11], so red crowns seen in a period recorded the flight of the previous summer.

## Terrain and scale

Leeward ground had more attack than windward ground at the same elevation and stand structure, and once the previous year's attack entered, the effect did not depend on density, which is the signature deposition predicts, since a beetle descending through slowing air settles where the flow decelerates [@byers2000] and @giroday2011 found landscape features that met the wind acting as surfaces that intercepted dispersing beetles. The effect was small, it was lost at 90 m, and under the spatial field it changed sign, as did the effect of open ground, so both terrain terms described where attack clustered on this range as much as a property of the slope. Pioneer beetles also land at random before choosing a host [@hynum1980; @safranyik2010], which would weaken any deposition pattern. The environmental results depended on the scale at which they were read, the concern @aukema2008 raised in choosing 12 km cells. A latent spatial field removed the terrain terms while basal area, pine basal area, northness and flight-window radiation held, residual autocorrelation remained in every year so that the p-values in every model were optimistic, and basal area held to 270 m while at about 1 km nearly every cell held an attacked cell. Mortality accrues faster in small areas than across large ones [@meddens2014], and the controls on red attack change through an outbreak "from forest susceptibility to dispersal to host availability" [@walter2013, p. 317], so a refugium defined at 30 m and one defined at 1 km were different objects, and this study supported the first mainly through the amount of host.

## Limits and management

The response was classified rather than observed. The classifier separated the field plots from one patch of undisturbed forest, so its accuracy measured that separation and not agreement with ground mortality across the landscape. Landsat classifications of red stage elsewhere reached kappa of 0.86 to 0.88 against fine-resolution reference imagery [@meddens2013], and high spatial resolution imagery has been assessed for detecting red attack directly [@coops2006], which would give an independent test of these maps. The inventory postdated part of the outbreak, since polygons interpreted after the beetle passed described the stand it left. Temperature entered the models only through elevation, radiation and aspect, so development and overwinter survival were not measured directly. The study covered one mountain range over eight outbreak years.

For management the result gave a narrow answer. Refugia on this landscape were stands with little host, which is the structure thinning and a younger age structure produce, and terrain maps alone could not locate them. The rating system of @shore2000susceptibility places partially cut lodgepole pine stands in its low susceptibility class [@mata2003], and regularly spaced mature stands of at least 4 by 4 m may lose fewer trees [@shore2006]. The dominance of attack nearby here agreed with the limits found in the field. In ponderosa pine, partial cutting "may be ineffective for partially cut parcels of \<10 acres if the partially cut stands are surrounded by unmanaged susceptible stands" and stands "should be managed on a landscape basis" [@schmid2005], and the field evidence that thinning protects stands during an outbreak is weaker than policy has assumed [@six2014management]. This study found no evidence that flight-period wind strengthens that protection.

# References {.unnumbered}

::: {#refs}
:::

{{< pagebreak >}}

# Acknowledgements {.unnumbered}

This work used no external funding. Beetle disturbance was classified from Landsat Collection 2 Level-2 surface reflectance distributed by the United States Geological Survey; stand structure from the British Columbia Data Catalogue; terrain from Natural Resources Canada; and wind from Environment and Climate Change Canada. The author thanks those agencies for maintaining the open archives the study rests on.

{{< pagebreak >}}

{{< pagebreak >}}

# Tables {.unnumbered}


::: {#tbl-vri .cell tbl-cap='Stand structure over the 64,000 sampled cell-years, from the annual Vegetation Resources Inventory snapshots. SD was the standard deviation, SE the standard error of the mean, and Skew and Kurt. the bias-corrected skewness and excess kurtosis.'}
::: {.cell-output-display}


|Attribute                             |   Mean|     SD|    SE| Median|   Min|     Max|  Skew|  Kurt.|
|:-------------------------------------|------:|------:|-----:|------:|-----:|-------:|-----:|------:|
|Stand basal area (m² ha⁻¹)            |  35.07|  12.62| 0.050|  37.57|  0.40|   93.49| -0.78|  +1.59|
|Crown closure (%)                     |  50.13|  13.35| 0.053|  50.00|  1.00|   90.00| -1.59|  +3.17|
|Live stems (n/ha)                     | 780.55| 320.62| 1.267| 794.00| 13.00| 5257.00| +1.09| +14.40|
|Quadratic mean diameter (cm)          |  26.43|   6.14| 0.024|  26.06| 13.55|   78.78| +1.08|  +2.50|
|Stand age (years)                     | 113.34|  25.69| 0.102| 110.00| 14.00|  337.00| +1.44|  +9.39|
|Stand height (m)                      |  26.19|   5.99| 0.024|  26.28|  7.00|   42.30| -0.09|  +0.42|
|Standing volume (m³ ha⁻¹)             | 264.45| 134.29| 0.531| 262.47|  0.69|  889.64| +0.10|  -0.27|
|Lodgepole pine cover (%)              |  23.56|  27.02| 0.107|  17.40|  0.00|  100.00| +1.12|  +0.38|
|Susceptible pine basal area (m² ha⁻¹) |   8.24|  10.26| 0.041|   3.96|  0.00|   48.30| +1.36|  +1.37|


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


::: {#tbl-dependence .cell tbl-cap='Dependence terms compared on AIC over 55,963 sampled cell-years with a previous map. Own state was attack in the cell in the previous outbreak year, and the share was the proportion of cells attacked within the radius around it that year, excluding the cell. Delta AIC was the difference from the lowest.'}
::: {.cell-output-display}


|Terms                                       |  k|    AIC| Delta AIC|
|:-------------------------------------------|--:|------:|---------:|
|intercept                                   |  1| 77,583|  24,284.1|
|intercept + own state                       |  2| 57,386|   4,087.3|
|intercept + own state + share within 42 m   |  3| 54,545|   1,245.5|
|intercept + own state + share within 90 m   |  3| 53,434|     134.9|
|intercept + own state + share within 150 m  |  3| 53,299|       0.0|
|intercept + own state + share within 210 m  |  3| 53,392|      93.3|
|intercept + own state + share within 510 m  |  3| 54,220|     920.9|
|intercept + own state + share within 1050 m |  3| 55,029|   1,729.5|


:::
:::


{{< pagebreak >}}


::: {#tbl-models .cell tbl-cap='The annual models, each adding one mechanism to the one before, over all eight years without the dependence terms and over the seven years with a previous map without and with them. M0 held host size, shading and landform, M1 added basal area, M2 terrain exposure, terrain shape and flight-window radiation, and M3 the interactions of basal area with wind shelter, July wind and flight-window radiation. AUC was the area under the receiver operating characteristic curve and Brier skill the reduction in mean squared error of the fitted probabilities against the base rate.'}
::: {.cell-output-display}


|Years        |Dependence |Model |      n|    AIC|   AUC| Brier skill|
|:------------|:----------|:-----|------:|------:|-----:|-----------:|
|2006 to 2014 |no         |M0    | 64,000| 70,228| 0.795|       0.268|
|2006 to 2014 |no         |M1    | 64,000| 69,769| 0.799|       0.274|
|2006 to 2014 |no         |M2    | 64,000| 69,652| 0.800|       0.275|
|2006 to 2014 |no         |M3    | 64,000| 69,556| 0.801|       0.277|
|2007 to 2014 |no         |M0    | 55,963| 61,035| 0.799|       0.274|
|2007 to 2014 |yes        |M0    | 55,963| 49,050| 0.876|       0.431|
|2007 to 2014 |no         |M1    | 55,963| 60,601| 0.804|       0.280|
|2007 to 2014 |yes        |M1    | 55,963| 48,904| 0.876|       0.434|
|2007 to 2014 |no         |M2    | 55,963| 60,493| 0.805|       0.282|
|2007 to 2014 |yes        |M2    | 55,963| 48,881| 0.877|       0.434|
|2007 to 2014 |no         |M3    | 55,963| 60,407| 0.805|       0.284|
|2007 to 2014 |yes        |M3    | 55,963| 48,534| 0.879|       0.439|


:::
:::


{{< pagebreak >}}


::: {#tbl-final .cell tbl-cap='Coefficients of M3 over all eight years, with the dependence terms over the seven years with a previous map, and with a latent spatial field as well. Continuous terms were changes in log-odds per standard deviation and dependence terms per unit, and the geomorphon classes are not shown. Significance was marked * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001.'}
::: {.cell-output-display}


|Term                                              |  All years| With dependence| With spatial field|
|:-------------------------------------------------|----------:|---------------:|------------------:|
|Susceptible pine basal area (m² ha⁻¹)             | +0.162****|      +0.094****|           +0.047**|
|Stand age (years)                                 | +0.080****|         +0.029*|             +0.022|
|Quadratic mean diameter (cm)                      | -0.228****|      -0.134****|           -0.060**|
|Sky view factor                                   | +0.327****|      +0.161****|             -0.009|
|Northness                                         | +0.112****|      +0.066****|         +0.171****|
|Elevation (m)                                     | +0.934****|      +0.633****|         +1.164****|
|Stand basal area (m² ha⁻¹)                        | +0.290****|      +0.183****|         +0.181****|
|Wind shelter index                                | -0.066****|         -0.040*|          +0.082***|
|Topographic position index                        |     -0.005|          +0.018|             +0.051|
|Convergence index                                 | -0.056****|         -0.029*|             -0.015|
|Profile curvature                                 | -0.070****|        -0.035**|             -0.003|
|Flight-window direct radiation (kWh/m²)           | +0.078****|      +0.085****|         +0.208****|
|July mean wind (km/h)                             |  +0.034***|      +0.217****|         +0.192****|
|June mean wind (km/h)                             | +0.057****|        +0.042**|            +0.035*|
|Attack in the same cell, previous year            |           |      +2.033****|         +2.129****|
|Attack within 150 m, previous year                |           |      +2.186****|         +0.827****|
|Stand basal area x Wind shelter index             | -0.044****|          -0.021|             +0.009|
|Stand basal area x July mean wind                 |     -0.014|          +0.022|             +0.013|
|Stand basal area x Flight-window direct radiation | +0.067****|      +0.054****|             -0.016|


:::
:::


{{< pagebreak >}}


::: {#tbl-diameter .cell tbl-cap='Red-stage attack by quadratic mean diameter class on the balanced annual sample, with Wilson 95 per cent intervals and the mean susceptible pine and total basal area of each class. The 25 cm boundary was the source-sink threshold of the species\' bionomics. The sample held equal numbers of attacked and unattacked cells in each year, so the percentages compared classes and were not landscape rates.'}
::: {.cell-output-display}


|QMD class (cm) |      n| Attacked| Attacked (%)|   95% CI (%)| Pine BA (m² ha⁻¹)| BA (m² ha⁻¹)|
|:--------------|------:|--------:|------------:|------------:|-----------------:|------------:|
|<15            |    611|      193|         31.6| 28.0 to 35.4|               1.1|          3.2|
|15-20          |  7,026|    3,060|         43.6| 42.4 to 44.7|              10.8|         23.5|
|20-25          | 18,540|    8,945|         48.2| 47.5 to 49.0|               8.2|         28.6|
|25-30          | 24,346|   13,580|         55.8| 55.2 to 56.4|               9.7|         39.8|
|30-40          | 11,118|    5,340|         48.0| 47.1 to 49.0|               5.5|         42.4|
|>40            |  2,359|      882|         37.4| 35.5 to 39.4|               0.4|         45.2|


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
![Red-stage attack across the study perimeter. (a) The first year in which each cell was classed as attacked, over shaded relief with the perimeter in white and the 2015 Mt Midgeley burn in red. (b) The share of the perimeter classed as attacked in each year, black, and of the cells seen in each sixteen-day period, grey.](Manuscript_files/figure-docx/fig-spread-1.png){#fig-spread}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Spatial pattern of red-stage attack on the annual maps. (a) Moran's I in distance classes of 60 m, one line per year, against the 2.5th to 97.5th percentiles of 999 random relabellings of the attacked cells, grey. (b) The number of pairs of neighbouring attacked cells divided by its expectation under relabelling.](Manuscript_files/figure-docx/fig-clustering-1.png){#fig-clustering}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The effect of flight-period wind on the log-odds of attack, per standard deviation of wind, in stands one standard deviation below and above the mean of live stems, 411 and 1,077 stems per hectare, in the sixteen-day models, with 95 per cent confidence intervals. E1 all hours used wind averaged over the whole day and the other models the hours of 12:00 to 17:00. E2 added the previous period's attack and E3 the previous year's as well. Plume disruption predicts a negative effect at the lower density.](Manuscript_files/figure-docx/fig-interaction-1.png){#fig-interaction}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The coefficients of M3 refitted at four grains, with their 95 per cent confidence intervals, without the dependence terms, open circles, and with them rebuilt at each grain, filled circles.](Manuscript_files/figure-docx/fig-grain-1.png){#fig-grain}
:::
:::



::: {.cell}

:::





::: {.cell}

:::



::: {.cell}

:::



