
rm(list=ls())

library(rjags)

code_folder <- "Stan and JAGS 2015-06-12/Code/"

# Data 
x = c(1,1,0,0,1,1,1,1,0,1)
n = length(x)
# Hyperparameters
a = 1
b = 1

BernBetaData <- list(n = length(x), x=x, a=a, b=b)

# Model is found in BetaBern.jags

# Fit model
jags <- jags.model(file = file.path(code_folder, "BetaBern.jags"),
                   data = BernBetaData,
                   n.chains = 4,
                   n.adapt = 100)

update(jags, 2000)

jagsDraws <- jags.samples(jags, c('p'), 1000)

# Analyze posterior results
str(jagsDraws)
summary(as.vector(jagsDraws$p))
hist(jagsDraws$p)
