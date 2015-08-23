
## Get And Clean - Week 3 Assignment
Programming Assignment for Get and Clean Data class, week 3 


Original Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Analysis Script: run_analysis.R

Files Generated:

File               | Description
----               | ----
tidy.txt           | Tidy dataset from step 4 of assignment
means.txt          | Summary of averages for step 5 
variableNames.txt  | list of all variables

The features_info.txt file in the original data has a description of the variables. A portion
of that file is duplcated here:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw
signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were 
captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 
3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly,
the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ
and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk
signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals 
were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, 
tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, 
fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to 
indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag


The original data contains many calculated values on these measurements. Most are not needed
for the current analysis. Retained values:

* mean: Mean value
* std: Standard deviation
* meanFreq: Weighted average of the frequency components to obtain a mean frequency

The full list of variables used in the current analysis is in the file "variableNames.txt"


The assignment asks for mean and std values. This could be taken to mean variables specifically named
mean or std, or variables which are mean or std measurements. I decided to play it safe and take
the latter meaning, and choose the variables named mean(), std(), and meanFreq(). There are some
variables that have mean in the name, but are not means. For example angle(tBodyAccMean,gravity) uses
a mean value in a calculation, but is itself not a mean value.


For what its worth: The assignment says that either wide or narrow tidy datasets are acceptable. I went with
wide. I felt that each column was measuring a different kind of thing. mean, std, freqMean are clearly different
things. time and frequency(fft) measurements are different things. accelerometer (linaer distance) and
gyroscope (angular distance) are different. Creating factor columns for these things would result in
measurement columns that have a mixture of measurement unit types. Pulling out the axis was the only
reasonable candidate, but at that point, it was a flip-a-coin decision. Of course, for the assignment,
everything is just numbers. So these considerations are probably unimportant.


