setwd("./UCI HAR Dataset")

##Read activity labels and feature files
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt") ##features name dim=[561,2]

##Read "test" files
subject_test <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/X_test.txt") ##test measures dim=[2947,561]
y_test <- read.table("./test/y_test.txt") ##activity list dim=[2947,1]

##Name columns in "test"
colnames(x_test) <- features[,2] ##Assign features names to x_test column

##Create a new variable called "Activity", these data come from y_test
x_test_f <- cbind(y_test,x_test)  ##Merge y_test with x_test
colnames(x_test_f)[1]<-"Activity"  ##Call the activity column

##Create a new variable called "Subject" that comes from "subject_test.txt"
x_test_f <- cbind(subject_test,x_test_f)
colnames(x_test_f)[1] <- "Subject"

##Create a new variable Calles "Measure.Type" containing 2 possible values: "Test" and "Train"
Measure.Type <- as.factor(rep("Test",dim(x_test_f)[1]))
x_test_f <- cbind(Measure.Type,x_test_f)
##=====================================O=======================================

## Read "train" files
subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt") ##train measures dim=[7352,561]
y_train <- read.table("./train/y_train.txt") ##activity list dim=[7352,1]

##Name columns in "train"
colnames(x_train) <- features[,2] ##Assign features names to x_test column

##Create a new variable called "Activity", these data come from y_train
x_train_f <- cbind(y_train,x_train)  ##Merge y_test with x_test
colnames(x_train_f)[1]<-"Activity"  ##Call the activity column

##Create a new variable called "Subject" that comes from "subject_train.txt"
x_train_f <- cbind(subject_train,x_train_f)
colnames(x_train_f)[1] <- "Subject"

##Create a new variable Calles "Measure.Type" containing 2 possible values: "Test" and "Train"
Measure.Type <- as.factor(rep("Train",dim(x_train_f)[1]))
x_train_f <- cbind(Measure.Type,x_train_f)

##==========================================O=============================

##Merge x_test_f and x_train_f
dataSet <- rbind(x_test_f,x_train_f) ## 1. Merges the training and the test sets to create one data set.

##==============================
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

colNames <- colnames(dataSet)
mean <- grep("mean",colNames)
Mean <- grep("Mean",colNames)
std <- grep("std",colNames)
selectedColumns <- sort(c(1:4,mean,Mean,std))
newDataSet <- dataSet[,selectedColumns]
##===================================

## 3.Uses descriptive activity names to name the activities in the data set

## Merge activity labels with our dataSet using the activity number as key
dataSet_mod <- merge(activity_labels,newDataSet,by.x="V1",by.y="Activity",all=T)
colnames(dataSet_mod)[1:2] <-c("Activity.number","Activity") 
dataSet_mod$Subject <- factor(dataSet$Subject) ##Converts Subject as Factor

##===================================

## 4.Appropriately labels the data set with descriptive variable names. 
## it has already been done on the step 1

##==================================

## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject.

## install.packages("reshape2") need to be installed

tidy_data <-aggregate(dataSet_mod, by=list(dataSet_mod$Activity,dataSet_mod$Subject),FUN=mean, na.rm=TRUE)
write.table(tidy_data,"../tidy_data.txt",row.names=F)


