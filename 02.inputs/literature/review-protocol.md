# Review protocol

Search run 2026-08-19 against the central store at `Github/scientific-library`, which held 579
distinct papers at that date, 380 of them with a CrossRef-verified bibliography entry. The store's
own build is documented in its `CONVENTIONS.md`.

## Objectives screened against

The review is written against this manuscript's four research objectives and is not a general survey
of the species.

1. Does terrain condition beetle-caused mortality once host abundance is accounted for?
2. Does that result survive coding host as stem diameter rather than as cover?
3. Does the component of a wind surface independent of elevation predict reduced attack?
4. How far does the answer to 3 depend on extent, grain and response coding?

## Stage 1, topic

Every record in the store was matched on title and filename against `beetle`, `dendroctonus`, `mpb`,
`ips typographus`, `scolytin` and `refugi`. This returned 69 candidates.

## Stage 2, inclusion

A study is included if it models bark-beetle-caused tree mortality spatially against terrain,
landscape or climate predictors. Only such studies can speak to objectives 1, 3 and 4. Eleven
studies qualified. The recorded exclusion reasons are: not a bark beetle of conifer boles; mechanism
or physiology rather than a spatial model of attack; post-disturbance response with attack not the
response variable; a detection method with terrain absent from the model; a range or spread
projection rather than within-landscape attack; and review, report or management document.

Excluded studies are not discarded. Mechanism and physiology papers carry the life history the
Introduction rests on, and detection papers carry the error properties of the response, so both are
cited there. They are excluded from the review's counts because they cannot answer the objectives.

## Stage 3, attribute extraction

All eleven included studies were read in full text rather than by abstract, because the review's
central claim is an absence and an absence established from titles is not evidence.
`build-review-screening.py` extracts the attributes at build time and writes `review-screening.csv`,
which the manuscript reads at render time. No count in the review is typed into prose.

**Wind.** Every occurrence of the string `wind`, excluding `window`, `winds` and `windthrow`, was
read in context by hand in each of the eleven. The findings by study:

- `wulder2006estimating`, `maciasfauria2009large`, `chen2013spatiotempor`, `walter2013multi`,
  `meddens2014spatial`: no occurrence anywhere in the text.
- `haukema2008movement`: one occurrence, a reference-list entry for Jackson et al. 2005,
  "Modeling beetle movement by wind". Not a predictor.
- `chen2011mountain`: two occurrences, one describing long-distance dispersal in convective updrafts
  in the introduction, one a reference-list entry. Not a predictor.
- Zabihi 2021: one occurrence, a reference-list entry for Chandler 1960 on wind and urban
  temperatures, unrelated to the study. Not a predictor.
- `cartwright2018landscape`: three occurrences, all in the discussion. The predictor set is slope,
  topographic position index, heat load index, compound topographic index and soil bulk density at
  two depths. Wind is invoked as the mechanism explaining an observed thinner-stand association and
  is not measured. Verified against the variable table and the results table.
- `krawchuk2020disturbance`: five occurrences. A conceptual framework paper that states the
  hypothesis; it fits no model.
- `murphy2026spatial`: thirty-five occurrences, and the only included study in which a wind surface
  enters the model. It is by the present author, on the same landscape, and its response is conifer
  regeneration rather than beetle attack.

**Host.** The screening table's `host_terms_present` column records whether host vocabulary occurs
anywhere in the text, reference list included. It is a search facet and is deliberately named for
what it measures. Whether a study *conditioned* its model on host abundance cannot be established by
string search and is not claimed from that column.

## Limits of this review

The corpus is one personal library, not a systematic search of an abstracting database. It is
therefore a review of what was read, made checkable, rather than a claim about the complete
literature. A study that entered a wind predictor and is absent from the store would not have been
found. The absence claim is stated with that scope attached wherever the manuscript makes it.
