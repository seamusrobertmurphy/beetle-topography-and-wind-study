# Remote Sensing of Environment: guidelines verification

Date of retrieval: 2026-07-31. Verifier: subagent, item 4 of TASK-REQUEST-2026-07-31.

**Headline: the journal-specific Guide for Authors could not be retrieved.** Every route to it
terminates on `www.sciencedirect.com`, which served HTTP 403 and a Cloudflare bot challenge on
every attempt in this session. Everything below is split into what was retrieved first-hand from a
live publisher page today, and what remains unverified. Nothing in the second category should be
treated as a requirement.

---

## 1. What is verified, and from where

All of the following were fetched directly from `elsevier.com` on 2026-07-31 in this session.
These are Elsevier-wide policies and they bind every Elsevier journal, RSE included. They do not
tell us anything journal-specific.

### 1.1 Declaration of generative AI in the writing process

Source: `https://www.elsevier.com/about/policies-and-standards/the-use-of-generative-ai-and-ai-assisted-technologies-in-writing-for-elsevier`

Section title required: "Declaration of Generative AI and AI-assisted technologies in the writing
process". Placement: "at the end of the manuscript, immediately above the references".

Suggested wording, quoted from the page: "During the preparation of this work the author(s) used
[NAME TOOL / SERVICE] in order to [REASON]. After using this tool/service, the author(s) reviewed
and edited the content as needed and take(s) full responsibility for the content of the
publication."

The page also states that AI tools "must never be used as a substitute for human critical thinking,
expertise and evaluation", warns that "AI-generated references can be incorrect or fabricated", and
prohibits "the use of generative AI or AI-assisted tools to create or alter images in submitted
manuscripts" except where such use is itself part of the research method and is described in
detail.

### 1.2 CRediT author contribution statement

Source: `https://www.elsevier.com/researcher/author/policies-and-guidelines/credit-author-statement`

Quoted: "CRediT statements should be provided during the submission process and will appear above
the acknowledgment section of the published paper." Also: "The role(s) of all authors should be
listed, using the relevant above categories."

Fourteen roles: Conceptualization, Methodology, Software, Validation, Formal analysis,
Investigation, Resources, Data Curation, Writing - Original Draft, Writing - Review & Editing,
Visualization, Supervision, Project administration, Funding acquisition. The corresponding author
must verify accuracy and obtain agreement from all co-authors.

### 1.3 Reference formatting at submission ("Your Paper Your Way")

Source: `https://www.elsevier.com/subject/next/guide-for-authors`

Quoted: "There are no strict requirements on reference formatting at submission. References can be
in any style or format as long as the style is consistent." Required elements, quoted: "Where
applicable, author(s) name(s), journal title/book title, chapter title/article title, year of
publication, volume number/book chapter and the article number or pagination must be present."

And: "The reference style used by the journals will be applied to the accepted article by Elsevier
at the proof stage."

This is the single most useful verified finding for this manuscript. It means the current
`apa.csl` is not a blocker at initial submission, provided it is applied consistently. It is
still worth switching, for the reason given in section 5.

Caveat: this is the generic Elsevier landing text. Individual journals may impose a stricter
requirement in their own guide. RSE's own guide is unread, so this cannot be confirmed for RSE.

### 1.4 Highlights

Source: `https://www.elsevier.com/researcher/author/tools-and-resources/highlights`

Quoted: "Highlights are three to five (three to four for Cell Press articles) bullet points". "Each
Highlight can be no more than 85 characters, including spaces." Submission format, quoted: "Must be
provided as a Word document" and select "Highlights" from the drop-down list when uploading files.

On whether they are mandatory, the page states they are "Not part of editorial consideration and
not required until the final files stage". Whether RSE additionally mandates them at first
submission is unverified.

### 1.5 Artwork

Source: `https://www.elsevier.com/about/policies-and-standards/author/artwork-and-media-instructions/artwork-faq`
and `.../artwork-overview`

Resolution, quoted: "300 dpi for halftones", "1000 dpi for line art", "500 dpi for combinations
(line art and halftone together)".

Formats, quoted: "We prefer your artwork in TIFF or EPS format because these common interchange
formats are readable by a wide number of applications." The overview page lists "EPS, PDF, TIFF or
JPEG formats are used for electronic artwork", and accepts Microsoft Office files.

Neither page states a numeric cap on figures or tables, and neither states a colour charge or a
colour restriction. Both of those are journal-level settings and are unverified for RSE.

