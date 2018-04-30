rm(list=ls())

# packages
# Packages are collections of R functions, data, and compiled code in a well-defined format.
# The directory where packages are stored is called the library.

# install from the web - CRAN repository
install.packages("ggplot2")

# call the library function to activate a package into the workspace that has been installed on the system
library(ggplot2)

qplot(data=diamonds, carat, price,
      color=clarity, facets=.~clarity)