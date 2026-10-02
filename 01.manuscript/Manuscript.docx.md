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

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins \[Coleoptera: Curculionidae: Scolytinae\]) is an irruptive bark beetle native to the pine forests of western North America, where lodgepole pine (*Pinus contorta* Douglas ex Loudon) represents its main host through most of its range [@safranyik2006chap1; @cooke2026mountain]. Endemic populations persist in weakened and suppressed trees, while outbreaks are observed infrequently in temporary patterns that are followed by sharp population declines [@safranyik2006chap1; @raffa2008cross; @cooke2026mountain]. At least four large outbreaks occurred in western Canada in the 120 years before 2006, and tree rings on the Chilcotin Plateau of central British Columbia showed one about every 40 years [@taylor2006]. In western Colorado, tree rings recorded outbreaks beginning in the 1760s, 1780s, 1820s to 1830s, 1860s, 1910s, 1960s and 1980s, at the same times as outbreaks from British Columbia to Utah [@jarvis2015]. The size of an outbreak varied with short-term changes in weather and long-term changes in the amount of mature pine [@taylor2006]. The most recent outbreak, which affected more lodgepole pine across British Columbia than any other disturbance on record [@taylor2003; @aukema2006landscape; @sambaraju2021; @woo2024], followed a century in which both the amount of mature pine and the area with a climate favourable to the beetle increased [@taylor2006]. As less forest burned, the share of the province's pine at the ages most susceptible to attack rose from about 18 per cent in 1910 to 53 per cent in 1990 [@taylor2003]. After 1976, when the Pacific Decadal Oscillation, a pattern of Pacific Ocean temperatures that shifts every few decades, entered its warm phase, extreme winter cold that kills the brood under the bark became rarer across the province [@maciasfauria2009]. Carried by wind, the outbreak then crossed the northern Rocky Mountains [@giroday2012; @burke2017consequences; @logan2010whitebark; @lundquist2014landscape; @gibson2008mountain]. At its leading edge in north-central Alberta it attacked natural stands of jack pine (*Pinus banksiana* Lamb.) for the first time, a risk that further climate change could increase [@cullingham2011].

In north-central Colorado and southern Wyoming, where the outbreak was mapped from Landsat images from 1996 to 2011, tree mortality rarely reached 100 per cent, even in that major outbreak [@meddens2014]. It is in these places where more trees survive than in surrounding forest that we find disturbance refugia. @krawchuk2020 defined these as locations that are disturbed less severely or less frequently than other areas within the surrounding landscape, while noting that "few studies have explicitly identified refugia from insect outbreaks" (p.235). They also posited that refugia from this beetle may occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" [@krawchuk2020, p. 239]. In lodgepole and whitebark pine forests of southern Oregon, refugia mapped at 30 m from a Landsat moisture index during a severe outbreak in 2009 were "associated with topographically shaded slopes, convergent environments such as valleys, areas of relatively low soil bulk density, and in thinner forest stands" [@cartwright2018, p. 1]. Each mechanism depends on part of the beetle's biology, how it chooses and kills a tree, how temperature determines its survival, and how it spreads and flies.

Studies have documented from landing traps set in lodgepole pine stands, that the first beetles to arrive, the pioneers, are "unable to distinguish between hosts, dead hosts and nonhosts during landing" [@hynum1980]. Surprisingly, the Mountain pine beetle judges a tree only after they land, by tasting compounds in its bark [@safranyik2010]. Where they come down can therefore depend on the airflow as much as on the trees below, which is why this study tested whether ground sheltered from the wind received more attack.

A female that bores into a suitable tree turns α-pinene from its resin into the aggregation pheromone trans-verbenol, which with compounds from the tree draws a mass attack that is usually complete within one to two days [@safranyik2006chap1]. In experimental stands of lodgepole pine, trees contained a few attackers in wounds of dead tissue but died once the bark had more than about 40 beetle tunnels, or galleries, per square metre [@raffa1983]. Resin also stopped a trapped beetle from attracting others, but less so as more beetles attacked at once [@raffa1983]. Following individual lodgepole pine stems across six stands over a period of three to six years, @boone2011efficacy found that tree defences limited attack while beetles were few and made no difference once their numbers in a stand passed a critical threshold. Once an outbreak is under way, whether a tree is killed therefore depends more on how many beetles are nearby than on its defences.

While beetles are few, populations breed mostly in weakened and injured trees [@jarvis2015; @shore2006]. They become outbreaks once they can kill the average large tree in a stand, a change that can follow drought, several generations of favourable weather or the arrival of beetles from elsewhere [@shore2006]. Large trees are the better hosts because their thicker phloem, the inner bark on which the larvae feed, is better food [@safranyik2010]. On average, lodgepole pines larger than 25 cm in diameter produce more beetles than attack them, while smaller pines produce fewer [@carroll2004bionomics]. The amount of pine in a stand and the size of its trees affect whether it escapes attack, and this study measured both.

