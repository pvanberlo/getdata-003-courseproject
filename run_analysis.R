library(reshape2)

## Step 1. Merge Training and Test data
trainData <- read.table("train/X_train.txt")
testData <- read.table("test/X_test.txt")
mergedData <- rbind(trainData, testData)

## Step 2. Extract the measurements on the mean and standard deviation
## for each measurement
features <- read.table("features.txt", col.names=c("FeatureID", "FeatureName"))
names(mergedData) <- features$FeatureName
mergedData <- mergedData[,grep("mean\\(\\)|std\\(\\)", colnames(mergedData))]

## Step 3 & 4. Label data with descritive activity names
trainActivities <- read.table("train/y_train.txt", col.names=c("ActivityID"))
testActivities <- read.table("test/y_test.txt", col.names=c("ActivityID"))
activityLabels <- read.table("activity_labels.txt", col.names=c("ActivityID", "ActivityName"))
mergedData <- cbind(merge(rbind(trainActivities, testActivities), activityLabels), mergedData)

## Step 5. Create tidy data set (tidy_data.txt)
## This part uses the reshape2 library to shape the tidy data set using
## melt() and dcast(). The output of the dcast() call below is a data frame
## containing the SubjectID, ActivityName and the mean for each variable for 
## this specific combination of SubjectID and ActivityName.
trainSubjects <- read.table("train/subject_train.txt", col.names=c("SubjectID"))
testSubjects <- read.table("test/subject_test.txt", col.names=c("SubjectID"))
mergedData <- cbind(rbind(trainSubjects, testSubjects), mergedData)
meltedData <- melt(mergedData, id=c("SubjectID", "ActivityName", "ActivityID"))
tidyData <- dcast(meltedData, SubjectID + ActivityName ~ variable, mean)    
write.table(tidyData, "tidy_data.txt")




