# Section 6 - Advanced Visualizations with ggplot2

# Project - Movie Ratings comparison
# Data:
# - Movies of 2007-2011
# - Ratings from audiences and critics
# - Movie budget data also available
# Need 5 visualizations that tell a story of that data
# 6th visualization of audience/critic ratings correlation over time by genre:
# - x axis: critic rating
# - y axis: audience rating
rm(list=ls())
setwd("/home/srussell/dev/r/r-programming-udemy/section06")



# Lecture 55 - Grammar of Graphics
# Charts consist of:
# data, 
# aesthetics (color, size, axes), 
# geometries (circles, bars, lines), 
# statistics (data transformations), 
# facets (categories of data), 
# coordinates (x-y, x-y-z), 
# theme (metadata, legend, font, style)



# Lecture 56 - What is a factor?

# load data set
movies <- read.csv("Movie-Ratings.csv")
head(movies)

# fix column names
colnames(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
tail(movies)

str(movies)
# Factors are non-numerical categorical stores of data variables in dataframes

summary(movies)
# Is year really a numerical value?
# No, we want Year to be categorical - we want to convert it to a factor

# shows that there are a set of levels of Year data
factor(movies$Year)
movies$Year <- factor(movies$Year)

str(movies)



# Lecture 57 - Aesthetics

# load ggplot2 package with library function
library(ggplot2)

?ggplot

# can produce an empty plot - ggplot needs minimum (data, aesthetics, and geometry)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

# add geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()

# add color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre)) +
  geom_point()

# add size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions)) +
  geom_point()



# Lecture 58 - Plotting with Layers

# Geometry is added as layer(s) to display a plot object 
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions))

# point geometry
p + geom_point()

# lines geometry
p + geom_line()

# can include multiple layers of geometry
p + geom_point() + geom_line()

# but can't see the points, because ordering of layers matters
p + geom_line() + geom_point()



# Lecture 59 - Overriding Aesthetics

q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions))

# add geom layer - the output here assumes/inherits the aesthetics of the initial object
q + geom_point()

# overriding aesthetics (override size aesthetic from Budget to CriticRating)
q + geom_point(aes(size=CriticRating))

# override color
q + geom_point(aes(color=BudgetMillions))

# override does not overwrite the initial plot object
q + geom_point()

# can override axes (and update the x-axis label)
q + geom_point(aes(x=BudgetMillions)) + xlab("Budget Million $")
# export plot and save as Audience-Budget-Genre.png
ggsave("Audience-Budget-Genre.png", device="png")

# on multiple layers - can override individually
q + geom_line() + geom_point()

# shows the difference between mapping aesthetics versus setting aesthetics
q + geom_line(size=1) + geom_point()



# Lecture 60 - Mapping versus Setting Aesthetics
# aesthetics can be affected by mapping to a variable in the data frame
# or by setting an aesthetic to a particular explicit value

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

# add color by mapping
r + geom_point(aes(color=Genre))

# add color by setting
r + geom_point(color="DarkGreen")

# error issue with mapping to a variable
r + geom_point(aes(color="DarkGreen"))

# change size by mapping
r + geom_point(aes(size=BudgetMillions))

# change size by setting
r + geom_point(size=10)

# error issue with mapping - treats mapping value as a category
r + geom_point(aes(size=10))



# Lecture 61 - Histograms and Density Charts

# histograms - count of a variable per bin width increment
s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth=10)

# add color
s + geom_histogram(binwidth=10, fill="Green")
s + geom_histogram(binwidth=10, aes(fill=Genre))

# add bi border
s + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")


# density charts - probability function of count by type
s + geom_density()
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")



# Lecture 62 - Starting Layer Tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth=10, fill="White", color="Blue")

# another way to achieve the same thing
t <- ggplot(data=movies)
t + geom_histogram(binwidth=10, aes(x=AudienceRating), fill="White", color="Blue")
# save as this shows normal distribution of humans clustering around an average rating
ggsave("AudienceRating-Histogram.png", device="png")

