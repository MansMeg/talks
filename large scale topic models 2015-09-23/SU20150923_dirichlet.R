# Demontsration of dirichlet draws
## We use package bayesm
library(bayesm)

# Set prior
alpha <- 0.1

# Draw a dirichlet draw of size 5 and plot it
dir_draw <- rdirichlet(alpha = alpha * c(1,1,1,1,1))
dir_draw
plot(1:length(dir_draw),dir_draw, ylim=c(0,1), xlab="category", ylab="prop")
