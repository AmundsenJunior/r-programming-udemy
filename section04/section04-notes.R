rm(list=ls())

# Lecture 26

# nba player stats
# top 10 players (by salary) in 2015-2016 season
# Looking at stats:
#  - Year 2005-06 to 2014-15
#  - GP (games played)
#  - MPG (minutes per game)
#  - FG% (field goal percentage - scored regular 2 or 3 point shots scored per total shots)
#  - PPG (points per game)

# Load data from r/r-programming-udemy/section04/s4-BasketballData.R into RStudio Workspace
setwd("/home/srussell/dev/r/r-programming-udemy/section04") # set working directory
dir() # list contest of working directory

source("s4-BasketballData.R") # execute R script into workspace

# Explore dataset
Salary
Games



# Lecture 27
# Matrices
# like a vector, matrices must be all of one data type

# individual lookup: Matrix[row.index, col.index]
# Get LeBron's salary in 2010
Salary[3, 6]

# get a row of data: Matrix[row.index, ]
# Get all Kevin Durant's salaries
Salary[8, ]

# get a column of data: Matrix[ , col.index]
# Get all 2014-15 salaries
Salary[ , 10]



# Lecture 28
Salary
Games
MinutesPlayed

# Matrix construction in s4-BasketballData.R
# load Seasons, Players, individual.player.salaries
# Salary <- rbind(individual.player.salaries as vectors)
# rm(individual.player.salaries)
# colname(Salary) <- Seasons
# rownames(Salary) <- Players

# Building a Matrix
# matrix() will bend a single-dim vector into either set of columns or rows (not often used)
# rbind() takes set of vectors as rows and combines into two-dim matrix
# cbind() takes set of vectors as columns and combines into two-dim matrix


# matrix()
?matrix

my.data <- 1:20
my.data

A <- matrix(my.data, 4, 5)
A
A[2,3]

B <- matrix(my.data, 4, 5, byrow=TRUE)
B
B[2,5]


# rbind()
r1 <- c("I", "am", "happy")
r2 <- c("What", "a", "day")
r3 <- c(1,2,3)

C <- rbind(r1, r2, r3)
C

c1 <- 1:5
c2 <- -1:-5
D <- cbind(c1, c2)
D



# Lecture 29: Naming Dimensions
# Names (character type) of rows and columns can be used as index values to access data in a matrix
Matrix[row.index, col.index]
Matrix[row.name, col.name]
Matrix[row.index, col.name]
Matrix[row.name, col.index]

# Named Vectors
Vector[index]
Vector[name]



# Lecture 30: row and column names

# Named vectors
Charlie <- 1:5
Charlie

names(Charlie) # check names of Charlie vector
names(Charlie) <- c("a", "b", "c", "d", "e") # assign names to names(Charlie)
names(Charlie)
Charlie
Charlie["d"]

# clear names from a vector
names(Charlie) <- NULL
Charlie


# Naming Matrix Dimensions

temp.vec <- rep(c("a", "B", "zZ"), each=3)
temp.vec                

Bravo <- matrix(temp.vec, 3, 3)
Bravo

rownames(Bravo)
rownames(Bravo) <- c("How", "are", "you")
rownames(Bravo)
Bravo

colnames(Bravo)
colnames(Bravo) <- c("X", "Y", "Z")
colnames(Bravo)

Bravo["are", "Y"]
Bravo["are", "Y"] <- 0
Bravo

rownames(Bravo) <- NULL
Bravo



# Lecture 31: Matrix Operations
rm(list=ls())

setwd("/home/srussell/dev/r/r-programming-udemy/section04")
dir()
source("s4-BasketballData.R")

Games
rownames(Games)
colnames(Games)
Games["LeBronJames", "2012"]

# How many Field Goals per game per player
FieldGoals

FieldGoalsPerGame <- round(FieldGoals / Games, 1)
FieldGoalsPerGame["DwightHoward", "2008"]

# How many minutes did each player play per game
round(MinutesPlayed / Games)

# Field Goal Accuracy (Field Goals per Attempts)
FieldGoalAccuracy <- round(FieldGoals/FieldGoalAttempts * 100, 2)
FieldGoalAccuracy



# Lecture 32: Visualizing with matplot
?matplot

FieldGoals
# to show field goals per player in matplot (which shows data by columns), need to transpose data
t(FieldGoals)

matplot(t(FieldGoals))

# show field goals with better attributes
matplot(t(FieldGoals), type="b", pch=15:18, col=c(1:4,6))

