data {
  int<lower=0> n;
  int<lower=0,upper=1> x[n];
  real<lower=0> a;
  real<lower=0> b;
}

parameters {
  real<lower=0,upper=1> p;
} 

model {
  // prior
  p ~ beta(a,b);
  // model
  for (i in 1:n)
    x[i] ~ bernoulli(p);
}