### 1.6 Research data

Source: `https://www.elsevier.com/about/policies-and-standards/research-data`

The page supports data availability statements "to enhance transparency" and encourages authors to
"share research data where appropriate and at the earliest opportunity" and to follow "proper data
citation practices". The language throughout is encouragement, not obligation. The page explicitly
defers to journal-specific guidelines for mandatory status, and notes that "expectations and
practices around research data vary between disciplines".

So: whether RSE requires a data availability statement is **unverified**. Treat writing one as
prudent regardless.

### 1.7 Preprints

Source: `https://www.elsevier.com/about/policies-and-standards/sharing`

Quoted: "Authors can share their preprint anywhere at any time". After acceptance, "Authors can
update their preprints on arXiv or RePEc with their accepted manuscript", and Elsevier "encourage[s]
authors to link from the preprint to their formal publication via its Digital Object Identifier
(DOI)". Constraint, quoted: "Preprints should not be added to or enhanced in any way in order to
appear more like, or to substitute for, the final versions of articles".

---

## 2. Requirements table

Status column: VERIFIED means retrieved first-hand from a live publisher page today. UNVERIFIED
means the live page was inaccessible and no first-hand retrieval exists.

| Requirement | Value | Status | Source |
|---|---|---|---|
| Article types | not retrieved | UNVERIFIED | RSE guide blocked |
| Word / page limit, research article | not retrieved | UNVERIFIED | RSE guide blocked |
| Abstract word limit | not retrieved | UNVERIFIED | RSE guide blocked |
| Abstract structured or not | not retrieved | UNVERIFIED | RSE guide blocked |
| Highlights, count and length | 3 to 5 bullets, max 85 characters each incl. spaces, Word file | VERIFIED (Elsevier-wide) | elsevier.com highlights page |
| Highlights mandatory? | Elsevier-wide: not required until final files stage. RSE-specific stance unknown | PARTIAL | elsevier.com highlights page |
| Keyword count | not retrieved | UNVERIFIED | RSE guide blocked |
| Section structure, IMRaD | not retrieved | UNVERIFIED | RSE guide blocked |
| Numbered sections | not retrieved for RSE; `elsarticle` template sets `number-sections: true` | UNVERIFIED | see section 4 |
| Figure count cap | no Elsevier-wide cap found; journal cap unknown | UNVERIFIED | RSE guide blocked |
| Table count cap | no Elsevier-wide cap found; journal cap unknown | UNVERIFIED | RSE guide blocked |
| Figure resolution | 300 dpi halftone, 1000 dpi line art, 500 dpi combination | VERIFIED (Elsevier-wide) | artwork-faq |
| Figure formats | TIFF or EPS preferred; PDF, JPEG, MS Office accepted | VERIFIED (Elsevier-wide) | artwork-faq, artwork-overview |
| Colour policy / charges | not retrieved | UNVERIFIED | RSE guide blocked |
| Reference style, name-year vs numbered | **not retrieved, and contested (see section 3)** | UNVERIFIED | RSE guide blocked |
| Flexible reference formatting at submission | "No strict requirements on reference formatting at submission" | VERIFIED (Elsevier-wide) | Your Paper Your Way |
| Generative AI declaration | required section, exact title and placement above references | VERIFIED (Elsevier-wide) | genAI policy page |
| Data availability statement | encouraged Elsevier-wide; mandatory status at RSE unknown | PARTIAL | research-data page |
| CRediT statement | provided during submission, printed above acknowledgments, 14 roles | VERIFIED (Elsevier-wide) | CRediT page |
| Cover letter | not retrieved | UNVERIFIED | RSE guide blocked |
| Graphical abstract | template supports it; whether RSE requests it is unknown | UNVERIFIED | RSE guide blocked |
| Supplementary material | not retrieved | UNVERIFIED | RSE guide blocked |
| Preprints | may be shared anywhere at any time; link to DOI on publication | VERIFIED (Elsevier-wide) | sharing policy |

---

## 3. The reference style is contested and must be resolved before submission

This is the one item where a careless verification would do real damage, so it is called out
separately.

