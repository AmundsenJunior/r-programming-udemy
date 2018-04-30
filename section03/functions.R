rm(list=ls())

# functions

# known functions
# rnorm() - produce normal distribution values
# is.numeric() - checks if numeric
# is.integer() - checks if integer
# is.double() - checks if double
# is.character() - checks if character
# isTRUE() - checks if TRUE
# seq() - create vector by sequence
# rep() - create vector by replicating input
# c() - create vector by input literals
# print() - print out
# ggplot() - create plot
# read.csv() - read csv file into workspace
# typeof() - get type of variable
# sqrt() - calcuate square root of input
# paste() - concatenate inputs

# get help of function from R documentation page
?rnorm()

rnorm(5)
rnorm(5, 10, 8)
rnorm(mean=100, n=5)


seq(from=10, to=20, by=3)
seq(from=10, to=20, length.out=100)

x <- c("a", "b", "c")
seq(from=10, to=20, along.with=x)


rep(5, 10)
rep(5:6, 10)
rep(5:6, times=10)
rep(5:6, each=10)


A <- seq(10, 20, along.with=1:3)
A
B <- sqrt(A)
B

