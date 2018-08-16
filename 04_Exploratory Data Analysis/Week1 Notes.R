setwd("/users/andrewhu/Documents/DataScience_JHU/Exploratory Data Analysis")

#Simple summaries of data:

#summary(var)


#boxplot
#abline(h =xx)
#hist(var)
#abline(v=12, lwd=2)
#abline(v= median(var), lwd=4)

#simple base plot
library(datasets)
data(cars)
with(cars,plot(speed,dist))

#Lattice System
library(lattice)
state<- data.frame(state.x77, region=state.region)
xyplot(Life.Exp~ Income | region, data=state, layout = c(4,1))

##ggplot
library(ggplot2)
data(mpg)
qplot(displ,hwy,data=mpg)


#Basic Plotting System in R
hist(airquality$Ozone)

with(airquality, plot(Wind, Ozone))

#Set global graphics parameters
#par()

#check default
par("lty")

#plot: make scatterplot
#lines: add lines
#points: add points
#text: add text labels
#title: add annotations outside the plot
#axis: add axis ticks/labels
with(airquality, plot(Wind, Ozone))
title(main= "Ozone")

#Base plot with subset

with(airquality, plot(Wind,Ozone, main="Ozone and Wind in NYC"))
with(subset(airquality,Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality,Month!=5), points(Wind, Ozone, col="red"))
legend("topright", pch=1 , col= c("blue","red"), legend=c("May", "Other Months"))

#add a regression line

with(airquality, plot(Wind,Ozone, main="Ozone and Wind",pch= 20))
model <- lm(Ozone~Wind, airquality)
abline(model, lwd=2)


######Base plot demons####

x<- rnorm(100)
hist(x)
y<- rnorm(100)
hist(y)
plot(x,y)

#margin of plots
par(mar= c(2,2,2,2))
plot(x,y)
par(mar= c(4,4,2,2))

#pch= different plotting symbols

plot(x,y, pch=20)
plot(x,y,pch=19)

#Add title and label
title("ScatterPlot")
text(-2,-2, "label")
legend("topleft",legend="Data" )

# Add regression line
fit <- lm(y~x)
abline(fit)

#Set the width of line
abline(fit, lwd=3, col="blue")

#plot two rows together
z<- rpois(100,2)
par(mfrow=c(2,1)) #two rows, one col
plot(x,y,pch=20)
plot(x,z,pch=19)

#rearrange the margin
par("mar")
par(mar= c(2,2,1,1))
plot(x,y,pch=20)
plot(x,z,pch=19)

#different rows of plots
par(mfrow=c(2,2))
plot(x,y)
plot(x,z)
plot(z,x)
plot(z,y)


#Loading points separately . Subsetting based on grouping variables
par(mfrow=c(1,1))
x<- rnorm(100)
y<- x + rnorm(100)
g <- gl(2,50)
g<- gl(2,50, labels = c("Male", "Female"))
str(g)

plot(x,y, type= "n") #meaning: don't put the data there yet
points(x[g=="Male"], y[g=="Male"], col= "green")
points(x[g=="Female"], y[g=="Female"], col= "blue")


