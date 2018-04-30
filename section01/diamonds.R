# does a better clarity always correlate to higher price (accounting for carat size)?

# load dataset interactively from window prompt
mydata <- read.csv(file.choose())

# install ggplot2 package
install.packages("ggplot2")
# check packages tab on right afterward to confirm ggplot2 is installed

# lines 14-16 returned "Error: could not find function "ggplot"
# added the following to include the package in the workspace
require(ggplot2)

# scatterplot the data with carat value on the x, price on the y
ggplot(data=mydata,
       aes(x=carat, y=price)) +
  geom_point()

# add clarity (categorical data) as color value
ggplot(data=mydata,
       aes(x=carat, y=price, color=clarity)) +
  geom_point()

# better visualize point density with some transparency of points
ggplot(data=mydata,
       aes(x=carat, y=price, color=clarity)) +
  geom_point(alpha=0.1)

# filter outlier data of carat > 2.5
ggplot(data=mydata[mydata$carat<2.5,],
       aes(x=carat, y=price, color=clarity)) +
  geom_point(alpha=0.1)

# add smoothing function with defaults (of func type, & confidence intervals shown)
ggplot(data=mydata[mydata$carat<2.5,], 
       aes(x=carat, y=price, color=clarity)) + 
  geom_point(alpha=0.1) +
  geom_smooth()
