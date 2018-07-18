library(ggplot2)
library("data.table")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")
NEIBAONROAD <- subset(NEI, fips=="24510" & type == "ON-ROAD")


#Method1
NEI.onroad <- aggregate(NEIBAONROAD[c("Emissions")], list(type= NEIBAONROAD$type, year= NEIBAONROAD$year), sum )

#base
g<- ggplot(NEI.onroad , aes(x= factor(year),y= Emissions, fill=type))

#
g + geom_bar(stat= "identity")


#Method2
NEI.onroad2 <- with(NEIBAONROAD, tapply(Emissions, year, sum, na.rm=T))
plot(NEI.onroad2, type="o", xlab="Year", ylab= "Emissions")
