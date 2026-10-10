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
3.  Attack was clustered in every year, with positive spatial autocorrelation to a median of 2,640 m, and attack in and around a cell the year before dominated every model.
4.  Beside those terms attack rose with stand basal area (+0.167 log-odds per standard deviation, p < 0.001) and peaked in stands of 25 to 30 cm mean diameter, and north-facing ground had more attack rather than less. Flight-hour wind did not lower attack where stems were fewer, and the effects of terrain shelter and openness did not survive a latent spatial field.
5.  Refugia on this landscape were stands with little host, and terrain and wind added small, scale-dependent modifiers to an outbreak whose spread was mostly contagion.

# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins \[Coleoptera: Curculionidae: Scolytinae\]) is an irruptive bark beetle native to the pine forests of western North America, where lodgepole pine (*Pinus contorta* Douglas ex Loudon) represents its main host through most of its range [@safranyik2006chap1; @cooke2026mountain]. Endemic populations persist in weakened and suppressed trees, while outbreaks are observed infrequently in temporary patterns that are followed by sharp population declines [@safranyik2006chap1; @raffa2008cross; @cooke2026mountain]. At least four large outbreaks occurred in western Canada in the 120 years before 2006, and tree rings on the Chilcotin Plateau of central British Columbia showed one about every 40 years [@taylor2006]. In western Colorado, tree rings recorded outbreaks beginning in the 1760s, 1780s, 1820s to 1830s, 1860s, 1910s, 1960s and 1980s, at the same times as outbreaks from British Columbia to Utah [@jarvis2015]. The size of an outbreak varied with short-term changes in weather and long-term changes in the amount of mature pine [@taylor2006]. The most recent outbreak, which affected more lodgepole pine across British Columbia than any other disturbance on record [@taylor2003; @aukema2006landscape; @sambaraju2021; @woo2024], followed a century in which both the amount of mature pine and the area with a climate favourable to the beetle increased [@taylor2006]. As less forest burned, the share of the province's pine at the ages most susceptible to attack rose from about 18 per cent in 1910 to 53 per cent in 1990 [@taylor2003]. After 1976, when the Pacific Decadal Oscillation, a pattern of Pacific Ocean temperatures that shifts every few decades, entered its warm phase, extreme winter cold that kills the brood under the bark became rarer across the province [@maciasfauria2009]. Carried by wind, the outbreak then crossed the northern Rocky Mountains [@giroday2012; @burke2017consequences; @logan2010whitebark; @lundquist2014landscape; @gibson2008mountain]. At its leading edge in north-central Alberta it attacked natural stands of jack pine (*Pinus banksiana* Lamb.) for the first time, a risk that further climate change could increase [@cullingham2011].

In north-central Colorado and southern Wyoming, where the outbreak was mapped from Landsat images from 1996 to 2011, tree mortality rarely reached 100 per cent, even in that major outbreak [@meddens2014]. It is in these places where more trees survive than in surrounding forest that we find disturbance refugia. @krawchuk2020 defined these as locations that are disturbed less severely or less frequently than other areas within the surrounding landscape, while noting that "few studies have explicitly identified refugia from insect outbreaks" (p.235). They also posited that refugia from this beetle may occur "in areas with cooler temperatures (eg from topographic shading) that protect trees from water stress; in areas with lower host density, allowing for greater wind disruption of beetle pheromone communication and more vigorous tree growth and chemical defenses; and in areas with fewer large-diameter host trees" [@krawchuk2020, p. 239]. In lodgepole and whitebark pine forests of southern Oregon, refugia mapped at 30 m from a Landsat moisture index during a severe outbreak in 2009 were "associated with topographically shaded slopes, convergent environments such as valleys, areas of relatively low soil bulk density, and in thinner forest stands" [@cartwright2018, p. 1]. Each mechanism depends on part of the beetle's biology, how it chooses and kills a tree, how temperature determines its survival, and how it spreads and flies.

Studies have documented from landing traps set in lodgepole pine stands, that the first beetles to arrive, the pioneers, are "unable to distinguish between hosts, dead hosts and nonhosts during landing" [@hynum1980]. Surprisingly, the Mountain pine beetle judges a tree only after they land, by tasting compounds in its bark [@safranyik2010]. Where they come down can therefore depend on the airflow as much as on the trees below, which is why this study tested whether ground sheltered from the wind received more attack.

A female that bores into a suitable tree turns α-pinene from its resin into the aggregation pheromone trans-verbenol, which with compounds from the tree draws a mass attack that is usually complete within one to two days [@safranyik2006chap1]. In experimental stands of lodgepole pine, trees contained a few attackers in wounds of dead tissue but died once the bark had more than about 40 beetle tunnels, or galleries, per square metre [@raffa1983]. Resin also stopped a trapped beetle from attracting others, but less so as more beetles attacked at once [@raffa1983]. Following individual lodgepole pine stems across six stands over a period of three to six years, @boone2011efficacy found that tree defences limited attack while beetles were few and made no difference once their numbers in a stand passed a critical threshold. Once an outbreak is under way, whether a tree is killed therefore depends more on how many beetles are nearby than on its defences.

While beetles are few, populations breed mostly in weakened and injured trees [@jarvis2015; @shore2006]. They become outbreaks once they can kill the average large tree in a stand, a change that can follow drought, several generations of favourable weather or the arrival of beetles from elsewhere [@shore2006]. Large trees are the better hosts because their thicker phloem, the inner bark on which the larvae feed, is better food [@safranyik2010]. On average, lodgepole pines larger than 25 cm in diameter produce more beetles than attack them, while smaller pines produce fewer [@carroll2004bionomics]. The amount of pine in a stand and the size of its trees affect whether it escapes attack, and this study measured both.

Cold is the largest single effect of weather on the beetle's numbers [@safranyik2006chap1; @safranyik2010], and @safranyik2010 estimated that winter mortality above about 80 per cent would, on average, stop a population from growing. Late-stage larvae, the usual overwintering stage, survive midwinter temperatures near minus 40 degrees C because they build up glycerol, a natural antifreeze, through the autumn [@carroll2004bionomics]. Cold early in winter, before the glycerol has built up, or late in winter, after it has been used, kills many larvae, while thick bark and deep snow shelter the brood [@carroll2004bionomics]. East of the Rocky Mountains in Canada, the middle 70 per cent of a season's flight lasted 26 days, a synchrony the beetles need to overwhelm trees by attacking together [@bleiker2016flight]. Where summers are too cool for the brood to develop in one year, as at high elevations, it spends two winters under the bark, mortality is severe and emergence is then spread over a longer period, which lowers the success of mass attack [@safranyik2006chap1; @logan2001].

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



::: {.cell}

:::



::: {.cell}

:::


The study area covered 5,573 ha of the Selkirk Mountains in southeastern British Columbia, from 830 to 1,744 m in elevation. It was centred on the site of @murphy2026, the 480 ha burned by the 2015 Mt Midgeley fire, and extended 5 km beyond the burn perimeter within the same band of elevation. The buffer added the range of stand density that the pheromone mechanism needed, and the elevation limit kept the added ground comparable with the burn site. The study area held 61,923 cells of 30 m on the grid of @murphy2026, so that the results compared directly with theirs. Attack was mapped once a year for the questions on refugia and every sixteen days for the wind test, the inventory once a year, the station winds every hour and the terrain once overall (Table S1).

The site lay on the eastern face of the Selkirk Mountains, between the Selkirk crest and the floor of the Creston valley, where the Kootenay River enters the south arm of Kootenay Lake (@fig-regional). Along the latitude of its centre the ground fell from 2,072 m at the crest of the study area to 531 m on the valley floor within 7.6 km, and the floor ran level for 6.3 km before the Purcell front rose on the far side (@fig-profile). The 1 m lidar elevation model covered the whole study area and the valley from the border to the north end of the lake, and the seven hourly wind stations that reported through 2005 to 2014 lay in the valleys at 17 to 147 km from the site.

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



::: {.cell}

:::


The response for the first and third questions was defined as red-stage attack in each outbreak year from 2006 to 2014, the year 2012 mapped from Landsat 7 alone, whose scan-line corrector had failed [@wulder2011continuity; @sadiq2016recovering], by the steps given under Fused series. The index and its baseline followed the procedures of @murphy2026, who mapped red-stage pine mortality across the burn site from Landsat images. This approach measured attack as the fall in the normalised difference moisture index (NDMI) from its value in 2005, when the outbreak began. NDMI tracks the moisture of the canopy and is used to detect forest disturbance in Landsat time series [@jin2005]. They validated the map against 28 field plots of 20 by 20 m, in which beetle-killed pine was confirmed from pitch tubes, frass and the pattern of the egg galleries.

Along a temporal axis, the time series dataset was resampled against a fixed point, so that every year was processed within the same calendar windows, thereby maintaining fidelity across temporal scales [@salazar2025resampling; @hasan2025comprehensive]. This follows agricultural forecasting research that found significant improvements from applying robust resampling to irregular or dense time series [@desloires2024; @parreiras2025]. Along its geometric plane, each image was reprojected to EPSG:3153 and resampled onto the 30 m grid inherited from @murphy2026 applying the nearest neighbour method. This ensured each new cell maintained an unchanged value of the closest original pixel rather than an average of several [@logan1979error]. Annual median composites were derived from cloud-masked imagery of the Collection 2 Level-2 Landsat 5 and 8 from between 1 June to 31 August 2005 to 2014. Because the two sensors record slightly different wavebands, the Landsat 8 images were converted to the scale of the earlier sensor with the band-pass coefficients of @roy2016, and then matched to the Landsat 5 range over undisturbed forest. Each year was mapped on its own, with lakes and rivers masked, and attack covered from 9.9 to 20.7 per cent of the perimeter by year (Table S2, @fig-spread).

The annual map of 2012, the one year without a Landsat 5 or Landsat 8 summer, was drawn from Landsat 7 alone. Its scan-line corrector failed in May 2003, after which each scene lacks data in wedge-shaped strips covering about a fifth of the image while the pixels it records are measured as before [@wulder2011continuity], and because the strips fall in different places from one pass to the next the median of the summer's clear scenes covers most cells. The moisture index was built for 2012 as for the other years, the median of the June to August scenes, and put on the Landsat 5 scale by a line fitted on stable forest, the cells attacked on none of the annual maps, in 2010, when both satellites flew; the map then followed the classifier's cut against 2005. The same steps applied to 2011, a year with a Landsat 5 map, were the check, and the strips were tested by counting the clear scenes behind each cell and scoring the 2011 check separately on cells seen by two scenes or fewer and by three or more. The 2012 map entered the annual models with the other eight.

