#=============================================================
#         Forest data exploration with R Exercise
#            (Forest Research Assessment, 2015)
#=============================================================

rm(list =ls()) # Clean R's memory

# Set the working directory
setwd("G:/My Drive/GitHub Desktop/Courses/Tutorial_R")

# Import the file
data1 = read.csv2("FRA_data2.csv", row.names = T)