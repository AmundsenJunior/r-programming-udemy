rm(list=ls())

# law of large numbers:
# The mean of observed/measured value Xbar from n samples approaches 
# the expected/theoretical value of X (E(X)) as n approaches infinity

# normal distribution
# curve over mean of 0 with std-dev of 1
# ~34.1% from 0 to 1 (and -1 to 0)
# ~13.6% from 1 to 2 (and -2 to -1)
# ~2.1% from 2 to 3 (and -3 to -2)
# ~0.1% beyond 3 (and beyond -3)

# Exercise: Test LLN for N random normally distributed numbers with mean = 0, stdev = 1
# Create an R script that will count how many of these numbers fall between -1 and 1, dividing by total N
# Known: E(X) = 68.2% for -1 > XbarN > 1
# Check that Mean of X for N approaches E(X) as script runs while increasing N

ex <- 68.2
n <- 10000000

count <- 0
for (x in rnorm(n)) {
  if (-1 <= x  & x <= 1) {
    count <- count + 1
  }
}

percent <- count / n
percent
