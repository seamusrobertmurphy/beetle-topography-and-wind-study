#!/usr/bin/env python3
"""Build the submission-length manuscript from the full one.

The short version is derived, never hand-maintained, so the two cannot drift. Every cut and
every rewritten passage is here, applied to a fresh copy of the master, which means a change
to the master propagates by re-running this script rather than by editing two files.

Two rules learned the hard way. Section markers are anchored to the start of a line, because
an unanchored match also hits the identical text inside an R comment and silently deletes
everything between that comment and the next heading. And code is hidden in this version
only: the limit cannot be met with roughly 4,200 words of listings in the body, so the code
stays visible in the full manuscript and in the repository.
"""
import sys

SRC = "01.manuscript/beetle-topography-wind-study.qmd"
DST = "01.manuscript/beetle-topography-wind-study-short.qmd"
s = open(SRC).read()

s = s.replace("execute:\n  eval: true\n  echo: true", "execute:\n  eval: true\n  echo: false")
s = s.replace("#| echo: true\n", "#| echo: false\n")

def cut(start, end):
    ## The end marker is searched FROM the start marker, never from the top of the file:
    ## a generic end anchor such as a chunk fence occurs earlier as well, and searching
    ## from the top silently finds it and does nothing.
    global s
    a = s.find("\n" + start); b = s.find("\n" + end, a + 1) if a >= 0 else -1
    if a < 0 or b < 0 or b <= a:
        print(f"  SKIP cut {start[:40]!r}", file=sys.stderr); return
    s = s[:a + 1] + s[b + 1:]

def replace_section(start, end, new):
    global s
    a = s.find("\n" + start); b = s.find("\n" + end, a + 1) if a >= 0 else -1
    if a < 0 or b < 0 or b <= a:
        print(f"  SKIP replace {start[:40]!r}", file=sys.stderr); return
    s = s[:a + 1] + new + s[b + 1:]

# --- sections that move to supplementary --------------------------------------------
cut("## Literature screening {#sec-screening}", "## Study area")
cut("### Univariate screening", "## Models")
cut("## Landform class {#sec-geomorphon}", "## Host as diameter {#sec-diameter}")
cut("## Specification sensitivity {#sec-sensitivity}", "# Discussion")
cut("## Autocorrelation as a control", "## Ruggedness and regeneration")
cut("## An old argument", "## What survives")

# --- passages rewritten shorter -----------------------------------------------------
WIND = r'''## Flight-window wind

Station wind is Environment and Climate Change Canada hourly records, reduced only at the
last step into monthly means for June, July and August and four flight-window metrics for
1 July to 15 August: mean speed, the 95th percentile, and the fractions of hours below
5 km h and above 15 km h.

Hourly resolution buys metrics, not observations. With an annual response every hourly
reading collapses into one of `r length(YRS)` values per metric, so a wind main effect is
identified only across years and its standard error should not be believed alone. Stand
density varies cell to cell; a season's wind does not. That asymmetry is why the annual
models report an interaction rather than a main effect, and why the response was rebuilt at
16 days.

'''
replace_section("## Flight-window wind", "# Methods", WIND)

