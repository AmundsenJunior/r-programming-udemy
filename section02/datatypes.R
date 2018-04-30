# clear workspace of environment variables/stored data
rm(list=ls())

# integer
x <- 2L # include L to ensure that value is saved as type Integer, where R default is "double"
typeof(x)

# double
y <- 2.5
typeof(y)

# complex
z <- 3 + 2i
typeof(z)

# character
a <- "h"
typeof(a)

# logical
p <- FALSE
typeof(p)
q <- T
typeof(q)
