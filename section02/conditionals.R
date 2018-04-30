rm(list=ls())

# set of randomly generated numbers within the normal distribution
# can include mean and std dev as 2nd & 3rd args
x <- rnorm(1)
x

if (x > 1) {
  answer <- "greater than 1"
} else if (x >= -1) {
  answer <- "between -1 and 1"
else {
  answer <- "less than -1"
}