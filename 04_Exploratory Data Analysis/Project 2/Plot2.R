#Q2

#Basic

library(ggplot2)
library("data.table")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")

#Subset for BA
NEIBA <- subset(NEI, fips=="24510")


#Calculation and Plot
Emi_over_year_BA <- with(NEIBA, tapply(Emissions, year, sum, na.rm=TRUE))
str(Emi_over_year_BA)
plot(Emi_over_year_BA, type="o", xlab= "Year", ylab= "Emissions")
