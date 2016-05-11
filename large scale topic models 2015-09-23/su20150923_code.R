

Phi <- matrix(c(0.4, 0.4,0.01,0.03,0.15,0.01,
                0.01,0.01,0.5, 0.46, 0.01, 0.01,
                0.01, 0.01, 0.01, 0.01, 0.48, 0.48),
              ncol=6, byrow = TRUE)
V <- c("boat","shore","soccer","Zlatan","bank","money")
alpha <- 0.5
Nd <- 7

gen_doc <- function(Nd, Phi, alpha, V){
  res <- list()
  alpha <- rep(alpha,3)
  theta_d <- as.vector(rdirichlet(alpha))
  res$theta_d <- round(theta_d,5)
  res$z <- sample(1:3, size = Nd, prob = res$theta_d, replace = TRUE)
  res$w <- as.character(res$z)
  for(i in 1:length(res$w)){
    res$w[i] <- sample(V, 1, prob = Phi[res$z[i],])
  }
  return(res)
}

print_theta <- function(res){
 cat("\\[ \\theta_{d}=(", paste(res$theta_d, collapse=", "), ")\\]", sep="") 
}

print_z <- function(res){
  cat("\\[ \\mathbf{z}=(", paste(res$z, collapse=", "), ")\\]", sep="") 
}

print_w <- function(res){
  cat("\\[ \\mathbf{w}: \\mbox{", paste(res$w, collapse=" "), "}\\]", sep="") 
}

draw_dir_example <- function(){   
  alpha <- c(0.01,0.1,1,10)    
  plt <- list()    
  dir_data <- list()    
  for(i in seq_along(alpha)){
    dir_draw <- as.vector(rdirichlet(alpha = alpha[i] * c(1,1,1,1,1)))
    dir_data[[i]] <- data.frame(category = 1:length(dir_draw), proportion = dir_draw)
    plt[[i]] <- ggplot(data = dir_data[[i]], aes(x=category, y = proportion)) + geom_point() + ggtitle(bquote(alpha==.(alpha[i]))) + ylim(c(0,1)) 
  }    
  plt 
} 