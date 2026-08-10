# references-beetle.bib: provenance and verification manifest

Every entry in `references-beetle.bib` was built from the text layer of a PDF in
`04.references/literature/`, read with `pypdf` over the first two pages (deeper
pages where a running header or a reference list was needed to fix a page
range). No page was rendered as an image. Filenames were used only to
cross-check; where the filename and the PDF text disagreed, the PDF text won,
and the disagreement is recorded below.

Fields that were not visible were left out of the entry rather than guessed. The
third column lists what is missing, so those fields can be filled in by hand
against the publisher record.

On 2026-07-31 the ten entries whose missing fields had been flagged in bold were
hand-verified against the publisher record, mostly through the CrossRef REST API
and, for the two grey-literature items, the B.C. Ministry of Forests publications
catalogue. Their rows now record what was verified and against which source.

Also on 2026-07-31, three entries were added: `work2011` and `smithmckenna2013`,
both cited in the task record but absent from the file, and `goodsman2024`, which
the Discussion now cites for the finding that spatial prediction of beetle winter
mortality fails in mountainous terrain. `work2011` was cited by the manuscript's
new grain section and would otherwise have rendered a broken reference.

91 entries, of which 31 are cited by the manuscript.

## Entries

| Citation key | Source PDF | Fields not extracted |
|---|---|---|
| brett2025 | Beetles/Brett et al 2025 A history of mountain pine beetle outbreaks in Alberta and Saskatchewan, 1940–2007 (Information Report GLC-X-38)...pdf | none. Note: the filename says GLC-X-38 but the title page and the cataloguing page both say **GLC-X-39**; the entry uses GLC-X-39 |
| carroll2003bionomics | Beetles/Carroll & Safranyik 2003 The bionomics of the mountain pine beetle in lodgepole pine forests.pdf | editors of the proceedings (Shore, Brooks and Stone) not on the extracted pages; some later papers date this proceedings volume 2004 rather than 2003 |
| carroll2006control | Beetles/Carroll et al 2006 Direct control- Theory and practice...pdf | none |
| safranyik2006 | Disturbance Ecology & Conifer Regeneration /Safranyik & Wilson 2006 Biology of MPB in BC Synthesis and Review.pdf | ISBN |
| shore2006 | Disturbance Ecology & Conifer Regeneration /Shore 2006 Effects of the Mountain Pine Beetle on.pdf | none |
| taylor2003 | Disturbance Ecology & Conifer Regeneration /Taylor & Carrol 2003 Disturbance_Forest_Age_and_Mountain_Pine_Beetle_Ou - History of BC.pdf | proceedings editors; cited elsewhere as 2004 |
| cooke2009mortality | Beetles/Carroll 2009 Forecasting mountain pine beetle-overwintering mortality in a variable environment.pdf | none. Note: the filename credits Carroll, the title page credits **Barry J. Cooke** as sole author |
| cooke2017 | Beetles/Cooke & Carroll 2009 Predicting the risk of mountain pine beetle spread to eastern pine forests.pdf | volume, pages. Note: the filename says 2009, the article was received Dec 2016 and accepted Apr 2017, and the DOI is a 2017 FEM DOI; year set to 2017 |
| cooke2025 | Beetles/Cooke et al 2024 On the deduction and quantification of irruptive dynamics in mountain pine beetle.pdf | issue. Note: filename says 2024, embedded metadata says J Appl Entomol 2025;149:309-323 |
| cullingham2011 | Beetles/Cullingham et al 2011 Mountain pine beetle host-range expansion threatens the boreal forest .pdf | volume, pages |
| howe2022 | Beetles/Howe et al 2022 Numbers matter- how irruptive bark beetles initiate transition...pdf | none |
| johnson2026density | Beetles/Johnson & Lewis 2026 - Evidence of negative density-dependent dispersal in an invasive forest pest.pdf | none |
| johnson2026stratified | Beetles/Johnson et al 2026 Modeling stratified dispersal in forest pests...pdf | none |
| safranyik2010 | Beetles/Safranyik et 2012 Potential for Range Expansion of Mountain Pine Beetle into the Boreal Forest of North America.pdf | none. Note: filename says 2012, the BioOne cover sheet says The Canadian Entomologist 142(5):415-442, 2010 |
| sambaraju2021 | Dendroctonus ponderosae/Sambaraju et al 2021 Mountain-pine-beetle-an-example-of-a-climate-driven-eruptive-insect...pdf | pages |
| jarvis2015 | Dendroctonus ponderosae/Jarvis, D. S., & Kulakowski, D. (2015). Long-term history and synchrony...pdf | volume, pages |
| janes2014 | Dendroctonus ponderosae/Janes et al 2014 How the Mountain Pine Beetle (Dendroctonus ponderosae).pdf | volume, issue. Pages taken from the PDF producer string `OP-MOLB140108 1803..1815` |
| powell2014 | Dendroctonus ponderosae/powell & bentz2014 Phenology and density-dependent dispersal...pdf | none |
| jones2019 | Dendroctonus ponderosae/Jones et al 2019 Factors-influencing-dispersal-by-flight-in-bark-beetles...pdf | issue |
| gray1972 | Dendroctonus ponderosae/gray2009 On the Emergence and Initial Flight Behaviour of the Mountain pine beetle.pdf | **Resolved 2026-08-04.** The garbled journal line (`Z. ang. Fnr. 71 (19723 30-259`) is now settled: CrossRef gives volume 71, pages 250--259, DOI 10.1111/j.1439-0418.1972.tb01745.x, and the PDF's own last page prints the running head `On the Emergence and Initial Flight Behaviour 259` across ten pages, so 250--259 is confirmed from two independent sources. Pages and DOI added. Issue number still not established and so still omitted. The filename year 2009 remains wrong |
| mccambridge1971 | Dendroctonus ponderosae/mccambridge1971 Temperature Limits of Flight of the the mountain pine beetle.pdf | pages. The running head gives `534 ... [Vol. 64, no. 2` so the note begins at 534; the PDF is two pages, so 534--535 is likely but was not printed |
| kellner2014 | Beetles/Kellner et al Accounting for Imperfect Detection in Ecology- A Quantitative Review.pdf | none |
| kery2008 | Beetles/Key 2008 Imperfect detection and its consequences for monitoring for conservation.pdf | **Resolved 2026-07-31.** Journal, volume, issue, pages and DOI verified against CrossRef `10.1556/ComEc.9.2008.2.10`: Community Ecology 9(2):207--216, 2008. The extracted footer page 216 matches the closing page. Nothing outstanding |
| wulder2006red | Disturbance Ecology & Conifer Regeneration /Wulder et al 2006 Estimating the probability of mountain pine beetle red-attack damage.pdf | none |
| white2005 | Disturbance Ecology & Conifer Regeneration /White et al Detection of red attack stage mountain pine beetle.pdf | none |
| wulder2009green | Beetles/Wulder et al 2009 Challenges for the operational detection of mountain pine beetle green attack with remote sensing.pdf | pages. Article starts at 32 (per the running head and the DOI suffix `tfc85032-1`); end page not printed on the extracted pages |
| walter2013 | Disturbance Ecology & Conifer Regeneration /Walter J A & Platt R V 2013 Multi-temporal analysis...pdf | none. Duplicated by `Remote Sensing of Natural Disturbances/walter2013.pdf` |
| meddens2012 | Disturbance Ecology & Conifer Regeneration /Meddens et al 2012 Spatiotemporal patterns of observed bark beetle-caused tree in BC and NW America.pdf | DOI |
| meddens2013 | Remote Sensing of Natural Disturbances/Meddens et al 2013 Evaluating methods to detect bark beetle-caused tree mortality...pdf | none. Duplicated by the near-identical file in the Disturbance Ecology folder, which the filename dates 2012 |
| meddens2014 | Disturbance Ecology & Conifer Regeneration /Meddens & Hicke 2014 Spatial and temporal patterns of Landsat.pdf | none |
| lausch2013 | Remote Sensing of Natural Disturbances/Lausch et al 2013 Forecasting potential bark beetle outbreaks based on spruce forest.pdf | none |
| woodward2018 | Remote Sensing of Natural Disturbances/Woodward 2018 Mapping Progression and Severity of a Southern_Colorado Spruce Beetle Outbreak...pdf | none |
| eitel2011 | Remote Sensing of Natural Disturbances/Eitel et al 2011 Broadband, red-edge information from satellites improves early stress detection in a.pdf | volume, pages |
| huo2021 | RSE Publications/Huo et al 2021 Early detection of forest stress from European spruce bark beetle attack...pdf | none |
| ye2021 | RSE Publications/Ye et al 2021 Detecting subtle change from dense Landsat time series.pdf | none |
| rodman2021 | RSE Publications/Rodman et al 2021 Disturbance detection in landsat time series...pdf | DOI. Single-page landing PDF; volume, article number and year come from the page banner |
| meigs2011 | RSE Publications/Meigs et al 2011 A Landsat time series approach to characterize bark beetle and defoliator impacts...pdf | **Resolved 2026-07-31.** Volume, issue, pages and DOI verified against CrossRef `10.1016/j.rse.2011.09.009`: Remote Sensing of Environment 115(12):3707--3718, December 2011. Nothing outstanding |
| kennedy2012 | RSE Publications/Kennedy et al 2012 Spatial and temporal patterns of forest disturbance and regrowth...pdf | none |
| goetz2006 | RSE Publications/Goetx et al 2006 Using satellite time-series data sets to analyze fire disturbance and forest recovery across Canada.pdf | none |
| rich2010 | RSE Publications/Rich et al 2010 Detecting wind disturbance severity and canopy heterogeneity in boreal forest...pdf | none |
| liang2016 | Disturbance Ecology & Conifer Regeneration /Liang et al 2016 Forest disturbance interactions and successional pathways in the Southern Rocky Mountains.pdf | none |
| littlefield2019 | Remote Sensing of Natural Disturbances/Littlefield2019_Article_TopographyAndPost-fireClimatic.pdf | volume, article number. Sole authorship shown on the extracted pages |
| sappington2007 | Climate & Topography/Shappington 2007 Quantifying Landscape Ruggedness for Animal Habitat Analysis.pdf | none. Note: the filename misspells the lead author; the JSTOR cover sheet gives **Sappington** |
| moreno2003 | Climate & Topography/Moreno2003_Chapter_GeomorphometricAnalysisOfRaste.pdf | none |
| rozycka2016 | Climate & Topography/Rozyckaetal et al 2017 Topographic Wetness Index and Terrain Ruggedness Index...pdf | **Resolved 2026-07-31.** Volume, issue and pages verified against CrossRef `10.1127/zfg_suppl/2016/0328` and the Schweizerbart landing page for the article: Zeitschrift für Geomorphologie, Supplementary Issues 61(2):61--80. **Year corrected from 2016 to 2017**: both CrossRef and the publisher give a print date of 1 November 2017, and only the DOI slug and the copyright line say 2016. The citation key `rozycka2016` was kept and the discrepancy noted in the entry |
| parker1982 | Climate & Topography/Parker A J 1982 THE TOPOGRAPHIC RELATIVE MOISTURE INDEX...pdf | none |
| badger2014 | Climate & Topography/Badger et al 2014 Wind-Climate Estimation Based on Mesoscale and Microscale Modeling.pdf | **Resolved 2026-07-31.** Volume 53, issue 8 verified against CrossRef `10.1175/JAMC-D-13-0147.1`, which also confirms the pages 1901--1919 that had been inferred from the PDF producer string, and August 2014. Nothing outstanding |
| awstruepower2012 | Climate & Topography/High-Resolution-Wind-Resource-Maps-and-Data-Methods-and-Validation-1.pdf | named authors (corporate report). Report number AWST-RN-2010-01 is from the PDF metadata Subject field |
| he2017 | Climate & Topography/Rayment et al 2019 Parameterisation of windbreak effects on sheep.pdf | none. Note: the filename credits Rayment and dates it 2019; the deposited citation page gives **He, Jones and Rayment (2017)**, Agricultural and Forest Meteorology 239:96-107 |
| tobler1970 | Seedling Point Patterns & Spatial Modelling/Tobler 1970 Toblers Law A-Computer-Movie and Detroit Population.pdf | **Resolved 2026-07-31.** Journal, volume, pages, year and DOI verified against CrossRef `10.2307/143141`: Economic Geography 46, June 1970, first page 234. The page range 234--240 is confirmed twice over, by the reprint's own closing footnote on its last page and by the Taylor and Francis article record. The issue is recorded as `sup1`, the label Taylor and Francis gives the supplement volume; Tobler's own footnote calls it number 2, so the issue designation is the one soft point in the entry |
| guelat2013 | Seedling Point Patterns & Spatial Modelling/Spatstat R.Package/Guelat et al 2020 Spatial Autocorrelation with Spatstat.pdf | URL. Note: the filename says 2020, which is the date the page was printed; the byline says 2013 |
| hoeting2006 | Seedling Point Patterns & Spatial Modelling/Hoeting et al 2006 MODEL SELECTION FOR GEOSTATISTICAL MODELS.pdf | DOI |
| fox2020 | Seedling Point Patterns & Spatial Modelling/Fox et al 2020 Comparing spatial regression to random forest.pdf | **Resolved 2026-07-31.** Volume, issue, article number and DOI verified against CrossRef `10.1371/journal.pone.0229509`: PLoS ONE 15(3):e0229509, 23 March 2020. The truncated in-text DOI is now complete. Nothing outstanding |
| hawkins2004 | Seedling Point Patterns & Spatial Modelling/Hawkins 2004 Problem of Overfitting.pdf | pages. Running heads show pp. 2 and 3, so the article starts at 1, but no full range is printed |
| fonti2017 | Seedling Point Patterns & Spatial Modelling/Fonti et al 2017 Variable Selection with GLMNET Lasso.pdf | none. Single-author student research paper, not peer reviewed; treat as grey literature |
| francolopez2001 | Seedling Point Patterns & Spatial Modelling/Franco-lopez 2001 Estimation of stand density and composition - Problem of Overfitting.pdf | DOI |
| baddeley2005 | Seedling Point Patterns & Spatial Modelling/Spatstat R.Package/Baddeley et al 2005 An R Package for Analyzing Spatial Point.pdf | pages |
| baddeley2000 | Seedling Point Patterns & Spatial Modelling/Spatstat R.Package/Baddeley, A., & Turner, R. (2000). Practical Maximum Pseudolikelihood...pdf | DOI |
| baddeley2015 | Seedling Point Patterns & Spatial Modelling/Baddeley et al 2015 Spatial point patterns.pdf | none. The PDF is Gómez-Rubio's JSS book review, not the book; the entry cites the book, whose author list, publisher, year and ISBN are all printed in the review header |
| renner2015 | Seedling Point Patterns & Spatial Modelling/Spatstat R.Package/Renner & Baddeley 2015 Point process models for presence-only analysis.pdf | issue |
| mitchell2020 | Spatiotemporal Autocorrelation/Mitchell et al 2020 Temporal Autocorrelation Neglected.pdf | **Resolved 2026-07-31.** Volume 31, issue 1, pages 222--231 verified against the Oxford Academic article page for `10.1093/beheco/arz180`. The CrossRef deposit still carries only the Advance Access date of 1 November 2019 and no pagination, so the print issue was read off the publisher page. Year 2020 confirmed as the issue year. Nothing outstanding |
| strachan1996 | Spatiotemporal Autocorrelation/Strachan & Harvey 1996 Quantifying the effects of temporal autocorrelation...pdf | **Resolved 2026-07-31.** The whole entry, built from the filename alone, is confirmed against CrossRef `10.1139/x26-094`: Ian B. Strachan and L. Edward Harvey, Canadian Journal of Forest Research 26(5):864--871, May 1996, title matching word for word. The initials `I. B.` and `L. E.` were correct. Nothing outstanding |
| collins2018 | Spatiotemporal Autocorrelation/Collins et al 2018 Temporal heterogeneity increases with spatial heterogeneity in ecological communities.pdf | volume, pages. The file is the accepted manuscript, not the version of record |
| mcintire2006 | Disturbance Ecology & Conifer Regeneration /McIntire & Fortin 2006 Structure and function of wildfire and mountain pine beetle forest boundaries...pdf | DOI |
| talucci2019dead | Disturbance Ecology & Conifer Regeneration /Talucci 2019 Dead forests burning...pdf | none |
| vore2020 | Disturbance Ecology & Conifer Regeneration /Vore 2020 Climate and forest disturbances...pdf | volume, pages |
| braumandl2005 | Local Ecology of South Selkirk Mountains/BC Nelson BEC.pdf | **Resolved 2026-07-31.** The second author is **P. R. Dykstra**, confirmed by the B.C. Ministry of Forests catalogue page for Land Management Handbook 20 (www.for.gov.bc.ca/hfd/pubs/docs/lmh/Lmh20.htm), which lists Supplement 1 of November 2005 as by T. F. Braumandl and P. R. Dykstra. Decoding the mojibake title page and page 3 of the same PDF gives the identical byline. **The corporate author was replaced by the two personal authors.** Handbook number 20, Supplement 1, November 2005 all stand |
| ketcheson1991 | Local Ecology of South Selkirk Mountains/Chapter_11_Interior_Cedar_-_Hemlock_Zone.pdf | **Resolved 2026-07-31.** Book, editors and publisher verified against the B.C. Ministry of Forests catalogue page for Special Report Series 06 (www.for.gov.bc.ca/hfd/pubs/docs/srs/srs06.htm): *Ecosystems of British Columbia*, edited by D. V. Meidinger and J. Pojar, Research Branch, B.C. Ministry of Forests, Victoria, 1991, Special Report Series 6. The chapter's own first page prints 167 and its last prints 181, so the page range and the chapter number 11 are confirmed from the PDF itself. Nothing outstanding |
| haxtema2018 | Local Ecology of South Selkirk Mountains/Darkwoods 2015 Fire report.pdf | none. Note: the filename says 2015 and calls it a fire report; it is in fact the **2018 CCB and VCS verification report** for the Darkwoods Forest Carbon Project |
| ncc2013 | Local Ecology of South Selkirk Mountains/NCC Darkwoods Report 2013.pdf | named authors (corporate document) |
| hall2010 | Local Ecology of South Selkirk Mountains/NCC Maintaining Fire REgimes of Darkwoods.pdf | publisher. The report names Erin Hall and September 2010 but no issuing body on the title page; the institution is inferred from where the file sits and should be confirmed |
| work2011 | Work et al 2011 Response of female beetles to LIDAR derived topographic variables in Eastern boreal mixedwood forests (Coleoptera, Carabidae).pdf | none. Added 2026-07-31. The PDF carries its own full citation on page 1 (ZooKeys 147:623--639, doi 10.3897/zookeys.147.2013), confirmed against CrossRef. The third author extracts as `J.M. Jacobs` from the byline and as `Jenna` from CrossRef; the entry uses `Jenna M. Jacobs`. Note the paper is a symposium contribution within the ZooKeys issue edited by T. Erwin |
| smithmckenna2013 | Smith-McKenna et ql 2013 Topographic Influences on the Distribution of White Pine Blister Rust in Pinus albicaulis Treeline Communities.pdf | none. Added 2026-07-31 from the BioOne cover sheet (Ecoscience 20(3):215--229, doi 10.2980/20-3-3599), confirmed against CrossRef. The journal is set as `Écoscience` with the accent, which is the form CrossRef deposits. Note the filename misspells `et al` as `et ql` |
| goodsman2024 | no local PDF | none. Added 2026-07-31 from the CrossRef record for doi 10.3390/f15081425 (Forests 15(8):1425), the only entry in this file not built from a PDF in the local library. The abstract sentence the Discussion relies on, that spatial prediction of relative mortality in Banff National Park was poor because mountainous terrain is a difficult prediction challenge when under-bark temperatures are not directly observed, was read from the CrossRef abstract deposit. Open access; retrieve the PDF from MDPI if the full text is ever needed |