A web search summary produced during this session asserted that RSE "uses Elsevier numbered
(Vancouver-style) format for references", alongside claims of a 250-word abstract limit and 1 to 7
keywords. **None of these were retrieved from the live page and the numbered-reference claim is
almost certainly wrong.** RSE articles carry author-date citations in text, the vendored Quarto
Elsevier extension defaults to `elsevier-harvard.csl` when citeproc is in use, and the present
manuscript is written throughout with author-date citations. A search engine's paraphrase of a page
that neither it nor I could show me is precisely the class of evidence this project was burned by
before. It is recorded here only so that nobody re-derives it later and mistakes it for a finding.

Resolution required: a human with browser access must open the RSE Guide for Authors and read the
References section. Until then, the manuscript should stay author-date and rely on the verified
Your Paper Your Way flexibility.

---

## 4. The vendored Elsevier Quarto template

Location: `_extensions/quarto-journals/elsevier/`

Declared identity, from `_extension.yml`: title "Elsevier Journal Format", author Charles Teague,
version 0.4.5, requires Quarto >= 1.2.198.

It is the genuine Elsevier `elsarticle` class. `elsarticle.cls` self-identifies as
`\RCSversion{3.4c}`, `\RCSdate{2025/01/11}`, "Copyright 2007-2025 Elsevier Ltd", distributed under
the LaTeX Project Public License. That is a current build of the class, not a stale copy.

Shipped files: `elsevier.lua` (filter), `elsarticle.cls`, `styles/elsevier.scss`, four bibliography
files (`elsarticle-num.bst`, `elsarticle-harv.bst`, `elsarticle-num-names.bst`,
`bib/elsevier-harvard.csl`), and three partials (`before-body.tex`, `title.tex`,
`_two-column-longtable.tex`).

### What the template already handles

- **PDF via `elsarticle`**, `cite-method: natbib`, `number-sections: true` by default.
- **Reference style switching.** `elsevier.lua` reads `journal.cite-style` and accepts `number`,
  `numbername`, `authoryear` and `super`, wiring the matching `.bst` and class option. So whichever
  way the contested style question resolves, the template can express it by changing one YAML key.
- **CSL fallback.** When cite method is citeproc and no `csl` is set, the filter substitutes
  `bib/elsevier-harvard.csl`. Note the trap: the manuscript *does* set `csl`, so this fallback will
  never fire and `apa.csl` wins.
- **Front matter structure** in `before-body.tex`: title, subtitle, authors with affiliations and
  ORCID-style notes, corresponding-author `\corref`, `\ead` email, abstract environment, and a
  keyword environment.
- **Highlights**, via a `journal.highlights` list rendered into a `highlights` environment as
  `\item` bullets.
- **Graphical abstract**, via `journal.graphical-abstract` rendered into a `graphicalabstract`
  environment.
- **Layout controls**: `journal.model` (1p, 3p, 5p), `journal.layout` (onecolumn, twocolumn),
  `journal.formatting` (preprint, review, doubleblind), and `journal.name` for the `\journal{}`
  line.

### What the template does NOT handle, and must be done by hand

- **No CRediT support.** There is no `credit` key and no environment for it. The statement must be
  written as prose in the manuscript and re-entered in the submission system.
- **No generative AI declaration support.** No partial emits the required section, and nothing
  enforces its placement immediately above the references. Must be authored by hand as the last
  section before `# References`.
- **No data availability statement support.** Must be authored by hand.
- **No declaration-of-competing-interest, funding or acknowledgments environments.** All by hand.
- **No word count, figure count or table count enforcement.** Nothing in the template will warn on
  a limit.
- **No figure resolution enforcement.** The manuscript currently sets `dpi = 200` in
  `knitr::opts_chunk$set`, which is below every Elsevier minimum. The template will not catch this.
- **The vendored `elsevier-harvard.csl` is stale relative to upstream.** Vendored copy is titled
  "Elsevier - Harvard (with titles)", `<updated>2019-01-22</updated>`. Upstream
  `citation-style-language/styles` now titles it "Elsevier (author-date/Harvard, with titles)" with
  `<updated>2014-03-04</updated>`, and the two files differ. Both are `citation-format="author-date"`.
  Verified by download and `diff` on 2026-07-31.

---

## 5. `04.references/` and the correct CSL

Present in `04.references/`: `apa.csl`, `springer-basic-author-date.csl`, `references-beetle.bib`,
`references.bib`, `references-beetle-manifest.md`, several `.docx` reference-doc styles, and an
**empty** `style-elsevier/` directory. There is no Elsevier or RSE CSL in `04.references/`.

