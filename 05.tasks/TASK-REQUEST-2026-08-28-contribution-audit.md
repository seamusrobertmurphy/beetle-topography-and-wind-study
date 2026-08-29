# Task request: contribution and framing audit

**Read this alongside** `TASK-REQUEST-2026-08-28-submission-audit.md`, which covers journal
compliance, statistics, prose mechanics and citations. This file covers what that one does
not: **whether the claims are worth making at all.**

A manuscript can pass every item in that rubric and still be rejected on the first page,
because compliance is not contribution. This audit exists because that happened here.

---

## 1. The fault this audit exists to catch

On 2026-08-28 the manuscript, its abstract and its cover letter all led with this claim:

> A wind test aggregated to the year answers a different question from the one the mechanism
> poses, and answers it wrongly. A test that aggregates the response to a year is not a
> weaker version of the right test; it is a different question.

Seamus's response, and he was right: **everybody already knows a single annual image cannot
resolve a within-season process.** It is a premise of the study design, not a finding. The
paper had built its stated contribution on something no reader needed telling, and the cover
letter told the editor so in its own words: "The finding I expect to be most useful to your
readers is the negative one attached to it."

This survived a full audit of compliance, statistics, prose and citations, because none of
those rubrics asks whether a true, well-supported, correctly-reported claim is *interesting*.

**A claim can be true, significant, correctly computed, cleanly written, and still worthless.**
That is the only thing this audit is looking for.

---

## 2. The test

For every claim the manuscript presents as a contribution, in the abstract, the final
paragraph of the Introduction, the Discussion openings, the Conclusions and the cover letter,
answer these in writing:

1. **Would a competent reader in this field already believe this before reading?** If yes,
   it is a premise. Premises belong in the Methods as a design justification, in one
   sentence, never in the abstract as a result.
2. **Could the opposite result have been published?** If a finding of "annual data works
   fine" would never have been written up, then finding that it does not work is not news.
3. **What does a reader do differently because of this?** If the answer is nothing, or
   "design their study the way everyone already designs it", cut it.
4. **Does the claim rest on a significant coefficient?** A claim built on p > 0.05 is not a
   finding. See section 4.
5. **Is the claim about the concept, or only about this study area?** Claims that travel are
   worth more than claims that do not, but only if they are also non-obvious.

Any claim failing 1, 2 or 3 is demoted out of the abstract and the Conclusions. Say where it
should go instead.

---

## 3. What this study actually has

Audit against this, and disagree in writing if you think it is wrong. Do not simply accept it.

**The framework does not transfer.** Disturbance refugia as a concept was built on wildfire,
where refugia are mapped from terrain: sheltered draws, north aspects, rock. Krawchuk et al.
(2020) carried the framework to beetle. This study is the first spatial test of that transfer
and it fails in two specific ways.

**Wind has no main effect.** There is no windy place that is a refugium. Wind changes what
stand density is worth, and nothing else. So a beetle refugium is a conjunction, thin stand
AND wind, in the weeks the insect flies, not a location. That is a claim about what the thing
IS, and it says a manager cannot map beetle refugia the way they map fire refugia.

**Shading fails backwards.** The most intuitive mechanism, cool ground protects trees, does
not merely fail to reach significance. Shaded ground carries MORE attack. The most
transferable-looking piece of the fire framework fails hardest.

**Two measurement traps that are genuinely not obvious.** A terrain wind index is partly
insolation, because windward slopes take afternoon sun on most ranges. And inventory vintage
governs what can be detected at all: holding stand structure at its current projection, which
is routine practice, halves the interaction and leaves basal area at chance, 0.517 against
0.602.

**The honest weakness.** The interaction is −0.049 per standard deviation. That is
defensible but small, and a claim about what a refugium IS is a large claim to rest on it.
Judge whether the manuscript acknowledges this proportionately or oversells.

---

## 4. Claims resting on non-significant results

The abstract previously said the annual model gave "the opposite sign" from a coefficient of
+0.031 at p = 0.087. **A coefficient not distinguishable from zero has no sign to report.**

Check every claim in the package for this failure mode:

- [ ] Every directional word (higher, lower, reversed, opposite, reduced, increased) attaches
      to a coefficient whose p-value supports a direction.
- [ ] Non-significant results are reported as "not distinguishable from zero" or "detected
      no effect", never as an effect in a direction.
- [ ] No claim of a reversal, contrast or difference rests on two coefficients where one is
      non-significant.
- [ ] Where a null result is genuinely informative, the manuscript says why it is informative
      rather than asserting that it is.

---

## 5. Language that signals the fault

Search the package for these. Each is a place where the manuscript may be announcing
significance rather than demonstrating it.

- "the lesson generalises", "travels further", "the more transferable", "beyond this dataset"
- "the methodological finding", "the key insight", "importantly", "crucially", "notably" when
  attached to a claim rather than a transition
- "is not a weaker version of", "answers a different question", "answers it wrongly"
- any sentence explaining why a result matters instead of stating what it is

Present tense in the Discussion, "this shows", is weaker than the finding itself. Prefer the
result stated plainly and the consequence left to the reader where the consequence is obvious.

---

## 6. Files

All under
`/Volumes/PortableSSD/Github/claude-science-library/publications-academic/beetle-topography-and-wind-study/`.

- `01.manuscript/beetle-topography-wind-study-vri-timeseries.qmd` the submission
- `01.manuscript/submission-jae/cover-letter.qmd` read this first; it states the claim to an editor
- `01.manuscript/submission-jae/package/` the six assembled files
- `01.manuscript/beetle-topography-wind-study-short-short.qmd` the Frontiers version, same faults likely
- `04.references/literature/Krawchuk 2020 Disturbance refugia within mosaics of forest fire, drought, and insect.pdf` the hypothesis under test
- `/Volumes/PortableSSD/Github/scientific-library/library/pdf/Murphy et al 2026 Spatial Patterns of Confier Regeneration Following Mixed Severity Fire and MPB Outbreaks in Selkirk Mountains.pdf` the companion study and the style to match

---

## 7. Correction protocol

Section 6 of the compliance task request governs how fixes are applied and still does. Two
additions specific to this audit:

**Reframing is Class C.** Changing what a paper claims to have found is Seamus's decision,
not the auditor's. Write the finding, name what the claim should be instead, show the
evidence for that alternative, and stop. Do not rewrite the abstract on your own judgement.

**Cutting is cheap; inventing is not.** Removing an overclaim needs no permission beyond the
protocol. Substituting a new headline claim does. If a section has nothing worth saying after
the overclaim is removed, say so rather than filling the space.

---

## 8. What a finished audit looks like

A ranked list of claims, each with: where it appears, whether it survives the five-question
test in section 2, and if it fails, which question it failed and where the claim should go
instead. Then the same for section 4, every directional claim checked against its p-value.

Do not report a pass on a manuscript whose stated contribution is something the field already
assumes.