## PDFs examined but not entered

| Source PDF | Why |
|---|---|
| Disturbance Ecology & Conifer Regeneration /Larson et al 2005 Whitebark pine and MPB.pdf | **Unresolved.** The file is AES-encrypted and `pypdf` cannot open it without the `cryptography` package, which is not installed. No text could be extracted |
| Seedling Point Patterns & Spatial Modelling/Spatstat R.Package/Wiegand & Moloney 2013 Handbook of Spatial Point-Pattern Analysis in Ecology.pdf | **Unresolved.** 538-page scan with no text layer (57 characters extracted from the first two pages). Metadata is empty |
| Local Ecology of South Selkirk Mountains/Darkwoods Project Overview.pdf | Not a citable document. It is a filled-in VCS Risk Report Calculation Tool spreadsheet exported to PDF, with no title, author or date |
| Remote Sensing of Natural Disturbances/walter2013.pdf | Byte-level duplicate of Walter and Platt (2013), already entered as `walter2013` |
| Disturbance Ecology & Conifer Regeneration /Meddens et al 2012 Evaluating methods to detect bark beetle-caused tree mortality...pdf | Duplicate of the Meddens et al. (2013) RSE paper filed under the Remote Sensing folder, already entered as `meddens2013` |
| Seedling Point Patterns & Spatial Modelling/Fox et al 2020 Variable selection for spatial regression.pdf | Supplementary material S1 to Fox et al. (2020), not a separate publication |

