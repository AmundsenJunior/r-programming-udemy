# Section 5 Homework
# Scatterplot
# X: Fertility Rate
# Y: Life Expectancy
# Categorized by Region
# Data of 1960 and 2013

rm(list=ls())
setwd("/home/srussell/dev/r/r-programming-udemy/section05")

# Load ggplot2 package for qplot usage
library(ggplot2)

# Load Life Expectancy Data into Data Frame
dir()
source("Section5-Homework-Vectors.R")
Life.Expectancy.1960 <- data.frame(Code=Country_Code, Life.Expectancy=Life_Expectancy_At_Birth_1960)
Life.Expectancy.2013 <- data.frame(Code=Country_Code, Life.Expectancy=Life_Expectancy_At_Birth_2013)
head(Life.Expectancy.1960)
head(Life.Expectancy.2013)

# Load Fertility Rate Data
stats <- read.csv("Section5-Homework-Data.csv")
head(stats)
tail(stats)
str(stats)
summary(stats)

nrow(stats)
nrow(stats[stats$Year == 1960,])
nrow(stats[stats$Year == 2013,])

# Create and Cleanup Merged Data Frames of the Two Years
Nineteen.Sixty <- merge(Life.Expectancy.1960, stats[stats$Year == 1960,],
                        by.x="Code", by.y="Country.Code")
Twenty.Thirteen <- merge(Life.Expectancy.2013, stats[stats$Year == 2013,],
                         by.x="Code", by.y="Country.Code")
Nineteen.Sixty$Year <- NULL
Twenty.Thirteen$Year <- NULL
head(Nineteen.Sixty)
head(Twenty.Thirteen)

# Create qplot Visualizations of Two Years
summary(Nineteen.Sixty)
summary(Twenty.Thirteen)
?qplot
qplot(data=Nineteen.Sixty, y=Life.Expectancy, x=Fertility.Rate,
      color=Region, size=I(4), shape=I(19), alpha=I(0.6),
      xlim=c(0,9), ylim=c(25,90),
      main="Life Expectancy vs Fertility Rate (1960)")
qplot(data=Twenty.Thirteen, y=Life.Expectancy, x=Fertility.Rate,
      color=Region, size=I(4), shape=I(19), alpha=I(0.6),
      xlim=c(0,9), ylim=c(25,90),
      main="Life Expectancy vs Fertility Rate (2013)")

qplot(data=Nineteen.Sixty, y=Life.Expectancy, x=Region,
      ylim=c(25,90), geom="boxplot",
      main="Life Expectancy by Region (1960)")
qplot(data=Twenty.Thirteen, y=Life.Expectancy, x=Region,
      ylim=c(25,90), geom="boxplot",
      main="Life Expectancy by Region (2013)")

qplot(data=Nineteen.Sixty, y=Fertility.Rate, x=Region,
      ylim=c(0,9), geom="boxplot",
      main="Fertility Rate by Region (1960)")
qplot(data=Twenty.Thirteen, y=Fertility.Rate, x=Region,
      ylim=c(0,9), geom="boxplot",
      main="Fertility Rate by Region (2013)")


# Overall trend of the last fifty years in fertility and life expectancy has been a 
# combination of a global average decrease in the former and global average increase
# in the latter. Also overall, there is a decrease in the variance within each region
# of these key global health statistics. While all regions have seen significant improvement,
# Europe has the best statistics from both time periods, with Africa the least improved
# in both statistics over this time period.
