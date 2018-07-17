setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis/project 2")

#Q1
dates1 <- NEI$year
NEIEmi<- NEI$Emissions

plot(dates1, NEIEmi)

#For calculation
Emi_over_year_total<- with(NEI, tapply(Emissions, year, sum, na.rm=T))