Sixteen-day maps for every period of 2006 to 2014, 2012 among them, were also drawn from a fusion of Landsat with MODIS adapted from the HIghly Scalable Temporal Adaptive Reflectance Fusion Model, HISTARFM, of @morenomartinez2020. That model combined Landsat and MODIS reflectance into monthly gap-free 30 m images through a pixel-wise regression of Landsat on MODIS, a prior from a ten-year Landsat climatology and a bias-aware Kalman filter. The version built here kept the pixel-wise regression and the Kalman filter and changed four things. It fused the moisture index itself rather than each reflectance band, at sixteen-day rather than monthly steps, so that the result matched the periods of the Landsat maps; it replaced the ten-year climatology, which the Landsat record of this study could not supply before 2014, with a local linear trend and an annual harmonic in the filter's state; it added a backward pass, so that each estimate used the observations after it as well as before; and it carried each estimate's standard error into the maps. For every 30 m cell the Landsat index was regressed on the index of the 500 m MODIS cell that contained it, from the eight-day composites of Terra and Aqua, over the 253 sixteen-day steps of 2004 to 2014, so that each MODIS observation gave a Landsat-scale value with the residual variance of that cell as its error. The process variance and the Landsat error were chosen over a grid of 25 pairs on 8,000 cells drawn once by holding out 15 per cent of the Landsat observations, the share @morenomartinez2020 removed to validate their model, and the held-out values were predicted with a root mean square error of 0.098 and a correlation of 0.83. The attack threshold for the fused series was chosen as the fall from the same step of 2005 that best reproduced the Landsat period maps outside two test years, and a cell was marked uncertain where its fall lay within 1.645 standard errors of that threshold. The test of a missing year hid every Landsat observation of 2008 and then of 2011, refitted the series and scored the maps of the hidden year against its Landsat maps. The fused sixteen-day maps did not enter the models, because they reproduced a hidden year less well than Landsat 7 reproduced 2011 (see Fused series).

The response for the second question was red-stage attack in each sixteen-day period, the Landsat revisit interval, from 1 May to 22 September of the same years, NDMI being the median of the scenes in each period differenced against the same period of 2005 so that the seasonal course of leaf moisture did not enter the difference. Periods in which the imagery saw less than a tenth of the perimeter were dropped, which left 47 periods over eight years (Table S5).

The fall in NDMI that counted as attack was set by a classifier trained on the four pixels nearest the centre of each field plot, 112 pixels, against the 84 points of undisturbed forest that @murphy2026 digitised on the 2020 Landsat 8 scene, which fell in 68 distinct cells. Each pixel entered with its deepest annual fall in NDMI against 2005. Random forest, a radial support vector machine and gradient boosting were compared over 100 random splits, each holding out a quarter of the field plots and of the 100 m blocks of undisturbed pixels, so that neighbouring pixels never fell on both sides of a split. The radial support vector machine classified most accurately, with kappa 0.859 ± 0.081 (95 per cent interval 0.682 to 1.000) and overall accuracy 0.934 ± 0.037, the three models differing by less than one standard deviation of the splits (@tbl-classifier). Its prediction changed class at a fall in NDMI of 0.0616 against 2005, and that cut was applied to the annual and the sixteen-day differences. The undisturbed pixels came from one patch of about 230 by 455 m, so the cross-validation measured separation of the plots from that patch rather than from undisturbed forest across the landscape.

Wind was summarised over the afternoon flight hours, 12:00 to 17:00. These hours follow the flight period @safranyik2006chap1 identified for this regionp (p.18). This also overlaps with the emergence peak period of 11:00 to 14:00 that @gray1972 recorded in eastern Washington. Hourly station records were used to check the window against the local climate. Across 236,079 records from May to September, 89.5 per cent of afternoon hours between 1 July and 15 August fell within the 19 to 41 degrees C range in which beetles fly [@mccambridge1971], against 51.4 per cent of afternoon hours in the rest of the season (Figure S1).

Hourly speed and direction from Environment and Climate Change Canada stations within 150 km were combined as vector components and adjusted for terrain with the MicroMet model of @liston2006, which weights each observation by the slope in the wind direction and the curvature of the ground. The adjustment depends on direction and not on speed, so it was computed once for each of 16 sectors of 22.5 degrees over an elevation model extending beyond the perimeter, with a curvature length scale of 600 m. Each period was summarised by its mean flight-hour wind and its share of flight hours below 5 km/h. Mean flight-hour wind ran from 4.0 to 8.6 km/h between periods and varied by up to 5.1 km/h across the grid within a period. The annual models took the same terrain-adjusted wind over the flight hours of 1 July to 15 August of each year, 230 hours from 6 to 9 stations a year, and the mean station wind of June and of July, interpolated to the grid by inverse distance weighting, as the wind that varied between years.

@fig-spread *near here*


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::




::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

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

Wind over the terrain was modelled rather than averaged from the valley stations, because each station recorded the axis of its own valley and no cell had a direction of its own. The driver was the ERA5-Land reanalysis [@munozsabater2021], the land surface member of ERA5 [@hersbach2020], read at its 0.1 degree cells over a 60 by 80 km box centred on the site, 99 cells in all, for every flight hour, 12:00 to 16:59 local time, of June to August from 2005 to 2014: the two wind components at 10 m, air temperature at 2 m, surface pressure and the hour's downward shortwave radiation. Cloud cover, which the reanalysis does not report at this level, was taken as the shortfall of each hour's radiation below the clearest hour of that cell, hour and month across the ten summers.

The terrain wind model was WindNinja 4.0.0, a mass-conserving diagnostic model built for fire management [@forthofer2014], which takes the reanalysis cells as points, interpolates them, and resolves the flow over the elevation model with its thermally driven slope and valley winds switched on, so that afternoon heating pulls air upslope and up-valley. It was run on four domains: the 30 m context model at a 90 m mesh for every flight hour, 5,520 fields; the 60 by 80 km regional box at 500 m for every flight hour; the whole Purcell Trench from Pend Oreille to the north end of Kootenay Lake and west to the Columbia, 48.0 to 50.3 N and 117.9 to 116.1 W, at 1 km for every flight hour, with its own reanalysis cells; and the 30 m context model at its own resolution and the 1 m lidar model at 10 m once per sixteen-day period and per annual flight window, at the period's mean condition at 14:00 on its middle day. The 10 m window, 9 by 15 km, was run as nine tiles, each with a 500 m margin on every inner side, and the cores of the tiles were joined (@fig-wind-micro). From the hourly fields each cell received, for each period and each annual window, its mean speed, its prevailing direction and the consistency of that direction, and the share of hours in which the air moved upslope. Downscaling of this kind improves near-surface wind under strong wind and gives mixed results during upslope and downslope flow [@wagenbrenner2016], which is the regime of the flight window, and the model carries no vertical velocity.

Lift was described separately, as the convective velocity scale of @deardorff1970, the characteristic speed of rising air in an unstable boundary layer, computed for each reanalysis cell and flight hour from the hourly surface sensible heat flux of ERA5-Land and the depth of the mixed layer, taken as the hourly boundary layer height that ERA5 diagnoses at 0.25 degrees [@hersbach2020], averaged into the same periods and windows, brought to the 30 m grid and scaled by the cube root of each slope's share of the flight-window sun, because the heat that drives the lift is the sun the slope receives. The source of the air over the site was traced with back-trajectories from HYSPLIT [@stein2015] on the North American Regional Reanalysis [@mesinger2006], 32 km and 3-hourly, run twelve hours back from 100 m and 500 m above the centre of the site at 14:00 on every flight day of 2005 to 2013, the summers whose flight made the red crowns mapped from 2006 to 2014 (@fig-trajectories). The share of the hourly endpoints from 100 m that lay over red attack in the provincial aerial overview survey of the same summer, whose red crowns held the brood that flew that summer, entered the models for the previous summer as a source term; the record south of the border was the Insect and Disease Survey of the US Forest Service, Region 1, for northern Idaho and Montana, and the reanalysis cells are far coarser than the valleys, so the trajectories give a corridor of ground rather than a point of origin. The broad rising and sinking of the air was read from the reanalysis vertical velocity between 850 and 650 hPa, the layer from the site to above the afternoon mixed layer, at 14:00 and 17:00 over the 32 km cells within 160 km of the site, converted from pressure to height units with the air temperature of each level (@fig-vertical); its value over the site in the same window of the previous summer entered the models as a term of its own, and at 32 km it describes the ascent of the air mass over the valley and not single thermals. Two depths were checked against the radiosonde at Spokane, station 72786, about 190 km south-south-west of the site and the nearest sounding station, at 17:00 on 917 summer days of 2005 to 2014, taking the depth of each sounding as the height at which the virtual potential temperature first exceeded its surface value by 0.5 K [@holzworth1964]. At the reanalysis cell over Spokane at 16:00, against a sounding mean of 2245 m, a depth grown from the morning's heat flux against a lapse rate of 5 K per kilometre averaged 1276 m, a bias of -969 m, a mean absolute error of 1060 m and a correlation of 0.43, whereas the ERA5 boundary layer height averaged 2172 m, a bias of -73 m, a mean absolute error of 344 m and a correlation of 0.78, so the ERA5 height was kept as the depth of the mixed layer (@fig-lift).

The air pushed up the ground by the terrain wind was described as a slope updraft, the vertical speed of the wind's mean vector over each 90 m cell multiplied by the slope of the ground in the direction it blew, positive where it blew uphill and negative where it blew down; because the slope of a cell does not change, the mean of the hourly updrafts equals the updraft of the mean wind, the mesh-corrected mean speed times its consistency in the prevailing direction. Over the flight windows of 2005 to 2014 the slope updraft across the study area averaged 0.31 m/s, with 90 per cent of cells between -0.28 and 1.44 m/s and a share of 0.71 of cells in rising air, and within a summer it correlated with the flight-window sun at a mean r of 0.43, with the convective lift at 0.49 and with topographic position at 0.11. It entered the models for the previous summer, alone and with the summer held and its interaction with topographic position, because air pushed up a slope leaves the ground at the ridge or spur above it.

## Sun and heat

The sun on each slope was computed a second time with r.sun in GRASS GIS 8.5 [@suri2004], so that each hour carried its own cloud. The clear-sky beam and diffuse irradiance of every 30 m cell of the context elevation model, with its slope, its facing and the shadow cast by the surrounding terrain, was computed at the middle of each flight hour from 12:30 to 16:30 on every day of June to August, at the r.sun default turbidity of 3.0 and ground albedo of 0.2, and again for flat ground at the same place. Each hour was then multiplied by that summer's clear-sky index, the ERA5-Land radiation of that hour over the cells of the context box as a share of the clearest value of the same hour and month in the ten summers, and summed into each sixteen-day period and each annual flight window. Over the flight windows of 2005 to 2014 the sky let through 0.83 of the clear-sky sun on average, and a cell received from 32 to 197 kWh/m² in the flight hours, 133 on average, and a slope received from 0.21 to 1.22 times the sun of flat ground at the same place. Across the cells of the study area the clear-sky totals correlated with the SAGA flight-window radiation at r = 0.97, and each summer's totals with the Landsat surface temperature of the same summer at a mean r of 0.14.

