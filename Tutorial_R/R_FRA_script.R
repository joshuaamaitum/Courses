##############################################################################
#                    Forest data exploration with R
#                  (Forest Research Assessment, 2015)
##############################################################################


##############################################################################
#############                 
#############        Run the scripts and see the results
#############                 
##############################################################################

##############################################################################
##### 4.1 - Importing data from files
##############################################################################

# Setting the working directory
setwd("D:/AGROPARISTECH/R_TUTORIAL/Tutorial_R") # Update

# Reading the first data set and the titles
Data = read.csv2("FRA_data1.csv",row.names=1) 
Titles = read.csv2("FRA_titles.csv",row.names=1)

# Table structure

str(Data)

#Questions 1 and 2

# Row names of the table
rownames(Data)

# First rows of the table
head(Data)

# Question 3
head(Titles)

# Questions 4 and 5
# Identifying the variables types
sapply(Data, class)
# Tracking the factor variables
sapply(Data,is.factor)
# Positions of the factor variables in the data frame
Vf = which(sapply(Data,is.factor))
Vf
# Positions of the numeric variables in the data frame
Vn = which(sapply(Data,is.numeric))
Vn

# Question 6
# Reminder of the 6 first rows of Data
head(Data)

# Selection of 1 line by its row number
Data[3,]

# Selection of a list of lines, with row numbers (example : 1 to 3, and 6)
Data[c(1:3,6),]

# Selection of one specific column (example for column number 1)
Data[,1]

# Selection of rows and columns
Data[1:5,1:2]

# Selection by removing 1 variable
Data[1:5,-2]

# Selection by removing several variables
Data[1:5,-c(2,3)]

# Selection by removing rows (numbers 1, 3 and 6 to 230)
Data[-c(1,3,6:230),]

# Selection by removing all rows from the 4th to the last
Data[-(4:nrow(Data)),]

# Question 7
# Selection of specific rows (example : 1 to 3, and 6)
Data[c(71, 82, 127, 130, 169),]

##############################################################################
##### 4.3.2 - Selection with names
##############################################################################

# Selection with a row name
Data["Algeria",]

# Same selection with an abbreviation of the row name
Data["Alg",]

# Warning : the abbreviation should be fitted to only 1 row name Data["Al",] # Tentative selection of Albania and Algeria
# Selection of a list of rows
Data[c("Af","Alb","Alg","Ango"),]

# Selection of a variable
Data[,"Continent"]

# Warning : abbreviations cannot be used for variables
#Data[,"Contin"] # Tentative selection of a variable with an abbreviation # Same selection with the $
Data$Continent

# Selection of a data frame subset with at least 2 columns --> data frame Selec = Data[1:3, c("LA","FA")]
Selec = Data[1:3, c("LA","FA")]
class(Selec)

# Selection of a data frame subset with only 1 column --> vector
Selec = Data[1:3, "LA"]
Selec
class(Selec)

# Question 8
Data[c("French Guiana","France"),]

# How to find easily information on the Data variables in Titles
names(Data) 
Titles[names(Data),] 
Titles["FA",c(1,3)]

##############################################################################
##### 4.3.3 - Selection with conditions
##############################################################################

# Select all data from a continent
Data[Data$Continent=="Asia",] 
Data[Data[,1]=="Asia",]

# Select all territories having a territory larger than a threshold
Data[Data$LA >= 500000,]

# Question 9
# Select the data of a list of territories
Data[rownames(Data) %in% c("France","French Guiana"),]

# Select data for French Guiana and France
Data[rownames(Data) %in% c("Australia","Brazil","Canada","China","Russian Federation","USA"),]
Area<-data.frame(Data[c("Australia","Brazil","Canada","China","Russian Federation","USA"),])

#Try and order by FA
df <- Area[order(Area$FA), ]
print(df)

# Question 10: Among the largest countries of the american continent, which one has the largest forest area ?
Area1 <- Data[rownames(Data) %in% c("Brazil","Canada","USA"),]
df1 <- Area1[order(Area1$FA), ]
print(df1)

##############################################################################
##### 4.4 – Descriptive statistics of variables
##############################################################################

##############################################################################
##### 4.4.1 - General function
##############################################################################

# Table content
summary(Data)

# Reminder of the factor variables in Data 
Vf

# Question 11: Which continent has the largest number of territories ?
# Frequency of the factor values 
table(Data$Continent)

