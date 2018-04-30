# Section 6 - Homework
# Project
# new dataset, existing chart, but no code
# Chart
# x-axis: "Genre" facets
# y-axis: "Gross % US", scale 0-80
# Each genre:
# boxplot overlay with jitter
# datapoints to movies
# point size Budget Millions
# point color Studio
# Comic Sans - all text
# x & y axes in blue
# title "Domestic Gross % by Genre" in black
# grid is light gray, with white grid lines


# clean and set working directory
rm(list=ls())
setwd("/home/srussell/dev/r/r-programming-udemy/section06")
dir()

# load dataset
data <- read.csv("Section6-Homework-Data.csv")
summary(data)
str(data)

# load ggplot2 package
library(ggplot2)

# create selected data frame with corrected names
movies <- data.frame(Studio=data$Studio, Genre=data$Genre, Budget.Millions=data$Budget...mill., Gross.Percent.US=data$Gross...US)
str(movies)
summary(movies)
nrow(movies) # 608

ggplot(data=movies) + geom_point(aes(x=Genre, y=Gross.Percent.US, color=Studio))
# there are 36 studios - looks like old chart might be top 6 studios
# also there are 15 genres - looks like old chart might be top 5 genres
# two ways to approach - 1) select genres/studios that match old chart, or 2) confirm hypothesis of top genres/studios

# what are the six biggest studios by number of movies?
movies$Studio
summary(movies$Studio, maxsum = 7)
studio.filter <- c("Buena Vista Studios", "WB", "Fox", "Universal", "Sony", "Paramount Pictures")

# what are the five biggest genres by number of movies?
movies$Genre
summary(movies$Genre, maxsum = 6)
genre.filter <- c("action", "animation", "comedy", "drama", "adventure")


# install and load dplyr package - manipulating data in dataframes
install.packages("dplyr")
library(dplyr)
?filter

# subset the movies dataframe by studio and genre filters
movies <- filter(movies, movies$Studio %in% studio.filter & movies$Genre %in% genre.filter)
str(movies)
summary(movies)
nrow(movies) # 423

# plot now shows correct data subset
ggplot(data=movies) + geom_point(aes(x=Genre, y=Gross.Percent.US, color=Studio))

# add budget size to point aesthetic
ggplot(data=movies) + geom_point(aes(x=Genre, y=Gross.Percent.US, color=Studio, size=Budget.Millions))

# add boxplot aesthetic
ggplot(data=movies, aes(x=Genre, y=Gross.Percent.US)) +
  geom_point(aes(color=Studio, size=Budget.Millions)) +
  geom_boxplot(alpha=0.6)

# add jitter to points
ggplot(data=movies, aes(x=Genre, y=Gross.Percent.US)) +
  geom_jitter(aes(color=Studio, size=Budget.Millions), alpha=0.7) +
  geom_boxplot(alpha=0.5)

# add theme elements & remove boxplot outliers from view
plot <- ggplot(data=movies, aes(x=Genre, y=Gross.Percent.US)) +
  geom_jitter(aes(color=Studio, size=Budget.Millions), alpha=0.7) +
  geom_boxplot(alpha=0.5, outlier.color=NA) +
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre") +
  theme(plot.title = element_text(hjust=0.5, size=25),
        axis.title = element_text(color="Blue", size=18),
        axis.text = element_text(size=12)
        )
plot

# Comic Sans not available on Linux: select from install.packages("extrafont"); library(extrafont)
install.packages("extrafont")
library(extrafont)
loadfonts()
font_import(prompt=FALSE)
fonts()

plot <- ggplot(data=movies, aes(x=Genre, y=Gross.Percent.US)) +
  geom_jitter(aes(color=Studio, size=Budget.Millions), alpha=0.7) +
  geom_boxplot(alpha=0.5, outlier.color=NA) +
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre") +
  theme(text = element_text(family="Ubuntu Mono"),
        plot.title = element_text(hjust=0.5, size=25),
        axis.title = element_text(color="Blue", size=18),
        axis.text = element_text(size=12)
  )
plot



# Adjust label of Budget legend, which is associated with sizing aesthetic
plot$labels$size = "Budget $M"
plot
ggsave("Top-Studio-Genre-Domestic-Gross.png", device="png")

