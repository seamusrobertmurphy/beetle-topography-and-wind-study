#!/usr/bin/env Rscript
## The annual Vegetation Resources Inventory, one snapshot per study year.
##
## Why this exists. Until 2026-08-28 the stand structure came from the live WFS layer
## WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY, which is a single composite projected to
## 2025. Every annual observation of a cell therefore carried the SAME basal area, volume,
## stems and diameter, so the host terms had no time variation at all, and the attributes
## had been grown forward through and past the outbreak they were meant to predict. On the
## study perimeter that layer gives a mean basal area of 35.18 m2/ha; the year-matched 2014
## snapshot gives 30.0, with 787 stems per hectare against 670 and a quadratic mean
## diameter of 26.74 cm against 30.13.
##
## The province publishes the correct thing: VRI - HISTORICAL Vegetation Resource
## Inventory (2002 - 2024), catalogue id 02dba161-fdb7-48ae-a4bb-bd6ef017c36d, one File
## Geodatabase per year, "updated for depletions, such as harvesting, and projected
## annually for growth". Each year's PROJECTED_DATE is 31 December of the year before its
## label, so the 2014 file is the stand as it stood entering 2014.
##
## Two things make this practical. The archives are about 3.9 GB each, so downloading all
## nine would be 35 GB; GDAL can instead read them in place over HTTP and pull only the
## byte ranges the spatial filter needs. But the server answers HEAD with 404, which
## breaks vsicurl's size probe and makes the dataset look unopenable, so
## CPL_VSIL_CURL_USE_HEAD=NO is required and is not optional.
##
## Writes: study-area/vri-timeseries/vri_<year>.gpkg, clipped to the map page in EPSG:3153
##
## Run:  /usr/local/bin/Rscript 02.inputs/beetle/50-fetch-vri-timeseries.R

suppressPackageStartupMessages({library(sf); library(terra)})

ROOT <- "02.inputs/beetle"
SA   <- file.path(ROOT, "study-area")
OUT  <- file.path(SA, "vri-timeseries"); dir.create(OUT, showWarnings = FALSE)
BASE <- "https://pub.data.gov.bc.ca/datasets/02dba161-fdb7-48ae-a4bb-bd6ef017c36d"

## The study years. 2012 is absent by design: it is the one year covered only by Landsat 7
## with its scan-line corrector off, and it is excluded from the response as well.
YEARS <- c(2005:2011, 2013, 2014)

## Nothing about these archives is uniform, so nothing is guessed. Three things vary:
##   the zip's file name        VRI2005_..._FINAL_DELIVERYV4.gdb.zip up to 2006, then
##                              VEG_COMP_LYR_R1_POLY_<year>.gdb.zip
##   the folder inside the zip  usually matches the zip stem, but where it does not GDAL
##                              cannot descend into it and reports the whole archive as
##                              "not recognized as being in a supported file format",
##                              which reads as a corrupt download and is not one
##   the layer inside the gdb   VEG_COMP_LYR_R1_POLY from 2007, but
##                              VEG_COMP_LYR_R1_POLY_FINALV4 in 2005 and 2006
## The first is read from the directory listing, the other two from the archive itself.

GDALENV <- c("CPL_VSIL_CURL_USE_HEAD=NO", "GDAL_DISABLE_READDIR_ON_OPEN=EMPTY_DIR",
             "GDAL_HTTP_TIMEOUT=600")

zip_for <- function(y) {
  h <- readLines(url(sprintf("%s/%d/", BASE, y)), warn = FALSE)
  f <- unlist(regmatches(h, gregexpr('[A-Za-z0-9_]+\\.gdb\\.zip', h)))
  f <- unique(f[grepl("R1_POLY", f)])
  if (!length(f)) stop("no R1 polygon archive listed for ", y)
  f[1]
}

