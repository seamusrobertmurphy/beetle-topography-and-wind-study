#!/usr/bin/env Rscript
## Which epoch and which index track measured plot mortality.
## Aggregated to the plot, because the label is a plot-level measurement and the four
## pixels are not independent observations of it. Epochs holding fewer than 20 plots
## are dropped: a correlation over a handful of plots is noise with a number on it.
OUT <- "02.inputs/beetle-classification/plot-locations"
cu  <- read.csv(file.path(OUT, "beetle_plots_cube_delivered.csv"))
IDX <- c("NDMI","NDVI","NBR","MSI","RGI","TCW")
res <- list()
for (k in split(cu, list(cu$year, cu$epoch), drop = TRUE)) {
  ag <- aggregate(k[, IDX], by = list(plot = k$plot, m2 = k$pi_mpb_killed,
                                      pc = k$pi_mpb_killed_pc), FUN = mean, na.rm = TRUE)
  ag <- ag[stats::complete.cases(ag[, IDX]), ]
  if (nrow(ag) < 20) next
  for (v in IDX) res[[length(res)+1]] <- data.frame(
    year = k$year[1], epoch = k$epoch[1], start = k$epoch_start[1], sensor = k$sensor[1],
    index = v, n_plots = nrow(ag),
    r_m2 = cor(ag[[v]], ag$m2), r_pc = cor(ag[[v]], ag$pc))
}
r <- do.call(rbind, res)
r$abs_m2 <- abs(r$r_m2); r$abs_pc <- abs(r$r_pc)
write.csv(r[order(-r$abs_m2), ], file.path(OUT, "cube_correlation_search_delivered.csv"), row.names = FALSE)
cat(sprintf("year-epochs with >=20 plots: %d | tests: %d\n\n",
            length(unique(paste(r$year, r$epoch))), nrow(r)))
cat("TOP 15 against basal area killed (m2/ha):\n")
print(head(r[order(-r$abs_m2), c("year","start","sensor","index","n_plots","r_m2","r_pc")], 15), row.names = FALSE)
cat("\n2020 epochs only:\n")
print(r[r$year == 2020, c("start","index","n_plots","r_m2","r_pc")][order(-abs(r$r_m2[r$year==2020])), ], row.names = FALSE)
cat("\nbest per year, by |r| against m2/ha:\n")
b <- do.call(rbind, lapply(split(r, r$year), function(x) x[which.max(x$abs_m2), ]))
print(b[, c("year","start","index","n_plots","r_m2","r_pc")], row.names = FALSE)
