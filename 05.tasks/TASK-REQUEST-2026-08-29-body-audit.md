# Task request: carry the abstract's corrections through the body

**Read first:** `TASK-REQUEST-2026-08-28-contribution-audit.md` for the framing test and
`TASK-REQUEST-2026-08-28-submission-audit.md` section 6 for the correction protocol. This
file is narrower. It exists because four faults were found and fixed **in the abstract only**
on 2026-08-28, and the same faults remain in the body of the main document.

**File:** `01.manuscript/beetle-topography-wind-study-vri-timeseries.qmd`
**Rendered:** `01.manuscript/submission-jae/package/02 Main Document.docx`
**Scope:** everything from `# Introduction` to `# Acknowledgements`. The abstract is done.

---

## 1. The four faults, with the abstract's corrections as the model

### Fault A. A premise presented as a finding

The abstract claimed that a wind test aggregated to the year "answers a different question
and answers it wrongly", framed as the paper's transferable contribution. Nobody in this
field needs telling that one image a year cannot resolve a within-season process. It is a
design premise. It was cut from the abstract and demoted to a one-sentence design
justification.

**Confirmed still in the body, two sites:**

1. Discussion, `## Radiation, not wind`, opens: *"The clearest result of this study is
   methodological, and it changes what a terrain variable in this literature is allowed to be
   taken for."* This elevates a measurement caution to the study's headline result. The
   section title itself, "Radiation, not wind", frames a covariate-selection outcome as the
   finding.
2. `## The wind claim`: *"nothing in it establishes the resolution at which one should be
   fitted; this study's answer is that it must be at least as fine as the flight period."*

Both need demoting. State the constraint once, in Methods, as why the 16-day response was
used. Do not present it as a result.

### Fault B. A direction claimed from a null result

The abstract said the annual model "gave the opposite sign" from a coefficient of +0.031 at
p = 0.087. A coefficient not distinguishable from zero has no direction to report.

**Confirmed still in the body, one site, and it is the worst instance:**

> *"Ruggedness takes the opposite sign to the parent study's, whose response is seedling
> establishment rather than attack."*

Terrain ruggedness index in the year-matched model is **−0.005, SE 0.025, z −0.19,
p = 0.848**. It is indistinguishable from zero. The manuscript is claiming a sign, and then
contrasting that sign against the companion paper, on a coefficient that has none. Two
sentences later the same paragraph correctly says ruggedness is "not distinguishable from
zero", so the document contradicts itself within a paragraph.

Note also that the vector ruggedness measure IS significant, −0.052, p = 0.013, so a claim
about ruggedness may be recoverable from that term. That is a Class C decision.

**Check every directional word in the body** against the p-value of the coefficient it
describes: higher, lower, reduced, increased, reversed, opposite, agrees, disagrees, carries
more, carries less.

### Fault C. An unsupported claim about another literature

The abstract asserted that fire refugia "are predicted by terrain variables without an
interaction term" and "can be mapped from terrain alone". Both are wrong. Krawchuk et al.
2016 (doi 10.1002/ecs2.1632) tests "how predictability of fire refugia varies according to
topographic complexity **and fire weather conditions**", and Krawchuk et al. 2020 CJFR
(doi 10.1139/cjfr-2019-0406) finds refugia "exhibited higher predictability under relatively
moderate fire weather conditions". Terrain effects are conditional on weather in both
literatures. The claim was written from memory about papers never opened, and was removed
from the abstract and cover letter.

**Search the body for any characterisation of another study's methods or findings that is
not supported by a quotation from that study.** The project rule is that a load-bearing
claim about a paper requires the paper to be opened. This manuscript compares itself to
`murphy2026`, `cartwright2018`, `krawchuk2020` and `powell2014`; verify each characterisation
against the source PDF in `04.references/literature/`.

### Fault D. An effect described as absent when it is present

The abstract said "wind had no main effect". It is **+0.022**. Small and positive, meaning
windier ground carried slightly more attack. The abstract now says that plainly.

**Check the body** for any statement that a term has no effect, does not matter, or carries
nothing, and confirm against the coefficient. "Crown closure carries nothing" appeared in an
earlier draft while the table showed −0.183 at p < 0.001.

---

## 2. Also check, same class

- [ ] Rhetorical constructions of the form "not X but Y", which were removed from the
      abstract. They assert rather than report.
- [ ] Section headings that frame rather than describe. "Radiation, not wind" is an argument;
      "Terrain and radiation" is a heading.
- [ ] Sentences explaining why a result matters instead of stating what it is.
- [ ] Any sentence that would survive unchanged in a paper about a different study area. That
      is a sign it carries no content.

---

## 3. Numbers current as of 2026-08-29

Year-matched models. Anything in the body disagreeing with these is a finding.

| Term | Value |
|---|---|
| Stem density x wind, 16-day | -0.049, p < 0.001 |
| Standing volume x wind, 16-day | -0.017, p < 0.05 |
| Wind main effect, 16-day | +0.022 |
| Stand basal area, annual M3 | +0.504 |
| Terrain ruggedness index, annual M3 | **-0.005, p = 0.848, not significant** |
| Vector ruggedness measure, annual M3 | -0.052, p = 0.013 |
| Density x exposure, with and without radiation | -0.040 and -0.068 |
| Attack peak, 25-30 cm class | 39.7 per cent |
| Basal area univariate AUC, year-matched vs static | 0.602 vs 0.517 |

Standing volume does **not** survive selection into the annual model. Any body text quoting
an annual standing-volume coefficient is stale. The epoch models do include it; those are
fine.

---

## 4. Budget

Abstract 260 of 300. Body **5,932 of 6,000**. There are 68 words of headroom. Cuts are
welcome; additions must be paid for.

---

## 5. Protocol

Section 6 of the compliance task request governs. In short: Fault B and D corrections are
Class A, fix them. Fault A demotions and Fault C removals are Class B, fix and flag. Anything
that changes what the paper claims to have found is Class C, write it up and stop.

Delete `01.manuscript/*_cache/` before any render whose result will be believed. Render one
format at a time. Rebuild with `05.tasks/scripts/build-submission-jae.py`.

Do not report a pass while `PLACEHOLDER-DRYAD-DOI` appears in any file.