## Descend into the zip and name the .gdb explicitly, then ask OGR for its layer. None of
## the three is derivable from the year: the zip name changes after 2006, the folder inside
## it is VRI2006_..._V4.gdb in 2006 but lowercase veg_comp_lyr_r1_poly.gdb in 2009 and
## veg_comp_lyr_r1.gdb in 2011, and the layer is VEG_COMP_LYR_R1_POLY_FINALV4 before 2007.
##
## The listing is read with sf::gdal_utils("info") rather than by shelling out to Python,
## which is what failed for 2009 and 2011: the answer arrived on a line the caller was not
## reading and the year was reported as unresolvable when the archive was fine.
source_for <- function(y) {
  zf <- zip_for(y)
  z  <- sprintf("/vsizip//vsicurl/%s/%d/%s", BASE, y, zf)
  ## No listing API is used. Every inner-folder form the series has actually shown is
  ## tried against ogrinfo, plus the bare archive, and whichever opens is the source.
  ## Listing the zip was the fragile step: it worked for some years and returned nothing
  ## for 2009 and 2011, which were then reported as unresolvable although both open fine.
  stem <- sub("[.]gdb[.]zip$", "", zf)
  cands <- c(z,
             file.path(z, paste0(stem, ".gdb")),
             file.path(z, "VEG_COMP_LYR_R1_POLY.gdb"),
             file.path(z, "veg_comp_lyr_r1_poly.gdb"),
             file.path(z, "veg_comp_lyr_r1.gdb"),
             file.path(z, tolower(paste0(stem, ".gdb"))))
  for (src in unique(cands)) {
    info <- suppressWarnings(system2("ogrinfo", c("-ro", shQuote(src)), env = GDALENV,
                                     stdout = TRUE, stderr = TRUE))
    lyr <- grep("^Layer: ", info, value = TRUE)
    if (length(lyr)) {
      lyr <- trimws(sub("\\(.*$", "", sub("^Layer: ", "", lyr[1])))
      if (nzchar(lyr)) return(list(src = src, layer = lyr))
    }
  }
  stop("no readable layer for ", y)
}

## Field names are not stable across the series. 2007 and earlier use the older truncated
## schema, so the same attribute arrives under a different name and a naive extract silently
## returns a year with most of its columns missing. Standing volume is the one attribute
## with no single equivalent before 2008: it exists only per species, VOLSP1_125 through
## VOLSP6_125, which sum to it.
FIELD_MAP <- list(
  CROWN_CLOSURE         = c("CROWN_CLOSURE", "CR_CLOSURE"),
  VRI_LIVE_STEMS_PER_HA = c("VRI_LIVE_STEMS_PER_HA", "LIVE_STEMS"),
  QUAD_DIAM_125         = c("QUAD_DIAM_125", "Q_DIAM_125"),
  PROJ_HEIGHT_1         = c("PROJ_HEIGHT_1", "PROJ_HT_1"),
  SPECIES_CD_1          = c("SPECIES_CD_1", "SPEC_CD_1"),
  SPECIES_PCT_1         = c("SPECIES_PCT_1", "SPEC_PCT_1"),
  BASAL_AREA            = c("BASAL_AREA"),
  PROJ_AGE_1            = c("PROJ_AGE_1"),
  LIVE_STAND_VOLUME_125 = c("LIVE_STAND_VOLUME_125")
)
## Per-species volume carries three different names across the series: VOLSP1_125 in the
## 2007 and earlier schema, VOL_PER_HA_SPP1_125 in 2008, and a single
## LIVE_STAND_VOLUME_125 from 2009. All three are handled, because a year whose volume
## column is merely renamed is not a year with missing volume.
VOLSP <- c(sprintf("VOLSP%d_125", 1:6), sprintf("VOL_PER_HA_SPP%d_125", 1:6))

