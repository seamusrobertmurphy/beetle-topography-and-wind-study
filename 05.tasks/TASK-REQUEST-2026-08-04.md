# Task request, 4 August 2026: after the wind result collapsed

Paste the block at the bottom into a fresh Claude Code session opened in this repository.
Everything above it is context for a human deciding what to ask for.

## What changed on 3 to 4 August

The full pre-submission review ran. Report: `review-remote-sensing-of-environment.md`, and
**read its ADDENDUM first**, which supersedes the rest of it.

The headline is that **the paper's central result is a specification artefact.** The
manuscript entered elevation as one linear term and orthogonalised the wind surface against
that same straight line, while its own descriptive result is that attack is unimodal in
elevation. Entering elevation as a quadratic or a spline, and residualising wind against
that basis, raises the share of the wind surface elevation explains from 0.617 to 0.728 and
collapses the wind coefficient at every severity threshold, with no interval excluding zero.

The check is saved at `05.tasks/scripts/elevation-nonlinearity-check.R` and now also lives
in the manuscript as `tbl-nonlinear` in the new §sec-nonlinear. The linear row reproduces
the published coefficients exactly, so the test is doing what the paper does.

**The manuscript was rewritten to report this**, including the abstract, §sec-krawchuk,
§sec-ordinal, §sec-aspect, the Discussion and the Conclusions. That rewrite has not been
reviewed by the author. It is the first thing that needs doing.

Also settled: RSE's guide for authors is verified and RSE is the wrong venue; the
methodological novelty claim collides with Wiens (1989) and Dungan et al. (2002); the VRI
reference year is 2014, interpreted from August 2014 photography; and five sources were
cited for things they do not say, one for the reverse.

## The decision the next session cannot make for you

**Which venue, and therefore which paper.** Three coherent options:

1. **The specification paper.** Lead with §sec-nonlinear: a downscaled surface residualised
   against a linear terrain term retains that terrain's curvature and will manufacture an
   effect that vanishes under a flexible basis. The beetle study becomes the worked example
   in which the effect appears and then disappears. This is the strongest and most general
   version, it answers the Wiens and Dungan priority problem, and Methods in Ecology and
   Evolution or Ecography would be the targets. It needs the extent sweep over many windows
   to be more than an anecdote.
2. **The refugia paper.** Lead with the host-layer result, which is the most robust thing
   here: without an independent host layer the pine-poor valley is mapped as the largest
   refugium on the mountain. Drop the wind analysis to a negative result. Forest Ecology
   and Management or Landscape Ecology.
3. **Both, split.** Probably two thin papers rather than one good one. Mentioned only so it
   is considered and rejected deliberately.

My recommendation is option 1 with the refugia material retained as the case study.

## The request

```text
Read review-remote-sensing-of-environment.md, starting with its ADDENDUM, then INDEX.md
and 05.tasks/progress.md Phase 10. The manuscript is
01.manuscript/beetle-topography-wind-study.qmd and it is the single source of truth.

Context you need before touching anything: the paper's wind result was shown on 4 August
to be an artefact of entering elevation linearly, the manuscript was rewritten to report
that, and the rewrite has not yet been reviewed by me.

Work in this order and stop after stage 1 to tell me what you found.

1. Audit the 3 to 4 August rewrite. Render the document if it is not current, then read
   the abstract, sec-krawchuk, sec-ordinal, sec-nonlinear, sec-aspect, the Discussion and
   the Conclusions as one piece. Tell me where the paper still asserts a wind effect,
   where it now contradicts itself, and where the retreat is overdone and gives away
   something the data actually supports. Do not fix anything yet.

2. Then, and only after I have answered stage 1:

   a. Recompute tbl-orthogonality on the analysis frame the coefficients are estimated on,
      not the full landscape, and add a column for R squared on slope. On the host-present
      frame heat load's R squared on elevation is 0.119, not the 0.000 the table currently
      shows, and its R squared on slope is 0.167. The table as it stands licenses a claim
      the model frame does not support.

   b. Raise B_BOOT to 2000 and re-render. Expect the light-or-worse threshold to stop
      clearing the interval test. Report every verdict that changes.

   c. Sweep the spatial block size at 20, 40, 80 and 160 cells and report the wind
      coefficient's interval at each. The Methods claim blocks are larger than any
      plausible correlation range of the survey polygons; 16 of the 301 polygons have an
      equivalent-circle diameter over 1 km, so that claim is false as written. Fix the
      Methods to match whatever the sweep shows.

   d. Report, per severity threshold, the number of contributing survey polygons and the
      number of spatial blocks containing an event. The severe threshold is 1,522 cells,
      which against a mean polygon of 26 ha is plausibly a handful of polygons.

   e. Replace the single 2 by 4 km clip in tbl-extent with several hundred windows of
      varying size and position drawn across the landscape, and plot R squared of wind on
      elevation, and the wind coefficient, against window extent. extent_row already does
      the per-window fit. This is what turns the extent claim from an anecdote into a
      result, and it produces the figure the paper most needs.

   f. Add the maps. A study about spatial pattern currently has one figure, a line plot.
      At minimum: study area with survey polygons, VRI pine cover and the clip outline;
      the wind surface beside its residual on a flexible elevation basis.

Rules that govern all of it. The .qmd is the only analysis artefact: if it is not in the
manuscript it is not part of the study, every chunk carries an explicit echo: true, and no
chunk uses echo: false, include: false or eval: false. Never quote a number from code you
did not save into the manuscript. Batch your edits and render once at the end, because the
render is roughly 25 minutes per format and Quarto reads the source at launch. Check that
/Volumes/PortableSSD is mounted before a long render. Run R natively at /usr/local/bin/R
against the global library; do not build an environment.

One specific hazard, because it bit during the last review: if you reconcile a mismatch
between prose and code in any threshold or breakpoint, recompute the affected quantities
and re-read every sentence that cites them. Changing one breakpoint from 1,850 to 1,900 m
inverted the paper's central host-cover claim while the prose still asserted the old
direction, and nothing errored.
```

## Two things to watch that are not analysis

**Chunk visibility.** During the 3 August session, 11 chunks were flipped from
`#| echo: true` to `#| echo: false` in the working tree, with no such change in `HEAD` and
no edit that touched `echo`. This is the same incident logged on 2026-07-22 and reverted in
`f1368b7`. It was restored before rendering. If it recurs, find the cause rather than just
fixing it again.

**Nothing is committed.** The working tree carries the whole review: the rewritten `.qmd`,
both renders, the new bib entries, `elsevier-harvard.csl`, the highlights files, the
verified guidelines note, the diagnostic script and the review report. Decide what to keep
before committing.
