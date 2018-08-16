#Q1
library(caret)
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(rattle)

inTrain <- createDataPartition(y=segmentationOriginal$Case, p=0.75, list=FALSE)
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]

set.seed(125)
modFit <- train(Class ~ .,method="rpart",data=training)
print(modFit$finalModel)
library(rattle)
fancyRpartPlot(modFit$finalModel)



#Q3
library(pgmm)
data(olive)
olive = olive[,-1]

modFit <- train(Area ~ .,method="rpart",data=olive)
print(modFit$finalModel)
predict(modFit,newdata=as.data.frame(t(colMeans(olive))))


#Q4

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]


set.seed(13234)
modFit <- train(chd ~ age+ alcohol +obesity + tobacco + ldl + typea,method="glm",family="binomial",data=trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(testSA$chd, predict(modFit, newdata = testSA))
missClass(trainSA$chd, predict(modFit, newdata = trainSA))


#Q5
library(dplyr)
library(randomForest)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train <- mutate(vowel.train, y=factor(y))
vowel.test <- mutate(vowel.test, y=factor(y))
set.seed(33833)
fit1<- randomForest(y~., data=vowel.train)

order(varImp(fit1),decreasing= T)


