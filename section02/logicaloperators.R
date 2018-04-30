rm(list=ls())

# values of logical type:
# TRUE, T
# FALSE, F

4 < 5
10 > 100
4 == 5

# logical operators:
# == ... Equal to
# != ... Not equal to
# < ... Less than
# > ... Greater
# <= ... Less or equal to
# >= ... Greater or equal to
# ! ... NOT
# | ... OR
# & ... AND
# isTRUE(var)

result <- 4 < 5
result
typeof(result)

result2 <- !TRUE
result2

result | result2

result & result2

isTRUE(result)

