rm(list=ls())

library(rjags)

code_folder <- "Stan and JAGS 2015-06-12/Code/"
data_folder <- "Stan and JAGS 2015-06-12/Data/"

# Data 
roachesData<-read.csv2(file.path(data_folder, "roachdata.csv"))

roachDataRJAGS<-
  list(N = nrow(roachesData),
       exposure2 = roachesData$exposure2,
       senior = roachesData$senior, 
       treatment = roachesData$treatment,
       y = roachesData$y) 

# Model can be found in RoachesPoisson.jags

# Fit model
jags <- jags.model(file = file.path(code_folder, "RoachesPoisson.jags"),
                   data = roachDataRJAGS,
                   n.chains = 2,
                   n.adapt = 100)

update(jags, 2000)

jagsDraws <- jags.samples(jags, c('beta1', 'beta2', 'beta3'), 1000)

# Analyze posterior results
str(jagsDraws)
summary(as.vector(jagsDraws$beta2))
hist(jagsDraws$beta2)
