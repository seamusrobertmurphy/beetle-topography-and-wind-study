# Here I code up the Regniere Bentz (2007) winter larval mortality model
# The model takes as input the maximum and minimum daily temperature.
# It computes a daily mean by averaging these two. It is assumed that 
# cold-hardening and survival processes begin on the second day in the 
# series and end on the final day.

RBentzWMort <- function(Tminvec, Tmaxvec, BolstadBentz = FALSE, MidWinter = 156) {
  Temp <- 0.5*(Tminvec + Tmaxvec)
  
  # parameters for distribution of supercooling points (equation 1)
  alpha1 <- -9.8       # mean supercooling point (SCP) in state 1 in degree C
  Beta1 <- 2.26        # spread of SCP in state 1
  alpha2 <- -21.2      # mean SCP in state 2
  Beta2 <- 1.47        # spread of SCP in state 2
  alpha3 <- -32.3      # mean SCP in state 3
  Beta3 <- 2.42        # spread of SCP in state 3
  
  # parameters for the gain rate (equation 3)
  rhoG <- 0.311        # maximum gain rate
  sigmaG <- 8.716      # spread of the gain temperature response
  
  # parameters for the changing optimal temperature for gains in cold hardiness (equation 5)
  muG <- -5.0
  kappaG <- -39.3
  
  # parameters for the loss rate (equation 4)
  rhoL <- 0.791
  sigmaL <- 3.251
  
  # parameters for the changing optimal temperature for loss of cold hardiness (equation 6)
  muL <- 33.9
  kappaL <- -32.7
  
  # These are the breakpoints that dictate what proportion of individuals are in each SCP state
  LambdaZero <- 0.254
  LambdaOne <- 0.764
  
  # We create an empty vector to hold the predicted cold hardiness level
  Cvec <- rep(NA,length(Tminvec))
  # Cvec[1] <- 0.0 # Initializing
  
  # and an empty vector for the probability of surviving any given cold event
  PrSurvVec <- rep(1,length(Tminvec))
  
  SCP <- rep(NA,length(Tminvec))
  
  # Doing the iteration
  for (i in 1:length(Tminvec)){ 
    Tmean <- Temp[i]
    
    if (BolstadBentz == TRUE) {
      # The Bolstad Bentz model for translating maximum and minimum temperatures to
      # maximum and minimum under bark temperatures
      TempMin <- Tminvec[i] + 1.8
      TempMax <- Tmaxvec[i] + 3.25/24.4*(Tmaxvec[i] - Tminvec[i])
    }else{
      TempMin <- Tminvec[i]
      TempMax <- Tmaxvec[i] 
    }
    
    Range <- TempMax - TempMin
    
    # Computing the optimum gain and loss temperatures (equations 5 and 6)
    if (i > 1) {
      TG <- muG + kappaG*Cvec[i-1]
      TL <- muL + kappaL*Cvec[i-1]
    } else {
      TG <- muG
      TL <- muL
    }
    
    # Computing the gain and loss functions for this time step (equations 3 and 4)
    Gt <- Range*rhoG*exp(-(Tmean - TG)/sigmaG)/(sigmaG*(1 + exp(-(Tmean - TG)/sigmaG))^2)
    Lt <- Range*rhoL*exp(-(Tmean - TL)/sigmaL)/(sigmaL*(1 + exp(-(Tmean - TL)/sigmaL))^2)
    
    # Computing the amount of cold hardiness achieved in the step (equation 7)
    if (i > 1) {
      if (i < MidWinter & Cvec[i-1] < 0.5) {
        Cvec[i] <- Cvec[i-1] + (1-Cvec[i-1])*Gt
      } else {
        Cvec[i] <- Cvec[i-1] + (1-Cvec[i-1])*Gt - Cvec[i-1]*Lt
      }
    } else {
      Cvec[i] <- Gt
    }

    
    # Computing the proportion of larvae that are in each SCP stage (equation 9)
    # This is modified from equation 9 according to advice from Jacques Regniere
    p1 <- max(0,min(1,(0.5-Cvec[i])/(0.5-LambdaZero)))
    p3 <- max(0,min(1,(Cvec[i]-0.5)/(LambdaOne-0.5)))
    p2 <- 1 - p1 - p3
    
    # Now computing the probability of surviving in each time step
    # Due to supercooling points, the probability of survival is just the 
    # cumulative density function of the corresponding logistic distribution
    # function
    PrSurv <- p1/(1 + exp(-(TempMin - alpha1)/Beta1)) + 
      p2/(1 + exp(-(TempMin - alpha2)/Beta2)) +
      p3/(1 + exp(-(TempMin - alpha3)/Beta3))
    # The current survival is the cumulative minimum probability of survival as
    # described in equation 10.
    PrSurvVec[i] <- min(PrSurvVec[i-1], PrSurv)
    
    # The median LT50 is just the linear combination each median supercooling 
    # point as stated in Regniere and Bentz (2007) equation 8.
    SCP[i] <- p1*alpha1 + p2*alpha2 + p3*alpha3
  }
  
  outmat <- cbind(PrSurvVec, Cvec, SCP)
  
  return(outmat)
}