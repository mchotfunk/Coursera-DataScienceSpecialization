library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

inTrain <- createDataPartition(y=segmentationOriginal$Case, p=0.75, list=FALSE)
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]

set.seed(125)
modFit <- train(Class ~ .,method="rpart",data=training)
print(modFit$finalModel)
library(rattle)
fancyRpartPlot(modFit$finalModel)
