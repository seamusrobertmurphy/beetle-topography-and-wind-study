## Academic base maps for this manuscript's figures.
##
## Sourced by every draft, so a change to the cartography reaches all of them and the
## three cannot show different maps of the same landscape.
##
## What this fixes. The earlier panels drew a raster clipped to the study perimeter and
## nothing else. The perimeter is the 2015 burn buffered 5 km and then cut to the parent
## study's elevation band, so its edge is ragged and it encloses a hole; with no
## surrounding feature on the page, that reads as a rendering fault rather than a study
## boundary, and a reader cannot place the site. Kootenay Lake is 1.9 km away and the
## Kootenay River 0.6 km, so a small opening of the extent brings a landmark onto every
## panel.
##
## Requires: terra, sf, ggplot2, tidyterra, ggspatial.

suppressPackageStartupMessages({
  library(terra); library(sf); library(ggplot2); library(tidyterra); library(ggspatial)
})

MAP_CRS   <- 3153      # NAD83(CSRS) / BC Albers, the parent study's grid
MAP_PAD   <- 3500      # metres of context beyond the perimeter; the lake shore is at 1900
MAP_PANEL <- 66        # nominal printed panel width in mm, for the representative fraction
MAP_CONT  <- 250       # contour interval, metres

## ---------------------------------------------------------------------------------
## Page furniture, built once and reused by every panel.
## ---------------------------------------------------------------------------------
map_context <- function(perimeter, dem, water_path) {
  bb <- st_bbox(st_transform(perimeter, MAP_CRS))
  ## unname() is load-bearing. bb["xmin"] keeps its name, and c(xmin = <named>) yields
  ## "xmin.xmin", which st_bbox rejects with a message naming no coordinate at all.
  xl <- unname(c(bb["xmin"] - MAP_PAD, bb["xmax"] + MAP_PAD))
  yl <- unname(c(bb["ymin"] - MAP_PAD, bb["ymax"] + MAP_PAD))
  page <- st_as_sfc(st_bbox(c(xmin = xl[1], xmax = xl[2], ymin = yl[1], ymax = yl[2]),
                            crs = st_crs(MAP_CRS)))

  ## Select the water features that reach the page rather than cropping them. Some
  ## Freshwater Atlas polygons carry NA vertices and st_crop stops on them with
  ## "!anyNA(x) is not TRUE"; ggplot clips to the coord_sf limits anyway.
  w <- st_transform(st_read(water_path, quiet = TRUE), MAP_CRS)
  w <- st_make_valid(w[!st_is_empty(w), ])
  w <- w[lengths(st_intersects(w, page)) > 0, ]

  ## Contours stop at the edge of the elevation model, which is honest: no elevation was
  ## obtained beyond it, and drawing them further would invent ground.
  rng <- as.vector(minmax(dem))
  brk <- seq(ceiling(rng[1] / MAP_CONT) * MAP_CONT, rng[2], by = MAP_CONT)
  cont <- if (length(brk)) st_as_sf(as.contour(dem, levels = brk)) else NULL

  ## The representative fraction holds only at the nominal printed width, which the
  ## caption states. A scale bar is the robust companion, so both are drawn.
  rf <- round((diff(xl) * 1000 / MAP_PANEL) / 1000) * 1000

  list(xl = xl, yl = yl, water = w, cont = cont, perimeter = st_transform(perimeter, MAP_CRS),
       rf = rf, rf_label = paste0("1:", formatC(rf, format = "d", big.mark = ",")))
}

## ---------------------------------------------------------------------------------
## One panel. `first` adds the north arrow, the scale bar and the representative
## fraction; the panels share an extent, a projection and a scale, so repeating that
## furniture on each one is clutter and the caption says so instead.
## ---------------------------------------------------------------------------------
academic_map <- function(r, title, ctx, palette = "viridis", burn = NULL,
                         first = FALSE, base_size = 8, contours = TRUE) {
  km <- function(x) sprintf("%.0f", x / 1000)
  g <- ggplot() +
    geom_sf(data = ctx$water, fill = "#c6dbef", colour = "#9ecae1", linewidth = 0.15) +
    geom_spatraster(data = r, maxcell = 5e5) +
    scale_fill_viridis_c(option = palette, na.value = "transparent", name = NULL)
  if (contours && !is.null(ctx$cont))
    g <- g + geom_sf(data = ctx$cont, colour = "grey40", linewidth = 0.08, alpha = 0.45)
  g <- g + geom_sf(data = ctx$perimeter, fill = NA, colour = "grey15", linewidth = 0.35)
  if (!is.null(burn))
    g <- g + geom_sf(data = st_transform(burn, MAP_CRS), fill = NA,
                     colour = "#d7301f", linewidth = 0.4)
  g <- g +
    ## datum = the map's own CRS draws the projected grid the axis ticks are labelled in,
    ## rather than a latitude and longitude graticule that matches no tick on the frame.
    coord_sf(xlim = ctx$xl, ylim = ctx$yl, expand = FALSE, datum = st_crs(MAP_CRS)) +
    scale_x_continuous(labels = km) + scale_y_continuous(labels = km) +
    labs(title = title, x = "Easting (km)", y = "Northing (km)") +
    theme_bw(base_size = base_size) +
    theme(panel.grid = element_line(colour = "grey82", linewidth = 0.15),
          plot.title = element_text(size = base_size + 1),
          legend.key.width = unit(0.22, "cm"),
          legend.key.height = unit(0.55, "cm"))
  if (first)
    g <- g +
      annotation_scale(location = "bl", width_hint = 0.34, height = unit(0.11, "cm"),
                       text_cex = 0.5, line_width = 0.4, pad_y = unit(0.42, "cm")) +
      annotation_north_arrow(location = "tr", height = unit(0.62, "cm"),
                             width = unit(0.42, "cm"), style = north_arrow_minimal()) +
      annotate("text", x = ctx$xl[1] + 0.02 * diff(ctx$xl),
               y = ctx$yl[1] + 0.02 * diff(ctx$yl), hjust = 0, vjust = 0,
               size = base_size * 0.22, colour = "grey25", label = ctx$rf_label)
  g
}
