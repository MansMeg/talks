
rm(list=ls())

library(rstan)

code_folder <- "Stan and JAGS 2016-05-12/Code/"

# Data 
x = c(1,1,0,0,1,1,1,1,0,1)
n = length(x)
# Hyperparameters
a = 1
b = 1

BernBetaData <- list(n = length(x), x=x, a=a, b=b)

# Model is found in BetaBern.stan

# Do the fitting of the model
fit1 <- stan(file = file.path(code_folder, "BetaBern.stan"),
           data=BernBetaData,
           warmup=1000,
           iter=2000,
           chains=4)

# Analyze outputs
print(fit1,digits_summary=3)
plot(fit1)

# Plot some results
res <- extract(fit1) 
str(res)
pSeq <- seq(0,1,by=0.01)
par(mfrow = c(1,1))
hist(res$p, 40, freq = FALSE, main = 'Posterior of p - all chains') # histogram of draws of a from the first Markov Chain
lines(pSeq, dbeta(pSeq, shape1 = sum(x) + a, shape2 = n - sum(x) + b), col = "red")
legend("topleft", inset=.05, legend = c('MCMC approximation','True density'), lty =c(1,1),col=c('black','red'))

