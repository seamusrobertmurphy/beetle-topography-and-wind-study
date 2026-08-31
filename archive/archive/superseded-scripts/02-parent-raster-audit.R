# Gate 1(b): which year is the differencing baseline, 2003 or 2005?
#
# Table 2 of FORECO-D-26-01171_Manuscript-FINAL-greycorrected.docx labels
# 2003 Aug 20 "Pre-outbreak" and 2005 Aug 09 "Early-outbreak". The Methods
# text says twice (cleaned-text lines 450 and 490) that the differenced
# images were "derived by subtracting the 2005 pre-disturbance scene from
# each annual outbreak scene". Those cannot both be true.
#
# Decisive test: if 2005 were its own baseline, the 2005 difference image is
# identically zero and no cell can be classified red-attack in 2005. So count
# red-attack cells in the 2005 raster.
#
# Also audits the annual rasters for coding consistency, because the series
# is assumed by the task request to be one product and is not.
#
# Run: /usr/local/bin/Rscript 02.inputs/beetle/02-parent-raster-audit.R

suppressMessages(library(terra))
D <- "/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData/beetle_stages"
RED <- 44  # "AOS severity code 44" = red attack, per Methods cleaned-text line 505

# note: the 2005 file is misspelt Beetle.Oubteak.2005.tif
fs <- sort(list.files(D, pattern = "^Beetle\\..*\\.[0-9]{4}\\.tif$",
                      full.names = TRUE))
cat(sprintf("%-6s %-8s %-8s %-9s %s\n", "year", "n_valid", "n_code44", "pct44", "distinct values"))
for (f in fs) {
  y <- sub(".*\\.([0-9]{4})\\.tif$", "\\1", f)
  v <- values(rast(f)); v <- v[!is.na(v)]
  n44 <- sum(v == RED)
  cat(sprintf("%-6s %-8d %-8d %-9s %s\n", y, length(v), n44,
              sprintf("%.2f%%", 100 * n44 / length(v)),
              paste(sort(unique(v)), collapse = ",")))
}

cat("\n--- reading of the above ---\n")
cat("2005 carries red-attack cells, so 2005 cannot be its own differencing\n")
cat("baseline. The baseline is the 2003 Aug 20 Landsat 5 scene that Table 2\n")
cat("labels Pre-outbreak. The Methods sentence naming 2005 is wrong.\n\n")
cat("The series is NOT one product. Three coding schemes appear:\n")
cat("  2005-2007, 2009-2011: AOS-style codes 1,36,44,61,77,80,94,105\n")
cat("  2008:                 two values only, 80 and 105, no code 44 at all\n")
cat("  2013-2014:            codes 2-7, an unrelated scheme\n")
cat("So 2008 and 2010 contribute zero red-attack cells to any union keyed on\n")
cat("code 44, and 2013/2014 cannot be read on that key at all.\n")
