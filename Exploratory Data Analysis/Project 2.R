NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")
summary(NEI)
#subset for 1999, 2002, 2005, and 2008

x99 <- subset(NEI,year ==1999)
x02 <- subset(NEI,year == 2002)
x05 <- subset(NEI,year == 2005)
x08 <- subset(NEI,year == 2008)
summary(x99)
str(x99)

#margin
par(mfrow=c(1,1),mar=c(1,1,1,1))

#Q1
boxplot((x99$Emissions),(x02$Emissions),(x05$Emissions),(x08$Emissions) )


#Subset for Baltimore City, Maryland 

x99ba <- subset(x99, fips=="24510")
x02ba <- subset(x02, fips=="24510")
x05ba <- subset(x05, fips=="24510")
x08ba <- subset(x08, fips=="24510")

#Q2
boxplot(log10(x99ba$Emissions),log10(x02ba$Emissions),log10(x05ba$Emissions),log10(x08ba$Emissions) )

#Subset for different types

x99point <- subset(x99ba, type=="POINT")
x99nonpoint <- subset(x99ba, type=="NONPOINT")
x99onroad <- subset(x99ba, type=="ONROAD")
x99nonroad <- subset(x99ba, type=="NONROAD")


x02point <- subset(x02ba, type=="POINT")
x02nonpoint <- subset(x02ba, type=="NONPOINT")
x02onroad <- subset(x02ba, type=="ONROAD")
x02nonroad <- subset(x02ba, type=="NONROAD")

x05point <- subset(x05ba, type=="POINT")
x05nonpoint <- subset(x05ba, type=="NONPOINT")
x05onroad <- subset(x05ba, type=="ONROAD")
x05nonroad <- subset(x05ba, type=="NONROAD")

x08point <- subset(x08ba, type=="POINT")
x08nonpoint <- subset(x08ba, type=="NONPOINT")
x08onroad <- subset(x08ba, type=="ONROAD")
x08nonroad <- subset(x08ba, type=="NONROAD")


