# Section 4 Homework: Investigating Free Throws

# Are being provided additional data of in-game stats:
# 1. Free Throws
# 2. Free Throw Attempts

# Create three plots to show:
# 1. Free Throw Attempts per game
# 2. Accuracy of Free Throws
# 3. Player playing style (2 vs 3 points preference) exluding Free Throws

rm(list=ls())
setwd("/home/srussell/dev/r/r-programming-udemy/section04")
dir()
source("s4-BasketballData.R")
source("Section4-Homework-Data.R")

myplot <- function(data, rows=1:10){
  Data <- data[rows,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}

# Add matrix creation steps into Section4-Homework-Data.R

# plot of free throw attempts per game
myplot(FreeThrowAttempts/Games)

# plot of accuracy of Free Throws
myplot(FreeThrows/FreeThrowAttempts)


# player playing style excluding free throws
FieldPoints <- Points - FreeThrows
FieldPointsPerFieldGoals <- FieldPoints / FieldGoals

Points
FieldGoals
Points[1,,drop=F]
FieldGoals[1,,drop=F]
FreeThrows[1,,drop=F]
FieldPoints[1,,drop=F]
FieldPointsPerFieldGoals[1,,drop=F]
FieldPointsPerFieldGoals
myplot(FieldPointsPerFieldGoals)
