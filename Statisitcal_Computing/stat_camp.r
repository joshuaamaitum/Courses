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

x <- log2(2)
c(3,2,2) # Concatenation operator (combining multiple values into a vector)
a * b # Elementwise multiplication
2 ^ 1.5 # Exponention