Air temperature on each slope in the flight hours was then modelled with microclima [@maclean2019microclima], an R package that adds to a coarse reference temperature the warming or cooling that a cell's net radiation and wind produce, and which has been used to give hourly temperatures on 30 m terrain to moth assemblages on forested mountain gradients in Malaysia and Taiwan [@liu2025warmer], to rodent trapping sites in mountain forest in Austria [@sachser2021differential] and to lizards along an elevation gradient in Slovenia [@dajcman2025microclimate]. The model was assembled from the package's own functions in the order of its mesoclimate example. The ERA5-Land air temperature of each flight hour was moved to the elevation of each 30 m cell at the lapse rate the package derived from that hour's temperature, humidity and pressure. Net shortwave radiation was the hour's direct and diffuse sun, split by the package from the ERA5-Land radiation, falling on the cell's slope and facing with the shadow of the surrounding terrain, net longwave radiation was the exchange with the part of the sky the terrain left open, and the wind was the ERA5-Land wind brought to 2 m and multiplied by the terrain's shelter coefficient for the direction from which it blew. In a valley of the Amazon lowland forest @pohl2024downscaling concluded that "Recalibration of the microclima model parameters is required" (Discussion) outside the area where it was developed, so the coefficients that turn net radiation and wind into a temperature departure were fitted to the Landsat land surface temperature of the 59 summer scenes of 2005 to 2014 that were at least half clear over the study area, at 3000 cells drawn once, against the reanalysis of the overpass hour moved to each cell's elevation, with each summer held out in turn and predicted from the coefficients fitted to the others. Landsat measures the temperature of the surface at the late-morning overpass, which under a closed canopy is that of the crowns, so the departures are those of the surface. The fitted coefficient of net radiation was 4.96 °C per MJ/m² per hour. In the held-out summers the predicted departure correlated with the measured departure across the cells of each scene at a mean r of 0.53, and north-facing ground departed by -0.27 °C against 2.92 °C on south-facing ground in the prediction and by -0.58 against 3.33 °C in the measurement. At the 29 provincial stations with an hourly temperature record, from 422 to 2423 m, the Darkwoods fire weather station among them, over 104029 flight hours, the reanalysis moved to each station's elevation gave a root mean square error of 3.0 °C and microclima 3.7 °C, lower at 3 stations. Over the flight windows of 2005 to 2014 the modelled afternoon air temperature across the study area ran from 15.9 to 26.1 °C, 21.3 °C on average, and the terrain moved a cell from -5.2 to 2.3 °C off the reanalysis at its elevation, -1.4 °C on north-facing ground and 0.6 °C on south-facing ground. Cold-air drainage, which the package also models, was left out because it forms at night and the flight hours were in the afternoon, and the departures, calibrated to the late-morning surface, were applied to the afternoon flight hours.

## Flight and dispersal

The scales at which the beetle moves set what each wind term can be asked. Within a stand, most beetles fly low and settle near where they emerged; in a mature lodgepole pine stand, most of the marked beetles were caught 3 m above the ground, catches fell sharply with distance, and only 0.2 per cent rose above the canopy [@safranyik1992]. The few that rise are the ones that travel. Beetles reach the air above the canopy on "convective upward drafts and are transported long distances above the forest canopy by wind" [@chen2011mountain, p. 2], which is the account of @safranyik2006chap1 and @robertson2009, and the field evidence for it is beetles found on snowfields above the timberline [@furniss1972]. Weather radar over central British Columbia showed significant numbers "at altitudes up to more than 800 m above the forest canopy", and the winds at those heights gave an estimated movement of 30 to 110 km in a day [@jackson2008], with back trajectories averaging about 20 km [@ainslie2010]. On the provincial surveys, jumps to uninfested ground had median distances of 5.1 to 16.3 km by year and a maximum of 391.9 km, against 3.6 to 4.8 km into infested ground [@chen2011mountain]. A beetle in the stream therefore lands within about a day's flight of where it rose, and a longer journey is several days of flights with landings between.

Where a beetle settles within a stand is governed at a much shorter range. A surrogate pheromone fell to about a tenth of its concentration within 10 m of its source and to a few per cent within 30 m [@thistle2004surrogate, as read by @brush2024spread], and within a stand wind speed "had negligible effect on the fit of the model for relative directional distribution of beetles" around attacked trees [@safranyik1989]. The pheromone decides the tree, not the slope. Where the air sets beetles down on the terrain was not measured for this species. Windblown insects are deposited on the lee side of summits and crests [@spalding1979; @antor1994; @eaton2014] and gather in the sheltered air behind windbreaks [@lewis1965; @lewis1970], while the one landscape study of this beetle found more attack on windward slopes and argued that the beetles are too heavy for lee eddies [@giroday2011].

## Scales of prediction

Those distances fix three scales, and the model carries a term for each. At hundreds of metres to kilometres, the terrain wind, the lift and the trajectories describe which slopes the above-canopy stream delivered beetles to and from which ground. At the 30 m cell, the inventory describes whether the stand holds host. At 10 to 30 m, below the cell, the pheromone decides the tree, and that effect enters the models only as the attack in and around the cell in the previous period and the previous year, the neighbourhood terms, which were strongest within 90 m. The wind terms were therefore read as predictors of where beetles arrived and not of where they settled, and no term was asked a question beyond the scale at which it was measured.

## Wind validation

The confidence of the modelled wind was documented three ways. First, the rhythm of the valley wind was read from the Creston station, the one hourly station in the Creston valley, over May to September 2005 to 2014: the direction of each hour of the day, each flight day's afternoon wind, the days on which the wind blew up the valley from the south for at least three of the five flight hours, the days on which a westerly above 15 km/h overrode it, and the hour at which the afternoon wind fell below 5 km/h. Over June to August, 34 per cent of flight days were up-valley days, the longest unbroken run was 8 days, a westerly overrode the valley wind on 2 per cent of days, and the afternoon wind died at a median of 18:00. Second, the modelled wind was compared with the stations hour by hour over every flight hour in the domains that held them, the trench run at Creston, Nelson, Castlegar and Warfield and the regional box at Creston, as the speed bias and root mean square error, the mean absolute error of direction on hours above 5 km/h, and the share of those hours in the station's eight-point sector; at Creston on the trench run the speed error was 7.5 km/h, the direction error 58.7 degrees and the sector agreement 0.20. Third, every period field carried the consistency of its own direction, the length of the mean wind vector over the mean speed, so that each cell reported how steady the direction had been. Fourth, the reanalysis wind at the cell over each station was scored against the same observed hours, so that a shortfall at a station could be placed in the driver or in the downscaling; at Creston the station recorded a mean of 9.1 km/h over the flight hours, the reanalysis cell 5.8 km/h and the model 3.2 km/h, with direction errors of 61 and 59 degrees. Fifth, two tests were run on the summer of 2010 at 1 km. Replacing the forest roughness with grass over the whole domain moved the modelled mean at Creston from 3.1 to 3.4 km/h against 8.8 observed, and the direction error from 59 to 59 degrees. Adding the hourly records of the other stations with data to the reanalysis cells as points, and scoring the station held out, left its scores unchanged; at Creston the direction error was 59 degrees against 59 without them, the sector agreement 0.23 against 0.23 and the speed bias -5.7 against -5.6 km/h.

The valley wind was then measured where it blew. The provincial networks of the BC Wildfire Service, the Ministry of Transportation and Infrastructure and the air quality programme, held by the Pacific Climate Impacts Consortium, recorded hourly wind direction at 28 stations inside the trench over the summers of 2005 to 2014, from 422 to 2423 m. The clock of each network was taken as the lag at which its stations' hourly temperature in July 2010 best matched the nearest Environment and Climate Change Canada station, which reports in standard time. At Akokli Creek, at 821 m on the east shore of the south arm and the station nearest the site, the wind of the flight hours blew from 239 degrees and the night wind from 101 degrees, whereas on the Stagleap ridge at 2140 m the wind blew from 240 degrees by day and 257 degrees by night. A BC Wildfire Service station on the study area's high ground, Darkwoods at 1657 m, began recording in October 2014, after the study years, and over June to August of 2015 to 2025 its flight-hour wind blew from 212 degrees and its night wind from 9 degrees (@fig-creston-rhythm). The trench was rerun for the summer of 2010 at 1 km, once as before and once with the model's non-neutral stability option, which set each hour's stability from its cloud and sun, and the regional box once at 500 m, all read at these stations, 16 of which had hours in that summer. At Akokli Creek the direction error was 44 degrees with a neutral atmosphere and 44 with stability, with 0.26 and 0.27 of hours in the measured sector against 0.125 by chance. Across the provincial stations the direction error ran from 27 to 97 degrees with a neutral atmosphere and changed by at most 14 degrees with stability, so stability did not move the fields toward the measured valley wind.

The limits of these predictions follow from their inputs. The reanalysis cells are 11 km across and carry no station from the trench, so the valley wind enters as a smoothed regional flow and the terrain inside each domain shapes it; the model conserves mass but assumes a neutral atmosphere and carries no vertical velocity, and performs worst in the upslope regime of the flight window [@wagenbrenner2016]; the lift term is a scale of rising air, not a measured updraft; and the trajectories give a corridor of ground, not a point of origin. Given a uniform wind of 10 km/h over the trench, the model returned a domain mean of 6.3 km/h at 10 m above ground with the slope winds on and 6.0 with them off, and at a single point it was given it returned 5.9 km/h unmatched and 5.9 matched. On 15 July 2010 the reanalysis cells gave the model a mean of 8.9 km/h over the flight hours and it returned 5.6 km/h at those cells unmatched and 5.6 km/h matched. None of these terms resolves the tree, which the pheromone decides.

The fields were used with the speed corrected and the direction limit stated. The model's own step from input to output speed was measured where terrain could not enter, on a flat grid of the same extent and cells as each domain given the same uniform 10 km/h, and read as the median speed returned at 10 m above ground; every modelled speed was multiplied by the factor of its mesh, 1.65 at 1 km, 1.64 at 500 m, 1.63 at 90 m, 1.62 at 30 m and 1.62 at 10 m, before it was mapped, summarised or entered in a model, so that the terrain's effect on speed stayed in the fields and the model's step did not. The direction of the fields was the reanalysis's regional flow steered by the terrain, which the stations showed to be wrong by about 60 degrees at the valley floor with a sector agreement of 0.2 against 0.125 by chance; the two terms that depend on it, the share of flight hours blowing upslope and the shelter index at the cell's modelled direction, were therefore read as the slope's standing to that regional flow and not to the valley wind, and no result rested on the direction at any one cell. The terrain wind entered the models in place of the station wind, one term to a specification: the corrected speed at 90 m, the upslope share, the shelter index at the modelled direction, the window speed at 30 m and at 10 m, and the convective lift, each from the same period or flight window of the previous summer, with basal area, quadratic mean diameter, crown closure, live stems and standing volume interacting with it in the sixteen-day models and basal area, diameter and crown closure in the annual ones. Because every cell of a period shared the reanalysis flux, the lift was fitted again with the summer held as a factor in the annual models and the period of the summer held in the sixteen-day ones, and then with each summer, or each period of each summer, held and the 10 m speed and the upslope share entered beside it, so that its coefficient was read from the differences between cells.

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


