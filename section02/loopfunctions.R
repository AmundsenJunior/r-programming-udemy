rm(list=ls())

counter <- 1
while (counter < 12) {
  print(counter)
  counter <- counter + 1
}

# for loop uses a vector of numbers to define loop
for (i in 1:5) {
  print("Hello R")
  print(i)
}

1:10
