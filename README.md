getdata-003-courseproject
=========================

Coursera Getting and Cleaning Data Course Project

This project contains a single R script called run_analysis.R. This script
generates a tidy dataset from the UCI HAR dataset available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This dataset contains data collected from accelerometers from the Samsung Galaxy S
smartphone.

The script does not set the working directory, please make sure that this is
set using setwd() to the directory containing the UCI HAR dataset!

The following steps are executed to create the tidy dataset:

* Training (X_train.txt) and Test (X_test.txt) data is merged using rbind()
* Variable names are read from features.txt, the columns from the merged data
are properly named based on these variable names, excluding all variable names
but the ones containing "mean()" or "std()" in the variable name
* Activity IDs (y_train.txt & y_test.txt) are read and merged, Activity Names
(activity_labels.txt) are read and cbind(), merge()
and rbind() are used to column bind the output of the merge of Activity IDs and
ActivityNames for both the training and test data to the merged data set from
step 1
* Subject IDs (subject_train.txt and subject_test.txt) are read, merged and
column binded to the merged data from step 1
* The reshape2 library's melt() function is used to generate a new melted data
frame with id.vars set to SubjectID, ActivityName and ActivityID, all other
columns are measure.vars
* The dcast() function is used to generate the final tidy data set, which contains
the mean of all 'measure.vars' for a specific combination of SubjectID and
ActivityName