INTRO = r"""# Introduction

Mountain pine beetle (*Dendroctonus ponderosae* Hopkins) has killed more lodgepole pine
(*Pinus contorta* Douglas ex Loudon) in British Columbia than any other agent on record
[@taylor2003; @sambaraju2021]. Where a landscape is not killed uniformly the surviving
patches shape what the forest becomes, and one framework for them is disturbance refugia,
places buffered from disturbance over time [@krawchuk2020]. Explaining refugia rather than
merely locating them requires mechanistic links to landscape drivers such as terrain, soil
and stand structure [@cartwright2018].

@krawchuk2020 proposed such a mechanism: refugia could occur "in areas with cooler
temperatures (eg from topographic shading) that protect trees from water stress; in areas
with lower host density, allowing for greater wind disruption of beetle pheromone
communication and more vigorous tree growth and chemical defenses; and in areas with fewer
large-diameter host trees". Three mechanisms, two of them terrain, and none fitted spatially:
of the studies our screen retained, only a companion study on this landscape enters a wind
term, and its response is conifer regeneration rather than attack [@murphy2026].

The wind half is a claim about canopy, not open air. @cartwright2018, the one retained study
designed to model insect-refugium controls, found them in stands of low basal area: "thinner
stands also increase wind penetration, helping to disperse beetle pheromones and disrupt
chemical communications needed to coordinate attacks." @powell2014 state the converse as the
condition for outbreak: "higher local host density, which minimizes pheromone plume
dispersion, reduces wind, and promotes successful switching to nearby hosts, positively
influences outbreak propensity." A model that controls stand density out and then reads a
terrain coefficient as a wind effect has removed the pathway it set out to test.

Terrain acts through more than airflow. Flight is thermally gated at 19 to 41 degrees C, most
of it between 22 and 32, and "most flights occur on bright sunny days, and peak flight is in
the early to mid afternoon" [@safranyik2006chap1; @mccambridge1971]. Radiation during the
flight window is therefore a different quantity from radiation across the season, and the
season quantity is the one the shading pathway concerns. Light, temperature and wind are named
as one triad rather than as alternatives, stand density affecting "tree vigour and within-stand
microclimate, which in turn influence success of bark beetle dispersal, host selection, attack
or brood development" [@safranyik2006chap1], an argument @bartos1989 put in their title as
microclimate against tree vigour. Cool sites also push the beetle toward a two-year cycle
[@sambaraju2021], so shading and vigour predict the same sign by independent routes.

No product reports the wind the hypothesis concerns, an instantaneous below-canopy speed at
flight height during the flight period. Gridded climatologies report a long-run mean at 10 m
over open ground and are downscaled over a digital elevation model, making them partly a
transform of the terrain offered alongside them [@badger2014; @davis2023]. Nor does the
literature state the interval over which wind should be summarised. We therefore take wind
from station observations of each 16-day period, modify it over the terrain with the MicroMet
model [@liston2006], and test the response at Landsat's own 16-day repeat rather than annually.

@tbl-hypotheses gives the direction expected of each attribute and the reasoning behind it.
The objectives were to test whether stand density predicts moderate-to-high disturbance as the
pheromone mechanism requires, whether topographic shading predicts it against the microclimate
and adaptive-seasonality arguments, whether terrain shape predicts it independently of density
and radiation, whether the density effect is conditional on wind, and how much the answer
depends on temporal resolution.

"""
replace_section("# Introduction", "```{r}", INTRO)

LIMITS = r"""# Limitations {#sec-limits}

**Radiation and exposure are not separable in the flight window.** The prevailing bearing is
`r sprintf("%.0f", WDIR)` degrees, so windward slopes face west and take afternoon sun.
Flight-window radiation correlates `r cc("solar_flight_direct", "wind_effect")` with the
windward-leeward index. Its positive coefficient is consistent with the thermal gate and with
exposure raising attack, and this design cannot choose between them.

**Growing-season radiation tests aspect, not shading.** Its correlation with northness is
`r cc("solar_season_direct", "northness")`, and the water-stress pathway @krawchuk2020
describe is not measured here. It is separable from wind exposure,
`r cc("solar_season_direct", "wind_effect")`, which is the one thing it establishes.

**The wind field is modelled, not measured.** MicroMet modifies station observations over the
terrain. What is established is that the modelled field behaves as the mechanism requires,
not that the air did.

**The inventory postdates part of the outbreak.** Polygons interpreted after the beetle
passed describe the stand it left. Total basal area discriminates below chance,
`r sprintf("%.3f", uni$auc[uni$term == "BASAL_AREA"])`, most likely for this reason.

**The response is classified, not observed.** Disturbance is inferred from Landsat moisture
indices trained on plots cut from those indices, so reported accuracy measures separability
rather than agreement with ground mortality.

**One landscape, one outbreak.** Every conclusion is conditioned on a single mountain range
over `r EP_YEARS` years and `r EP_EPOCHS` epochs.

"""
replace_section("# Limitations {#sec-limits}", "# Data availability", LIMITS)

