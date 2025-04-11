#=============================================================
#              Forest data exploration with R
#            (Forest Research Assessment, 2015)
#=============================================================

# Run the scripts and see the results

rm(list = ls()) #Clean R's memory

#=============================================================
# 4.1 - Importing data from files 
#=============================================================

# Setting the working directory
setwd("G:/My Drive/GitHub Desktop/Courses/Tutorial_R") # Update working directory 

# Reading the first data set and the titles
data = read.csv2("FRA_data1.csv",row.names=1) 
titles = read.csv2("FRA_titles.csv",row.names=1)

#=============================================================
# 4.2 - General information on the data structure
#=============================================================

#=============================================================
# 4.2.1 - Main functions
#=============================================================

str(data) # Structure of the object
nrow(data) # No. of rows
ncol(data) # No. of columns
dim(data) # No. of rows & columns
names(data) # Names of columns
rownames(data) # Names of rows
head(data) # First 6 rows
tail(data) # Last 6 rows
head(titles) # First 6 rows

#=============================================================
# 4.2.2 - Types of variables
#=============================================================

class(data) # Type of object
sapply(data, is.factor) # Tracking the factor variables
sapply(data, class) # Identifying variable types
is.factor(data) # Checks if variable is a factor
is.numeric(data) # Checks if variable is numeric
which(data) # Returns list of elements having a true value
Vn = which(sapply(data, is.numeric)) # Determine the position of the numeric variables
Vn

#=============================================================
# 4.3 - Selecting subsets of data
#=============================================================

#=============================================================
# 4.3.1 - Selection with numbers
#=============================================================

head(data) # First 6 rows of data
data[3,] # Extract a single row, e.g. 3
data[c(1:3,6),] # Extract several specific rows
data[,1] # Extract a single column, e.g. 1
data[1:5,1:2] # Select ranges of specific rows & columns
data[c(10:15,30:35),1:2] # Select ranges of specific rows & columns
data[10:20,-3] # Selection by removing specific row
data[50:60,-c(2,3)] # Selection by removing several rows
data[-c(1:3,6:230),] # Selection by removing rows 1-3 and 6-230
data[-(11:nrow(data)),] # Selection by removing all rows from the 11th to the last
data[c(71,82,127,130,169),] # Selection of French overseas territories

#=============================================================
# 4.3.2 - Selection with names
#=============================================================

# Selection with a row name
Data["Algeria",]

# Same selection with an abbreviation of the row name
Data["Alg",]

#=============================================================
# 4.4 – Descriptive statistics of variables
#=============================================================

#=============================================================
# 4.4.1 - General function
#=============================================================



#=============================================================
# 4.4.3 - Descriptive statistics for numeric variables
#=============================================================



#=============================================================
# 4.5 – Missing values
#=============================================================

