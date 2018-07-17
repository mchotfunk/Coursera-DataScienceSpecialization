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