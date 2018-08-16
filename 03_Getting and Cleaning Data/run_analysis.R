#Reading all the data
library(reshape2)

#Activity and features
activity_labels <- fread('/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/activity_labels.txt', col.names=c("class_labels","activity_name"))
features <- fread('/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/features.txt',col.names= c("class_labels","feature_name"))

#Select means and std only ********
featuresWanted <- grep("(mean|std)\\(\\)", features[, feature_name]) #indicate the location

#subsetting 

measurements <- features[featuresWanted, feature_name]


#test and train
x_test <- fread("/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/X_test.txt")[,featuresWanted,with=FALSE]
x_train <- fread("/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/X_train.txt")[,featuresWanted,with=FALSE]

setnames(x_train, colnames(x_train), measurements)
setnames(x_test, colnames(x_test), measurements)

test_activities <- fread("/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/y_test.txt", col.names = "Activities")
train_activities <- fread("/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/y_train.txt", col.names = "Activities")

train_subject <- fread("/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/subject_train.txt", col.names= "Num")
test_subject <- fread("/users/andrewhu/desktop/Coursera/Cleaning and Getting data/data/subject_test.txt", col.names= "Num")

#Combine

train_all <- cbind(x_train, train_activities, train_subject)
test_all <- cbind(x_test, test_activities, test_subject)

all <- rbind(train_all, test_all)


#Melting: create mean for each activity for each subject
all<- melt(all, id= c("Num", "Activities"))
all<- dcast(all, Num+Activities~ variable, mean)

fwrite(x = all, file = "tidyData_PeerReview.txt", quote = FALSE)
