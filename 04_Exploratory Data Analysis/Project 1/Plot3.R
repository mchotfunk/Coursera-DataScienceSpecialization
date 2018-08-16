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

#plot3

plot(hp2$dateTime, hp2$Sub_metering_1, type= "l",ylab = "Energy sub metering")#meaning: don't put the data there yet
lines(hp2$dateTime, hp2$Sub_metering_2, type= "l",col="red")
lines(hp2$dateTime, hp2$Sub_metering_3, type= "l", col="blue")

legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))