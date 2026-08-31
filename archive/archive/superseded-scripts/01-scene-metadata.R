# Gate 1(a) and 1(c): which sensor actually supplied each annual scene, and
# whether 2012 was a cloud rejection or an omission.
#
# The parent paper is internally inconsistent on this. Table 2 of
# FORECO-D-26-01171_Manuscript-FINAL-greycorrected.docx lists "Landsat 5" for
# every beetle scene including 2013 Aug 31, which is impossible: Landsat 5
# stopped acquiring in November 2011. The same paper's Methods (cleaned-text
# lines 122-123) says the beetle series came from "Landsat 7 ETM+ L1GT and
# Landsat 8 OLI". This script resolves the question from scene metadata.
#
# Run: /usr/local/bin/Rscript 02.inputs/beetle/01-scene-metadata.R

suppressMessages(library(rgee))
ee_Initialize(project = "murphys-deforisk", quiet = TRUE)

# Analysis grid bounding box, from Elevation.utm.tif (EPSG:32611, 25.11 m,
# 695 x 639 cells, E 515617.9-531665.3, N 5437375-5454829).
AOI <- ee$Geometry$Rectangle(c(-116.7861, 49.0884, -116.5649, 49.2460))

# Dates as printed in Table 2 of the parent paper.
tbl2 <- data.frame(
  role = c("Pre-outbreak", rep("Early-outbreak", 3), rep("Mid-outbreak", 3),
           rep("Post-outbreak", 2), "Pre-fire(-1yr)", "Pre-fire(-1mth)",
           "Post-fire(+1yr)", "Post-fire(+5yrs)"),
  date = c("2003-08-20","2005-08-09","2006-08-28","2007-08-15","2008-08-17",
           "2009-08-20","2010-08-07","2011-08-10","2013-08-31","2014-07-01",
           "2015-07-04","2016-07-20","2020-09-03"),
  table2_sensor = c(rep("Landsat 5", 9), rep("Landsat 8", 4)),
  stringsAsFactors = FALSE)

COLS <- c(LT05 = "LANDSAT/LT05/C02/T1_L2",
          LE07 = "LANDSAT/LE07/C02/T1_L2",
          LC08 = "LANDSAT/LC08/C02/T1_L2")
PROPS <- list("system:index", "SPACECRAFT_ID", "DATE_ACQUIRED",
              "WRS_PATH", "WRS_ROW", "CLOUD_COVER", "CLOUD_COVER_LAND")

# Pull every scene intersecting the grid, 2003-2020, as one table per sensor.
pull <- function(id) {
  fc <- ee$ImageCollection(id)$
    filterBounds(AOI)$
    filterDate("2003-01-01", "2021-01-01")$
    map(function(im) ee$Feature(NULL, im$toDictionary(PROPS)))
  x <- ee$FeatureCollection(fc)$getInfo()
  if (length(x$features) == 0) return(NULL)
  g <- function(p, k) { v <- p[[k]]; if (is.null(v) || length(v) == 0) NA else v[1] }
  do.call(rbind, lapply(x$features, function(f) {
    p <- f$properties
    data.frame(index = g(p, "system:index"), sensor = g(p, "SPACECRAFT_ID"),
               date = g(p, "DATE_ACQUIRED"), path = g(p, "WRS_PATH"),
               row = g(p, "WRS_ROW"), cloud = as.numeric(g(p, "CLOUD_COVER")),
               cloud_land = as.numeric(g(p, "CLOUD_COVER_LAND")),
               stringsAsFactors = FALSE)
  }))
}
sc <- do.call(rbind, lapply(COLS, pull))
sc <- sc[order(sc$date), ]
rownames(sc) <- NULL
cat(sprintf("Scenes intersecting the analysis grid, 2003-2020: %d\n", nrow(sc)))
cat("WRS-2 path/row present:",
    paste(unique(sprintf("%s/%s", sc$path, sc$row)), collapse = ", "), "\n\n")

cat("=== Gate 1(a): what actually flew on each Table 2 date ===\n")
for (i in seq_len(nrow(tbl2))) {
  hit <- sc[sc$date == tbl2$date[i], ]
  if (nrow(hit) == 0) {
    cat(sprintf("%-16s %s  Table 2 says %-9s -> NO SCENE ON THIS DATE\n",
                tbl2$role[i], tbl2$date[i], tbl2$table2_sensor[i]))
  } else {
    for (j in seq_len(nrow(hit)))
      cat(sprintf("%-16s %s  Table 2 says %-9s -> %s  p%s/r%s cloud %.1f%%  %s\n",
                  tbl2$role[i], tbl2$date[i], tbl2$table2_sensor[i],
                  hit$sensor[j], hit$path[j], hit$row[j], hit$cloud[j], hit$index[j]))
  }
}

cat("\n=== Gate 1(c): growing-season scenes per year, 1 Jun to 30 Aug ===\n")
cat("(the parent's stated selection window, Methods cleaned-text line 122:\n")
cat(" \"cloud-free days (<20% cloud cover) between 1 June and 30 August\")\n\n")
sc$year <- as.integer(substr(sc$date, 1, 4))
sc$mmdd <- substr(sc$date, 6, 10)
gs <- sc[sc$mmdd >= "06-01" & sc$mmdd <= "08-30", ]
for (y in 2003:2016) {
  g <- gs[gs$year == y, ]
  ok <- g[g$cloud < 20, ]
  cat(sprintf("%d: %2d scene(s), %2d under 20%% cloud", y, nrow(g), nrow(ok)))
  if (nrow(ok) > 0)
    cat("  | ", paste(sprintf("%s %s %.1f%%", ok$date, ok$sensor, ok$cloud),
                      collapse = "; "))
  cat("\n")
}

write.csv(sc, "02.inputs/beetle/landsat-scene-inventory.csv",
          row.names = FALSE)
cat("\nWrote 02.inputs/beetle/landsat-scene-inventory.csv\n")