##############################################################################
##### 4.4.3 - Descriptive statistics for numeric variables
##############################################################################

# Reminder of the factor variables in Data 
Vn

Datanum = Data[,Vn]
head(Datanum)

# Examples of statistics 
apply(Datanum,2,min)
apply(Datanum,2,quantile)

# Remove the missing values (na.rm = TRUE) 
apply(Datanum,2,min, na.rm = TRUE) 
apply(Datanum,2,quantile, na.rm = T) 
apply(Datanum,2,mean, na.rm = T) 
apply(Datanum,2,sd, na.rm = T)

# Question 12: Comparing the FA quantiles to the mean FA shows that

##############################################################################
##### 4.5 – Missing values
##############################################################################

# Creation of a data frame with TRUE in place of the NAs and FALSE everywhere else
MV = is.na(Data)
head(MV)

# Total number of missing values
sum(MV)

# Number of missing values / variables
MVv = apply(MV,2,sum)
MVv

# Number of missing values / rows
MVr = apply(MV,1,sum)
MVr

# Frequency of the number of missing values per row table(MVr)
# Rows with missing values
Data[MVr>0,]

# Question 13
# Table without rows containing missing values
Dataw = Data[MVr == 0,]
dim(Dataw) ; dim(Data)
Dataw = na.omit(Data)
dim(Dataw) ; dim(Data)

# Substitution of all NAs by 0 (only if there are relevant reasons to do it) 
Data[MV]=0 

# In fact, the values are equal to 0 in the original data base # Checking the absence of NAs, without removing rows
summary(Data)
dim(Dataw) ; dim(Data)

##############################################################################
##### 4.6 – Manipulation of data frames
##############################################################################

#4.6.1 - Creating variables
# Creation of a variable “FCR” (Forest Cover Rate”)
Data$FCR = ((Data$FA / Data$LA)*100)
summary(Data)

# Transformation of LA and FA by the decimal logarithm
Data$LAlog = log10(Data$LA) 
Data$FAlog = log10(Data$FA) 
summary(Data)

# Transformed variables avoiding the infinite values (log(0)→-inf) Data$LAlog = log10(Data$LA+1)
Data$FAlog = log10(Data$FA+1)
summary(Data)

# Question 15

#4.6.2 - Ordering rows or columns

# Selection of 2 variables of the data frame (continent ant forest cover rate), and ordering the data rows by increasing forest cover rate
Data[order(Data$FCR) , c("Continent","FCR")]

# Here we order the rows by decreasing forest cover rate
# and then we select the 10 first rows
Data[order(Data$FCR, decreasing=T),c("Continent","FCR","FA")][1:10,]

# Question 16

#4.7 – Statistics calculated for subsets of data
# Land and forest covers per continents
Continents = aggregate(Data[,2:3], list(Data$Continent), sum, na.rm=T)
Continents

# Transfer the names of the continents in the row names
rownames(Continents) = Continents[,1]
Continents

# Removal of the first column
Continents = Continents[,-1]
Continents

# Calculation of a forest cover rate / continent
Continents$FCR = Continents$FA / Continents$LA

# Ordering the rows by decreasing forest area
Continents = Continents[order(Continents$FA, decreasing=T),]
Continents

##############################################################################
##### 4.8 - Graphics
##############################################################################

#4.8.1 - Comparing values of small data sets
# Pie chart of the forest area per continent
pie(Continents$FA, main="Forest area / continent", labels=rownames(Continents))

# Bar chart of the forest area per continent
barplot(Continents$FA, main="Forest area / continent", names=rownames(Continents))

# Barplot of the forest cover rate with bar's width proportional to land area # --> bars area proportional to forest area
barplot(Continents$FCR, width = Continents$LA,
        names=rownames(Continents), las=2, main = "Forest cover rate / continent", ylab="Forest cover rate")
mtext("(forest areas proportional to bar areas)",line=0.3)

# Addition of the mean forest cover rate (world scale)
FCRw = sum(Continents$FA)/sum(Continents$LA)
abline(h= FCRw, col="red", lty=2)
mtext(paste("Global FC rate :",round(FCRw*100,1),"%"),line=-4, col="red")

#Question 17: "Which territory displays the highest forest cover rate ? (French Guiana, Guyana, Suriname, Gabon, Laos, Micronesia)
countries = Data[c("French Guiana","Guyana","Suriname","Gabon","Laos","Micronesia"),]
rate=countries[order(countries$FCR, decreasing=T),]
rate

