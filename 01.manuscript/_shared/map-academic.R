## Academic base maps for this manuscript's figures.
##
## Sourced by every draft, so a change to the cartography reaches all of them and the
## three cannot show different maps of the same landscape.
##
## Why the data raster has the shape it has, since every map shows it and a reader will
## ask. The study perimeter is the 2015 Mt Midgeley burn buffered 5 km and then cut to
## the elevation band the parent study's site occupies, 830 to 1744 m. That cut removes
## 28,633 cells from inside the perimeter's own hull: 59.7 per cent of them lie above
## the 1744 m ceiling, median 1773 m and up to 2161 m, and 39.4 per cent below the 830 m
## floor. So the hole in the middle of the ring is the summit ridge and the ragged outer
## edge is the valley floor. The analysis area is a band around a mountain, by
## construction, and drawing it over a hillshade is what makes that legible rather than
## looking like a clipping error.
##
## Requires: terra, sf, ggplot2, tidyterra, ggspatial, ggnewscale.

suppressPackageStartupMessages({
  library(terra); library(sf); library(ggplot2); library(tidyterra)
  library(ggspatial); library(ggnewscale)
})

MAP_CRS   <- 3153      # NAD83(CSRS) / BC Albers, the parent study's grid
MAP_RF    <- 250000    # the representative fraction every panel reports
MAP_PANEL <- 66        # nominal printed panel width, mm
MAP_CONT  <- 200       # contour interval, metres

## The extent follows from the scale rather than the scale from the extent. At 1:250,000
## on a 66 mm panel the ground width is 16.5 km exactly, so the page is set to that and
## the ratio printed on every panel is true rather than rounded to whatever the
## perimeter happened to span. 48-fetch-basemap-relief.R uses the same two constants and
## the two must agree.
MAP_W     <- MAP_RF * MAP_PANEL / 1000     # 16,500 m
MAP_ASPECT <- 20190 / 15960                # page height as a multiple of its width

map_context <- function(perimeter, burn, sa_dir) {
  per <- st_transform(perimeter, MAP_CRS)
  ## Centre the fixed-scale page on the perimeter. unname() is load-bearing: a named
  ## coordinate here yields "xmin.xmin", which st_bbox rejects with a message naming no
  ## coordinate at all.
  ctr <- as.numeric(st_coordinates(st_centroid(st_union(per))))
  xl <- unname(ctr[1] + c(-1, 1) * MAP_W / 2)
  yl <- unname(ctr[2] + c(-1, 1) * MAP_W * MAP_ASPECT / 2)
  page <- st_as_sfc(st_bbox(c(xmin = xl[1], xmax = xl[2], ymin = yl[1], ymax = yl[2]),
                            crs = st_crs(MAP_CRS)))

  ## A cached grey relief base map, Esri World Shaded Relief, downloaded once by
  ## 48-fetch-basemap-relief.R. A hillshade computed from the project's own DEM was tried
  ## first and rejected: that elevation model is a rotated rectangle in this projection,
  ## so it cut a hard diagonal across every panel, and its narrow value range rendered
  ## flat. The contours below still come from the project's own DEM.
  relief <- rast(file.path(sa_dir, "basemap_relief.tif"))
  dem <- rast(file.path(sa_dir, "dem_context.tif"))

  ## Select the water features that reach the page rather than cropping them. Some
  ## Freshwater Atlas polygons carry NA vertices and st_crop stops on them with
  ## "!anyNA(x) is not TRUE"; ggplot clips to the coord_sf limits anyway.
  w <- st_transform(st_read(file.path(sa_dir, "basemap_water.geojson"), quiet = TRUE), MAP_CRS)
  w <- st_make_valid(w[!st_is_empty(w), ])
  w <- w[lengths(st_intersects(w, page)) > 0, ]

  rng <- as.vector(minmax(dem))
  brk <- seq(ceiling(rng[1] / MAP_CONT) * MAP_CONT, rng[2], by = MAP_CONT)
  cont <- st_as_sf(as.contour(dem, levels = brk))

  ## The representative fraction holds only at the nominal printed panel width, which
  ## the caption states. Journal of Applied Entomology asked for a numerical scale, so
  ## the ratio is printed and no scale bar is drawn.
  list(xl = xl, yl = yl, water = w, cont = cont, relief = relief,
       perimeter = per, burn = st_transform(burn, MAP_CRS),
       rf_label = paste0("1:", formatC(MAP_RF, format = "d", big.mark = ",")))
}

