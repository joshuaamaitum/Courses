#=============================================================
#                 STATISTICAL COMPUTING R
#=============================================================

# Run the scripts and see the results

rm(list=ls()) # Clean R's memory

# Set the working directory
setwd("G:/My Drive/GitHub Desktop/Courses/Statisitcal_Computing")

#=============================================================
#                     1. INTRODUCTION
#=============================================================

#=============================================================
# 1.3 Getting started with R
#=============================================================

1/sqrt(2*pi)*exp(-2)
dnorm(2)

plot(cars, xlab="Speed", ylab="Distance to Stop",
     + main="Stopping Distance for Cars in 1920")

x <- sqrt(2 * pi) # Assignment vector
x

# Creating a sequence
seq(0, 3, 0.5) # Displays a sequence, but does not store it
seq(0, 100, 10)
x <- seq(0, 3, 0.5) # Stores a sequence, but does not display it

# R Syntax and commonly used operators
x <- log2(2)
c(3,2,2) # Concatenation operator (combining multiple values into a vector)
a * b # Elementwise multiplication
2 ^ 1.5 # Exponention
25 %% 3 # x mod y (returns reminder after division)
25%/%3 # Integer division
seq(10,50,5) # Sequence from 10 to 50 by 5
0:20 # Sequence operator

?Control # Control flow help function

# Avoid the use of T or t for assignment because they are already defined by R

#=============================================================
# 1.4 Using the R online help function
#=============================================================

help.search("permutation")

sample(20) # Randomly generate numbers until 20
sample(30)
sample(30, size=5)

example(sample)
example(density)

help(denisty)
help(faithful)
faithful$eruptions

# Identify a list of available datasets
data()
help(geyser, package="MASS")

View(InsectSprays) # View the dataset
View(LakeHuron)
View(Seatbelts)
help("Seatbelts")

#=============================================================
# 1.5 Functions
#=============================================================

# Function that rolls n fair dice and returns the sum
sumdice <- function(n) {
  k <- sample(1:6, size=n, replace=TRUE)
  return(sum(k))
}

# Print & store the result
sumdice(2)
a <- sumdice(100)
a
x <- a / 100
x

#=============================================================
# 1.6 Arrays, Data Frames & Lists
#=============================================================