## Folders not mined

About 150 further PDFs were left unread because their subject falls outside this
manuscript. They are:

1. Most of `Disturbance Ecology & Conifer Regeneration /` (91 files). The
   majority concern mycorrhizal ecology, post-fire seedling recruitment,
   ethnobotany and provenance trials. Only the mountain pine beetle, Landsat and
   British Columbia disturbance-history papers were extracted.
2. Most of `Seedling Point Patterns & Spatial Modelling/` (39 files). The
   seedling point-pattern and post-fire regeneration case studies were skipped;
   the spatial-statistics methodology, variable-selection and overfitting papers
   were extracted.
3. Most of `Remote Sensing of Natural Disturbances/` (28 files). Burn-severity
   index papers (dNBR, GeoCBI, MTBS, tasseled cap) were skipped; the bark beetle
   and forest-stress detection papers were extracted.
4. Several `Local Ecology of South Selkirk Mountains/` items: the 2016 and 2017
   Darkwoods verification and validation reports, the 2016 restoration report,
   the 2018 Vera report and the Kootenay conservation plans, all of which
   duplicate or postdate the two Darkwoods documents already entered.

Any of these can be added later by rerunning the same first-two-pages extraction
against a longer file list.

## Audit of 2026-08-04

Every citekey used in the manuscript was cross-checked against this file, and every
cited entry carrying a DOI was compared field by field against the CrossRef record.
Thirty-one keys are cited; all thirty-one resolve; there are no duplicate keys and no
key cited but undefined. Sixty entries sit in the file uncited, which is harmless
under citeproc since only cited entries reach the reference list.

