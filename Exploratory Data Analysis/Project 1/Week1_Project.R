library(dplyr)
library(data.table)

#Reading the data
hp <- fread("/users/andrewhu/desktop/Coursera/Data/hp.txt")

#Trasforming dates and time
hp$dateTime =  as.POSIXct(paste(hp$Date, hp$Time), format = "%d/%m/%Y %H:%M:%S")

#Subsetting data
hp$Date = as.Date(hp$Date, format= "%d/%m/%Y")



hp2<- subset(hp, Date == "2007-02-01" | Date == "2007-02-02")
hp3 <- filter(hp, Date == "2007-02-01" | Date == "2007-02-02")#same, just for practice

#transform to numeric
hp2$Global_active_power<-as.numeric(hp2$Global_active_power)

#plot1
hist(hp2$Global_active_power, col="red", xlab = "Global Active Power(kilowatts)")


#plot2
hp$dateTime =  as.POSIXct(paste(hp$Date, hp$Time), format = "%d/%m/%Y %H:%M:%S")
hp2 <- filter(hp, dateTime >= "2007-02-01" &  dateTime <= "2007-02-02")

plot(hp2$dateTime, hp2$Global_active_power, type="l",xlab="", ylab = "Global Active Power (kilowatts)")


#plot3

plot(hp2$dateTime, hp2$Sub_metering_1, type= "l",ylab = "Energy sub metering")#meaning: don't put the data there yet
lines(hp2$dateTime, hp2$Sub_metering_2, type= "l",col="red")
lines(hp2$dateTime, hp2$Sub_metering_3, type= "l", col="blue")

legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

#plot4
par(mfrow=c(2,2))
plot(hp2$dateTime, hp2$Global_active_power, type="l",xlab="", ylab = "Global Active Power (kilowatts)")
plot(hp2$dateTime, hp2$Voltage,type="l")


plot(hp2$dateTime, hp2$Sub_metering_1, type= "l",ylab = "Energy sub metering")#meaning: don't put the data there yet
lines(hp2$dateTime, hp2$Sub_metering_2, type= "l",col="red")
lines(hp2$dateTime, hp2$Sub_metering_3, type= "l", col="blue")

legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3 "), lty=c(1,1)
       , bty="n"
       , cex=.5 )


plot(hp2$dateTime,hp2$Global_reactive_power,type="h")
