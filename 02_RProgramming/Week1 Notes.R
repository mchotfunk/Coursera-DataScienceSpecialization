swirl()
old.dir
getwd()


#Reading URL
Con <-url("http://www.jhsph.edu" ,"r" )
Con
x<- readLines(Con)
head(x)


#Subsetting
# double braket can be used for computed index

x<- list(foo=1:4, bar=0.6, baz= "hello")
x$bar
x$foo
name <- "foo"
x[[name]]

x<- list(a= list(10,12,14), b=c(3.14,2.81))
x[[c(1,3)]]

x[[c(2,1)]]

x<- matrix(1:6, 2,3 )

x[1,2]
x[1,]
x[,2]

#Return the matrix
x[1,2,drop=F]
x[2, ,drop=F]

#Partial matching
x<- list(adjdofjodaif= 1:5)
x$a
x[["a"]]
x[["a", exact=F]]

#Removing NA values
x<- c(1,2,3,NA,NA,5)
bad<- is.na(x) #create a logical vector
x[!bad]

#choosing non NA values
y<- c("a", "b","c", NA, NA,"d")

good<- complete.cases(x,y)
x[good]
y[good]

#Double equal sign tests the equality 

x<- c(1,3,5)
y<- c(2,2,2)
cbind(x,y)

x<- list(2,"a","b",TRUE)
x[[1]]


x <- c(17, 14, 4, 5, 13, 12, 10)
x[x > 10]<- 4
x[x == 10] <-4
x

setwd('/users/andrewhu/desktop/')
hw1<-read.csv("hw1_data.csv")
hw1[47,]
dim(hw1)

sum(is.na(hw1$Ozone))


bad<- is.na(hw1)
good<- (hw1[!bad])
good <- complete.cases(hw1)

summary(hw1[good,])

summary(good)


ex<- hw1[hw1$Ozone>31 & hw1$Temp>90, ]
summary(ex)


summary(hw1[hw1$Month==5,])