GEOM = r"""## Geomorphometry

Terrain is described by `r length(GEO_V)` geomorphometric surfaces computed with SAGA GIS
over the full reprojected elevation model and clipped afterwards, so a search radius near the
boundary sees real ground.

Radiation is computed twice because two mechanisms need it. Flight-window insolation is direct
and diffuse radiation over 1 July to 15 August restricted to 12:00 to 17:00, the hours
@safranyik2006chap1 identify as the flight peak; growing-season insolation is the whole-day
total from 1 May to 30 September, the shading quantity @krawchuk2020's first mechanism
concerns. A single annual heat index cannot separate them: flight-window direct radiation
spans a `r sprintf("%.0f", max(d$solar_flight_direct)/min(d$solar_flight_direct))`-fold range
here against `r sprintf("%.1f", max(d$solar_season_total)/min(d$solar_season_total))`-fold for
the season total.

Exposure enters as the windward-leeward index and effective air flow height at the prevailing
bearing, the omnidirectional wind exposition index, the wind shelter index and topographic
openness. Shape enters as terrain ruggedness, vector ruggedness, topographic position and its
multi-scale form, convergence, slope, curvature and geomorphon class. Landform enters as
topographic wetness, valley depth, height above the valley floor, normalised height and
mid-slope position, because infested groups are reported in draws and gullies and deep snow
insulates overwintering brood [@safranyik2006chap1]. Aspect enters as its northward and
eastward components with the heat load index of @mccune2002.

One distinction matters. The strongest aspect statements in @safranyik2006chap1 concern the
aspect of the bole, not the slope, and are within-tree effects a 30 m raster cannot measure.
Nothing here tests them.

"""
replace_section("## Geomorphometry", "## Terrain-resolved wind {#sec-micromet}", GEOM)

MMET = r"""## Terrain-resolved wind {#sec-micromet}

```{r}
#| label: micromet-load
#| echo: false
#| output: false

mmsum <- read.csv(file.path(BC, "covariates", "wind-micromet", "micromet_summary.csv"))
mmW   <- rast(file.path(BC, "covariates", "wind-micromet", "wind_weight_by_direction.tif"))
MM_WW <- range(as.vector(minmax(mmW)))
```

Station wind interpolated from four to seven valley stations is nearly flat within a year, so
wind is also computed as a field varying in space, using the MicroMet model of @liston2006.
WindNinja, the usual tool, ships no macOS binary. MicroMet's wind component is seven equations
rather than a program, implemented directly with the paper's equation numbers against each.

Terrain slope and slope azimuth come from the elevation model (equations 12, 13). Curvature is
a cell's elevation minus the mean of the two opposite cells one curvature length scale away,
on four direction lines and averaged (equation 14); the length scale is estimated as the first
lag at which elevation autocorrelation falls below 0.5, 600 m here. Slope in the wind direction
is $\Omega_s = \beta\cos(\theta-\xi)$ (equation 15), both scaled to $[-0.5, 0.5]$. The
weighting factor is $W_w = 1 + \gamma_s\Omega_s + \gamma_c\Omega_c$ with
$\gamma_s=\gamma_c=0.5$ (equation 16), the modified speed $W_t = W_wW$ (equation 17), and
direction is diverted by $\theta_d = -0.5\,\Omega_s\sin[2(\xi-\theta)]$ (equation 18).

$W_w$ depends on direction and not speed, so it is computed once for each of 16 direction bins
and each hourly observation multiplied by the surface for its own bin; nothing is averaged
before the terrain acts on it. Over all bins $W_w$ runs `r sprintf("%.2f", MM_WW[1])` to
`r sprintf("%.2f", MM_WW[2])`. Speed and direction combine as components because averaging
degrees across the 360/0 line is meaningless. The field varies
`r sprintf("%.1f", min(mmsum$spatial_range))` to
`r sprintf("%.1f", max(mmsum$spatial_range))` km/h across the grid within a year, and is not a
repackaged terrain index: it correlates `r cc("mm_flight_mean", "wind_effect")` with the
windward-leeward index and `r cc("mm_flight_mean", "solar_flight_direct")` with flight
radiation. Its strongest association is with elevation,
`r cc("mm_flight_mean", "elevation")`.

"""
replace_section("## Terrain-resolved wind {#sec-micromet}", "## Flight-window wind", MMET)