rate1=Continents[order(Continents$FCR, decreasing=T),]
rate1          

# Example of small data set : number of territories per continent
table(Data$Continent)

# Pie chart
pie(table(Data$Continent), main="Number of territories")

# Bar chart
barplot(table(Data$Continent), main="Number of territories")
# Choice of colours for the continents
rownames(Continents)
Colcont = c("red","orange","green","blue","magenta")
# Application to the pie chart
pie(table(Data$Continent), col=Colcont, main="Number of territories")
# Application to the bar chart
barplot(table(Data$Continent), col=Colcont, main="Number of territories")

#4.8.3 - Distributions of large data sets
# Histograms
hist(Data$LA, main="Histogram of the land areas", xlab="Land area (1000 ha)") 
hist(Data$FA, main="Histogram of the forest areas", xlab="Forest area (1000 ha)") 
hist(Data$FCR, main="Histogram of the forest cover rates", xlab="Forest cover rate") 
hist(Data$LAlog, main="Histogram of the land areas (log10 scale)",xlab="log10(Land area (1000 ha)+1)")

# Controlling the number of intervals with "breaks"
hist(Data$LAlog, main="Histogram of the land areas (log10 scale)", xlab="log10(Land area (1000 ha)+1)", breaks=6)
hist(Data$FAlog, main="Histogram of the forest areas (log10 scale)", xlab="log10(Forest area (1000 ha)+1)", breaks=6)

# Question 18: How many territories have a forest area comprised between 100 000 and 1000 000 ha ?
territories<-Data[Data$FA >= 100 & Data$FA <= 1000,]
territories
nrow(territories)

# Boxplots of areas (original scales)

boxplot(Data[,2:3], ylab="Areas (1000 ha)", names=c("Land area" ,"Forest area"), main="Distribution of the land and forest areas")
# Boxplots of forest areas (original scales)
boxplot(Data[,4], ylab="Forest cover rate", main="Distribution of the forest cover rate")
# Boxplots of forest areas (log scales)
boxplot(Data[,5:6], ylab="log(Areas (1000 ha) + 1)", 
        names=c("Land area" ,"Forest area"), 
        main="Distribution of the land and forest areas")
mtext("(decimal log scale)",line=0.3)

# Question 19: To which interval do belong the medians of both variables "Land area" and "Forest area" ?

#4.8.4 – Displaying several graphs on a divided window
# Drawing 5 histograms in a same figure
# Sharing the window into 2x3 small windows par(mfrow=c(2,3))
# Reduction of the margins
par(mar=c(2,2.5,2.5,0.5))

# Histograms
hist(Data$LA, main="Land areas")
mtext("(1000 ha)", cex=0.7, line=-0.5)
hist(Data$FA, main="Forest areas")
mtext("(1000 ha)", cex=0.7, line=-0.5)
hist(Data$FCR, main="Forest cover rates") 
hist(Data$LAlog, main="log10(Land area +1)" ,breaks=6,
                                               xlab="log10(Land area (1000 ha)+1)")
mtext("(1000 ha)", cex=0.7, line=-0.5)
hist(Data$FAlog, main="log10(Forest area +1)" ,breaks=6,
     xlab="log10(Forest area (1000 ha)+1)") mtext("(1000 ha)", cex=0.7, line=-0.5)

# Back to a unique window par(mfrow=c(1,1))
# Back to the standard margins par(mar=c(5,4,4,2)+0.1)

# Drawing 3 graphs with boxplots on the same figure 
# Sharing the window into 2x2 small windows 
par(mfrow=c(2,2))

# Reduction of the margins
par(mar=c(2,4,4,0.5))
# Boxplots
boxplot(Data[,2:3], ylab="Areas (1000 ha)", names=c("Land area" ,"Forest area"), main="Land and forest areas")
mtext("(1000 ha)",line=0.3, cex=0.9) boxplot(Data[,4], ylab="Forest cover rate", main="Forest cover rate")
boxplot(Data[,5:6], ylab="log(Areas (1000 ha) + 1)",names=c("Land area" ,"Forest area"),main="Land and forest areas") mtext("(log10(1000 ha +1))",line=0.3, cex=0.9) # Back to a unique window
par(mfrow=c(1,1))
# Back to the standard margins par(mar=c(5,4,4,2)+0.1)

Data2 = read.csv2("FRA_data2.csv",row.names=1) 


