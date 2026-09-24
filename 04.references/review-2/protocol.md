# Review protocol, second review

Written 2026-09-24, before any query ran, for `beetle-topography-and-wind-study`. Follows
`library-science/protocols/literature-review.md` except where the section Departures says
otherwise. Frozen by the commit that adds it. Nothing above "Deviations" is edited after
that commit. The first review, `04.references/review/protocol.md`, frozen in commit
d100742, is left as it stands and is not amended by this one.

## Purpose

Seamus asked on 2026-09-24 for a wider and deeper survey, in these words.

> i need to expand our literature survey wider and deeper analysis of the research body
> that is published on topic of beetle outbreak movements, seasonal biology and mass
> attach dynamics, and regional lansdcape scale and microscale patterns of beetle
> movement and infestation in response to topographic gradients and geomorphology. A
> second major component of this literature review scope is the study of beetle-tree
> biochemical defenses and engagement dynamics, such as which conditions favour beetles
> and which favour trees at individual and population lewvels.

He ruled the same day that it is a second review with its own protocol, that its first
purpose is a corpus of checked source notes and a synthesis in `library-science`, with
what enters the AFE manuscript chosen later, and that it runs at the store's floor with a
cap on full-text reading rather than as a full scoping review.

## Questions

Component A covers outbreak movement, seasonal biology, mass attack and terrain.
Component B covers host defence and the conditions that favour beetle or tree.

1. Seasonal biology. What has prior work established about the life cycle, development
   rate, voltinism, emergence and flight timing of mountain pine beetle, and the
   temperatures that govern them? Population mountain pine beetle, concept phenology and
   seasonal development, context field and laboratory studies and phenology models.
2. Mass attack. What has prior work established about how mass attack proceeds, through
   aggregation and anti-aggregation pheromones, attack density and the switch from
   endemic to epidemic behaviour? Population mountain pine beetle, concept mass attack
   and aggregation, context tree, stand and population studies.
3. Outbreak movement. What has prior work established about how outbreaks spread and
   move across stands, landscapes and regions, including dispersal distance, spatial
   synchrony and range expansion? Population mountain pine beetle, concept spread and
   dispersal, context landscape and regional studies.
4. Terrain and microsite. What has prior work established about how infestation responds
   to elevation, aspect, slope, landform and geomorphology, at landscape and at microsite
   scale, including microclimate? Population mountain pine beetle, concept terrain and
   microclimate, context landscape models and site studies.
5. Host defence. What has prior work established about the constitutive and induced
   defences of pines against mountain pine beetle and its fungal associates, resin flow,
   monoterpenes and other defence chemistry? Population mountain pine beetle and its
   pine hosts, concept host defence chemistry, context tree and stand studies.
6. Beetle against tree. What has prior work established about the conditions that favour
   the beetle over the tree, and the tree over the beetle, at the level of the tree and
   of the population, including tree vigour, size, drought, stand density and the
   population threshold at which defence is overwhelmed? Population mountain pine beetle
   and its hosts, concept host susceptibility and resistance, context tree and population
   studies.

## Adjudication

Each rule states in advance what finding would change a claim in
`01.manuscript/Manuscript.qmd` as it stood on 2026-09-24.

1. If prior work places peak flight inside the sixteen-day windows the manuscript used
   for wind, the flight-window choice is stated as following that record. If it places
   flight outside them, the windows are reported as a limitation and the size of the
   mismatch given.
2. If mass-attack studies report that aggregation depends on pheromone plume
   concentration near the bole, the density by wind interaction is read as consistent
   with them. If they report that attack density is set by host defence alone, with
   pheromones secondary, the plume reading is stated as one of two explanations.
3. If spread studies report that previous-year attack within a short radius predicts
   current attack more strongly than terrain, the manuscript's terrain coefficients are
   stated as what remains after that term, with the radius compared by name.
4. If terrain studies report attack concentrated on warm aspects or low elevations for
   reasons of beetle development rather than of wind, the shelter reading is stated
   alongside that alternative and the Discussion says which the design can separate.
5. If defence studies report that resin flow or monoterpene composition varies with
   aspect, elevation or stand density, host defence is named as a pathway by which
   terrain can act on attack without wind, and the Discussion says so.
6. If studies report that defence is overwhelmed above a population threshold whatever
   the site, the terrain and wind effects are stated as bearing on the endemic and
   incipient phases and not on the epidemic peak, unless the manuscript's own years show
   otherwise.

## Criteria

1. Document types. Peer-reviewed articles, reviews and book chapters, conference
   proceedings, theses where they are the primary source of a measurement, and
   government or agency reports where they are the primary source of a method,
   threshold, data product or field trial.
2. Published in any year indexed by the sources, with no lower bound, as in the first
   review, because the defence and phenology work begins in the 1960s.
3. Languages. English.
4. Bears on at least one question, meaning it concerns mountain pine beetle, or its pine
   hosts under attack by it, and at least one concept named in the questions.
5. Records already decided in `02.inputs/derived/review-records.csv` keep their first
   decision and are marked `first-review` in the routes column, so no work is screened
   twice.

Exclusions use the codes in the store protocol. No extra code is added.

## Sources

1. `library-science`, searched with the `review2-store` chunk.
2. Semantic Scholar bulk search, with the `review2-semantic-scholar` chunk, cap 5,000 per
   query.
3. Crossref, with the `review2-crossref` chunk, as the independent strand, by the same
   title-ranked method the first review settled on in its Deviation 1.
4. One round of backward and forward citation chasing from eight seeds, each resolved at
   Crossref on 2026-09-24. For component A, Aukema et al. 2006,
   10.1111/j.2006.0906-7590.04445.x, Logan and Powell 2001, 10.1093/ae/47.3.160, Bentz
   et al. 2010, 10.1525/bio.2010.60.8.6, and Safranyik et al. 2010, 10.4039/n08-CPA01.
   For component B, Raffa and Berryman 1983, 10.2307/1942586, Boone et al. 2011,
   10.1139/x11-041, Raffa et al. 2008, 10.1641/B580607, and Erbilgin et al. 2014, issued online 2013,
   10.1111/nph.12573.

The chunks are in `01.manuscript/_sections/_review-2.qmd`, which the master includes
after the first review's chunks. Every file they write is prefixed `review2-` in
`02.inputs/derived/`.

## Reading cap

Every included record is screened on title, and on abstract where one is returned. Full
texts are read for at most the 40 most cited included records in each component, ranked
by the Semantic Scholar citation count, together with every record a synthesis sentence
rests on that is not among them. Each full text read gets a source note in
`library-science/sources/`, every quotation checked with `check-quotes.py --control`. The
rest of the included records are cited in the synthesis from their abstracts, marked
`full_text` no, as in the first review.

## Departures

1. Search terms. The store protocol admits terms only from the manuscript's title,
   subtitle and keywords. This review is not written against the manuscript's objectives,
   so its terms are drawn from Seamus's request of 2026-09-24, quoted above, and from the
   field's own words for the concepts it names, and are listed in
   `04.references/review-2/search-terms.csv` with a `source` column saying which. The
   `review2-queries` chunk checks that every selected term is listed there, not that it
   appears in the front matter.
2. Escalation. The store protocol sends a review with more than 300 included records to
   the `scoping-review` skill. Seamus chose the capped floor on 2026-09-24 knowing the
   host defence literature alone would pass that number, so the reading cap above stands
   in place of escalation.
3. Objectives. The store protocol writes one question per research objective. These six
   questions come from the request, not from the manuscript's objectives, and the
   adjudication rules tie each back to a named claim in the manuscript.

## Deviations
