# ---------------------------------------------------------------------------
# Correlation between MPB tree mortality and NDMI, as recorded in the
# ground plots workbook. Relative paths: set working directory to this folder.
# ---------------------------------------------------------------------------

library(readxl)

f <- "2.1.darkwoods_beetle_ground_plots.xlsx"
stopifnot(file.exists(f))

d <- read_excel(f)
d <- d[!is.na(d$plot), ]

cat("file :", f, "\n")
cat("plots:", nrow(d), "\n")
cat("cols :", paste(names(d), collapse = ", "), "\n\n")

ct <- cor.test(d$pi_mpb_killed, d$ndmi, method = "pearson")
print(ct)

cat(sprintf("\nr        = %.6f\n", ct$estimate))
cat(sprintf("r squared = %.4f\n", ct$estimate^2))
cat(sprintf("p        = %.4g\n", ct$p.value))
cat(sprintf("Spearman = %.6f\n",
            cor(d$pi_mpb_killed, d$ndmi, method = "spearman")))

plot(d$ndmi, d$pi_mpb_killed, pch = 19, col = "steelblue",
     xlab = "NDMI (workbook)", ylab = "MPB mortality (%)",
     main = sprintf("r = %.3f, n = %d", ct$estimate, nrow(d)))
abline(lm(d$pi_mpb_killed ~ d$ndmi), col = "red", lwd = 2)
text(d$ndmi, d$pi_mpb_killed, d$plot, pos = 4, cex = 0.7)
