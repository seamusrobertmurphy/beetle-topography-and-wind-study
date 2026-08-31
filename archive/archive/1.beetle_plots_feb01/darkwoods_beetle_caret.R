
##note to self: two  sets of results were generated using 'nmi' and then 'ndmi' as the predictor variable
##note to self: need to confirm which predictor when sharing with co-authors...

library(readxl)
library(spdep)
library(gstat)
library(rgdal)
library(maptools)
library(raster)
library(spatstat)
library(GISTools)
library(rgeos)
library(sp)
library(rpanel)
library(ncf)
library(sf)
library(spatial)
library(spatstat.data)
library(spatstat.local)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(psych)
library(useful)
library(caret)

getwd()
setwd("~/1.beetle_plots_ndmi_feb01")
darkwoods_beetle_plots_data = read_excel("darkwoods_beetle_plots_data.xlsx")
set.seed(123) ##seeds hereafter set as "123" ##

##ndmi predictor: 
beetle_ndmi <- lm(pi_mpb_killed ~ ndmi, data = darkwoods_beetle_plots_data)
beetle_ndmi_residuals <- resid(beetle_ndmi)
summary(beetle_ndmi)

plot(pi_mpb_killed ~ ndmi, data = darkwoods_beetle_plots_data, 
     main=NULL, 
     ylab = "Basal area of pine trees killed by MPB", xlab = "NDMI", col="blue")
abline(beetle_ndmi, col = "red")

#splitting data 70:30 for training samples based on outcome variable
beetle_training.samples <- createDataPartition(darkwoods_beetle_plots_data$pi_mpb_killed, p=0.70, list = FALSE)
beetle_train.data <- darkwoods_beetle_plots_data[beetle_training.samples, ]
beetle_test.data <- darkwoods_beetle_plots_data[-beetle_training.samples, ]

#model training method - time-series
model_training_time_series <- trainControl(method = "timeslice",
                                           initialWindow = 36,
                                           horizon = 12,
                                           fixedWindow = TRUE)

#model training method - 10K-Fold x10repeat
model_training_10kfold <- trainControl(method = "repeatedcv", 
                                       number = 10, repeats = 10)
                                        
#model 1 - NDMI - model specification
svm_ndmi_linear <- train(pi_mpb_killed ~ ndmi, 
                         data = beetle_train.data,
                         method = "svmLinear",
                         trControl = model_training_10kfold, 
                         preProcess = c("center","scale"), 
                         tuneGrid = expand.grid(C=seq(0,3, length = 20)))

#model 2 - TAS-WET - model specification
svm_taswet_linear <- train(pi_mpb_killed ~ ndmi, 
                         data = beetle_train.data,
                         method = "svmLinear",
                         trControl = model_training_10kfold, 
                         preProcess = c("center","scale"), 
                         tuneGrid = expand.grid(C=seq(0,3, length = 20)))

#model 3 - TAS-GRE - model specification
svm_tasgreen_linear <- train(pi_mpb_killed ~ tasgre, 
                         data = beetle_train.data,
                         method = "svmLinear",
                         trControl = model_training_10kfold, 
                         preProcess = c("center","scale"), 
                         tuneGrid = expand.grid(C=seq(0,3, length = 20)))

#model 4 - TAS-BRI - model specification
svm_tasbright_linear <- train(pi_mpb_killed ~ tasbri, 
                         data = beetle_train.data,
                         method = "svmLinear",
                         trControl = model_training_10kfold, 
                         preProcess = c("center","scale"), 
                         tuneGrid = expand.grid(C=seq(0,3, length = 20)))

#model 4 - results
summary(lm(predict(svm_ndmi_linear) ~ beetle_train.data$pi_mpb_killed))
beetle_ndmi_pred_train <- predict(svm_tasbright_linear, data = beetle_train.data)
beetle_ndmi_pred_train_mae <- mae(beetle_ndmi_pred_train, beetle_train.data$pi_mpb_killed)
beetle_ndmi_pred_train_mae 
beetle_ndmi_pred_train_mae_rel <- (beetle_ndmi_pred_train_mae/mean(beetle_train.data$pi_mpb_killed))*100
beetle_ndmi_pred_train_mae_rel
beetle_ndmi_pred_train_rmse <- rmse(beetle_ndmi_pred_train, beetle_train.data$pi_mpb_killed)
beetle_ndmi_pred_train_rmse
beetle_ndmi_pred_train_rmse_rel <- (beetle_ndmi_pred_train_rmse/mean(beetle_train.data$pi_mpb_killed))*100
beetle_ndmi_pred_train_rmse_rel
beetle_ndmi_pred_train_R2 <- R2(beetle_ndmi_pred_train, beetle_train.data$pi_mpb_killed)
beetle_ndmi_pred_train_R2
TheilU(beetle_train.data$pi_mpb_killed, beetle_ndmi_pred_train, type = 2)
beetle_ndmi_pred_train_Ubias <- ((beetle_ndmi_pred_train_mae)*20)/((beetle_ndmi_pred_train_mae)^2)
beetle_ndmi_pred_train_Ubias

beetle_ndmi_pred_test <- predict(svm_tasbright_linear, data = darkwoods_beetle_plots_data)
beetle_ndmi_pred_test_rmse <- rmse(beetle_ndmi_pred_test, darkwoods_beetle_plots_data$pi_mpb_killed)
beetle_ndmi_pred_test_rmse/beetle_ndmi_pred_train_rmse

# animation of 10-kfold method: 
cv.ani(k=10)

# model 1 - results
svm_ndmi_linear
svm_ndmi_linear$finalModel
trellis.par.set(caretTheme())
plot(svm_ndmi_linear)
densityplot(svm_ndmi_linear)

# model 2 results
svm_taswet_linear

# model 3 results
svm_tasgreen_linear

#check descriptives (load package = "psych")
describe(darkwoods_beetle_plots_data$ndmi)
describe(darkwoods_beetle_plots_data$taswet)
describe(darkwoods_beetle_plots_data$tasbri)
describe(darkwoods_beetle_plots_data$tasgre)

shapiro.test(darkwoods_beetle_plots_data$ndmi)
shapiro.test(darkwoods_beetle_plots_data$taswet)
shapiro.test(darkwoods_beetle_plots_data$tasbri)
shapiro.test(darkwoods_beetle_plots_data$tasgre)


