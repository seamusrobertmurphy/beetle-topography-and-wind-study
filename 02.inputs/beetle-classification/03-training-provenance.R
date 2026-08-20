# Gate 3 blocker check: which Landsat product supplied the 310-row training
# sample, and can it be applied to the annual composites the pipeline builds?
#
# The masterfile sheet `dataset_beetleplots` in
#   ~/repos/publications-pending/Darkwoods-Disturbance-Paper/
#     2.ExcelData/1.0.darkwoods_masterfile.xlsx
# names every band column with a 2020 prefix (2020B1Aero ... 2020NDMI_c), and
# the parent's Methods says the plots were established "during July and August
# 2020". Table 2's last row is Landsat 8, 2020 Sept 03. So the classifier that
# maps 2005-2014 attack was trained on 2020 imagery.
#
# This script compares the training band ranges against that scene at both
# product levels, to establish which one the sample was drawn from.
#
# Run: /usr/local/bin/Rscript 02.inputs/beetle-classification/03-training-provenance.R

suppressMessages(library(rgee))
ee_Initialize(project = "murphys-deforisk", quiet = TRUE)

e <- new.env()
load("/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/4.RData/1.Beetle_plots/.RData",
     envir = e)
d <- e$darkwoods_beetle_plots_data_II
tb <- c("B1Aerosol","B2Blue","B3Gree","B4Red","B5NIR","B6SW1","B7SW2")
tr <- sapply(d[tb], range)

AOI <- ee$Geometry$Rectangle(c(-116.7861, 49.0884, -116.5649, 49.2460))
ee_bands <- c("B1","B2","B3","B4","B5","B6","B7")
l2_bands <- c("SR_B1","SR_B2","SR_B3","SR_B4","SR_B5","SR_B6","SR_B7")

stat <- function(coll, bands, label) {
  im <- ee$ImageCollection(coll)$filterBounds(AOI)$
    filterDate("2020-09-03", "2020-09-04")$first()
  if (is.null(im$getInfo())) { cat(label, ": no scene\n"); return(invisible()) }
  r <- im$select(bands)$reduceRegion(
    reducer = ee$Reducer$percentile(list(2, 98)),
    geometry = AOI, scale = 30, maxPixels = 1e9, bestEffort = TRUE)$getInfo()
  cat(sprintf("\n%s  (2nd and 98th percentile over the analysis grid)\n", label))
  for (i in seq_along(bands)) {
    lo <- r[[paste0(bands[i], "_p2")]]; hi <- r[[paste0(bands[i], "_p98")]]
    cat(sprintf("  %-6s scene %10.1f to %10.1f   training %8.0f to %8.0f\n",
                tb[i], lo, hi, tr[1, i], tr[2, i]))
  }
}

cat("Training sample band ranges are the right-hand columns below.\n")
stat("LANDSAT/LC08/C02/T1",    ee_bands, "Collection 2 Level-1 quantised DN")
stat("LANDSAT/LC08/C02/T1_L2", l2_bands, "Collection 2 Level-2 surface reflectance")

cat("\nWhat a Level-2 reading of the training values would imply\n")
cat("(surface reflectance = DN * 0.0000275 - 0.2):\n")
sr <- round(tr * 0.0000275 - 0.2, 4)
for (i in seq_along(tb))
  cat(sprintf("  %-6s %7.4f to %7.4f%s\n", tb[i], sr[1, i], sr[2, i],
              if (sr[1, i] < 0) "   <- negative reflectance, not physical" else ""))
