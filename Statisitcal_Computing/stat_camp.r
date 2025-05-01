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

#View(InsectSprays) # View the dataset
#View(LakeHuron)
#View(Seatbelts)
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

# A matrix is a 2 dimensional array, contain a single type
# Data frame can be represented in a rectangular layout, can contain different types of variables

# DATA FRAMES (List of variables each with the same length but not same type)
help("iris")
head(iris)
#View(iris)
names(iris) # List column names
iris$Species
table(iris$Species) # Numbers for each species
w <- iris[[2]] # Sepal.width (2nd column)
mean(w)

attach(iris) # Data frame is attached
summary(Petal.Length[51:100]) # Variables referenced directly by name

with(iris, summary(Petal.Length[51:100])) # Attach temporarily

# Compute means by species
#View(iris)
head(iris)
m <- aggregate(iris[,1:4],list(iris$Species),mean,na.rm=T)
m
#by(iris[,1:4], Species, mean)
detach(iris) # Detach when not needed

# ARRAYs (A multiply subscripted collection of a single type of data)
x <- 1:24 # vector
dim(x) <- length(x) # 1 dimensional array
matrix(1:24, nrow=4, ncol=6) # 4 by 6 matrix
x <- array(1:24, c(3, 4, 2)) # 3 by 4 by 2 array
x

# MATRIX (A doubly subscripted array of a single type of data)
A <- matrix(0, nrow=2, ncol=2)
A <- matrix(c(0,0,0,0), nrow=2, ncol=2)
A <- matrix(0,2,2)
A <- matrix(1:8, nrow=2, ncol=4)

# Convert first 4 columns of iris data into a matrix
head(iris)
x <- as.matrix(iris[,1:4]) # All rows of columns 1 to 4
mean(x[,2]) # mean of sepal width, all species
mean(x[51:100,3]) # mean of petal length, versicolor

#View(iris3)

# LISTS (An ordered collection of objects)
w <- wilcox.test(rnorm(10),rnorm(10, 2))
w
w$statistic
w$p.value
unlist(w)
unclass(w)

# Create a list to assign row and column names in a matrix
a <- matrix(runif(8),4,2)
a
dimnames(a) <- list(NULL, c("x","y")) # If we want row names
a

#=============================================================
# 1.7 Workspace and Files
#=============================================================

ls() # Display the names of objects in the current workspace
remove() # Remove a specific object
rm()
rm(list = ls()) # Remove the entire list of objects
ls()

# It is a better idea to save functions in scripts and data in files
# Collections of functions & data sets can also be organised & documented in packages












