library(dplyr)
library(data.table)


######Data Preparation######


#Reading the data
hp <- fread("/users/andrewhu/desktop/Coursera/Data/hp.txt")

#Trasforming dates and time
hp$dateTime =  as.POSIXct(paste(hp$Date, hp$Time), format = "%d/%m/%Y %H:%M:%S")

#Subset
hp2<- subset(hp, Date == "2007-02-01" | Date == "2007-02-02")

#transform to numeric
hp2$Global_active_power<-as.numeric(hp2$Global_active_power)

#plot1
hist(hp2$Global_active_power, col="red", xlab = "Global Active Power(kilowatts)")