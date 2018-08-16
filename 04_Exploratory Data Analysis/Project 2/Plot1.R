library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")

par(mfrow= c(1,1))
#Q1
Emi_over_year_total<- with(NEI, tapply(Emissions, year, sum, na.rm=T))
plot(Emi_over_year_total, type="o", xlab="Year", ylab= "Emissions")