Three groups of terms that the earlier models lacked were added beside M3 and E2. Valley bottoms and ridge tops were measured by the multiresolution indices of valley bottom and ridge top flatness [@gallant2003], computed in SAGA GIS on the 30 m elevation model. Canopy height was the 2017 lidar surface model less its bare-earth model at 1 m, summarised to each 30 m cell as its mean, its standard deviation and the share of the cell above 5 m, and because the lidar was flown after the outbreak it measured the canopy that remained. Winter cold was the lowest daily minimum temperature and the number of days at or below -30 °C in the winter, October to April, that ended before the flight behind each map, from the ERA5-Land daily minimum [@munozsabater2021] moved to each cell's elevation at the lapse rate the reanalysis cells gave on that day, with the cooling that cold air draining into the cell would add, from the basins, flow accumulation and drainage model of microclima [@maclean2019microclima], on every day whose night met that package's conditions for cold-air drainage at the site. Over the ten winters the temperature rose with elevation, an inversion, on 0.01 of days, the conditions for drainage held on 0.32 of nights, drainage cooled the coldest cells by up to 9.3 °C, and the lowest winter minimum across the study area averaged -26.8 °C and fell no lower than -35.4 °C, so that the days at or below -30 °C, 2.0 on average in the coldest winter, did not enter the models. The sixteen-day model was also refitted with the terms of the annual model it lacked, northness, sky view, the wind shelter index, convergence and stand age.


::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

:::



::: {.cell}

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

The environmental terms were 40 variables, grouped by the mechanism each represented (Table S3). Four logistic regressions were fitted in sequence, each adding one mechanism to the one before. M0 contained host size, shading and landform; M1 added stand density as basal area; M2 added terrain exposure to wind, terrain shape and direct radiation in the flight window; and M3 added the interactions of basal area with the wind shelter index, July wind and flight-window radiation. Every model included the geomorphon class of the cell, and every continuous term was standardised, so that each coefficient was a change in log-odds per standard deviation. The sequence was fitted first on all nine years without the dependence terms, and then on the eight years with a previous map, without and with them, so that the change in each environmental term once attack nearby and the year before entered could be read directly.

The first and third questions were answered with these annual models. For the third, the main effect of the wind shelter index was compared with its interaction with basal area, in M3 fitted with and without flight-window radiation. Each interaction was read as the slope of one term at one standard deviation either side of the mean of the other. Attack was also tabulated by quadratic mean diameter class, with Wilson intervals, a chi-square test across classes and a two-proportion test across 25 cm, the diameter that @carroll2004bionomics gave as the boundary between beetle sinks and sources.

The second question was tested on the sixteen-day maps, on which wind varied between periods within a season as well as between years. Attack in a period was regressed on 15 stand and terrain variables, mean flight-hour wind, the geomorphon class, and the interactions of wind with live stems and with standing volume, in a model labelled E1. E2 added the cell's own state in the previous period and the share attacked within 90 m around it. E3 added the same two terms for the same period of the previous year, with the radii chosen on AIC as for the annual models. Each period contributed up to 2,000 cells of each class.

Because the red crowns of a period recorded the flight of the previous summer, every wind test was run a second time with the wind of the same calendar period one year earlier, and the annual models with the flight window of the previous summer, which required the 2012 station record although 2012 had no map. The lagged sixteen-day model with the dependence terms was fitted a third time with two pressure terms from the same stations, the mean departure of station pressure in the flight hours from the station's own May to September mean, and its mean change over the following three hours, both for the period one year earlier.

Surface temperature in the flight window was read from the thermal band of the same Landsat scenes, the Collection 2 Level-2 surface temperature at 30 m, as the median over the clear scenes of 1 July to 15 August in each year from 2005 to 2014 at the late-morning overpass, and it entered the annual models for the previous summer in place of modelled radiation. Terrain at the scale of single trees came from the 1 m lidar bare-earth model of the Natural Resources Canada series, project Kootenay Columbia 2017, as the standard deviation of elevation within each 30 m cell and, from the model aggregated to 5 m, the share of the cell facing north and the spread of the position index in a 55 m window, each summarised to the 30 m grid and added to the lagged model.

Residual spatial autocorrelation was measured for every annual model as Moran's I of the deviance residuals, computed within each year on the eight nearest sampled cells. To account for spatial pattern left after the dependence terms, M3 with those terms was refitted with a Gaussian process smooth of easting and northing [@wood2017], with its Matérn range set to the median range of positive autocorrelation, 2,640 m. To test the grain, M3 was refitted on cells coarsened to 90, 270 and 990 m. A coarse cell counted as attacked if any 30 m cell inside it was, the definition @aukema2008 used on their 12 km cells, and the previous year's state and the share of the eight neighbouring cells were rebuilt at each grain.


::: {.cell}

:::


# Results {#sec-results}

Attack was clustered in every year, with pairs of neighbouring attacked cells 3.2 to 5.8 times as many pairs of neighbouring attacked cells as random permutations produced and positive autocorrelation to a median of 2,640 m (@fig-clustering). The previous year's attack in the cell and within 150 m, the best of six radii (@tbl-dependence), dominated every model it entered. A cell attacked the year before had 9.1 times the odds of attack, and the two dependence terms raised the area under the receiver operating characteristic curve (AUC) of M3 from from 0.814 to 0.890.

## Refugia mechanisms