# show field goals with legend that uses same pictures and colors
matplot(t(FieldGoals), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players, col=c(1:4,6), pch=15:18, horiz=F)

# show field goals per game
matplot(t(FieldGoals/Games), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players, col=c(1:4,6), pch=15:18, horiz=F)

# show field goal accuracy
matplot(t(FieldGoals/FieldGoalAttempts), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players, col=c(1:4,6), pch=15:18, horiz=F)



# Lecture 33: Subsetting
rm(list=ls())

setwd("/home/srussell/dev/r/r-programming-udemy/section04")
dir()
source("s4-BasketballData.R")

# every time you subset a vector, you get a new vector
x <- c("a", "b", "c", "d", "e")
x
x[c(1,5)]
x[1]

# subsetting applies the same with matrices
Games

# subset of top three players in last five years
Games[1:3, 6:10]

# compare top and lowest paid players across all years
Games[c(1, 10),]

# compare all players in 2008 and 2009
Games [,c("2008", "2009")]


# just want kobe's stats
Games[1,]
is.matrix(Games[1,]) # FALSE
is.vector(Games[1,]) # TRUE

Games[1,5]

# square brackets in R will guess what you want, and one-dim results from matrix is a vector
# to fix, turn off drop attribute for these calls to get consistent results
Games[1,,drop=FALSE]
Games[1,5,drop=F]



# Lecture 34: Visualizing Subsets
rm(list=ls())

setwd("/home/srussell/dev/r/r-programming-udemy/section04")
dir()
source("s4-BasketballData.R")

matplot(t(MinutesPlayed), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players, col=c(1:4,6), pch=15:18, horiz=F)

# subset of top three players, minutes played
Data <- MinutesPlayed[1:3,]
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players[1:3], col=c(1:4,6), pch=15:18, horiz=F)

# subset just of kobe's data, but subset drops names from matrix into vector
Data <- MinutesPlayed[1,]
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players[1], col=c(1:4,6), pch=15:18, horiz=F)

# subset just of kobe's data, with drop=F
Data <- MinutesPlayed[1,,drop=F]
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players[1], col=c(1:4,6), pch=15:18, horiz=F)



# Lecture 35: Create your first function
rm(list=ls())

setwd("/home/srussell/dev/r/r-programming-udemy/section04")
dir()
source("s4-BasketballData.R")

Data <- MinutesPlayed[1,,drop=F]
matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset=0.01, legend=Players[1], col=c(1:4,6), pch=15:18, horiz=F)

# create the chart function to call each time we want to show different data in the same way each time
myplot <- function(){
  Data <- MinutesPlayed[2,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset=0.01, legend=Players[2], col=c(1:4,6), pch=15:18, horiz=F)
}

myplot()


# add arguments/parameters to the function to specify the set of players to show
myplot <- function(rows){
  Data <- MinutesPlayed[rows,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot(1:5)
myplot(1:10)

# Add additional arg for changing the dataset to show
myplot <- function(data, rows){
  Data <- data[rows,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot(Salary, 1:5)
myplot(Salary, 1:2)

# Can set default parameter for values of args not included
myplot <- function(data, rows=1:10){
  Data <- data[rows,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}
myplot(Salary)
myplot(MinutesPlayed/Games)



# Lecture 36: Basketball Insights
rm(list=ls())
setwd("/home/srussell/dev/r/r-programming-udemy/section04")
dir()
source("s4-BasketballData.R")

myplot <- function(data, rows=1:10){
  Data <- data[rows,,drop=F]
  matplot(t(Data), type="b", pch=15:18, col=c(1:4,6))
  legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:4,6), pch=15:18, horiz=F)
}

myplot(Salary) # how did salaries change over time, to become top 10
myplot(Salary / Games) # Kobe and Derrick were both injured in 2013-2014
myplot(Salary / FieldGoals) # same deal

# salary is not affected by injuries, whereas in-game stats are affected

myplot(MinutesPlayed)
myplot(Points)

# can normalize in-game metrics by other in-game metrics to account for injuries or other discrepancies
myplot(FieldGoals/Games)

myplot(FieldGoals/FieldGoalAttempts) # accuracy of players shows high accuracy for Dwight Howard, but is 5th highest paid
myplot(FieldGoalAttempts/Games) # shows that Dwight Howard doesn't make that many attempts per game

myplot(MinutesPlayed/Games) # on average all players trend down on number of minutes in games
myplot(Games)

myplot(FieldGoals/MinutesPlayed) # two groupings apparent

myplot(Points/FieldGoals) # as average goes up or down, shows possibly the number of goals for two versus three point shots (though points includes free throws)




