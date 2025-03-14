#=============================================================
#              Forest data exploration with R
#            (Forest Research Assessment, 2015)
#=============================================================

# Run the scripts and see the results

rm(list = ls()) #Clean R's memory

#=============================================================
# 4.1 - Importing data from files #####
#=============================================================

# Setting the working directory
setwd("G:/My Drive/GitHub Desktop/Courses/Tutorial_R") # Update

# Reading the first data set and the titles
Data = read.csv2("FRA_data1.csv",row.names=1) 
Titles = read.csv2("FRA_titles.csv",row.names=1)

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

