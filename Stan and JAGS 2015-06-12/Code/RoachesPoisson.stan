data {
  int<lower=0> N;
  vector[N] exposure2;
  vector[N] senior;
  vector[N] treatment;
  int y[N];
}

transformed data {
  vector[N] log_expo;
  log_expo <- log(exposure2);
}

parameters {
  vector[3] beta;
}

model {
  # Prior
  beta ~ normal(0, 1000.0);

  # Model/likelihood
  y ~ poisson_log(log_expo + beta[1] + beta[2] * treatment + beta[3] * senior);
}
