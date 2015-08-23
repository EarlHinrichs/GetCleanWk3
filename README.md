## Get And Clean - Week 3 Assignment
Programming Assignment for Get and Clean Data class, week 3

Analysis Script: run_analysis.R

Original Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data should be downloaded and unzipped before running the script.
The location of the original data is put into the script variable projectFolder, if you
use a different location, modify the variable for your location. You can use "." for
your working directory. (Personally I like to keep the original data out of my working
directory.)

In my case, the file is unzipped into C:\\Coursera\\GetAndClean\\Project.Wk3\\

First, the original data is read into memory, unmodified. File paths are built up
with the file.path command. The script is designed for Windows OS. If you are
using Linux you will need to change the path separator.


R Object      | Original File
------------- | -------------
features      | features.txt
activities    | activity_labels.txt
subjectTrain  | train\\subject_train.txt
activityTrain | train\\y_train.txt
valuesTrain   | train\\X_train.txt
subjectTest   | test\\subject_test.txt
activityTest  | test\\y_test.txt
valuesTest    | test\\X_test.txt

There are requirements on the original data. For example the number or rows in the various `\*Train`
files must match. The number of rows in the `\*Test` files must match. And the number of columns in
the `values\*` objects (`X_\*.txt` files) must match the number of rows in `features`. These
expectations are checked with the `stopifnot()` function throughout the script.

`rbind()` is used to combine the `\*Train` and `\*Test` objects into full objects `subject`, `activity`,
and `subject`.

The names in the original data look more like formulas than variable names. That works, but I wanted
them to look more like variable names used in R. So I strip the "()" and change "-" to "." in the names.
The function `gsub()` is used, the variable `goodNames` holds the cooked names.

The raw data has numbers for activities. The tidy data needs the activity names. The `merge()` function is
used to merge the `activity` object with the `activities` object, then subsetting extracts just the names.

The assignment asks for mean and std values. This could be taken to mean variables specifically named
mean or std, or variables which are mean or std measurements. I decided to play it safe and take
the latter meaning, and choose the variables names `mean()`, `std()`, and `meanFreq()`. There as some
variable that have mean in the name, but are not means. For example `angle(tBodyAccMean,gravity)` uses
a mean value in a calculation, but is itself not a mean value.

Finally `cbind()` combines `subject`, `activityNames`, and `valuesOfInterest` to build the tidy dataset for
step 4. While not specifically part of the assignment, this dataset is saved to disk. It was beneficial
while debugging and I decided to keep it.

For step 5 I use the `ddply()` function in the plyr library to group by subject and activity and then compute
the mean on the other columns. The resulting dataset is saved to disk in the file `means.txt`


For what its worth: The assignment says that either wide or narrow tidy datasets are acceptable. I went with
wide. I felt that each column was measuring a different kind of thing. mean, std, freqMean are clearly different
things. time and frequency(fft) measurements are different things. accelerometer (linaer distance) and
gyroscope (angular distance) are different. Creating factor columns for these things would result in
measurement columns that have a mixture of measurement unit types. Pulling out the axis was the only
reasonable candidate, but at that point, it was a flip-a-coin decision. Of course, for the assignment,
everything is just numbers. So these considerations are unimportant.


