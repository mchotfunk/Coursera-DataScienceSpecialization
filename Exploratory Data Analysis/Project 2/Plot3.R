library(ggplot2)
library("data.table")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd("/Users/andrewhu/Documents/GitHub/Coursera_DataScience_JHU/Exploratory Data Analysis")
NEIBA <- subset(NEI, fips=="24510")

#Subset a df: sum for Emissions, by type and by year
Emi_over_year_BA_df <- aggregate(NEIBA[c("Emissions")], list(type= NEIBA$type, year= NEIBA$year), sum )

##ggplot

#base
g<- ggplot(Emi_over_year_BA_df, aes(factor(year),Emissions) )

#
g + geom_point()+ facet_grid(. ~type)
