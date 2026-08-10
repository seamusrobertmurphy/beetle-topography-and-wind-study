# Cover letter, Forest Science

*Submission portal: https://www.editorialmanager.com/frsc. Article type: Original Article.
Confirm the Editor-in-Chief's name on the journal's editorial board page before sending;
it is deliberately left as a placeholder below rather than guessed.*

---

Seamus Murphy
ORCID 0000-0002-1792-0351
seamusrobertmurphy@gmail.com

[DATE]

[EDITOR NAME]
Editor-in-Chief, *Forest Science*
Society of American Foresters

Dear [EDITOR NAME],

I am submitting "Testing the wind disruption hypothesis for beetle refugia" for
consideration as an Original Article in *Forest Science*.

Disturbance refugia have become an organising concept for forest conservation under a
changing climate, and the concept now shapes where agencies place surveys, salvage and
retention. This paper reports a failure mode in how refugia are identified that is simple,
general, and easy to reproduce without noticing. On a 168 km² landscape in the Selkirk
Mountains of British Columbia, mountain pine beetle attack is strongly unimodal in
elevation. A refugia mapping exercise without an independent host layer would identify the
valley bottom as the largest, most spatially coherent and most topographically predictable
refugium on the mountain. It is not a refugium. It is a place with almost no pine.
Conditioning on host presence raises attack in the lowest elevation band from near zero to
within the range observed at mid elevations. Any refugium claim made without a host or
habitat layer is, on this evidence, not interpretable.

The second contribution is what makes the first credible. We set out to test a specific
mechanism proposed in the refugia literature, that thinner stands admit more wind and so
disrupt the pheromone communication on which mass attack depends. Entered alongside a
linear elevation term, the component of a downscaled wind surface orthogonal to elevation
is the strongest negative predictor in host-bearing stands and clears our interval test at
every severity threshold above trace. That result does not survive its own specification.
Because the response is unimodal in elevation, residualising wind against a straight line
leaves the curvature of elevation inside the wind term. Entering elevation as a quadratic
or a spline and residualising against the same basis raises the share of the wind surface
that elevation explains and collapses the coefficient at every threshold, with no interval
excluding zero. The apparent wind signal is an artefact of how elevation was specified.

We report this because the same construction is now widespread. Gridded climate products
are produced by draping coarse fields over a digital elevation model, so a fine-resolution
climate surface offered to a model alongside elevation is not an independent measurement.
The severity of the problem depends on analysis extent: across our landscape elevation
explains 0.63 of the variance in the wind surface, but 0.80 inside a 2 by 4 km clip, which
is the extent at which most operational disturbance work is done. Coarsening the grain from
25 m to 100 m barely moves it. Extent matters and grain does not, which is the reverse of
where most attention goes.

The work uses data any North American forest agency already holds: a provincial aerial
overview survey of beetle-caused mortality from 1999 to 2015, operational forest inventory
host cover, and a freely available global wind product. The three diagnostics we ask for,
regressing a climate surface on elevation, repeating that diagnostic at more than one
extent, and interpreting only the orthogonalised coefficient, require no new data and can
be run before any model is fitted.

The manuscript is executable. Every analysis stage is an R code chunk inside the document,
so rendering it reruns the pipeline and regenerates every table and number in the text.
This is a single landscape, and we do not claim otherwise. What we claim is that the
failure mode is general even though the study site is one.

The manuscript is original, is not under consideration elsewhere, and has not been
published previously. A companion study on the same ground, which supplied the terrain
surfaces used here, is published as Murphy et al. (2026) in *Forest Ecology and Management*
618:123985; that paper predicts conifer regeneration and treats disturbance as a predictor,
whereas here disturbance is the response. There are no competing interests to declare and
the work received no external funding.

Thank you for considering it.

Yours sincerely,

Seamus Murphy
