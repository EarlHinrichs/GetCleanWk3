# Get And Clean - Week 3 Assignment
Programming Assignment for Get and Clean Data class, week 3

Analysis Script: run_analysis.R

Original Data is obtained from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data should be downloaded and unzipped before running the script.
The location of the original data is put into the script variable projectFolder, if you
use a different location, modify the variable for your location. 

In my case, the file is unzipped into C:\Coursera\GetAndClean\Project.Wk3\

First the original data is read into memory, unmodified. 

R Object | Original File
-------- | -------------
features      | features.txt
activities    | activity_labels.txt
subjectTrain  | train\subject_train.txt
activityTrain | train\y_train.txt
valuesTrain   | train\X_train.txt
subjectTest   | test\subject_test.txt
activityTest  | test\y_test.txt
valuesTest    | test\X_test.txt

