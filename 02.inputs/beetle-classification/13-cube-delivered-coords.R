#!/usr/bin/env Rscript
## Put the delivered workbook's 28 plot coordinates into the form 06-build-cube.R reads.
## Same imagery, same epochs, same harmonisation as the earlier run; only the
## locations differ, which is what PLOTS_CSV in 06-build-cube.R exists for.
suppressPackageStartupMessages(library(readxl))
ROOT <- "02.inputs/beetle-classification"; OUT <- file.path(ROOT, "plot-locations")
d <- as.data.frame(read_excel(file.path(ROOT, "2.1.darkwoods_beetle_ground_plots_ndmi.xlsx")))
d$plot <- as.integer(d$plot)
o <- data.frame(point_id = seq_len(nrow(d)), plot = d$plot,
                easting_m = d$easting, northing_m = d$northing,
                pi_mpb_killed = d$pi_mpb_killed, pi_mpb_killed_pc = d$pi_mpb_killed_pc,
                ndmi_parent = d$ndmi, ndmi_norm = d$ndmi_norm)
stopifnot(nrow(o) == 28, !anyNA(o$easting_m), !anyNA(o$northing_m))
write.csv(o, file.path(OUT, "beetle_plots_delivered.csv"), row.names = FALSE)
cat("wrote", file.path(OUT, "beetle_plots_delivered.csv"), "with", nrow(o), "plots\n")
