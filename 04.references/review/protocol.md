# Review protocol

Written 2026-09-23, before any query ran, for `beetle-topography-and-wind-study`. Follows
`library-science/protocols/literature-review.md`. Frozen by the commit that adds it.
Nothing above "Deviations" is edited after that commit.

The review is run for the resubmission of AFE(2026)5804 to Agricultural and Forest
Entomology, which was returned on 2026-09-22 because the Introduction and Discussion were
"not well supported or linked to the (admittedly vast) literature on MPB" and because the
novelty had to be "explicitly stated". Seamus asked on 2026-09-23 for the search to run
over a wider timeline and a larger number of publications than the store's default, so
the criteria below set no lower year bound and the caps are raised.

## Objectives

Copied verbatim from the closing paragraph of the Introduction of `01.manuscript/Manuscript.qmd`
as it stood on 2026-09-23.

The study addressed three questions. Do the three mechanisms Krawchuk et al. (2020)
named, stand density, topographic shading and the scarcity of large hosts, predict
moderate-to-high disturbance once host, terrain and previous attack are in the model?
Does wind act on attack through stand density, which is the form plume disruption takes,
and only where wind varies in time? Does terrain shelter act as a main effect, which is
what deposition of wind-borne beetles predicts, or only through stand density, which is
what plume disruption predicts?

## Questions

1. What has prior work established about stand density, topographic shading or aspect,
   and host size as predictors of where mountain pine beetle attack falls across a
   landscape, and about refugia from the outbreak? Population mountain pine beetle,
   concept refugia, terrain and stand density as landscape predictors of attack, context
   outbreak landscapes in western North America.
2. What has prior work established about wind acting on attack through stand density,
   whether by thinning, stand microclimate or pheromone plume dispersion, and at what
   timescale wind was measured? Population mountain pine beetle, concept wind and
   thinning, context stand and landscape studies of attack.
3. What has prior work established about terrain, topography and landing in the beetle's
   dispersal, including elevation and aspect as predictors and where dispersing beetles
   come down? Population mountain pine beetle, concept terrain, topography, dispersal and
   flight, context landscape studies and dispersal experiments.
4. Novelty. Has a prior landscape study of this beetle entered a terrain-resolved wind
   field with stand density so that a terrain main effect could be told apart from a
   density by wind interaction, or measured wind below the canopy at the timescale of
   flight? Population mountain pine beetle, concept wind with terrain or stand density in
   one model, context landscape models of attack.

## Adjudication

1. If prior landscape models report elevation, aspect or stand density coefficients on
   attack, the Introduction states those directions as the expectation and the Discussion
   compares this study's coefficients with them by name; if a prior study found the
   shading prediction reversed, as Kaiser et al. (2012) is believed to, the shading verdict
   is reported as a replication of that finding rather than as a new result.
2. If field or plume studies report that thinning reduced attack through microclimate or
   plume dispersion, the density by wind interaction is read as consistent with that
   literature and its size compared with theirs; if they report no such effect, the
   Discussion says the interaction stands against them and states the difference in
   design.
3. If dispersal studies report deposition on windward faces rather than in the lee, the
   Landing zones reading is stated as the opposite of that record and the difference is
   discussed; if they report settlement where wind slows, the reading is a replication.
4. If any study is found that entered a terrain-resolved wind field with stand density
   in a landscape model of attack, or measured wind at the flight timescale below the
   canopy, the novelty statement is cut to what remains and that study is cited as the
   precedent; the "no prior study" form of the statement is written only if no such
   study is found in the full text of every candidate.

## Criteria

1. Document types. Peer-reviewed articles, reviews and book chapters, conference
   proceedings, and government or agency reports where they are the primary source of a
   method, threshold, data product or field trial, such as Canadian Forest Service and
   USDA Forest Service research papers.
2. Published in any year indexed by the sources, with no lower bound, because the flight
   thresholds date from 1971, the elevation result from 1973 and the stand density trials
   from the 1980s, and Seamus asked for the widest timeline.
3. Languages. English.
4. Bears on at least one question, meaning it concerns mountain pine beetle and at least
   one of refugia, terrain or topography or elevation or aspect, stand density or thinning,
   wind, dispersal or flight, as a predictor or a mechanism of attack.

Exclusions use the codes in the protocol. No extra code is added.

## Sources

1. `library-science`, searched with the `review-store` chunk.
2. Semantic Scholar bulk search, with the `review-semantic-scholar` chunk, cap 5,000 per
   query.
3. Crossref, with the `review-crossref` chunk, as the third strand, because OpenAlex
   refused every request on 2026-09-23 with a 503 and Semantic Scholar refused unkeyed
   requests with a 429 for part of the day, so a strand that answers is needed to show a
   gap in the second one. Crossref matches titles and metadata only, so its hits are
   filtered locally by the concept terms in the title.
4. Grey literature by hand from the Canadian Forest Service and USDA Forest Service
   report series, in particular Bartos and Amman (1989), Whitehead and Russo (2005) and
   Safranyik, Shrimpton and Whitney (1975), added to the records with route `grey`.

Search terms are selected in `04.references/review/search-terms.csv`, from candidates the
`review-terms` chunk drew from the manuscript's title, subtitle and keywords, and committed
with this file. The queries are built from that selection by the `review-queries` chunk in
`01.manuscript/_sections/_review.qmd`, which the master includes. Three keywords were
added to the manuscript for the search, thinning, dispersal and topography, because the
protocol admits a term only from the front matter and the journal allows up to ten
keywords.

## Deviations

1. 2026-09-23. The Crossref strand as first written sent every concept word as one bibliographic query with cursor paging, and the cursor returned records unsorted, so the top 2,000 held none with the beetle in the title and all four queries retrieved zero. Rewritten to send the population terms as a title query ranked by relevance with offset paging, then filter by concept in the title. The four zero rows were removed from the search log before the strand reran.
2. 2026-09-23. Ten works from the candidate scan made before the protocol was written, each resolved at Crossref that day, were not retrieved by any strand or by the chase, because their titles carry none of the selected terms. They were added to the screening table by hand with route `hand` and decision include, so that the table shows every record the review rests on. They are Waring and Pitman 1985, Thistle et al. 2004, Schmid et al. 1992, Hicke and Jenkins 2008, Assal et al. 2014, Six et al. 2018, Trzcinski and Reid 2009, Smith et al. 2010, Bone et al. 2005 and Byers 2000. Byers 2000 has a source note in the store already.
3. 2026-09-23. The screening was done by the agent reading every title, because the loop ran unattended, and abstracts were available for only 47 of the included records. Seamus is to spot-check the decisions before the Methods sentence describes the review.
