#Week 2 Notes

############Lattice plotting system#########


#xyplot:


library(lattice)
library(datasets)

#Simple scatter
xyplot(Ozone~Wind, data=airquality)

#seperated by month

#convert month to factor
airquality <- transform(airquality, Month= factor(Month))
xyplot(Ozone~ Wind | Month, data=airquality,layout= c(5,1))


#Lattice Panel Functions##

#Generate random data
set.seed(10)
x<- rnorm(100)
f <- rep(0:1, each=50)
y <- x + f - f*x + rnorm(100, sd=0.5)
f <- factor(f, labels = c("Group1", "Group2"))

#plot with 2 panels
xyplot( y~x | f, layout= c(2,1))


#Custom panel function (structure)

xyplot(y~x | f, panel= function(x,y,...) {
        panel.xyplot(x,y,...)#first, call the default panel function for xyplot
        panel.abline(h = median(y), lty=2) #add line at median
        panel.lmline(x,y, col=2) #slr line
        
}) 




######  ggplot2 : qplot#####
library(ggplot2)
str(mpg)



#simple qplot
qplot(displ, hwy, data=mpg, color= drv)#assign different colors by drv

#adding a geom: smooth?
qplot(displ, hwy, data=mpg, geom= c("point", "smooth"))


#histogram
qplot(hwy, data=mpg, fill= drv)#seperate by drv


#Facets: subsets of data indicated by a factor
#var at right hand side determines the cols of the panels
#var at left: determine rows
qplot(displ, hwy, data=mpg, facets= .~drv)
qplot(hwy, data= mpg, facets= drv~.)



######  ggplot2: ggplot#####


g<- ggplot(df, aes(x,y))
print(g) #no layers yet

p<- g + geom_point() #save and print ggplot object
print(p)

g+ geom_point() #auto print plot object







