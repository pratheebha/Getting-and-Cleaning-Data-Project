---
title: "Code Book.md"
author: "Pratheebha"
date: "May 23, 2015"
output: pdf_document
---

Actions Performed:
------------------
  created one R script called run_analysis that does the following tasks:
  - getting all the data by reading the text file from the test data set.
  - getting all the data by reading the text file from the training data set.
  - Merges the training and test sets to create one data set.
  - Extracts measurements on the mean and standdard deviation for each measurement.
  - used descriptive activity names to name activity in the data set.
  - Appropriately labelled the data with descrptive variable names.
  - Finally created a independent tidy data set average of each variable for each activity and each    subject.

testData : reads the table X_test.txt from the test data set

testLabel :  reads the table y_test.txt to get appropriate labels from test data set

testSubject :  reads the table subject_test.txt from the test data set

## getting all the data by reading the training dataset

trainData : reads the table X_train.txt from the training data set.

trainLabel:  reads the table y_train.txt for appropriate lables for the training data se
trainSubject:  reads the table subject_train.txt where each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Step 2: getting the list of all the features and the links to class labels with their activity name from both the features and
## activity_labels data.
featuresData : reads the table features.txt which lists  all of the features.
activityLabel : reads the table activity_labels.txt  that links the class labels with their activity name.


## 1) Merges the training and test data to create one large dataset.
mergedData = rbind(testData, trainData) ## row binds the testData with the trainData to create one dataset
## row binds the testLabel and the trainLabel into a single mergedlabel data set
mergedLabel = rbind(testLabel, trainLabel)
## row binds the testSubjcet and the trainSubject who performed the activity.
mergedSubject = rbind(testSubject, trainSubject)

## 2)Extracts only the measurements on mean and std deviationfor each measurement.

varaible : meanstd serches the data to find the mean and stddeviation on the features data.

names(mergedData) <- featuresData[meanstd, 2] ## naming the data in mergeddata with features data as columns

## 3) using Descriptive activity names to name the activity in the data set

activityName : descriptive activity name

names(mergedLabel) :associate names to names in "Activity"

## 4) Appropriately labels the data set with descriptive variable names

namedData : new data set containing columns of mergedSubject, mergedLabel, mergedData
write.table(namedData, "named_Data.txt") ## writing it out to a file named Data containg mergedData.

## 5) Creates a second, independent tidy data set with the avg of
## each variable for each activity and each subject

subLen : gets the length from table mergedSubject

activityLen: gets the  dim / length of activityLabel for the subject 

solution : holds the result  as.data.frame where 
colnames(solution) are linked to the colnames(namedData)
row: initialized to 1 
after the execution of the for loop iteration row is incremented by 1.
    row <- row + 1
  }
}
finally the solution is written to a tidy_data.txt file which inturn stores the tidy data.
write.table(solution, "tidy_data.txt", row.names = FALSE)


Key columns 
------------
 Variable name     |     Description
 subject              ID of subject int(1-30)
 activityLabel           Label of activity Factor with 6 levels  
 
 
 tidy_data variable
 ------------------
  variable name         Description 
 solution               contains the avg of each varaible for each activity and each subject.
 tidy_data.txt          independent tidy_data set  
 
 
