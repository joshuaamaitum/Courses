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

head(data)
data["Algeria",] # Selection with a row name
data["Uganda",]

# Same selection with an abbreviation of the row name
data["Alg",]
data["Uga",]

data[c("Ken","Uga","Tan","Rwa","Buru"),] # Select a list of rows
head(data)
data[,"Continent"] # Selection of a variable
data$Continent

# Select a dataframe subset with a 2 columns 
selec = data[1:5,c("LA","FA")]
selec
class(selec) # Type of object

# Select a dataframe subset with 1 column
selec = data[6:10,c("LA")]
selec

# Select the data from French Guiana & France
french = data[c("French Guiana","France"),]
french

#=============================================================
# 4.3.2 - Selection with Conditions
#=============================================================

head(data)
data[data$Continent=="Asia",] # Select all data from a continent
data[data$LA>=500000,] # Select countries with LA above 500000

#=============================================================
# 4.4 – Descriptive statistics of variables
#=============================================================

summary(data)
table(data$Continent) # Frequency of factor variables
vn = which(sapply(data, is.numeric)) # Identify the numeric variables
vn
datanum = data[,vn] # Table without factor variables
head(datanum)

# Apply statistics (affected by missing values)
apply(datanum,2,min)
apply(datanum,2,max)
apply(datanum,2,quantile)

# Deal with the missing values
apply(datanum,2,min,na.rm=T)
apply(datanum,2,max,na.rm=T)
apply(datanum,2,sd,na.rm=T)
apply(datanum,2,mean,na.rm=T)
apply(datanum,2,quantile,na.rm=T)

#=============================================================
# 4.5 – Missing values
#=============================================================

MV = is.na(data) # TRUE is place of NA & FALSE else where
head(MV)
sum(MV) # Sum of missing values
MVv = apply(MV,2,sum) # Number of missing values per variable
MVv
MVr = apply(MV,1,sum) # Number of missing values per row
MVr
table(MVr) # Frequency of the number of missing values per row
data[MVr>0,] # Identify what specific rows have missing values

# Question 13
dataw = data[MVr==0,] # Table of rows without missing values
dataw
dim(dataw);dim(data)
data1 = na.omit(data)
dim(dataw);dim(data)

# Replace all missing values (TRUE) with a zero
MV = is.na(data)
data[MV]=0
summary(data) # NA now replaced with 0
dim(dataw);dim(data)

#=============================================================
# 4.6 – Manipulation of dataframes
#=============================================================

#=============================================================
# 4.6.1 – Creation of variables
#=============================================================

# These can be features for each variable

data$FCR -> data$FA / data$LA # For example forest cover rate from FA & LA
summary(data)
head(data)

# Create transformed variables
data$LAlog = log10(data$LA)
data$FAlog = log10(data$FA)
summary(data)

# Avoid infinite values in transformed functions
data$LAlog <- log10(data$LA+1)
data$FAlog <- log10(data$FA+1)
summary(data) # Mean and the median are not very different

#=============================================================
# 4.6.2 – Ordering rows or columns
#=============================================================

# Ordering rows by increasing order of forest cover (lowest to highest)
data[order(data$FCR),c("Continent","FCR")]
head(data)

# Order by decreasing forest cover
data[order(data$FCR, decreasing=T),c("Continent","FCR")]

# Select top 10 forest cover rate countries
fcr <- data[order(data$FCR, decreasing=T),c("Continent","FCR")][1:10,]
fcr

#=============================================================
# 4.7 – Statistics calculated from subsets of data
#=============================================================

# Compute average land and forest area per continent
head(data)
continents = aggregate(data[,2:3], list(data$Continent), mean, na.rm=T)
continents

# Land and forest cover per continent
head(data)
continents = aggregate(data[,2:3],list(data$Continent), sum, na.rm=T)
continents

# Transfer names of continents to row names and remove the first column
rownames(continents) = continents[,1]
continents
continents = continents[,-1]
continents

# Forest cover rate per continent
head(continents)
continents$FCR = continents$FA / continents$LA
continents
continents = continents[order(continents$FCR,decreasing = T),]
continents

#=============================================================
# 4.8 – Graphics
#=============================================================

#=============================================================
# 4.8.1 – Comparing values of small data sets
#=============================================================

# Pie chart of forest area per continent
pie(continents$FA,main="Forest area / Continent",labels=rownames(continents))

# Bar chart of forest area per continent
barplot(continents$FA,main="Forest Area / Continent",names=rownames(continents))

# Make the thickness of the barplots proportional to land area
barplot(continents$FCR,main="Forest Cover Rate / Continent",
        width=continents$LA,names=rownames(continents),
        ylab="Forest cover rate",
        xlab="Continents")

# Include the mean forest cover rate (global average)
FCRw = sum(continents$FA)/sum(continents$LA)
abline(h=FCRw, col="red", Ity=2)
mtext(paste("Global FC rate :",round(FCRw*100,1),"%"),line=-4,col="red")

# Territories per continent
table(data$Continent)
pie(table(data$Continent), main="Number of Territories")
barplot(table(data$Continent), main="Number of Territories")