Of the twenty cited entries with a DOI, twenty matched CrossRef on year, journal,
volume, issue, pages and author count. The only diffs were artefacts: CrossRef holds
first-page-only records for `hadley1994` and `wiens1989`, and returns markup rather
than plain text for the title and journal of `smithmckenna2013`. Nothing needed
changing in any of the twenty.

Changed in the bib on this date:

1. `murphy2024` became `murphy2026`, and `@unpublished` became `@article`. The
   companion study is published: Forest Ecology and Management 618, 123985,
   doi:10.1016/j.foreco.2026.123985, October 2026, confirmed against CrossRef with
   the lead author's ORCID 0000-0002-1792-0351 on the record. Three further errors
   were corrected at the same time: the author order is Murphy, Leslie, Wilson,
   Banks, not Murphy, Leslie, Banks, Wilson; the published title drops "and temporal"
   and names "the southern Selkirk Mountains, British Columbia" rather than "the
   Darkwoods Conservation Area"; and journal, volume, pages and DOI were absent
   entirely. The old entry described the local draft in
   `04.references/grandfather-study/Manuscript_2024-02-29.docx`, which is where the
   2024 date came from. The key was renamed in both `.qmd` files.
2. `gray1972` gained pages 250--259 and doi:10.1111/j.1439-0418.1972.tb01745.x.
3. `wang2006` gained doi:10.1080/13658810500433453.
4. `beers1966` gained doi:10.1093/jof/64.10.691. `beers1973` gained its place of
   publication, West Lafayette, Indiana.