## Rename what the map covers, and rebuild standing volume from the per-species columns
## where the single column is absent. Returns the layer with the modern names.
harmonise <- function(v) {
  for (target in names(FIELD_MAP)) {
    if (target %in% names(v)) next
    alt <- FIELD_MAP[[target]][FIELD_MAP[[target]] %in% names(v)]
    if (length(alt)) names(v)[names(v) == alt[1]] <- target
  }
  if (!"LIVE_STAND_VOLUME_125" %in% names(v)) {
    have <- VOLSP[VOLSP %in% names(v)]
    if (length(have)) {
      m <- as.data.frame(sf::st_drop_geometry(v)[, have, drop = FALSE])
      m[] <- lapply(m, function(x) { x <- as.numeric(x); x[!is.finite(x)] <- 0; x })
      v$LIVE_STAND_VOLUME_125 <- rowSums(m)
      attr(v, "volume_from") <- paste(have, collapse = "+")
    }
  }
  v
}

g <- rast(file.path(SA, "geomorphometry_context.tif"))
e <- unname(as.vector(ext(g)))
cat(sprintf("clipping to the map page, EPSG:3153: %.0f %.0f %.0f %.0f\n",
            e[1], e[3], e[2], e[4]))

for (y in YEARS) {
  out <- file.path(OUT, sprintf("vri_%d.gpkg", y))
  if (file.exists(out)) { cat(sprintf("  %d already extracted\n", y)); next }
  t0 <- Sys.time()
  sl <- tryCatch(source_for(y), error = function(e) NULL)
  if (is.null(sl)) { cat(sprintf("  %d: could not resolve archive or layer\n", y)); next }
  cat(sprintf("  %d: layer %s\n", y, sl$layer))
  st <- system2("ogr2ogr",
    c("-f", "GPKG", shQuote(out), shQuote(sl$src), shQuote(sl$layer),
      "-spat", e[1], e[3], e[2], e[4], "-spat_srs", "EPSG:3153",
      "-t_srs", "EPSG:3153"),
    env = GDALENV, stdout = TRUE, stderr = TRUE)
  mins <- as.numeric(difftime(Sys.time(), t0, units = "mins"))
  code <- attr(st, "status"); code <- if (is.null(code)) 0L else code
  if (code != 0 || !file.exists(out)) {
    cat(sprintf("  %d FAILED (%s) after %.1f min\n", y, code, mins))
    cat(paste0("      ", head(st, 6)), sep = "\n")
    unlink(out); next
  }
  v <- harmonise(st_read(out, quiet = TRUE))
  st_write(v, out, delete_dsn = TRUE, quiet = TRUE)
  miss <- setdiff(names(FIELD_MAP), names(v))
  cat(sprintf("  %d: %5d polygons, projected %s, %.1f min%s%s\n", y, nrow(v),
      if ("PROJECTED_DATE" %in% names(v)) substr(as.character(v$PROJECTED_DATE[1]),1,10) else "unstated",
      mins,
      if (!is.null(attr(v, "volume_from"))) paste0(", volume from ", attr(v, "volume_from")) else "",
      if (length(miss)) paste0(", MISSING ", paste(miss, collapse=",")) else ""))
}

## A single summary so the series can be checked at a glance rather than opened file by
## file. If basal area does not move across the nine years, the extraction is wrong.
files <- list.files(OUT, pattern = "^vri_\\d{4}\\.gpkg$", full.names = TRUE)
if (length(files)) {
  s <- do.call(rbind, lapply(files, function(f) {
    v <- st_read(f, quiet = TRUE)
    data.frame(year = as.integer(sub(".*vri_(\\d{4})\\.gpkg", "\\1", f)),
               polygons = nrow(v),
               projected = substr(as.character(v$PROJECTED_DATE[1]), 1, 10),
               basal_area = mean(v$BASAL_AREA, na.rm = TRUE),
               stems = mean(v$VRI_LIVE_STEMS_PER_HA, na.rm = TRUE),
               qmd = mean(v$QUAD_DIAM_125, na.rm = TRUE),
               volume = mean(v$LIVE_STAND_VOLUME_125, na.rm = TRUE))
  }))
  s <- s[order(s$year), ]
  write.csv(s, file.path(OUT, "vri_timeseries_summary.csv"), row.names = FALSE)
  print(s, row.names = FALSE, digits = 4)
}