Of the three refugia mechanisms, stand density was supported through the amount of host, host size acted as a threshold, and shading was not supported. Each step of the model sequence lowered AIC, most when basal area entered, by 478 (@tbl-models). Basal area entered M3 at +0.276 log-odds per standard deviation (p < 0.001). It remained positive with the dependence terms, +0.167, and under the spatial field, +0.200, as did susceptible pine basal area, whereas stand age could not be distinguished from zero under the field (p = 0.058) (@tbl-final). Attack depended on quadratic mean diameter class [χ²(5) = 980.1, p < 0.001, Cramér's V = 0.117]. It peaked in the 25 to 30 cm class, at 56.4 per cent of the balanced sample against 48.1 per cent at 20 to 25 cm, and fell in the larger classes, whose stands had less pine (@tbl-diameter). Elevation had the largest coefficient in every model, +0.940 in M3 (p < 0.001), with more attack on higher ground. North-facing ground had more attack, +0.105 (p < 0.001). Afternoon sun in the flight window raised attack in stands one standard deviation above the mean basal area, +0.144 (p < 0.001), but not in stands one standard deviation below it, +0.012 (p = 0.471).

## Wind and density

Flight-hour wind did not lower attack in any stand structure the inventory described (Table S4). The station wind of the same period entered E1 at +0.014 (p = 0.020) and E2, with the previous period's attack, at +0.116 (p < 0.001), and its interaction with standing volume could not be distinguished from zero in either model (p = 0.642 and p = 0.296). With the wind of the previous summer in place of the same period's, wind itself entered at +0.002 (p = 0.749) and +0.087 (p < 0.001), its interaction with quadratic mean diameter at -0.064 (p < 0.001) and with crown closure at -0.000 (p = 0.963), so that attack rose with the previous summer's wind in stands of larger trees and closed canopy (@fig-interaction). The pressure departure of the previous summer's period entered the lagged model with dependence terms at +0.011 (p = 0.318) and its three-hour change at +0.149 (p < 0.001). In the annual models the interaction of basal area with July wind was +0.004 (p = 0.715) with the same summer's wind and +0.010 (p = 0.292) with the previous summer's.

## Modelled wind

With the terrain wind of the previous summer in place of the station wind, attack rose after a windier summer in the annual models, more so in stands of greater basal area and diameter, the sixteen-day speed itself could not be distinguished from zero but attack rose with it in stands of greater crown closure and diameter, and ground facing the modelled wind had less attack at both scales. In the annual model with the previous year's attack and the dependence terms, the corrected 90 m speed entered at +0.077 (p < 0.001), its interaction with basal area at +0.057 (p < 0.001), with quadratic mean diameter at +0.046 (p < 0.001) and with crown closure at +0.024 (p = 0.023). The window speed at 10 m entered at +0.077 (p < 0.001) and at 30 m at +0.012 (p = 0.387). The share of flight hours blowing upslope entered at -0.003 (p = 0.804) and its interaction with basal area at +0.065 (p < 0.001); the shelter index at the modelled direction, higher on ground facing that wind, entered at -0.051 (p < 0.001) and its interaction with basal area at +0.054 (p < 0.001). The convective lift of the previous summer entered at +0.180 (p < 0.001) and its interaction with basal area at -0.060 (p < 0.001). With the summer held as a factor, so that the lift was read from the differences between cells within a summer, it entered at -0.390 (p < 0.001), and beside the window speed at 10 m and the upslope share at -0.402 (p < 0.001), with the 10 m speed at +0.031 (p = 0.033) and the upslope share at +0.018 (p = 0.177).

In the sixteen-day models with the previous period's attack, the corrected 90 m speed of the same period a summer earlier entered at -0.014 (p = 0.271), its interaction with crown closure at +0.071 (p < 0.001), with diameter at +0.041 (p < 0.001) and with basal area at -0.047 (p = 0.093). The upslope share entered at -0.057 (p < 0.001) and its interaction with diameter at +0.077 (p < 0.001); the shelter index entered at -0.064 (p < 0.001) and its interaction with diameter at +0.060 (p < 0.001). The window speed at 10 m entered at +0.040 (p < 0.001) and at 30 m at +0.015 (p = 0.195), with crown closure at +0.070 (p < 0.001) and +0.060 (p < 0.001). The convective lift of the same period a summer earlier entered at -0.239 (p < 0.001), with crown closure at -0.002 (p = 0.858) and diameter at -0.023 (p = 0.097). With the period of the summer held as a factor it entered at -0.121 (p < 0.001), and with each period of each summer held, beside the 10 m speed and the upslope share, at -0.360 (p < 0.001), with the 10 m speed at -0.003 (p = 0.827) and the upslope share at -0.040 (p = 0.001).

The slope updraft of the terrain wind went with less attack in the sixteen-day models and could not be distinguished from zero in the annual models once the summer was held. In the sixteen-day model with the previous period's attack, the updraft of the same period a summer earlier entered at -0.103 (p < 0.001), with quadratic mean diameter at +0.045 (p < 0.001) and with crown closure at +0.041 (p = 0.002). With each period of each summer held it entered at -0.077 (p < 0.001), and its interaction with topographic position at -0.029 (p < 0.001), so that the fall in attack with updraft was steepest on ridges and spurs. In the annual model with the dependence terms the updraft entered at -0.029 (p = 0.050) and its interaction with basal area at +0.063 (p < 0.001), and with the summer held at -0.015 (p = 0.314), its interaction with topographic position at -0.014 (p = 0.122).

## Terrain shelter

Leeward ground had slightly more attack, and once the previous year's attack was in the model the effect did not depend on density. The wind shelter index, which was higher on slopes facing the prevailing wind, entered M3 at -0.073 (p < 0.001), and at -0.032 (p = 0.043) with the dependence terms, when its interaction with basal area was -0.000 (p = 0.971). Sky view entered at +0.369 (p < 0.001). Both terrain terms depended on place and grain. Under the spatial field, sky view fell to +0.037 (p = 0.285) and the shelter index changed sign, to +0.096 (p < 0.001). At coarser grain, the shelter index lost significance at 90 m and sky view at 270 m, while basal area remained positive at 270 m, +0.094 (p = 0.026) (@fig-grain). Residual Moran's I remained significant in every year, even with the spatial field, at a median of 0.345.

## Heat and microsite

In the flight window the late-morning surface temperature of north-facing ground was 21.4 °C against 24.8 °C on south-facing ground, averaged over the ten summers and 108 scenes, and it correlated -0.42 with northness and 0.02 with modelled flight-window radiation (@fig-heat). With the measured temperature of the previous summer in place of modelled radiation, northness entered at +0.258 (p < 0.001) against +0.102 (p < 0.001) beside radiation, and temperature itself at +0.560 (p < 0.001). With the three terms from the 1 m terrain added to the lagged model, ground roughness within the cell entered at -0.086 (p < 0.001), the share of the cell facing north at +0.028 (p = 0.036) and the spread of crown-scale position at +0.007 (p = 0.584), and the AIC moved from 77087 to 77074.

The cloud-adjusted sun and the slope temperature both raised attack in the annual models and both lowered it in the sixteen-day models. In the annual model with the dependence terms, the flight-hour sun of the previous summer from r.sun, in place of the clear-sky radiation, entered at +0.063 (p = 0.003) and its interaction with basal area at +0.031 (p = 0.008), and northness beside it at +0.076 (p < 0.001). The slope temperature from microclima, the terrain's departure from the reanalysis at the cell's elevation, entered at +0.129 (p = 0.001) and its interaction with basal area at +0.072 (p = 0.023), with northness at +0.096 (p < 0.001). In the sixteen-day models with the previous period's attack, the sun of the same period a summer earlier entered at -0.128 (p < 0.001), with quadratic mean diameter at -0.079 (p < 0.001), and the slope temperature at -0.259 (p < 0.001), with quadratic mean diameter at -0.035 (p = 0.008). With each period of each summer held, the sun entered at +0.077 (p = 0.099) and the slope temperature at -0.203 (p < 0.001), and in the annual models with the summer held the sun entered at +0.037 (p = 0.089) and the slope temperature at -0.462 (p < 0.001). Across the study area the slope temperature correlated at 0.97 with the flight-window sun, so it was refitted without the two radiation terms, when it entered at +0.018 (p = 0.388) in the annual model with the summer held and at -0.054 (p < 0.001) in the sixteen-day model with each period of each summer held. The share of cells attacked was highest on ground facing west (23 per cent) and lowest on ground facing south (10 per cent) (@fig-flight-paths).

## Valleys and winter

With the previous year's attack and the dependence terms in the annual model, valley bottom flatness entered at -0.059 (p < 0.001) and ridge top flatness at +0.071 (p < 0.001), cold-air pooling at -0.083 (p = 0.012), mean canopy height at -0.088 (p = 0.004), its variation at +0.171 (p < 0.001) and the share above 5 m at -0.389 (p < 0.001). The lowest minimum of the winter before the flight entered at -0.210 (p < 0.001), and with the summer held at -0.102 (p = 0.068). In the sixteen-day models with the previous period's attack, valley bottom flatness entered at -0.020 (p = 0.179), ridge top flatness at -0.014 (p = 0.174), cold-air pooling at -0.045 (p = 0.058), mean canopy height at +0.509 (p < 0.001) and the winter minimum at -0.111 (p < 0.001). With the terms of the annual model added to the sixteen-day model, northness entered at -0.097 (p < 0.001), sky view at +0.305 (p < 0.001), the wind shelter index at -0.023 (p = 0.233), convergence at -0.023 (p = 0.030) and stand age at +0.044 (p < 0.001). With the survey south of the border added, the share of the afternoon air's endpoints that lay over red attack of the same summer averaged 0.019 over the flight windows, and the source term entered the annual model at +0.091 (p < 0.001) and the sixteen-day model at +0.074 (p < 0.001).

## Fused series

Mapped from Landsat 7 alone, 2012 had attack on 12.9 per cent of the perimeter, with 100 per cent of cells seen in the summer's median despite the strips the failed scan-line corrector left. The same steps applied to 2011 reproduced the Landsat 5 map of that year at an agreement of 0.93 and a kappa of 0.70, with attack on 14.2 against 13.6 per cent of cells, and the two satellites' NDMI correlated at r = 0.97 with a mean difference of 0.014. The strips were tested by counting the clear scenes behind each cell: in 2012 0.0 per cent of cells were seen by none and 8.1 per cent by two or fewer, and in 2011 the kappa against the Landsat 5 map was 0.58 on cells seen by two scenes or fewer and 0.73 on cells seen by three or more. The fused series reproduced a hidden year only in part. With every Landsat observation of 2008 and then of 2011 hidden, the fused maps of those years matched their Landsat maps at a mean kappa of 0.35 at the Landsat cut and 0.34 at the cut chosen for the fused series, a fall in NDMI of 0.040 against 0.0616, and at 0.58 on the 0.22 of cells whose fall lay clearly on one side of the cut. The fused series gave nine maps for 2012, the year without usable Landsat imagery, on which attack covered 4.6 to 18.7 per cent of the perimeter by period, a mean of 11.1 per cent against 11.0 per cent in 2011 and 21.3 per cent in 2013 on the same series.

# Discussion

## Contagion first

Attack in a 30 m cell was predicted first by attack in and around it the year before, and every environmental term in this study was read beside those terms rather than in place of them. This order followed @aukema2008, who found on the Chilcotin Plateau that an outbreak in a 12 km cell was best predicted by outbreaks within 18 km that year and within 6 km in the two years before, and that temperature still "contributed to explaining outbreak probabilities" once those terms were in the model (p. 348). The same pattern appeared here at a far finer scale. The share of cells attacked within 150 m the year before fitted better than any wider neighbourhood, close to the 140 m within which previous attack raised the rate of red attack above its background in Colorado [@walter2013]. That distance matched short-range dispersal, which "takes place under the forest canopy" and is "determined by the relative proximity of brood trees within individual stands" [@safranyik2010, p. 428].

The outbreak was already epidemic in the years mapped, and the dominance of the dependence terms fitted that phase. @walter2013 found that distance to the previous year's infestation "increased in importance relative to other predictors" as an outbreak progressed (p. 315), and @meddens2014 found that late in an outbreak "almost all new mortality was associated with intensification of existing outbreaks, not expansion" (p. 83). Here the dependence terms raised the AUC of M3 from 0.814 to 0.890, whereas the whole environmental sequence from M0 to M3 raised it by 0.005. The refugia mechanisms were therefore tested as modifiers of an outbreak that spread mostly by contagion.

## Host and density

Attack rose with the amount of host, through basal area and susceptible pine basal area, and less firmly with stand age. These are the variables of the stand susceptibility rating used in British Columbia, which is built on "the percentage of susceptible pine by basal area", pine age and stand density, together with climate [@safranyik2010, p. 429; @shore2000susceptibility]. The refugia this landscape showed were therefore stands with little host, in agreement with the thinning trials in which stands reduced in basal area lost fewer trees [@mitchell1983thinning; @amman1988susceptibility; @fettig2007effectiveness; @hood2016fortifying]. The amount of host is itself a product of forest history. @taylor2003 concluded that within climatically suitable areas "forest age-class structure will be the primary factor influencing host susceptibility and outbreak severity" (p. 42), and by 2000 the area of mature lodgepole pine in British Columbia was more than three times that of a century earlier [@shore2006].

Basal area here measured the amount of pine rather than crowding. Dense unmanaged stands have thinner phloem, and "beetle production and subsequent tree mortality in dense, unmanaged stands tend to be less than in more open stands" [@shore2006, p. 103]. @walter2013 found red attack moving to less dense stands once an outbreak became epidemic, whereas here attack rose with basal area in every model through to 2014.

Attack peaked in stands of 25 to 30 cm quadratic mean diameter, just above the 25 cm diameter at which, on average, lodgepole pines change from beetle sinks to beetle sources [@carroll2004bionomics]. Thicker phloem feeds more brood, and in laboratory trials brood production rose from an average of 16 beetles to 94 as phloem thickened from 2.3 to 5.8 mm [@amman1972]. During epidemics the share of trees killed rises with diameter above about 10 cm [@shore2006], so the fall in attack in stands of larger trees did not reflect the beetle's preference. It reflected composition, since stands of the largest trees here had little pine. Epidemics also "often deplete the large diameter pine component of stands" [@shore2006, p. 110], after which smaller trees are attacked in later years [@meddens2014].

## Elevation and climate

Elevation had the largest coefficient in every model, with more attack on higher ground. That ran against the historical pattern, in which mortality "tends to decline with elevation" because the cool climate of high ground slows development and lowers brood survival [@shore2006, p. 103], and in which cooler summers stretch the life cycle over two years, with severe mortality [@safranyik2006chap1]. Three explanations fit this result, and the design could not separate them, because on this range the higher ground also had the pine. The first was the distribution of the host, since where elevation entered an earlier model of red attack, in western Montana, its sign followed where lodgepole pine grew rather than the beetle's preference [@wulder2006red]. The second was the phase of the outbreak, since in Colorado red attack "moved from high elevations to in 2003 to low elevations in 2005 and 2006" [@walter2013, p. 316]. The third was a milder climate, since the warm phase of the Pacific Decadal Oscillation after 1976 favoured outbreaks "by reducing the occurrence of extremely low winter temperatures province-wide" [@maciasfauria2009, p. 1], and climates that had once limited epidemics became more favourable [@taylor2003].

## Aspect and wind

Over the flight windows of 2005 to 2013 the afternoon air reached the site from the south-west, from 193 to 256 degrees, and the least attack fell on the faces that met it. The share of cells attacked was 10 per cent on south-facing and 12 per cent on south-west-facing ground, against 23 per cent on west-facing and 19 per cent on north-west-facing ground. In the sixteen-day models attack fell where the modelled wind was pushed up the slope it met, -0.103 (p < 0.001), most steeply on ridges and spurs. Northness raised attack in every model after host, stand density and elevation had entered, so the distribution of lodgepole pine could not account for the pattern alone. This was the reverse of what most studies of aspect had reported. In Colorado red attack was associated with southern aspects [@walter2013], and in the South sub-area of @nelson2007environmental "southern slopes appeared to be preferred" (p. 105). In the Peace River region @giroday2011 found attack concentrated on windward faces and concluded that beetles "tend to accumulate on windward sides of barriers" (p. 1107).

Two observations of the beetle's flight are consistent with the pattern found here. Beetles released by @safranyik1989 "climbed towards the tree tops, and usually tracked to the north or northeast, generally crosswind and downwind" (p. 508), and @carroll2004bionomics noted that "bark beetles do not fly in winds that exceed their maximum flight speed" (pp. 22-23). A face on which the afternoon wind was forced upslope would then be the face that beetles could least easily reach, and the flanks lying along the flow the faces they reached while flying across it. @kunegel2020factors read the north-facing onset of an outbreak in the Cypress Hills in the same way, writing that "This directionality could be explained by the fact that the dominant winds in Cypress Hills come from the south-west" (p. 9).

Heat offers a second reading that this design could not fully separate from the first, because the south-west faces that met the wind also received the most afternoon sun. Within a tree "the heaviest attacks are usually found on the northern aspect and the lightest attacks on the southern aspect" of the bole [@safranyik2006chap1, p. 18], and in the Black Hills "The decreased number of attacks during midday coincides with the period of highest mean temperatures" [@schmid1991bark, p. 1445]. Once the flight-window sun was removed from the annual model, the modelled slope temperature no longer predicted attack within a summer, +0.018 (p = 0.388), so exposure to the wind, not heat, was the term that remained. No study has compared beetles landing on the windward and lee faces of the same ridge, and nothing has been published on the summer winds of the Creston valley, so the test this reading needs is a wind record taken on the slopes themselves.

## Wind and density

Flight-hour wind did not lower attack in any stand structure the inventory described, and once attack in the previous period entered, wind raised attack, most in stands of larger trees and closed canopy, which is the reverse of plume disruption.

The plume mechanism rests on measurements inside the canopy. In Utah, @bartos1989 found a thinned stand windier than the unthinned stand beside it by about 1.6 km/h on average and by 3.2 km/h or more in the late afternoon, and argued that in a thinned stand the pheromone "rises through the canopy on convection currents and is dispersed above the canopy" (p. 9). A tracer gas released in place of pheromone was likewise diluted fastest in the most open of three canopies [@thistle2004surrogate]. A stand one standard deviation below the mean crown closure here was not the open canopy those trials created, and neither the inventory nor a terrain model of station wind could resolve a contrast at that scale. Under epidemic pressure the benefit of spacing may also be lost, since in ponderosa pine the influence of pheromones from attacked trees in adjacent unmanaged stands "may override the positive benefits of increased spacing and improved tree growth derived from partial cutting" [@schmid2005, p. 9].

Wind above the canopy carries beetles into new stands [@jackson2008; @chen2017; @safranyik2010], and within a stand @safranyik1989 found that "wind speed had negligible effect on the fit of the model for relative directional distribution of beetles". Both predict more attack with wind rather than less, the direction the models with dependence terms showed. Red crowns seen in a period also recorded the flight of the previous summer, because the foliage of an attacked tree stays green "usually until May and June of the year following attack" [@safranyik2006chap1, p. 11].

## Modelled wind

The terrain wind model changed the question the wind terms could answer more than it changed the answer. At the four valley stations its direction was the reanalysis's, wrong by about 60 degrees with a sector agreement of 0.2 against 0.125 by chance, and its speed came back at a constant six tenths of what it was given on flat ground at every mesh, so the fields were read for where the regional flow met the slopes and how fast, with the speed corrected, and not for the valley wind itself, which nothing in the 2005 to 2014 record resolved except the stations in other valleys. Read that way, the fields repeated the station result and sharpened it. Attack rose after a windier previous summer in the annual models, at +0.077 per standard deviation of the corrected 90 m speed, and more so where basal area and diameter were greater, +0.057 and +0.046, which is the pattern of beetles delivered to large hosts by the wind above the canopy [@jackson2008; @chen2017] and not the pattern of a plume broken up in open stands. Ground facing the modelled wind had less attack at both scales, -0.051 in the annual model and -0.064 in the sixteen-day one, the reverse of the windward attack that @giroday2011 reported, now at the direction the terrain gave each cell rather than at one bearing pooled from seven stations.

The scale of the speed mattered. The window speed at 10 m from the lidar terrain entered at +0.077, against +0.077 for the 90 m mesh and +0.012 for the 30 m one, so the cell's own exposure carried a signal that the coarser meshes smoothed, at the grain at which the pheromone decides the tree. In the sixteen-day models the speed itself could not be distinguished from zero, -0.014 (p = 0.271), but attack rose with it in closed stands, +0.071, and in stands of larger trees, +0.041, and the share of flight hours in which the modelled air moved upslope lowered attack in that period, -0.057 (p < 0.001), as if the afternoon upslope flow carried beetles past a slope rather than onto it, while the share over the whole flight window did not enter the annual model (p = 0.804). The convective lift of the previous summer, the characteristic speed of rising air over each slope, entered at +0.180 (p < 0.001) in the annual model and at -0.239 (p < 0.001) in the sixteen-day one. The lift varied between periods and summers far more than between cells, because every cell of a period shared the reanalysis flux and differed only by its sun, and once the calendar was held it lowered attack at both scales, at -0.390 (p < 0.001) in the annual model with the summer held and at -0.121 (p < 0.001) in the sixteen-day model with the period held. The positive annual coefficient therefore came from the differences between summers, in that attack rose after summers of stronger convection, while within a summer the slopes over which the air rose fastest held less attack, and this held with the 10 m speed and the upslope share beside it, at -0.402 annually and -0.360 by period. Within a summer the lift of a cell differed from its neighbours chiefly through the slope's share of the sun, which the models also held as flight-window radiation, so the two terms shared much of their variation and the within-summer lift was read as the slope's convection over and above its direct sun rather than as an independent measurement.

None of these specifications fitted better than the model with the station wind (@tbl-models), so the terrain wind did not add information the stations lacked; it placed the same information on the slopes. What the modelling showed was narrower than what was asked of it. Wind at the site acted as a term of arrival and not of refuge, its effect grew with the size of the host it reached, and the lee of the terrain held more attack whether the direction came from the stations or from the model. The valley circulation that would carry beetles up from the trench, and the lift that would raise them above the canopy, remained a reading of the regional flow and of the sun on each slope rather than a measurement, and the test of that reading is a wind record from the slopes themselves.

## Terrain and scale

Ground facing the prevailing wind had slightly less attack than sheltered ground at the same elevation and stand structure, and once the previous year's attack entered, the effect did not depend on density. This was the pattern deposition predicts, since changes in wind speed "may cause increased settlement in areas where wind speed is reduced" [@giroday2011, p. 1098], and in simulations of beetles flying through forest, dispersal downwind shortened as trunks became denser [@byers2000]. The effect was small, however, and it disappeared at 90 m and changed sign under the spatial field, as did the effect of open ground. Both terrain terms therefore described where attack clustered on this range as much as a property of the slope.

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


::: {#tbl-vri .cell tbl-cap='Stand structure over the 72,000 sampled cell-years, from the annual Vegetation Resources Inventory snapshots. SD was the standard deviation, SE the standard error of the mean, and Skew and Kurt. the bias-corrected skewness and excess kurtosis.'}
::: {.cell-output-display}


|Attribute                             |   Mean|     SD|    SE| Median|   Min|     Max|  Skew|  Kurt.|
|:-------------------------------------|------:|------:|-----:|------:|-----:|-------:|-----:|------:|
|Stand basal area (m² ha⁻¹)            |  35.25|  12.44| 0.046|  37.59|  0.40|   93.15| -0.78|  +1.65|
|Crown closure (%)                     |  50.05|  13.19| 0.049|  50.00|  1.00|   90.00| -1.61|  +3.25|
|Live stems (n/ha)                     | 782.10| 317.51| 1.183| 798.00| 13.00| 5257.00| +1.04| +13.76|
|Quadratic mean diameter (cm)          |  26.51|   6.11| 0.023|  26.09| 13.55|   78.78| +1.10|  +2.62|
|Stand age (years)                     | 113.04|  25.43| 0.095| 110.00| 14.00|  337.00| +1.30|  +8.73|
|Stand height (m)                      |  26.17|   5.89| 0.022|  26.10|  7.00|   42.30| -0.07|  +0.49|
|Standing volume (m³ ha⁻¹)             | 263.51| 132.15| 0.492| 261.01|  0.69|  885.23| +0.13|  -0.19|
|Lodgepole pine cover (%)              |  23.96|  26.99| 0.101|  20.00|  0.00|  100.00| +1.08|  +0.27|
|Susceptible pine basal area (m² ha⁻¹) |   8.47|  10.32| 0.038|   4.09|  0.00|   48.30| +1.31|  +1.22|


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


::: {#tbl-dependence .cell tbl-cap='Dependence terms compared on AIC over 63,968 sampled cell-years with a previous map. Own state was attack in the cell in the previous outbreak year, and the share was the proportion of cells attacked within the radius around it that year, excluding the cell. Delta AIC was the difference from the lowest.'}
::: {.cell-output-display}


|Terms                                       |  k|    AIC| Delta AIC|
|:-------------------------------------------|--:|------:|---------:|
|intercept                                   |  1| 88,680|  30,456.0|
|intercept + own state                       |  2| 62,907|   4,682.6|
|intercept + own state + share within 42 m   |  3| 59,502|   1,277.9|
|intercept + own state + share within 90 m   |  3| 58,264|      39.4|
|intercept + own state + share within 150 m  |  3| 58,224|       0.0|
|intercept + own state + share within 210 m  |  3| 58,380|     155.3|
|intercept + own state + share within 510 m  |  3| 59,448|   1,223.9|
|intercept + own state + share within 1050 m |  3| 60,370|   2,145.2|


:::
:::


{{< pagebreak >}}


::: {#tbl-models .cell tbl-cap='The annual models, each adding one mechanism to the one before, over all nine years without the dependence terms and over the eight years with a previous map without and with them. M0 held host size, shading and landform, M1 added basal area, M2 terrain exposure, terrain shape and flight-window radiation, and M3 the interactions of basal area with wind shelter, July wind and flight-window radiation. AUC was the area under the receiver operating characteristic curve and Brier skill the reduction in mean squared error of the fitted probabilities against the base rate.'}
::: {.cell-output-display}


|Years        |Dependence |Model                                  |      n|    AIC|   AUC| Brier skill|
|:------------|:----------|:--------------------------------------|------:|------:|-----:|-----------:|
|2006 to 2014 |no         |M0                                     | 72,000| 77,729| 0.804|       0.284|
|2006 to 2014 |no         |M1                                     | 72,000| 77,252| 0.807|       0.289|
|2006 to 2014 |no         |M2                                     | 72,000| 77,120| 0.808|       0.290|
|2006 to 2014 |no         |M3                                     | 72,000| 76,994| 0.809|       0.292|
|2006 to 2014 |no         |M3 lagged wind                         | 72,000| 77,087| 0.809|       0.291|
|2006 to 2014 |no         |M3 lagged wind, diameter and closure   | 72,000| 77,060| 0.809|       0.291|
|2006 to 2014 |no         |M3 measured heat                       | 71,922| 74,341| 0.825|       0.319|
|2006 to 2014 |no         |M3 lidar                               | 72,000| 77,074| 0.809|       0.291|
|2006 to 2014 |no         |M3 modelled wind                       | 72,000| 77,065| 0.809|       0.291|
|2006 to 2014 |no         |M3 upslope share                       | 72,000| 77,051| 0.809|       0.291|
|2006 to 2014 |no         |M3 shelter at the modelled wind        | 72,000| 77,086| 0.809|       0.291|
|2006 to 2014 |no         |M3 modelled wind, diameter and closure | 72,000| 76,997| 0.809|       0.292|
|2006 to 2014 |no         |M3 modelled wind, 30 m                 | 72,000| 77,044| 0.809|       0.291|
|2006 to 2014 |no         |M3 modelled wind, 10 m                 | 72,000| 77,089| 0.809|       0.291|
|2006 to 2014 |no         |M3 lift                                | 72,000| 77,010| 0.809|       0.291|
|2006 to 2014 |no         |M3 lift with year                      | 72,000| 76,094| 0.814|       0.301|
|2006 to 2014 |no         |M3 lift, 10 m speed and upslope        | 72,000| 76,084| 0.814|       0.301|
|2006 to 2014 |no         |M3 slope updraft                       | 72,000| 76,952| 0.809|       0.292|
|2006 to 2014 |no         |M3 slope updraft at ridges             | 72,000| 76,822| 0.810|       0.295|
|2006 to 2014 |no         |M3 cloud-adjusted sun                  | 72,000| 77,019| 0.809|       0.292|
|2006 to 2014 |no         |M3 slope temperature                   | 72,000| 76,982| 0.809|       0.292|
|2006 to 2014 |no         |M3 cloud-adjusted sun with year        | 72,000| 76,854| 0.810|       0.295|
|2006 to 2014 |no         |M3 slope temperature with year         | 72,000| 76,655| 0.811|       0.297|
|2006 to 2014 |no         |M3 slope temperature without sun       | 72,000| 76,984| 0.809|       0.293|
|2006 to 2014 |no         |M3 valley and ridge flats              | 72,000| 76,952| 0.809|       0.292|
|2006 to 2014 |no         |M3 cold-air pooling                    | 72,000| 76,899| 0.810|       0.293|
|2006 to 2014 |no         |M3 canopy height                       | 72,000| 74,044| 0.827|       0.325|
|2006 to 2014 |no         |M3 winter cold                         | 72,000| 76,946| 0.809|       0.293|
|2006 to 2014 |no         |M3 winter cold with year               | 72,000| 76,788| 0.810|       0.296|
|2006 to 2014 |no         |M3 all new terrain                     | 72,000| 73,858| 0.828|       0.327|
|2006 to 2014 |no         |M3 vertical air speed                  | 72,000| 77,080| 0.809|       0.291|
|2006 to 2014 |no         |M3 trajectory source                   | 72,000| 77,072| 0.809|       0.291|
|2007 to 2014 |no         |M0                                     | 63,968| 68,444| 0.809|       0.292|
|2007 to 2014 |yes        |M0                                     | 63,968| 53,628| 0.886|       0.460|
|2007 to 2014 |no         |M1                                     | 63,968| 68,000| 0.813|       0.298|
|2007 to 2014 |yes        |M1                                     | 63,968| 53,490| 0.887|       0.462|
|2007 to 2014 |no         |M2                                     | 63,968| 67,881| 0.814|       0.299|
|2007 to 2014 |yes        |M2                                     | 63,968| 53,473| 0.887|       0.462|
|2007 to 2014 |no         |M3                                     | 63,968| 67,744| 0.814|       0.302|
|2007 to 2014 |yes        |M3                                     | 63,968| 53,016| 0.890|       0.467|
|2007 to 2014 |no         |M3 lagged wind                         | 63,968| 67,852| 0.814|       0.300|
|2007 to 2014 |yes        |M3 lagged wind                         | 63,968| 53,390| 0.888|       0.464|
|2007 to 2014 |no         |M3 lagged wind, diameter and closure   | 63,968| 67,825| 0.814|       0.300|
|2007 to 2014 |yes        |M3 lagged wind, diameter and closure   | 63,968| 53,319| 0.888|       0.464|
|2007 to 2014 |no         |M3 measured heat                       | 63,890| 64,883| 0.832|       0.334|
|2007 to 2014 |yes        |M3 measured heat                       | 63,890| 53,096| 0.889|       0.464|
|2007 to 2014 |no         |M3 lidar                               | 63,968| 67,849| 0.814|       0.300|
|2007 to 2014 |yes        |M3 lidar                               | 63,968| 53,381| 0.888|       0.464|
|2007 to 2014 |no         |M3 modelled wind                       | 63,968| 67,830| 0.814|       0.300|
|2007 to 2014 |yes        |M3 modelled wind                       | 63,968| 53,414| 0.888|       0.464|
|2007 to 2014 |no         |M3 upslope share                       | 63,968| 67,829| 0.814|       0.300|
|2007 to 2014 |yes        |M3 upslope share                       | 63,968| 53,432| 0.887|       0.463|
|2007 to 2014 |no         |M3 shelter at the modelled wind        | 63,968| 67,836| 0.814|       0.300|
|2007 to 2014 |yes        |M3 shelter at the modelled wind        | 63,968| 53,423| 0.888|       0.463|
|2007 to 2014 |no         |M3 modelled wind, diameter and closure | 63,968| 67,764| 0.815|       0.301|
|2007 to 2014 |yes        |M3 modelled wind, diameter and closure | 63,968| 53,337| 0.888|       0.464|
|2007 to 2014 |no         |M3 modelled wind, 30 m                 | 63,968| 67,791| 0.814|       0.300|
|2007 to 2014 |yes        |M3 modelled wind, 30 m                 | 63,968| 53,457| 0.887|       0.463|
|2007 to 2014 |no         |M3 modelled wind, 10 m                 | 63,968| 67,851| 0.814|       0.300|
|2007 to 2014 |yes        |M3 modelled wind, 10 m                 | 63,968| 53,426| 0.888|       0.463|
|2007 to 2014 |no         |M3 lift                                | 63,968| 67,780| 0.814|       0.300|
|2007 to 2014 |yes        |M3 lift                                | 63,968| 53,346| 0.888|       0.464|
|2007 to 2014 |no         |M3 lift with year                      | 63,968| 66,847| 0.820|       0.311|
|2007 to 2014 |yes        |M3 lift with year                      | 63,968| 52,556| 0.893|       0.472|
|2007 to 2014 |no         |M3 lift, 10 m speed and upslope        | 63,968| 66,849| 0.820|       0.311|
|2007 to 2014 |yes        |M3 lift, 10 m speed and upslope        | 63,968| 52,553| 0.893|       0.472|
|2007 to 2014 |no         |M3 slope updraft                       | 63,968| 67,753| 0.814|       0.301|
|2007 to 2014 |yes        |M3 slope updraft                       | 63,968| 53,423| 0.888|       0.463|
|2007 to 2014 |no         |M3 slope updraft at ridges             | 63,968| 67,611| 0.815|       0.304|
|2007 to 2014 |yes        |M3 slope updraft at ridges             | 63,968| 52,627| 0.893|       0.471|
|2007 to 2014 |no         |M3 cloud-adjusted sun                  | 63,968| 67,769| 0.814|       0.301|
|2007 to 2014 |yes        |M3 cloud-adjusted sun                  | 63,968| 53,034| 0.890|       0.467|
|2007 to 2014 |no         |M3 slope temperature                   | 63,968| 67,793| 0.814|       0.300|
|2007 to 2014 |yes        |M3 slope temperature                   | 63,968| 53,447| 0.887|       0.463|
|2007 to 2014 |no         |M3 cloud-adjusted sun with year        | 63,968| 67,679| 0.815|       0.303|
|2007 to 2014 |yes        |M3 cloud-adjusted sun with year        | 63,968| 52,639| 0.893|       0.471|
|2007 to 2014 |no         |M3 slope temperature with year         | 63,968| 67,487| 0.816|       0.305|
|2007 to 2014 |yes        |M3 slope temperature with year         | 63,968| 52,580| 0.893|       0.472|
|2007 to 2014 |no         |M3 slope temperature without sun       | 63,968| 67,728| 0.815|       0.302|
|2007 to 2014 |yes        |M3 slope temperature without sun       | 63,968| 52,684| 0.893|       0.471|
|2007 to 2014 |no         |M3 valley and ridge flats              | 63,968| 67,694| 0.815|       0.302|
|2007 to 2014 |yes        |M3 valley and ridge flats              | 63,968| 52,986| 0.890|       0.468|
|2007 to 2014 |no         |M3 cold-air pooling                    | 63,968| 67,662| 0.815|       0.303|
|2007 to 2014 |yes        |M3 cold-air pooling                    | 63,968| 53,012| 0.890|       0.467|
|2007 to 2014 |no         |M3 canopy height                       | 63,968| 64,520| 0.835|       0.341|
|2007 to 2014 |yes        |M3 canopy height                       | 63,968| 52,172| 0.894|       0.477|
|2007 to 2014 |no         |M3 winter cold                         | 63,968| 67,715| 0.815|       0.302|
|2007 to 2014 |yes        |M3 winter cold                         | 63,968| 52,739| 0.892|       0.470|
|2007 to 2014 |no         |M3 winter cold with year               | 63,968| 67,626| 0.815|       0.304|
|2007 to 2014 |yes        |M3 winter cold with year               | 63,968| 52,612| 0.893|       0.472|
|2007 to 2014 |no         |M3 all new terrain                     | 63,968| 64,352| 0.836|       0.344|
|2007 to 2014 |yes        |M3 all new terrain                     | 63,968| 51,917| 0.896|       0.479|
|2007 to 2014 |no         |M3 vertical air speed                  | 63,968| 67,841| 0.814|       0.300|
|2007 to 2014 |yes        |M3 vertical air speed                  | 63,968| 53,446| 0.887|       0.463|
|2007 to 2014 |no         |M3 trajectory source                   | 63,968| 67,813| 0.814|       0.300|
|2007 to 2014 |yes        |M3 trajectory source                   | 63,968| 53,398| 0.888|       0.463|


:::
:::


{{< pagebreak >}}


::: {#tbl-final .cell tbl-cap='Coefficients of M3 over all nine years, with the dependence terms over the eight years with a previous map, and with a latent spatial field as well. Continuous terms were changes in log-odds per standard deviation and dependence terms per unit, and the geomorphon classes are not shown. Significance was marked * p ≤ 0.05, ** p ≤ 0.01, *** p ≤ 0.001, **** p ≤ 0.0001.'}
::: {.cell-output-display}


|Term                                              |  All years| With dependence| With spatial field|
|:-------------------------------------------------|----------:|---------------:|------------------:|
|Susceptible pine basal area (m² ha⁻¹)             | +0.186****|      +0.090****|             +0.032|
|Stand age (years)                                 | +0.102****|        +0.035**|             +0.029|
|Quadratic mean diameter (cm)                      | -0.250****|      -0.136****|          -0.069***|
|Sky view factor                                   | +0.369****|      +0.170****|             +0.037|
|Northness                                         | +0.105****|      +0.073****|         +0.133****|
|Elevation (m)                                     | +0.940****|      +0.636****|         +1.199****|
|Stand basal area (m² ha⁻¹)                        | +0.276****|      +0.167****|         +0.200****|
|Wind shelter index                                | -0.073****|         -0.032*|         +0.096****|
|Topographic position index                        |     -0.011|          +0.012|             +0.023|
|Convergence index                                 | -0.049****|          -0.006|             +0.011|
|Profile curvature                                 | -0.071****|         -0.029*|             -0.002|
|Flight-window direct radiation (kWh/m²)           | +0.078****|      +0.085****|         +0.215****|
|July mean wind (km/h)                             | +0.064****|      +0.224****|         +0.209****|
|June mean wind (km/h)                             | +0.049****|      +0.061****|         +0.064****|
|Attack in the same cell, previous year            |           |      +2.208****|         +2.282****|
|Attack within 150 m, previous year                |           |      +2.216****|         +0.905****|
|Stand basal area x Wind shelter index             |   -0.030**|          -0.000|             +0.009|
|Stand basal area x July mean wind                 |     +0.004|        +0.039**|            +0.034*|
|Stand basal area x Flight-window direct radiation | +0.066****|       +0.048***|             -0.018|


:::
:::


{{< pagebreak >}}


::: {#tbl-diameter .cell tbl-cap='Red-stage attack by quadratic mean diameter class on the balanced annual sample, with Wilson 95 per cent intervals and the mean susceptible pine and total basal area of each class. The 25 cm boundary was the source-sink threshold of the species\' bionomics. The sample held equal numbers of attacked and unattacked cells in each year, so the percentages compared classes and were not landscape rates.'}
::: {.cell-output-display}


|QMD class (cm) |      n| Attacked| Attacked (%)|   95% CI (%)| Pine BA (m² ha⁻¹)| BA (m² ha⁻¹)|
|:--------------|------:|--------:|------------:|------------:|-----------------:|------------:|
|<15            |    672|      203|         30.2| 26.9 to 33.8|               1.0|          3.5|
|15-20          |  7,678|    3,380|         44.0| 42.9 to 45.1|              10.9|         23.7|
|20-25          | 20,445|    9,842|         48.1| 47.5 to 48.8|               8.4|         28.9|
|25-30          | 28,046|   15,807|         56.4| 55.8 to 56.9|              10.1|         39.7|
|30-40          | 12,526|    5,836|         46.6| 45.7 to 47.5|               5.5|         42.2|
|>40            |  2,633|      932|         35.4| 33.6 to 37.2|               0.4|         45.4|


:::
:::


{{< pagebreak >}}

# Figures {.unnumbered}


::: {.cell}
::: {.cell-output-display}
![Regional setting of the study area, in EPSG:3153 over the Copernicus 30 m elevation model with shaded relief. The red fill is the study perimeter, 5,573 ha. The black box is the 30 m context grid and the window of the 1 m lidar model, 23.6 by 25.4 km. The orange outline is the full extent of the 1 m lidar project, Kootenay Columbia 2017, from the border to the north end of Kootenay Lake. The green dashed box is the 60 by 80 km domain proposed for the terrain wind model. The blue grid is the ERA5-Land reanalysis at 0.1 degree, about 11 km. Yellow triangles are the seven hourly stations within 150 km of the site that reported through 2005 to 2014. The black line is the profile of @fig-profile and the long dash is the Canada and United States border. Lakes are from the British Columbia Freshwater Atlas.](Manuscript_files/figure-docx/fig-regional-1.png){#fig-regional}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Relief from the Selkirk crest east across the study area to the Purcell front, along the latitude of the centre of the perimeter, from the Copernicus 30 m elevation model sampled every 100 m. The red band is the span of the study perimeter. The level floor at 531 m is the Creston flats and the south arm of Kootenay Lake, which the ground reaches within 7.6 km of the crest of the study area at 2,072 m.](Manuscript_files/figure-docx/fig-profile-1.png){#fig-profile}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The valley wind at the Creston station, May to September 2005 to 2014. (a) The share of hours in each eight-point sector by hour of the day, where S and SW are the up-valley sectors. (b) The afternoon wind of each flight day of 2010 as its direction, with up-valley days filled and days on which a westerly above 15 km/h overrode the valley wind marked with a cross. (c) By year over June to August, the share of flight days that were up-valley days and the share overridden by a westerly, with the median hour at which the afternoon wind fell below 5 km/h written above each year. (d) The measured direction by hour of day over June to August 2005 to 2014 at three stations of the provincial networks, Creston on the valley side, Akokli Creek on the east shore of the south arm of Kootenay Lake, the Stagleap ridge, and Darkwoods on the study area's high ground, whose record begins in October 2014 and is shown for June to August 2015 to 2025, the vector mean of the hours above 5 km/h with point size the consistency of direction; the box marks the flight hours.](Manuscript_files/figure-docx/fig-creston-rhythm-1.png){#fig-creston-rhythm}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The modelled wind against the stations over every flight hour of June to August 2005 to 2014, on the trench run at 1 km. (a) Modelled against observed speed at each station, with the one-to-one line. (b) The error of direction on hours above 5 km/h, as the share of hours within each band of degrees, by station.](Manuscript_files/figure-docx/fig-wind-validation-1.png){#fig-wind-validation}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The terrain wind over the site from WindNinja at a 90 m mesh, averaged over the flight windows, 1 July to 15 August, of 10 summers, every flight hour 12:00 to 16:59. (a) Mean speed with the mean direction drawn as arrows, one per six cells. (b) The consistency of direction, the length of the mean wind vector over the mean speed, 1 for a wind that never changed direction. (c) The share of flight hours in which the air moved upslope. Speeds are multiplied by the model's flat-ground factor at this mesh, 1.63. The red outline is the study perimeter.](Manuscript_files/figure-docx/fig-wind-site-1.png){#fig-wind-site}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The terrain wind at the two regional scales, averaged over the flight windows of the summers run, every flight hour. (a) The Purcell Trench from Pend Oreille to the north end of Kootenay Lake at a 1 km mesh, with the 60 by 80 km box outlined. (b) The 60 by 80 km box around the site at 500 m. Colour is mean speed, arrows the mean direction, the red outline the study perimeter, and lakes from the Freshwater Atlas in blue. Speeds are multiplied by the model's flat-ground factor at each mesh, 1.65 at 1 km and 1.64 at 500 m.](Manuscript_files/figure-docx/fig-wind-regional-1.png){#fig-wind-regional}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The terrain wind over the site by sixteen-day period through the 2010 season at a 90 m mesh, every flight hour, periods 3 to 8 from 2 June to 5 September. Colour is mean speed and arrows the mean direction, one per six cells; the red outline is the study perimeter. Speeds are multiplied by the model's flat-ground factor at this mesh, as in the previous figure.](Manuscript_files/figure-docx/fig-wind-periods-1.png){#fig-wind-periods}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Convective lift, the characteristic speed of rising air in the afternoon mixed layer, from the reanalysis heat flux and the ERA5 boundary layer height, over the flight hours 12:00 to 16:59 of 2005 to 2014. (a) The ERA5-Land cells of the 60 by 80 km box, the mean over the flight windows, 1 July to 15 August, before any slope scaling; lakes from the Freshwater Atlas in blue. (b) The site at 30 m, the same mean with each cell scaled by the cube root of its share of the flight-window sun. (c) The mean over the box of each sixteen-day period, one grey line per summer and the mean of the ten summers in black. The red outline is the study perimeter.](Manuscript_files/figure-docx/fig-lift-1.png){#fig-lift}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The terrain wind over the microsite window, the extent of the 1 m lidar, at two meshes, each the mean of the flight-window runs of 10 summers, one run per window at its mean flight-hour condition at 14:00. (a) A 30 m mesh on the 30 m elevation model. (b) A 10 m mesh on the lidar ground model, run as nine tiles whose cores were joined. Colour is mean speed and arrows the mean direction, one every 600 m. Speeds are multiplied by the model's flat-ground factor, 1.62 at 30 m and 1.62 at 10 m. The red outline is the study perimeter.](Manuscript_files/figure-docx/fig-wind-micro-1.png){#fig-wind-micro}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Heat over the flight windows, 1 July to 15 August of 2005 to 2014, at the two scales at which it was measured. (a) ERA5-Land air temperature at 2 m over the 60 by 80 km box, the mean of the flight hours 12:00 to 16:59. (b) Direct radiation over the site in the flight window, computed in SAGA GIS from the 30 m elevation model. (c) Landsat land surface temperature over the site at the late-morning overpass, the median of the clear flight-window scenes of each summer averaged over the summers. (d) Measured surface temperature against modelled radiation over the site, one point per cell of a 2,000-cell sample, with the least-squares line. The red outline is the study perimeter.](Manuscript_files/figure-docx/fig-heat-1.png){#fig-heat}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Back-trajectories of the air over the site at 14:00 on every flight day, 1 July to 15 August of 2005 to 2013, from HYSPLIT on the North American Regional Reanalysis. (a) The hourly endpoints of the first 6 h from 100 m above ground, counted in hexagons, over the Purcell Trench and Kootenay Lake. (b) The 12 h endpoints from 100 m and 500 m above ground. The site is the red cross, lakes from the Freshwater Atlas are blue and the international border is grey.](Manuscript_files/figure-docx/fig-trajectories-1.png){#fig-trajectories}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The afternoon air over the site and the attack it met, flight windows of 1 July to 15 August. (a) The paths of the air over the 12 h before 14:00 on every flight day of 2005 to 2013, from 100 m above the site centre (red cross), by HYSPLIT on the North American Regional Reanalysis, one grey line a day, with the mean path in black; lakes in blue and the international border in grey. (b) The share of the annual maps of 2006 to 2014 on which each 30 m cell was attacked, with ridge and peak cells in black and the WindNinja wind of the flight hours, averaged over 2005 to 2014, as arrows pointing where the air went. (c) The slope updraft of the same wind, the speed at which it was pushed up or down the ground it blew over, red where it rose and blue where it sank, with the same ridges and arrows. (d) The share of cells attacked by the direction the ground faced, with the mean slope updraft above each bar. The red outline is the study perimeter.](Manuscript_files/figure-docx/fig-flight-paths-1.png){#fig-flight-paths}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![The measured afternoon wind along the Purcell Trench and the Creston valley in the flight hours, 12:00 to 16:59 of June to August. Each arrow points where the wind went at one hourly station of the provincial networks, its direction the mean of the hourly directions weighted by the windy hours, and its length the consistency of that direction; black arrows are 2005 to 2014 and the purple arrow is the Darkwoods fire weather station, 2015 to 2025. The thick black line is the mean path of the air over the 12 h before 14:00 on the flight days of 2005 to 2013, from HYSPLIT, ending over the site. Relief from the 150 m Copernicus model, lakes from the Freshwater Atlas in blue and the international border in grey; the red outline is the study perimeter.](Manuscript_files/figure-docx/fig-trench-winds-1.png){#fig-trench-winds}
:::
:::


{{< pagebreak >}}


::: {.cell}
::: {.cell-output-display}
![Vertical air speed from the North American Regional Reanalysis between 850 and 650 hPa at 14:00 and 17:00, positive for rising air. (a) The mean over the flight windows, 1 July to 15 August of 2005 to 2014, at each 32 km cell within 160 km of the site, the red cross; lakes from the Freshwater Atlas in blue. (b) The mean at the cell over the site by sixteen-day period, one grey line per summer and the mean of the ten summers in black.](Manuscript_files/figure-docx/fig-vertical-1.png){#fig-vertical}
:::
:::


{{< pagebreak >}}


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
![The effect of the previous summer's wind on the log-odds of attack, per standard deviation of wind, in stands one standard deviation below and above the mean of basal area, quadratic mean diameter and crown closure, in the sixteen-day models with the previous period's attack, for the station wind and for the terrain wind at 90 m, with 95 per cent confidence intervals.](Manuscript_files/figure-docx/fig-interaction-1.png){#fig-interaction}
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