5. `nrcan2017` and `globalwindatlas` became `@online` so the Elsevier style prints
   their URLs, which it does not do for `@misc`. `nrcan2017` gained the open.canada.ca
   permanent URL and the "-- CanElevation Series" half of its official title.
   `globalwindatlas` lost the World Bank Group from its author field: DTU alone
   develops, owns and operates the atlas, and the World Bank is a release partner.
6. Corporate names in `braumandl2005`, `beers1973` and `wang2006` were wrapped in a
   second pair of braces. Without them citeproc reads the "and" in "Ministry of
   Forests and Range", "T and C Enterprises" and "Taylor and Francis" as a name
   separator and renders "British Columbia Ministry of Forests; Range" and
   "T; C Enterprises". The same second pair of braces was added to the title of
   `ketcheson1991`, which the sentence-casing style was rendering as "Interior cedar
   -- hemlock zone" rather than as the formal name of the biogeoclimatic zone.

7. `carroll2003bionomics` became `carroll2004bionomics`. The symposium was held in October
   2003 but the proceedings were published in 2004, per the NRCan OSTR record for
   BC-X-399. The manifest had flagged this doubt since the file was built; it is now
   settled. The proceedings editors (Shore, Brooks and Stone) and ISBN 0-662-38389-3 were
   added, and the key was renamed in both `.qmd` files.
