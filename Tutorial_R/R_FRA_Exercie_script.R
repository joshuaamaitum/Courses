#=============================================================
#         Forest data exploration with R Exercise
#            (Forest Research Assessment, 2015)
#=============================================================

rm(list =ls()) # Clean R's memory

# Set the working directory
setwd("G:/My Drive/GitHub Desktop/Courses/Tutorial_R")

# Import the file
data1 = read.csv2("FRA_data2.csv", row.names=1)
names = read.csv2("FRA_titles.csv",row.names=1)

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
FAC = data1[order(data1$FAC,decreasing=T),]
head(FAC)

# 29. Which territory has the lowest forest area change
FAC = data1[order(data1$FAC),]
head(FAC)

# 30. The 3 variables having more than 40 missing values
MV = is.na(data1)
sum(MV)
MVr = apply(MV,1,sum)
MVr
MVc = apply(MV,2,sum)
MVc

# 31. How many countries have no missing values
table(MVr)

# 32. Identify the countries with 5 missing values
data1[MVr>5,]

# 33. Under which climate are other wooded lands most common
names(data1)
owa = aggregate(data1[,6], list(data1$Climate), sum, na.rm=T)
owa

# 34. Which climate displays two-thirds of the world's biomass
names(data1)
bio = aggregate(data1[,15], list(data1$Climate), sum, na.rm=T)
bio

# 35. Under what climate do we find more than half of the world's forest plantations
names(data1)
pla = aggregate(data1[,9],list(data1$Climate), sum, na.rm=T)
pla

# 36. Under what climate do we find half of the world's primary forests
names(data1)
pri = aggregate(data1[,8], list(data1$Climate), sum, na.rm=T)
pri

# 37. Climate with more than 60% of the world's coniferous forest volume
names(data1)
con = aggregate(data1[,12], list(data1$Climate), sum, na.rm=T)
con

# 38. Climate with forest area decrease of 4 million hectares per year
names(data1)
fac = aggregate(data1[,7], list(data1$Climate), sum, na.rm=T)
fac

# 39. Forests having the lowest species diversity
names(data1)
div = aggregate(data1[,14], list(data1$Climate), sum, na.rm=T)
div

# 40. Climate with lowest forest volume per hectare
names(data1)
vol = aggregate(data1[,11], list(data1$Climate), sum, na.rm=T)
vol