The only Elsevier CSL anywhere in the project is
`_extensions/quarto-journals/elsevier/bib/elsevier-harvard.csl`, which is inside the extension and
is currently overridden by the manuscript's explicit `csl: ../04.references/apa.csl`.

There is **no journal-specific CSL for Remote Sensing of Environment**. Verified on 2026-07-31:
`https://raw.githubusercontent.com/citation-style-language/styles/master/remote-sensing-of-environment.csl`
returns HTTP 404. The correct choice is therefore the generic Elsevier style.

Download URLs, all verified to resolve HTTP 200 on 2026-07-31:

- Author-date, the likely correct choice:
  `https://raw.githubusercontent.com/citation-style-language/styles/master/elsevier-harvard.csl`
- Numbered, if the RSE guide turns out to specify Vancouver:
  `https://raw.githubusercontent.com/citation-style-language/styles/master/elsevier-vancouver.csl`
- Numbered with titles, an Elsevier variant:
  `https://raw.githubusercontent.com/citation-style-language/styles/master/elsevier-with-titles.csl`

Recommendation, pending the human read of the live guide: place `elsevier-harvard.csl` in
`04.references/` and point the manuscript at it. Do not do this on my authority about RSE's style;
do it because it is the Elsevier author-date default and matches how the manuscript is already
written.

---

## 6. Gap list: what the current manuscript does not yet meet

Assessed against `01.manuscript/beetle-topography-wind-study.qmd` as of 2026-07-31.

**Blocking, and verified against a live Elsevier policy:**

1. **No generative AI declaration.** The manuscript has no such section. Elsevier requires a
   section titled "Declaration of Generative AI and AI-assisted technologies in the writing
   process" placed immediately above the references. Given that this manuscript is an executable
   document produced with AI assistance, the declaration is not optional. Currently the last
   section before `# References` is `# Data and code availability`.
2. **No CRediT author contribution statement.** Absent from the manuscript entirely. Single-author
   paper still requires the roles to be listed.
3. **Figure resolution is below the Elsevier minimum.** `knitr::opts_chunk$set(... dpi = 200 ...)`
   at line 87. Elsevier requires 300 dpi for halftones, 500 for combination art and 1000 for line
   art. A plotted figure is combination or line art, so 200 dpi fails by a factor of 2.5 to 5.
4. **No declaration of competing interests, no funding statement, no acknowledgments.** Standard
   Elsevier front or back matter, all missing.

**Blocking, but the threshold itself is unverified:**

5. **Abstract is 318 words.** Counted from the YAML `abstract:` block. Elsevier journals commonly
   cap at 250, and the search summary claimed 250 for RSE, but that number is unverified. If the cap
   is 250 the abstract is 68 words over and must be cut. Flag for the human who reads the live page.
6. **Six keywords.** Listed in YAML: disturbance refugia, mountain pine beetle, aerial overview
   survey, Global Wind Atlas, scale dependence, collinearity. The unverified claim is 1 to 7, which
   six would satisfy. Cannot be confirmed.
7. **No word-limit check possible.** The `.qmd` is roughly 5,250 words including code, chunk options
   and YAML, so prose is well under that. Without the journal's limit this cannot be assessed.

**Structural and configuration gaps:**

8. **`csl: ../04.references/apa.csl`.** APA is not an Elsevier style. Not fatal at initial
   submission given the verified Your Paper Your Way flexibility, but it should be swapped to
   `elsevier-harvard.csl`. The explicit `csl` key also suppresses the extension's own CSL fallback,
   so simply adding the format will not fix it.
9. **No Elsevier output format configured.** The manuscript's `format:` block offers only `docx`
   and `html`. The vendored `_extensions/quarto-journals/elsevier` extension is never invoked, so
   the `elsarticle` PDF, the front matter, the highlights environment and the graphical abstract
   environment are all unused. `_quarto.yml` contains only project-level pre-render and post-render
   hooks and no format definitions.
10. **No highlights.** Nothing in the manuscript supplies 3 to 5 bullets of 85 characters or fewer.
    Elsevier says these are not needed until final files, so this is a late-stage task, not a
    submission blocker.
11. **No graphical abstract.** Template supports it; whether RSE wants one is unverified.
12. **Section structure is close to IMRaD but not exactly it.** Top-level headings are
    Introduction, Materials, Methods, Results, Discussion, Conclusions, Data and code availability,
    References. "Materials" and "Methods" are separate top-level sections rather than a single
    "Materials and methods". Whether RSE cares is unverified.
