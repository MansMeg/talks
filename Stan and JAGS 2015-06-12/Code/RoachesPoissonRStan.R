rm(list=ls())

library(rstan)
library(ggplot2)

code_folder <- "Stan and JAGS 2015-06-12/Code/"
data_folder <- "Stan and JAGS 2015-06-12/Data/"


# Data 
roachesData<-read.csv2(file.path(data_folder, "roachdata.csv"))

roachDataRStan<-
  list(N = nrow(roachesData),
       exposure2 = roachesData$exposure2,
       senior = roachesData$senior, 
       treatment = roachesData$treatment,
       y = roachesData$y) 

# Model can be found in RoachesPoisson.stan

# Fit the model
fitRoach<-stan(file = file.path(code_folder, "RoachesPoisson.stan"),
           data=roachDataRStan,
           warmup=1000,
           iter=10000,
           chains=4)

# Analyze the results
print(fitRoach,digits=2)
res<-extract(fitRoach)
str(res)
hist(res$beta[,2])

