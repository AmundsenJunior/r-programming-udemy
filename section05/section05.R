# Section 5: Data Frames

rm(list=ls())

# Challenge: Demographic Analysis
# World Bank Data Scientist
# Produce:
# 1. Scatterplot illustrating Birth Rate and Internet Usage stats by Country
# 2. Scatterplot needs to also be categorized by Country Income Groups

# DemographicData.csv
# Internet users (% of population in 2012 using the Internet)
# Birth rate (how many new births per year per 1000 people in 2012)
# Income Group [High, Upper middle, Lower middle, Low]





# Lecture 41: Reading Data into R
?read.csv()


# method 1: select file manually
stats <- read.csv(file.choose())


# method 2: Set Working Directory and Read Data
getwd()
setwd("/home/srussell/dev/r/r-programming-udemy/section05")
getwd()
dir()

# remove the manually loaded data
rm(stats)

# load data from working directory
stats <- read.csv("DemographicData.csv")
stats



# Lecture 42: Exploring your dataset
stats

# get number of rows or columns
nrow(stats) 
ncol(stats)

# get first or last 6 rows of data
head(stats)
tail(stats, n=10)

# data structure
str(stats)
# Factor - R auto-categorizes named data, and indexes those categories
# num - numerical data

# summary statistics
summary(stats)



# Lecture 43: Using the $ sign
stats
head(stats)

# data frames can work like matrices
stats[3, 3]
# can selected by named rows or columns
stats[3, "Birth.rate"]

# in data frames, rows never have names, unlike columns (as Excel does it)
stats["Angola", 3] # this doesn't work, as "Angola" is a value in a column, not a row name

# Use the $ sign to get an object by any name or index
stats$Internet.users # extract a whole column
stats$Internet.users[2] # get a specific row's value in a column

# get factors/categorical data of a field
levels(stats$Income.Group)



# Lecture 44: Basic Operations with a Data Frame

# subsetting
stats[1:10,]
stats[3:9,]
stats[c(4,100),]

# remember how the square brackets work
stats[1,]
# in a data frame, unlike matrix, one row extraction doesn't convert to a vector
is.data.frame(stats[1,])

# single-column subsetting for data frames does convert to vector
stats[,1]
is.data.frame(stats[,1])
is.data.frame(stats[,1,drop=F])

# arithmetic on data frames (via vector operations)
head(stats)
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users

# add a column to data frame
head(stats)
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
head(stats)

# test vector knowledge
# replicates an insert of a vector, as long as it evenly divides into the number of rows (error if not)
stats$xyz <- 1:5 
head(stats, n=12)

# remove a column
head(stats)
stats$MyCalc <- NULL
stats$xyz <- NULL
head(stats)


# test dataframes operations knowledge
# create new fields of transformed data

# birth rate per 1M
stats$Birth.rate.per.million <- round(stats$Birth.rate / 1000, 3)
head(stats)

# Internet non-users
stats$Internet.nonusers <- 100 - stats$Internet.users
tail(stats)

# cleanup
stats$Birth.rate.per.million <- NULL
stats$Internet.nonusers <- NULL



# Lecture 45: Filtering a Data Frame
# row-oriented filtering of data frame by contents of columns
# using boolean vectors

head(stats)
stats$Internet.users < 2 # evaluate Internet.users less than 2%
filter <- stats$Internet.users < 2
stats[filter,] # R will take the "filter" vector and only show rows that are true in that filter

# filter for birth rate over 40
stats[stats$Birth.rate > 40,]

# filter on both birth rate and internet users
stats[stats$Birth.rate > 40 & stats$Internet.users < 2,]


# filter by categorical factor (income group)
stats[stats$Income.Group == "High income",]


# exercise
# find all information about Malta
stats[stats$Country.Name == "Malta",]



# Lecture 46: Introduction to qplot

# load qplot package from ggplot2
library(ggplot2)
?qplot
# qplot works directly with a data frame

# qplot auto chooses bucket sizes and axes headers
qplot(data=stats, x=Internet.users) 

# qplot auto-chooses type of plot to use for data set
qplot(data=stats, x=Income.Group, y=Birth.rate) 

# add parameters to change parameters
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3)) 

# isolate parameters with I() to ensure correct interpretation
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3), color=I("blue"))

# change the plot type
qplot(data=stats, x=Income.Group, y=Birth.rate, geom="boxplot")



# Lecture 47: Visualizing with qplot, part 1

# Exercise - World Bank data challenge (My own attempt)
summary(stats)
qplot(data=stats, x=Birth.rate, y=Internet.users)
qplot(data=stats, y=Birth.rate, x=Internet.users)
qplot(data=stats, x=Birth.rate, y=Internet.users, color=Income.Group, size=I(3))
?qplot

# lecture attempt
qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(4), color=I("red"))
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(5), color=Income.Group)

# There's one high-income data point that is high birth-rate & low internet usage
high <- stats[stats$Income.Group == "High income",]
high
nrow(high)
max(high$Birth.rate)
min(high$Internet.users)

outlier <- high[high$Birth.rate == max(high$Birth.rate)
                 & high$Internet.users == min(high$Internet.users),]
outlier
summary(high)

rm(outlier, filter, high)



# Lecture 48: Building Dataframes

# New Challenge - same scatterplot (Birth rate & Internet Usage by Country), but also categorized by Region

# load data into workspace
getwd()
dir()
source("CountryRegionVectors.R")

# create data frame from vectors
mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)
head(mydf)

# rename columns
colnames(mydf) <- c("Country", "Code", "Region")
head(mydf)

rm(mydf)

# can instead during data frame creation rename columns (this also works in cbind and rbind functions)
mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset, Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)



# Lecture 49: Merging Data Frames

head(stats)
head(mydf)

# Want to merge mydf and stats by Country Code (better to use code than name, to avoid data quality issues)
merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)
# "Code" column from mydf does not merge in, as R knows that is a duplicate

# remove other duplicate column, Country
merged$Country <- NULL
str(merged)
tail(merged)



# Lecture 50: Visualizing with qplot, part 2

# visualize birth rate and internet usage by region (my attempt)
qplot(data=merged, x=Internet.users, y=Birth.rate, size=I(3), color=Region)


# lecture process to make this visualization
qplot(data=merged, x=Internet.users, y=Birth.rate, color=Region)

# alter shapes and sizes of points
qplot(data=merged, x=Internet.users, y=Birth.rate, color=Region, size=I(3), shape=I(7))
qplot(data=merged, x=Internet.users, y=Birth.rate, color=Region, size=I(3), shape=I(23))
qplot(data=merged, x=Internet.users, y=Birth.rate, color=Region, size=I(5), shape=I(19))

# add transparency
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, size=I(5), shape=I(19), alpha=I(0.6))

# add title
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region, size=I(5), shape=I(19), alpha=I(0.6),
      main="Birth Rate vs Internet Users")