13. **Only one figure and four tables.** `fig-gradient`; `tbl-relief`, `tbl-gradient`,
    `tbl-krawchuk`, `tbl-extent`. No cap is known so this is recorded as fact, not as a gap. A
    reviewer may find one figure thin for a remote sensing paper, but that is an editorial matter,
    not a guideline breach.
14. **A data availability statement exists in substance.** `# Data and code availability` names the
    BC Aerial Overview Survey, the Vegetation Resources Inventory, the Open Government Licence and
    the NRCan HRDEM, and points to `02.inputs/README-data.md`. It may need reformatting into
    Elsevier's expected phrasing, but the content is there. This is the one policy area where the
    manuscript is in reasonable shape.

---

## 7. What could NOT be verified, and why

**Every journal-specific requirement for Remote Sensing of Environment is unverified.** Namely:
article types, word and page limits, abstract word limit, whether the abstract is structured,
whether highlights are mandatory at first submission, keyword count, required section structure and
numbering, figure and table caps, colour policy and any colour charges, reference style, cover
letter requirement, graphical abstract requirement, supplementary material rules, and any
RSE-specific data availability mandate.

Routes attempted on 2026-07-31, and how each failed:

1. `https://www.sciencedirect.com/journal/remote-sensing-of-environment/publish/guide-for-authors`
   via WebFetch: **HTTP 403 Forbidden**, body not retrieved.
2. `https://www.elsevier.com/journals/remote-sensing-of-environment/0034-4257/guide-for-authors`:
   **HTTP 301** to `https://www.sciencedirect.com/science/journal/00344257/publish/guide-for-authors`.
   Fetching that target: **HTTP 403 Forbidden**.
3. Same path without `www`, `https://elsevier.com/journals/...`: same **301** to the blocked
   ScienceDirect URL.
4. `curl` with a desktop browser user-agent: **HTTP 403**, but with a 1,208,054-byte body. Inspected
   locally: `<title>ScienceDirect</title>`, zero occurrences of "guide for authors", zero
   occurrences of "highlights", seven matches for CAPTCHA and Cloudflare markers. It is a bot
   challenge page, not the guide.
5. Text-extraction proxy (`r.jina.ai`): HTTP 200, 113,025 bytes, but the content is the Cloudflare
   interstitial. Title "Just a moment...", body "Are you a robot? Please confirm you are a human by
   completing the captcha challenge below." Reference number a23d18132fa917fe, timestamp
   2026-07-31 13:54:16 UTC. **I did not attempt to solve the CAPTCHA**, as bypassing bot detection
   is out of bounds.
6. Chrome browser automation: **extension not connected**, so no browser session was available.
7. `https://www.journals.elsevier.com/remote-sensing-of-environment/guide-for-authors`: **HTTP 403**.
8. `https://www.sciencedirect.com/journal/remote-sensing-of-environment/about/aims-and-scope`:
   **HTTP 403**. The entire ScienceDirect host is closed to this session.
9. Editorial Manager, `https://www.editorialmanager.com/rse/`: reachable, and it is the RSE site,
   but it carries the notice "Site under development. Do not use for live manuscript submission."
   It exposes no article types, word limits or requirements; its Instructions for Authors link
   points back to the blocked Elsevier guide.
10. Legacy Elsevier PDF mirrors, four candidate paths under `legacyfileshare.elsevier.com` and
    `elsevier.com/__data/promis_misc/`: all **HTTP 404**.
11. Local fallback: `04.references/style-elsevier/` is an **empty directory**. There is no saved
    copy of the RSE guide anywhere in the project. (Recall that the analogous saved PDF for Forest
    Science turned out to be 43 blank pages, so a saved copy would have needed its text layer
    checked anyway.)

**Search-engine summaries were obtained but are explicitly NOT counted as verification.** A
WebSearch synthesis asserted a 250-word abstract limit, 1 to 7 keywords, and numbered
Vancouver-style references for RSE. The first two are plausible; the third is very likely wrong.
None were retrieved from a page anyone in this session could actually read. They are recorded in
section 3 as a caution, not as findings.

**Recommended next step:** a human opens the RSE Guide for Authors in a normal browser, clears the
CAPTCHA, and reads out the fourteen unverified rows in the section 2 table. Everything else in this
memo is settled.