PREV = r"""## Previous-year pressure {#sec-autologistic}

Attack recurs where it was, by a margin that changes how every other coefficient reads. A cell
attacked one year is between
`r sprintf("%.0f", min(read.csv(file.path(BC, "model-data", "lag1_persistence.csv"))$odds_ratio))`
and
`r sprintf("%.0f", max(read.csv(file.path(BC, "model-data", "lag1_persistence.csv"))$odds_ratio))`
times more likely to be attacked the next. Entering persistence and 90 m spread separately,
after the autologistic design used for this province, gives `r b4("lag_self")` and
`r b4("lag_nbr90")`, raising discrimination from `r sprintf("%.3f", AUC3l)` to
`r sprintf("%.3f", AUC4)`.

Which environmental terms survive is the informative part (@tbl-autologistic). Growing-season
radiation retains `r ret("solar_season_direct")` and ruggedness `r ret("tri")`, the terms
describing conditions a cell has whether or not the beetle was there. The landform terms do
not: valley depth retains `r ret("valley_depth")` and mid-slope position
`r ret("midslope_position")`. Most of what they measured was where the outbreak had already
been, which is the same failure the terrain-wind index showed against radiation, one level up.

"""
replace_section("## Previous-year pressure {#sec-autologistic}", "## Host as diameter {#sec-diameter}", PREV)

RES = r"""Every pathway earns its place: AIC falls `r fmt(aic$AIC[1] - aic$AIC[2])` when stand density
enters, `r fmt(aic$AIC[2] - aic$AIC[3])` more with terrain and flight radiation, and
`r fmt(aic$AIC[3] - aic$AIC[4])` more with the interactions (@tbl-aic).

Stand density is supported in one of its three measures. Standing volume carries
`r b3("LIVE_STAND_VOLUME_125")` log-odds per standard deviation, stem count
`r b3("VRI_LIVE_STEMS_PER_HA")`, and crown closure nothing (p = `r p3("CROWN_CLOSURE")`).
Total basal area did not survive selection, its univariate discrimination being
`r sprintf("%.3f", uni$auc[uni$term == "BASAL_AREA"])`. What predicts attack is standing wood
in large stems, not how many stems there are.

Radiation enters twice with opposite signs, `r b3("solar_flight_direct")` for the flight window
and `r b3("solar_season_direct")` for the growing season, so a single annual index would have
cancelled them. Shaded ground carries more attack, against the prediction.

Terrain predicts attack independently of both. Ruggedness is `r b3("tri")`, the vector
ruggedness measure agrees at `r b3("vrm")`, the windward-leeward index is
`r b3("wind_effect")`, and elevation remains the largest single term at `r b3("elevation")`.
Ruggedness takes the opposite sign to the parent study's, whose response is seedling
establishment rather than attack [@murphy2026].

Fitted without flight-window radiation, stand density interacts with terrain exposure at
`r bnr(I_GEO)`, which reads as a wind result pointing the wrong way. With radiation in the
model that interaction is `r b3(I_GEO)` (p = `r p3(I_GEO)`) and density interacts with
radiation at `r b3(paste0(DENS[1], ":", FSUN[1]))`. On a range whose prevailing bearing is
`r sprintf("%.0f", WDIR)` degrees the windward slopes face west, which are also the slopes
taking afternoon sun, so the exposure index was standing in for insolation.

"""
a = s.find("Every pathway the review identified earns its place.")
b = s.find("```{r}\n#| label: fig-interaction")
if a > 0 and b > a:
    s = s[:a] + RES + s[b:]
else:
    print("  SKIP results compression", file=sys.stderr)

open(DST, "w").write(s)
print(f"wrote {DST}, {len(s)} chars")
