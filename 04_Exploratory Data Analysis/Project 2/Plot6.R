library(ggplot2)
library("data.table")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")
NEIBAONROAD <- subset(NEI, fips=="24510" & type == "ON-ROAD")
NEILAONROAD <- subset(NEI, fips=="06037" & type == "ON-ROAD")


par(mfrow=c(1,2))

ba <- with(NEIBAONROAD, tapply(Emissions, year, sum, na.rm= TRUE))
la <- with(NEILAONROAD, tapply(Emissions, year, sum, na.rm= TRUE))


plot(ba, type ="o", xlab="Year", ylab= "Emissions", main="BA Emissions")
plot(la, type ="o", xlab="Year", ylab= "Emissions", main= "LA Emissions")