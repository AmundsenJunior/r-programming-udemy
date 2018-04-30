rm(list=ls())

# vector: a sequence of data elements of the same basic type in R
# vector of integers, doubles, or characters, e.g.
# vectors are ordered elements, indexed starting at 1 (NOT at 0)

# secret of R: a single number, even, is stored as a vector of length 1

# combine - func c(x, y...) creates new vector object
MyFirstVector <- c(3, 45, 68, 732)
MyFirstVector

# func is.TYPE checks vector whether its elements are a specific type
is.numeric(MyFirstVector) # numeric type encompasses both integers and doubles
is.integer(MyFirstVector)
is.double(MyFirstVector)

V2 <- c(3L, 12L, 10234L, 0L)
is.numeric(V2)
is.integer(V2)
is.double(V2)

v3 <- c("a", "b23", "hello")
v3
is.character(v3)
is.numeric(v3)

# cannot mix elements of different types into a vector
v4 <- c("b", "34", "yes", 7)

# sequence - generate a sequence, with more flexibility than i:j
# seq() 
seq(1,15)

# include step arg to skip elements of sequence
seq(1,15,2)

z <- seq(1,15,4)
z


# replicate - create vector of value x number of times
# rep()

rep(3, 50)
d <- rep(3, 500)
d

# can replicate characters
rep("a", 5)

# can replicate other vectors
x <- c(80, 20)
y <- rep(x, 10)
y

# square brackets - accessing elements of vectors by index value
w <- c("a", "b", "c", "d", "e")
w
w[2]

# access all elements except specific ones
w[-1]
v <- w[-3]
v

# access multiple elements of a vector
w[1:3]
w[3:5]
w[c(1, 3,5)]
w[c(-2,-4)]
w[-3:-5]
w[1:2]