Cold is the largest single effect of weather on the beetle's numbers [@safranyik2006chap1; @safranyik2010], and @safranyik2010 estimated that winter mortality above about 80 per cent would, on average, stop a population from growing. Late-stage larvae, the usual overwintering stage, survive midwinter temperatures near minus 40 degrees C because they build up glycerol, a natural antifreeze, through the autumn [@carroll2004bionomics]. Cold early in winter, before the glycerol has built up, or late in winter, after it has been used, kills many larvae, while thick bark and deep snow shelter the brood [@carroll2004bionomics]. East of the Rocky Mountains in Canada, the middle 70 per cent of a season's flight lasted 26 days, a synchrony the beetles need to overwhelm trees by attacking together [@bleiker2016flight]. Where summers are too cool for the brood to develop in one year, as at high elevations, it spends two winters under the bark and mortality is severe [@sance is then spread over alonger period, which lowers the success of mass attack [@safranyik2006chap1; @logan2001].

Cold is the largest single effect of weather on the beetle's numbers [@safranyik2006chap1; @safranyik2010], and @safranyik2010 estimated that winter mortality above about 80 per cent would, on average, stop a population from growing. Late-stage larvae, the usual overwintering stage, survive midwinter temperatures near minus 40 degrees C because they build up glycerol, a natural antifreeze, through the autumn [@carroll2004bionomics]. Cold early in winter, before the glycerol has built up, or late in winter, after it has been used, kills many larvae, while thick bark and deep snow shelter the brood [@carroll2004bionomics]. East of the Rocky Mountains in Canada, the middle 70 per cent of a season's flight lasted 26 days, a synchrony the beetles need to overwhelm trees by attacking together [@bleiker2016flight]. Where summers are too cool for the brood to develop in one year, as at high elevations, it spends two winters under the bark and mortality is severe [@safranyik2006chap1]. Emergence is then spread over a longer period, which lowers the success of mass attack [@safranyik2006chap1; @logan2001].

Temperature acts on outbreaks directly, through winter survival, the timing of the life cycle and the synchrony of attack, and indirectly, through drought, which lowers the resistance of trees [@jarvis2015; @bentz2010climate]. In Colorado and southern Wyoming from 1996 to 2010, the outbreak began in several separate places, which suggested drought as a regional trigger, and years with less precipitation than average helped it spread [@chapman2012spatiotemporal]. In Oregon and Washington over three decades, once beetle numbers nearby were accounted for, winter minimum temperature and drought in the current and previous years had the largest effects on whether an outbreak grew large [@preisler2012climate]. In helicopter surveys of the Morice Timber Supply Area of north-central British Columbia from 1995 to 2002, the most intense infestations were typically found early on warmer slopes facing south and west [@nelson2007environmental]. To test the shading mechanism, this study measured the sun each slope received during the flight period and over the growing season, and how far each slope faced north.

When marked beetles were released in a mature lodgepole pine stand, most were caught 3 m above the ground, catches fell sharply with distance, and only 0.2 per cent rose above the canopy [@safranyik1992]. Within a stand, beetles fly downwind under the crowns until they meet the scent of an attacked tree, then turn upwind towards it [@carroll2004bionomics; @safranyik1989]. @robertson2007mountain measured the distance from clusters of trees attacked the year before, whose needles had turned red, to clusters attacked that year, whose needles were still green, as a measure of how far the beetles had moved. They consistently found 30 and 50 m, and as the infestation grew, the clusters merged. In the south of the province, where this study was set, many infestations erupted locally, apart from the main front that spread east from the west-central interior [@aukema2006landscape; @mitton2012mountain; @talucci2019drivers]. In an earlier outbreak on the Chilcotin Plateau, an outbreak in a 12 km cell was best predicted by outbreaks in the neighbouring cells that year or in the same cell in the two years before [@aukema2008]. In Cypress Hills Interprovincial Park, Saskatchewan, surveyed tree by tree from 2006 to 2018, infestations left untreated nearby in the previous year were the most important single predictor of attack in every phase of the outbreak [@kunegel2020factors]. This study considered the same dependence at 30 m, the previous year's attack in each cell and in the cells around it, in every model.

Where terrain was applied to these models, it entered as elevation, slope and aspect, and its effects followed the phase of the outbreak and where the host grew. In the Arapaho and Roosevelt National Forests of Colorado, mapped from Landsat images for 2003 to 2010, @walter2013 found that the best predictors of red attack changed "from forest susceptibility to dispersal to host availability" as the outbreak grew (p. 317). Attack there also moved from high to low elevations between 2003 and 2006 [@walter2013]. In the Lolo National Forest of western Montana, the odds of red attack rose with elevation because lodgepole pine grew higher, along ridge tops, than the Douglas-fir that dominated the area [@wulder2006red]. This study instead measured shelter from the wind and openness to the sky, alongside the sun on each slope.

Evidence for the density mechanism comes from thinning trials, in which thinned lodgepole and ponderosa pine stands across the western United States lost fewer trees to the beetle [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying]. @mitchell1983thinning and @waring1985modifying attributed this to the greater vigour of the surviving trees. In the Uinta Mountains of Utah, @bartos1989 instead proposed microclimate as the primary driver, having measured more light, warmth and wind in a thinned stand than in the unthinned stand beside it. Specifically, the thinned stand had 382 fewer trees per hectare than the unthinned stand, of similar average diameter [@bartos1989]. Throughout the day, wind speeds ranged between 1.6 and 5.6 km/h, and the thinned stand was on average only about 1.6 km/h windier. Between 4 and 6 p.m., when most beetles flew, the wind in the thinned stand was consistently at least 3.2 km/h stronger than in the unthinned stand, twice the average difference over the day [@bartos1989]. In central Oregon, thinned plots at first attracted few beetles, but once attack began, trees near attacked trees were more likely to be attacked in thinned plots than in unthinned ones [@preisler1993colonization]. Wide spacing did not seem to stop attacks moving from tree to tree [@preisler1993colonization]. Across 94 unmanaged lodgepole pine stands in the western United States, @anhold1987potential measured crowding as the stand density index, which combines the number of trees with their size. Crowding was unrelated to whether beetle populations rose or fell, but it changed how many trees they killed [@anhold1987potential]. In stands of more than 80 per cent pine, mortality was low where the index was below 125, much greater just above 125, and declined as the index rose towards 250 and beyond [@anhold1987potential]. The least and the most crowded stands both lost fewer trees than those in between. In crowded stands, trees grow more slowly and have thinner phloem, so they produce fewer beetles [@shore2006]. Adding trees can therefore raise attack in an open stand and lower it in a crowded one. This study measured stand density three ways, as basal area, live stems per hectare and standing volume, and read the effects of wind and sun at lower and higher density.

Wind can lower attack by breaking up the pheromone plume, the trail of scent downwind of an attacked tree, which @krawchuk2020 called "wind disruption of beetle pheromone communication" (p. 239). This would lower attack most in thin stands, where more wind reaches the trunks [@bartos1989]. Wind can also concentrate attack through deposition, meaning beetles settling out of the air where it slows. @giroday2011 noted that "alterations in wind speed may cause increased settlement in areas where wind speed is reduced" (p. 1098). During the beetle's range expansion in the Peace River region of western Canada, they found that infestations established first in canyons and valleys before moving onto more open slopes [@giroday2011]. Because pioneers cannot choose a host until they land, deposition should put more attack on ground sheltered from the wind, whatever the stand. Both effects act only during flight, which peaks in the early to mid afternoon [@safranyik2006chap1] and needs air temperatures of 19 to 41 degrees C [@mccambridge1971]. Beetles do not fly in winds above about 2 metres per second, their top flying speed [@carroll2004bionomics]. A machine-learning model of the outbreak in the Cypress Hills described wind by a mean of daily station wind speed for July and August [@ramazi2021outbreaks]. Studies of flight above the canopy resolved wind over terrain but not within the stand [@jackson2008; @ainslie2010]. This study measured wind over terrain in the afternoon hours of the flight season.

This study tested the three mechanisms together on one landscape, with attack nearby and in the previous year in every model. It grew out of a study of conifer regeneration after the 2015 Mt Midgeley fire on the same ground [@murphy2026]. In that study, terrain ruggedness had the largest coefficient of any variable on seedling density, +0.626 (p \< 0.001), but ruggedness combines several properties of the ground and could not show which one mattered. Red-stage attack, meaning trees whose needles had turned red in the year after they were attacked, was mapped across part of the Selkirk Mountains of southeastern British Columbia with that study's 28 field plots and 30 m grid. It was mapped once a year to test the refugia mechanisms and every sixteen days to test wind. The study asked three questions. The first was whether stand density, shading by terrain and the scarcity of large trees predicted attack once attack nearby was in the model. The second was whether wind during flight lowered attack more in thin stands than in dense ones, as disruption of the pheromone plume predicted. The third was whether ground sheltered from the wind had more attack whatever the stand, as deposition predicted.


::: {.cell}

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


The study area covered 5,573 ha of the Selkirk Mountains in southeastern British Columbia, from 830 to 1,744 m in elevation. It was centred on the site of @murphy2026, the 480 ha burned by the 2015 Mt Midgeley fire, and extended 5 km beyond the burn perimeter within the same band of elevation. The buffer added the range of stand density that the pheromone mechanism needed, and the elevation limit kept the added ground comparable with the burn site. The study area held 61,923 cells of 30 m on the grid of @murphy2026, so that the results compared directly with theirs. Attack was mapped once a year for the questions on refugia and every sixteen days for the wind test, the inventory once a year, the station winds every hour and the terrain once overall (Table S1).

Stand structure came from British Columbia's Vegetation Resources Inventory, using for each study year the snapshot the province published that year, rasterised to the 30 m grid (@tbl-vri). The attributes were basal area, crown closure, live stems per hectare, quadratic mean diameter of stems of 12.5 cm and larger, stand age, stand height, standing volume and susceptible pine basal area, the product of basal area and pine cover. The 2007 snapshot omitted basal area and live stems, so the 2006 snapshot stood in for it. The inventory is a projection rather than a census, and polygons interpreted from photographs taken late in the outbreak described stands that the beetle had already attacked.

Terrain was computed in SAGA GIS from an elevation model that extended beyond the perimeter, so that search radii near the edge fell on measured ground. The terrain variables split the ruggedness index of @murphy2026 into the properties of the ground that the beetle's biology concerns, and ruggedness itself was kept as a candidate so that the split was tested rather than assumed. Exposure was measured by the windward-leeward index, effective air flow height, the wind exposition index, topographic openness, sky view and the wind shelter index, which @plattner2004 based on "the maximum gradient within a given radius in upwind direction" (p. 47). and geomorphon class, which assigns each cell a landform such as ridge, slope or valley. Landform was measured by wetness, valley depth and height above the valley floor, because groups of infested trees are "frequently associated with draws and gullies" [@safranyik2006chap1, p. 41] and deep snow insulates the overwintering brood [@carroll2004bionomics]. Aspect entered as northness, eastness and the heat load index of @mccune2002. Radiation was computed twice, because flight and shading depend on different quantities. The first covered the flight window, 1 July to 15 August from 12:00 to 17:00, and the second the whole growing season, 1 May to 30 September, the period over which shading by terrain can protect trees from water stress [@krawchuk2020]. Across the study area, flight-window radiation varied 15-fold and growing-season radiation 2.9-fold. Temperature differences between slopes at the same elevation were represented by these radiation surfaces and by northness rather than modelled, because @running1987 found that closed forest canopies "may exhibit virtually no slope related differences in surface temperature when the surface is an actively transpiring canopy" (p. 475). Table S3 lists the variables that entered the models with the mechanism each represents.

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


The response for the first and third questions was defined as red-stage attack in each of eight outbreak years, 2006 to 2014, excluding 2012, when Landsat 7 was the only sensor and its scan-line corrector had failed [@wulder2011continuity; @sadiq2016recovering]. The index and its baseline followed the procedures of @murphy2026, who mapped red-stage pine mortality across the burn site from Landsat images. This approach measured attack as the fall in the normalised difference moisture index (NDMI) from its value in 2005, when the outbreak began. NDMI tracks the moisture of the canopy and is used to detect forest disturbance in Landsat time series [@jin2005]. They validated the map against 28 field plots of 20 by 20 m, in which beetle-killed pine was confirmed from pitch tubes, frass and the pattern of the egg galleries.

Along a temporal axis, the time series dataset was resampled against a fixed point, so that every year was processed within the same calendar windows, thereby maintaining fidelity across temporal scales [@salazar2025resampling; @hasan2025comprehensive]. This follows agricultural forecasting research that found significant improvements from applying robust resampling to irregular or dense time series [@desloires2024; @parreiras2025]. Along its geometric plane, each image was reprojected to EPSG:3153 and resampled onto the 30 m grid inherited from @murphy2026 applying the nearest neighbour method. This ensured each new cell maintained an unchanged value of the closest original pixel rather than an average of several [@logan1979error]. Annual median composites were derived from cloud-masked imagery of the Collection 2 Level-2 Landsat 5 and 8 from between 1 June to 31 August 2005 to 2014. Because the two sensors record slightly different wavebands, the Landsat 8 images were converted to the scale of the earlier sensor with the band-pass coefficients of @roy2016, and then matched to the Landsat 5 range over undisturbed forest. Each year was mapped on its own, with lakes and rivers masked, and attack covered from 9.9 to 20.7 per cent of the perimeter by year (Table S2, @fig-spread).

The response for the second question was red-stage attack in each sixteen-day period, the Landsat revisit interval, from 1 May to 22 September of the same years, NDMI being the median of the scenes in each period differenced against the same period of 2005 so that the seasonal course of leaf moisture did not enter the difference. Periods in which the imagery saw less than a tenth of the perimeter were dropped, which left 47 periods over eight years.

The fall in NDMI that counted as attack was set by a classifier trained on the four pixels nearest the centre of each field plot, 112 pixels, against the 84 points of undisturbed forest that @murphy2026 digitised on the 2020 Landsat 8 scene, which fell in 68 distinct cells. Each pixel entered with its deepest annual fall in NDMI against 2005. Random forest, a radial support vector machine and gradient boosting were compared over 100 random splits, each holding out a quarter of the field plots and of the 100 m blocks of undisturbed pixels, so that neighbouring pixels never fell on both sides of a split. The radial support vector machine classified most accurately, with kappa 0.859 ± 0.081 (95 per cent interval 0.682 to 1.000) and overall accuracy 0.934 ± 0.037, the three models differing by less than one standard deviation of the splits (@tbl-classifier). Its prediction changed class at a fall in NDMI of 0.0616 against 2005, and that cut was applied to the annual and the sixteen-day differences. The undisturbed pixels came from one patch of about 230 by 455 m, so the cross-validation measured separation of the plots from that patch rather than from undisturbed forest across the landscape.

Wind was summarised over the afternoon flight hours, 12:00 to 17:00. These hours follow the flight period @safranyik2006chap1 identified for this regionp (p.18). This also overlaps with the emergence peak period of 11:00 to 14:00 that @gray1972 recorded in eastern Washington. Hourly station records were used to check the window against the local climate. Across 236,079 records from May to September, 89.5 per cent of afternoon hours between 1 July and 15 August fell within the 19 to 41 degrees C range in which beetles fly [@mccambridge1971], against 51.4 per cent of afternoon hours in the rest of the season (Figure S1).

Hourly speed and direction from Environment and Climate Change Canada stations within 150 km were combined as vector components and adjusted for terrain with the MicroMet model of @liston2006, which weights each observation by the slope in the wind direction and the curvature of the ground. The adjustment depends on direction and not on speed, so it was computed once for each of 16 sectors of 22.5 degrees over an elevation model extending beyond the perimeter, with a curvature length scale of 600 m. Each period was summarised by its mean flight-hour wind and its share of flight hours below 5 km/h. Mean flight-hour wind ran from 4.0 to 8.6 km/h between periods and varied by up to 5.1 km/h across the grid within a period. The annual models took the same terrain-adjusted wind over the flight hours of 1 July to 15 August of each year, 230 hours from 6 to 9 stations a year, and the mean station wind of June and of July, interpolated to the grid by inverse distance weighting, as the wind that varied between years.

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


Before any model was fitted, the spatial pattern of attack was described on each annual map. Attack was treated as present or absent in each cell of the grid. The join count [@moran1948] counted the pairs of neighbouring cells that were both attacked, taking the eight cells around each cell as its neighbours. Moran's I [@moran1950] was computed in distance classes of 60 m out to 6 km, giving a correlogram [@legendre1989]. Both statistics were compared with 999 random permutations of the attacked cells among the cells mapped that year. The range of positive autocorrelation was the first distance class at which Moran's I no longer exceeded the permuted values at p ≤ 0.05.

The annual models were built in the order @aukema2008 used, in which they first "determined an appropriate spatial neighborhood structure(s) and time lag(s) to account for spatial and temporal dependencies" (p. 351) and only then entered environmental variables. The first dependence term was the cell's own state in the previous outbreak year, which for 2013 was 2011. The second was the share of cells attacked around it in that year, within 42, 90, 150, 210, 510 or 1,050 m and excluding the cell itself, with the radius chosen on AIC (@tbl-dependence). Each year contributed up to 4,000 attacked and 4,000 unattacked cells, because at a landscape prevalence near one cell in ten an unbalanced fit would report its intercept rather than its covariates.

The environmental terms were 14 variables, grouped by the mechanism each represented (Table S3). Four logistic regressions were fitted in sequence, each adding one mechanism to the one before. M0 contained host size, shading and landform; M1 added stand density as basal area; M2 added terrain exposure to wind, terrain shape and direct radiation in the flight window; and M3 added the interactions of basal area with the wind shelter index, July wind and flight-window radiation. Every model included the geomorphon class of the cell, and every continuous term was standardised, so that each coefficient was a change in log-odds per standard deviation. The sequence was fitted first on all eight years without the dependence terms, and then on the seven years with a previous map, without and with them, so that the change in each environmental term once attack nearby and the year before entered could be read directly.

The first and third questions were answered with these annual models. For the third, the main effect of the wind shelter index was compared with its interaction with basal area, in M3 fitted with and without flight-window radiation. Each interaction was read as the slope of one term at one standard deviation either side of the mean of the other. Attack was also tabulated by quadratic mean diameter class, with Wilson intervals, a chi-square test across classes and a two-proportion test across 25 cm, the diameter that @carroll2004bionomics gave as the boundary between beetle sinks and sources.

The second question was tested on the sixteen-day maps, on which wind varied between periods within a season as well as between years. Attack in a period was regressed on 15 stand and terrain variables, mean flight-hour wind, the geomorphon class, and the interactions of wind with live stems and with standing volume, in a model labelled E1. E2 added the cell's own state in the previous period and the share attacked within 90 m around it. E3 added the same two terms for the same period of the previous year, with the radii chosen on AIC as for the annual models. Each period contributed up to 2,000 cells of each class.

Residual spatial autocorrelation was measured for every annual model as Moran's I of the deviance residuals, computed within each year on the eight nearest sampled cells. To account for spatial pattern left after the dependence terms, M3 with those terms was refitted with a Gaussian process smooth of easting and northing [@wood2017], with its Matérn range set to the median range of positive autocorrelation, 2,610 m. To test the grain, M3 was refitted on cells coarsened to 90, 270 and 990 m. A coarse cell counted as attacked if any 30 m cell inside it was, the definition @aukema2008 used on their 12 km cells, and the previous year's state and the share of the eight neighbouring cells were rebuilt at each grain.

# Results {#sec-results}

Attack was clustered in every year, with pairs of neighbouring attacked cells 3.2 to 5.3 times as many pairs of neighbouring attacked cells as random permutations produced and positive autocorrelation to a median of 2,610 m (@fig-clustering). The previous year's attack in the cell and within 150 m, the best of six radii (@tbl-dependence), dominated every model it entered. A cell attacked the year before had 7.6 times the odds of attack, and the two dependence terms raised the area under the receiver operating characteristic curve (AUC) of M3 from from 0.805 to 0.879.

## Refugia mechanisms

Of the three refugia mechanisms, stand density was supported through the amount of host, host size acted as a threshold, and shading was not supported. Each step of the model sequence lowered AIC, most when basal area entered, by 459 (@tbl-models). Basal area entered M3 at +0.290 log-odds per standard deviation (p < 0.001). It remained positive with the dependence terms, +0.183, and under the spatial field, +0.181, as did susceptible pine basal area, whereas stand age could not be distinguished from zero under the field (p = 0.157) (@tbl-final). Attack depended on quadratic mean diameter class [χ²(5) = 715.1, p < 0.001, Cramér's V = 0.106]. It peaked in the 25 to 30 cm class, at 55.8 per cent of the balanced sample against 48.2 per cent at 20 to 25 cm, and fell in the larger classes, whose stands had less pine (@tbl-diameter). Elevation had the largest coefficient in every model, +0.934 in M3 (p < 0.001), with more attack on higher ground. North-facing ground had more attack, +0.112 (p < 0.001). Afternoon sun in the flight window raised attack in stands one standard deviation above the mean basal area, +0.145 (p < 0.001), but not in stands one standard deviation below it, +0.011 (p = 0.547).

## Wind and density

Flight-hour wind did not lower attack in stands with fewer stems. In E1, the interaction of wind with live stems was -0.012 (p = 0.034), so that attack rose with wind at 411 stems per hectare, +0.026 (p = 0.001), but not at 1,077, +0.002 (p = 0.847). Once the previous period's attack entered (E2), the interaction became +0.051 (p < 0.001), and wind raised attack at both densities (@fig-interaction). The interaction of wind with standing volume could not be distinguished from zero in either model (p = 0.642 and p = 0.296).

## Terrain shelter

Leeward ground had slightly more attack, and once the previous year's attack was in the model the effect did not depend on density. The wind shelter index, which was higher on slopes facing the prevailing wind, entered M3 at -0.066 (p < 0.001), and at -0.040 (p = 0.016) with the dependence terms, when its interaction with basal area was -0.021 (p = 0.110). Sky view entered at +0.327 (p < 0.001). Both terrain terms depended on place and grain. Under the spatial field, sky view fell to -0.009 (p = 0.799) and the shelter index changed sign, to +0.082 (p < 0.001). At coarser grain, the shelter index lost significance at 90 m and sky view at 270 m, while basal area remained positive at 270 m, +0.094 (p = 0.037) (@fig-grain). Residual Moran's I remained significant in every year, even with the spatial field, at a median of 0.337.

# Discussion

## Contagion first

Attack in a 30 m cell was predicted first by attack in and around it the year before, and every environmental term in this study was read beside those terms rather than in place of them. This order followed @aukema2008, who found on the Chilcotin Plateau that an outbreak in a 12 km cell was best predicted by outbreaks within 18 km that year and within 6 km in the two years before, and that temperature still "contributed to explaining outbreak probabilities" once those terms were in the model (p. 348). The same pattern appeared here at a far finer scale. The share of cells attacked within 150 m the year before fitted better than any wider neighbourhood, close to the 140 m within which previous attack raised the rate of red attack above its background in Colorado [@walter2013]. That distance matched short-range dispersal, which "takes place under the forest canopy" and is "determined by the relative proximity of brood trees within individual stands" [@safranyik2010, p. 428].

The outbreak was already epidemic in the years mapped, and the dominance of the dependence terms fitted that phase. @walter2013 found that distance to the previous year's infestation "increased in importance relative to other predictors" as an outbreak progressed (p. 315), and @meddens2014 found that late in an outbreak "almost all new mortality was associated with intensification of existing outbreaks, not expansion" (p. 83). Here the dependence terms raised the AUC of M3 from 0.805 to 0.879, whereas the whole environmental sequence from M0 to M3 raised it by 0.006. The refugia mechanisms were therefore tested as modifiers of an outbreak that spread mostly by contagion.

## Host and density

Attack rose with the amount of host, through basal area and susceptible pine basal area, and less firmly with stand age. These are the variables of the stand susceptibility rating used in British Columbia, which is built on "the percentage of susceptible pine by basal area", pine age and stand density, together with climate [@safranyik2010, p. 429; @shore2000susceptibility]. The refugia this landscape showed were therefore stands with little host, in agreement with the thinning trials in which stands reduced in basal area lost fewer trees [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying]. The amount of host is itself a product of forest history. @taylor2003 concluded that within climatically suitable areas "forest age-class structure will be the primary factor influencing host susceptibility and outbreak severity" (p. 42), and by 2000 the area of mature lodgepole pine in British Columbia was more than three times that of a century earlier [@shore2006].

Basal area here measured the amount of pine rather than crowding. Dense unmanaged stands have thinner phloem, and "beetle production and subsequent tree mortality in dense, unmanaged stands tend to be less than in more open stands" [@shore2006, p. 103]. @walter2013 found red attack moving to less dense stands once an outbreak became epidemic, whereas here attack rose with basal area in every model through to 2014.

Attack peaked in stands of 25 to 30 cm quadratic mean diameter, just above the 25 cm diameter at which, on average, lodgepole pines change from beetle sinks to beetle sources [@carroll2004bionomics]. Thicker phloem feeds more brood, and in laboratory trials brood production rose from an average of 16 beetles to 94 as phloem thickened from 2.3 to 5.8 mm [@amman1972]. During epidemics the share of trees killed rises with diameter above about 10 cm [@shore2006], so the fall in attack in stands of larger trees did not reflect the beetle's preference. It reflected composition, since stands of the largest trees here had little pine. Epidemics also "often deplete the large diameter pine component of stands" [@shore2006, p. 110], after which smaller trees are attacked in later years [@meddens2014].

## Elevation and climate

Elevation had the largest coefficient in every model, with more attack on higher ground. That ran against the historical pattern, in which mortality "tends to decline with elevation" because the cool climate of high ground slows development and lowers brood survival [@shore2006, p. 103], and in which cooler summers stretch the life cycle over two years, with severe mortality [@safranyik2006chap1]. Three explanations fit this result, and the design could not separate them, because on this range the higher ground also had the pine. The first was the distribution of the host, since where elevation entered an earlier model of red attack, in western Montana, its sign followed where lodgepole pine grew rather than the beetle's preference [@wulder2006red]. The second was the phase of the outbreak, since in Colorado red attack "moved from high elevations to in 2003 to low elevations in 2005 and 2006" [@walter2013, p. 316]. The third was a milder climate, since the warm phase of the Pacific Decadal Oscillation after 1976 favoured outbreaks "by reducing the occurrence of extremely low winter temperatures province-wide" [@maciasfauria2009, p. 1], and climates that had once limited epidemics became more favourable [@taylor2003].

## Aspect and sun

North-facing ground had more attack in every model. This was the reverse of the shading mechanism of @krawchuk2020 and of the association of red attack with southern aspects in Colorado [@walter2013], and elsewhere attack reached south-facing and drier ground first [@kaiser2012ecohydrology; @nelson2007environmental]. Aspect here more likely measured where lodgepole pine grew on this range than any effect of temperature. Afternoon sun in the flight window raised attack only in dense stands, which fitted the biology of flight better than that of host stress. Within the range of temperatures for flight, "flight propensity increases with increasing light intensity" [@safranyik2006chap1, p. 15]. In the thinned stands of @bartos1989, which let more light reach the ground, pheromone traps caught only 5 per cent of the beetles trapped in the two stands, which the authors explained by beetles sensing "the difference in light intensity or the greater air turbulence in thinned stands" and avoiding them (p. 9). Sun on a dense stand may therefore have helped flight without opening the canopy that keeps the pheromone plume within the stand [@bartos1989].

## Wind and density

Flight-hour wind did not lower attack in stands with fewer stems. The interaction of stems with wind was small, and where it could be read it meant more attack in windier periods among stands with fewer stems, the reverse of plume disruption. Once attack in the previous period entered, wind raised attack at every density.

The plume mechanism rests on measurements inside the canopy. In Utah, @bartos1989 found a thinned stand windier than the unthinned stand beside it by about 1.6 km/h on average and by 3.2 km/h or more in the late afternoon, and argued that in a thinned stand the pheromone "rises through the canopy on convection currents and is dispersed above the canopy" (p. 9). A tracer gas released in place of pheromone was likewise diluted fastest in the most open of three canopies [@thistle2004surrogate]. A stand one standard deviation below the mean here had 411 stems per hectare, which was not the open canopy those trials created, and neither the inventory nor a terrain model of station wind could resolve a contrast at that scale. Under epidemic pressure the benefit of spacing may also be lost, since in ponderosa pine the influence of pheromones from attacked trees in adjacent unmanaged stands "may override the positive benefits of increased spacing and improved tree growth derived from partial cutting" [@schmid2005, p. 9].

Wind above the canopy carries beetles into new stands [@jackson2008; @chen2017; @safranyik2010], and within a stand @safranyik1989 found that "wind speed had negligible effect on the fit of the model for relative directional distribution of beetles". Both predict more attack with wind rather than less, the direction the models with dependence terms showed. Red crowns seen in a period also recorded the flight of the previous summer, because the foliage of an attacked tree stays green "usually until May and June of the year following attack" [@safranyik2006chap1, p. 11].

## Terrain and scale

Leeward ground had more attack than windward ground at the same elevation and stand structure, and once the previous year's attack entered, the effect did not depend on density. This was the pattern deposition predicts, since changes in wind speed "may cause increased settlement in areas where wind speed is reduced" [@giroday2011, p. 1098], and in simulations of beetles flying through forest, dispersal downwind shortened as trunks became denser [@byers2000]. The effect was small, however, and it disappeared at 90 m and changed sign under the spatial field, as did the effect of open ground. Both terrain terms therefore described where attack clustered on this range as much as a property of the slope.

The environmental results also depended on the scale at which they were read, the concern @aukema2008 raised in choosing 12 km cells. The spatial field removed the terrain terms, while basal area, susceptible pine basal area, northness and flight-window radiation remained. Residual autocorrelation persisted in every year, so the p-values in every model were optimistic. Basal area remained positive to 270 m, while at about 1 km nearly every cell contained an attacked cell. Mortality occurs more rapidly in small areas than across large ones [@meddens2014], and the controls on red attack change through an outbreak "from forest susceptibility to dispersal to host availability" [@walter2013, p. 317]. A refugium defined at 30 m and one defined at 1 km were therefore different things, and this study supported the first mainly through the amount of host.

## Limits and management

The response was classified rather than observed. The classifier separated the field plots from one patch of undisturbed forest, so its accuracy measured that separation and not agreement with ground mortality across the landscape. Landsat classifications of red stage have been tested elsewhere against fine-resolution reference imagery [@meddens2013], and high spatial resolution imagery has been assessed for detecting red attack directly [@coops2006], either of which would give an independent test of these maps. The inventory postdated part of the outbreak, so polygons interpreted after the beetle passed described the stand it left. Temperature entered the models only through elevation, radiation and aspect, so the beetle's development and overwinter survival were not measured directly. The study covered one mountain range over eight outbreak years.

For management, the refugia this landscape showed were stands with little host, the structure that thinning and a younger age structure produce, and terrain maps alone could not locate them. Under the stand susceptibility rating used in British Columbia, partial cutting substantially lowers the susceptibility of lodgepole pine stands [@mata2003; @shore2000susceptibility], and regularly spaced mature stands, at least 4 by 4 m apart, may lose fewer trees [@shore2006]. The dominance of attack nearby agreed with the limits found in the field. In ponderosa pine, partial cutting "may be ineffective for partially cut parcels of \<10 acres if the partially cut stands are surrounded by unmanaged susceptible stands", and stands "should be managed on a landscape basis" [@schmid2005]. @six2014management found the field evidence that thinning protects stands during an outbreak weaker than policy had assumed. This study found no evidence that flight-period wind strengthens that protection.

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



