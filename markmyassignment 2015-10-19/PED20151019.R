library(markmyassignment)
lab_path <-
  "https://raw.githubusercontent.com/MansMeg/KursRprgm/master/Labs/Tests/d1.yml"
set_assignment(lab_path)

# Mandatory
Namn <- "Mans"
LiuId <- "manma97"

# Exercise 1
thre_elements <- function(){
  c(log(4), exp(pi+1), sin(pi/3))
}


mark_my_assignment("three_elements")