## One panel. Every panel carries its own north arrow and its own numerical scale,
## because a reader should not have to look at a neighbouring panel to size this one.
academic_map <- function(r, title, ctx, palette = "viridis", base_size = 8,
                         contours = TRUE) {
  km <- function(x) sprintf("%.0f", x / 1000)
  g <- ggplot() +
    ## The grey relief base map first, as RGB, so everything above it reads against it.
    geom_spatraster_rgb(data = ctx$relief, maxcell = 6e5)
  if (contours)
    g <- g + geom_sf(data = ctx$cont, colour = "grey45", linewidth = 0.07, alpha = 0.5)
  g <- g +
    ## No alpha on the data layer. geom_spatraster applies alpha to the whole layer
    ## including its NA cells, which paints a pale rectangle over the hillshade wherever
    ## the analysis raster has no data. The data is opaque instead, and the hillshade
    ## shows through where it matters: the excluded summit, and the ground beyond the
    ## perimeter.
    geom_spatraster(data = r, maxcell = 6e5) +
    scale_fill_viridis_c(option = palette, na.value = "transparent", name = NULL) +
    ## Water goes OVER the data, not under it. The surfaces now fill the page, so drawn
    ## underneath the lakes simply disappear, and a stand basal area painted across
    ## Kootenay Lake is worse than no base map at all.
    geom_sf(data = ctx$water, fill = "#a8cae4", colour = "#7fb0d0", linewidth = 0.15) +
    ## The perimeter has to read against both a pale and a near-black surface, so it is
    ## drawn as a white casing under a dark line rather than as one stroke.
    geom_sf(data = ctx$perimeter, fill = NA, colour = "white", linewidth = 0.75) +
    geom_sf(data = ctx$perimeter, fill = NA, colour = "grey5", linewidth = 0.3) +
    ## The burn anchors the perimeter, so it belongs on every panel, not just the first.
    geom_sf(data = ctx$burn, fill = NA, colour = "white", linewidth = 0.8) +
    geom_sf(data = ctx$burn, fill = NA, colour = "#d7301f", linewidth = 0.4) +
    ## datum = the map's own CRS draws the projected grid the ticks are labelled in.
    ## Omit it and ggplot draws a latitude and longitude graticule matching no tick.
    coord_sf(xlim = ctx$xl, ylim = ctx$yl, expand = FALSE, datum = st_crs(MAP_CRS)) +
    scale_x_continuous(labels = km) + scale_y_continuous(labels = km) +
    labs(title = title, x = "Easting (km)", y = "Northing (km)") +
    annotation_north_arrow(location = "tr", height = unit(0.55, "cm"),
                           width = unit(0.36, "cm"), style = north_arrow_minimal(),
                           pad_x = unit(0.12, "cm"), pad_y = unit(0.12, "cm")) +
    annotate("label", x = ctx$xl[1] + 0.03 * diff(ctx$xl),
             y = ctx$yl[1] + 0.03 * diff(ctx$yl), hjust = 0, vjust = 0,
             label = ctx$rf_label, size = base_size * 0.26, colour = "grey15",
             fill = alpha("white", 0.75), label.padding = unit(0.08, "cm")) +
    theme_bw(base_size = base_size) +
    theme(panel.grid = element_line(colour = "grey70", linewidth = 0.12),
          plot.title = element_text(size = base_size + 1),
          legend.key.width = unit(0.2, "cm"), legend.key.height = unit(0.5, "cm"))
  g
}