8. Two chapter entries were added to the Safranyik and Wilson volume: `taylor2006`
   (Chapter 2, pages 67--94), which is where the -40 degree complete-mortality figure
   actually lives, and `safranyik2006chap1` (Chapter 1, pages 3--66). `safranyik2006`
   gained ISBN 0-662-42623-1. Neither new entry is cited yet; see the task record.

Checked and deliberately left alone: `cooke2009mortality` names Pacific Forestry
Centre, Victoria as its institution. The title page gives Cooke's own affiliation as
Northern Forestry Centre, Edmonton, which looks like an error until page 1's imprint
and the Library and Archives Canada cataloguing on page 2 both name Pacific Forestry
Centre as the issuing body. The entry is right as it stands.

Still open, and needing a decision rather than a lookup:

- `globalwindatlas` has no year and no version. The reference list prints "n.d.".
  The raster was inherited unchanged from the companion study's archive, so its
  vintage belongs to that download and is not recoverable from this repository.
  Version matters more than usual here: Global Wind Atlas 4.0, June 2025, rebuilt the
  microscale step on the Copernicus DEM30, so which version is in `Wind.utm.tif`
  determines which elevation model is baked into the surface this paper argues is
  largely an elevation transform.
- `nrcan2017` carries a bare year for a continuously revised product. The 1 m tiles
  entered HRDEM only at specification edition 1.1 in August 2017, and the product is
  delivered at 1 m or 2 m depending on the acquisition project.
- The Beers and Parker citations at manuscript line 302 describe compound indices
  that are not in the inherited layer set. See the note in the task record.
