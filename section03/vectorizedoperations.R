rm(list=ls())

# vectorized operations
# vector math is central to R

# add two vectors
a <- c(50, 34, 111, 7, 24, 631, 20, 4, 7, 21)
b <- c(100, 2, 56, 12, 0, 65, 93, 10, 244, 1)
c <- a + b
c
d <- a > b
d

# recycling of vectors (two vectors of different sizes, where larger is whole multiple of smaller)
e <- c(2, 4, 5)
f <- c(1, 3, 6, 2, 8, 9)
g <- e + f
g

# functions take vectors as arguments, and can return vectors from their operations



x <- rnorm(5)
x

# r-specific programming loop thru vector and print values
for (i in x) {
  print(i)
}

# print individual values
print(x[1])
print(x[2])
print(x[3])
print(x[4])
print(x[5])

# conventional programming loop thru vector and print values
for (j in 1:5) {
  print(x[j])
}



# compare vectorized to de-vectorized operations

N <- 100
a <- rnorm(N)
b <- rnorm(N)

# vectorized approach
c <- a * b

# de-vectorized approach
d <- rep(NA, N) # create empty vector with allocated memory
for (i in 1:N) {
  d[i] <- a[i] * b[i]
}

# in R, vectorized ops are faster than de-vectorized
# R is a high-level programming language wrapper (around C or FORTRAN)