# Why one way or another?
# Do you know what all charts will show ahead of time?
# In exploratory analysis, include less in the plot object,
# where aesthetics will likely be changing from plot to plot
# Overriding is not best practice regularly, so include less.

t + geom_histogram(binwidth=10, aes(x=CriticRating), fill="White", color="Blue")
# save as critics show more uniform distribution of precision about values placed on movies
ggsave("CriticRating-Histogram.png", device="png")

t + geom_density(aes(x=AudienceRating), color="Red") +
  geom_density(aes(x=CriticRating), color="Blue")



# Lecture 63 - Statistical Transformations

# smoothing function - used in exploratory for showing general trends in data
?geom_smooth

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre))
u + geom_point() + geom_smooth(fill=NA)
summary(movies$Genre)
# Can see that audience will statistically likely rate a Romance at >50% when critics rate 25%,
# but the sample size is very small for Romance movies, which might explain the bump at 25%
# that is not present in other genres.
# Can see that for the same critic rating of 75%, audience ratings more closely agree with
# critics on action movies than with horror, but the sample size of action is three times that
# of horror. That shouldn't be discounted, however, as comedies also rate lower for audiences
# than critics in a similar fashion as horror, as compared to action.


# boxplot
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating, color=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()

# distribute data points in a boxplot category to help display density
u + geom_boxplot(size=1.2) + geom_jitter() 

# work with layers and alpha to better display
u + geom_jitter() + geom_boxplot(size=1.2)
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)
ggsave("AudienceRating-Genre-Boxplot.png", device="png")

# create same chart for CriticRating
u + geom_jitter(aes(y=CriticRating)) + geom_boxplot(aes(y=CriticRating), size=1.2, alpha=0.5)
ggsave("CriticRating-Genre-Boxplot.png", device="png")



# Lecture 64 - Using Facets

v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth=10)
v + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")
# would be more useful to have a histogram per genre

# facet_grid(separate rows ~ columns)
v + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") +
  facet_grid(Genre~.)
v + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") +
  facet_grid(Genre~., scales="free")

# facets on scatterplots
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre))
w + geom_point(size=3)

w + geom_point(size=3) + facet_grid(Genre~.)
w + geom_point(size=3) + facet_grid(.~Year)

w + geom_point(size=3) + facet_grid(Genre~Year)

w + geom_point(size=3) + geom_smooth() + facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) + geom_smooth() + facet_grid(Genre~Year)
# the confidence interval bands expand the y axis beyond 0-100



# Lecture 65 - Coordinates

# limits on axes
# zooming

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, size=BudgetMillions, color=Genre))
m + geom_point()

# let's only show visualize best quadrant (50-100, 50-100)
m + geom_point() + xlim(50,100) + ylim(50,100)

# won't always work well
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")
n + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") + ylim(0,50) # cut off all y data above 50

# instead, use zoom with coord_cartesian
n + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") +
  coord_cartesian(ylim=c(0,50))


# fix the facet grid
w + geom_point(aes(size=BudgetMillions)) + geom_smooth() + facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) + geom_smooth() + facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))
ggsave("Audience-Critic-Genre-Budget-Facet-Grid.png", device="png")



# Lecture 66 - Perfecting by Adding Themes

o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")

h

# add axes labels
h + xlab("Money Axis") + ylab("Number of Movies")

# label formatting
h + xlab("Money Axis") + ylab("Number of Movies") +
  theme(axis.title.x= element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30))

# tick mark formatting
h + xlab("Money Axis") + ylab("Number of Movies") +
  theme(axis.title.x = element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))

# legend formatting 
h + xlab("Money Axis") + ylab("Number of Movies") +
  theme(axis.title.x = element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1))

# plot title
h + xlab("Money Axis") + ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(color="DarkGreen", size=10),
        axis.title.y = element_text(color="Red", size=10),
        axis.text.x = element_text(size=8),
        axis.text.y = element_text(size=8),
        
        legend.title = element_text(size=10),
        legend.text = element_text(size=8),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="DarkBlue", size=15, family="Courier"))
ggsave("Movie-Budget-Distribution.png", device="png")
