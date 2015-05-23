
## getting all the data by reading the text files from the test data 
getwd()
testData <- read.table("./Documents/UCI HAR Dataset/test/X_test.txt", sep = "", stringsAsFactor = FALSE)
dim(testData)
testLabel <- read.table("./Documents/UCI HAR Dataset/test/y_test.txt", sep = "", stringsAsFactor = FALSE)
dim(testLabel)
testSubject <- read.table("./Documents/UCI HAR Dataset/test/subject_test.txt", sep = "", stringsAsFactor = FALSE)
dim(testSubject)
## getting all the data by reading the training dataset

trainData <- read.table("./Documents/UCI HAR Dataset/train/X_train.txt", sep = "", stringsAsFactor = FALSE)
dim(trainData)
trainLabel <- read.table("./Documents/UCI HAR Dataset/train/y_train.txt", sep ="", stringsAsFactor = FALSE)
dim(trainLabel)
trainSubject <- read.table("./Documents/UCI HAR Dataset/train/subject_train.txt", sep = "", stringsAsFactor = FALSE)
dim(trainSubject)
## Step 2: getting the list of all the features and the links to class labels with their activity name from both the features and
## activity_labels data.
featuresData <- read.table ("./Documents/UCI HAR Dataset/features.txt", sep = "", stringsAsFactor = FALSE)
activityLabel <- read.table ("./Documents/UCI HAR Dataset/activity_labels.txt", sep = "", stringsAsFactor = FALSE)


## 1) Merges the training and test data to create one large dataset.
mergedData = rbind(testData, trainData)
mergedLabel = rbind(testLabel, trainLabel)
mergedSubject = rbind(testSubject, trainSubject)

## 2)Extracts only the measurements on mean and std deviationfor each measurement.
meanstd <- grep( "mean\\(|std", featuresData[,2])


mergedData <- mergedData[, meanstd]
names(mergedData) <- featuresData[meanstd, 2] ## naming the data in mergeddata with features data as columns

## 3) using Descriptive activity names to name the activity in the data set

activityName <- activityLabel[mergedLabel[, 1], 2]
mergedLabel[,1] <- activityName
names(mergedLabel) <- "Activity"

## 4) Appropriately labels the data set with descriptive variable names
names(mergedSubject) <- "Subject"
namedData <- cbind(mergedSubject, mergedLabel, mergedData)
write.table(namedData, "named_Data.txt")

## 5) Creates a second, independent tidy data set with the avg of
## each variable for each activity and each subject

subLen <- length(table(mergedSubject))

activityLen <- dim(activityLabel)[1]
colLen <- dim(namedData)[2]
solution <- as.data.frame(matrix(NA, nrow= subLen*activityLen, ncol = colLen))
colnames(solution) <- colnames(namedData)
row <- 1 
for ( i in 1 : subLen) {
  for(j in 1: activityLen) {
    solution [row, 1] <- sort (unique (mergedSubject) [, 1 ] ) [i]
    solution[ row, 2] <- activityLabel[j , 2]
    solution [row, 3:colLen] <- colMeans(namedData[(i == namedData$Subject) & (activityLabel[j, 2] == namedData$Activity), 3: colLen])
    row <- row + 1
  }
}
write.table(solution, "tidy_data.txt", row.names = FALSE)
