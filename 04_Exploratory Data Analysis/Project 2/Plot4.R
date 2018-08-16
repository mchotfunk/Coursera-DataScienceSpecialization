library(ggplot2)
library("data.table")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")
NEIBA <- subset(NEI, fips=="24510")



coal <- SCC[grepl("Coal",SCC$Short.Name),"SCC" ]

NEI.sub <- NEI[NEI$SCC %in% coal,]

NEI.coal <- aggregate(NEI.sub[c("Emissions")], list(type= NEI.sub$type, year= NEI.sub$year), sum )


##ggplot

#base
g<- ggplot(NEI.coal, aes(x= factor(year),y= Emissions, fill=type))

#
g + geom_bar(stat= "identity")
