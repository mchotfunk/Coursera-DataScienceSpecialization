library(ggplot2)
#Q1
dates1 <- factor(NEI$year)
NEIEmi<- NEI$Emissions

plot(dates1, NEIEmi)

#For calculation
Emi_over_year_total<- with(NEI, tapply(Emissions, year, sum, na.rm=T))

#Q2
#Subset for BA

NEIBA <- subset(NEI, fips=="24510")

#Plot
datesBA <- NEIBA$year
BAEmi <- NEIBA$Emissions
plot(datesBA, BAEmi)

#Calculation
Emi_over_year_BA <- with(NEIBA, tapply(Emissions, year, sum, na.rm=TRUE))
Emi_over_year_BA

#Q3
BApoint <- subset(NEIBA, type == "POINT")
BAnonpoint <- subset(NEIBA, type == "NONPOINT")
BAonroad <- subset(NEIBA, type == "ON-ROAD")
BAnonroad <- subset(NEIBA, type == "NON-ROAD")

#Calculation
point<- with(BApoint, tapply(Emissions, year, sum, na.rm=T))
nonpoint<- with(BAnonpoint, tapply(Emissions, year, sum, na.rm=T))
onroad<- with(BAonroad, tapply(Emissions, year, sum, na.rm=T))
nonroad<- with(BAnonroad, tapply(Emissions, year, sum, na.rm=T))

point
nonpoint
onroad
nonroad

plot(BApoint$year, BApoint$Emissions)
plot(BAnonpoint$year, BAnonpoint$Emissions)
plot(BAonroad$year, BAonroad$Emissions)
plot(BAnonroad$year, BAnonroad$Emissions)


##ggplot base
g<- ggplot(NEIBA, aes(factor(year),Emissions) )
g + geom_point()+ facet_grid(. ~type)

#Q4




