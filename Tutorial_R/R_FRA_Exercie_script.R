#=============================================================
#         Forest data exploration with R Exercise
#            (Forest Research Assessment, 2015)
#=============================================================

rm(list =ls()) # Clean R's memory

# Set the working directory
setwd("G:/My Drive/GitHub Desktop/Courses/Tutorial_R")

# Import the file
data1 = read.csv2("FRA_data2.csv", row.names=1)

# 21. For how many territories do we have data
nrow(data1)

# 22. How many factor variables do we have
sapply(data1, class)

# 23. # How many levels have the variable climate
table(data1$Climate)

# 24. What do contain the rownames
rownames(data1)

# 25. How many numeric / integer variables do we have
str(data1)
sapply(data1, class)

# 26. What is the minimum value of Forest Area (FA)
forest_area = data1[order(data1$FA),]
head(forest_area)

# 27. What country has the lowest FA = Fiji

# 28. Which territory has the highest forest area change
names(data1)







