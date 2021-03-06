
    #Location of original data.
projectFolder <- "C:\\Coursera\\GetAndClean\\Project.Wk3"
rawFiles      <- file.path(projectFolder,"UCI HAR Dataset",fsep="\\")
    cat("Raw data files at:", rawFiles, "\n")

features.txt  <- file.path(rawFiles,"features.txt",fsep="\\")
features      <- read.table(features.txt)
    cat("dim(features):", dim(features), "\n")

activities.txt<- file.path(rawFiles,"activity_labels.txt",fsep="\\")
activities    <- read.table(activities.txt)
    cat("dim(activities):", dim(activities), "\n")
    
    #The various *train files should have the same number of rows.
    #The number of columns in the values* object should match the columns in features
subjectTrain.txt <- file.path(rawFiles,"train","subject_train.txt",fsep="\\")
subjectTrain     <- read.table(subjectTrain.txt)
    cat("dim(subjectTrain):", dim(subjectTrain), "\n")

activityTrain.txt <- file.path(rawFiles,"train","y_train.txt",fsep="\\")
activityTrain     <- read.table(activityTrain.txt)
    cat("dim(activityTrain):", dim(activityTrain), "\n")
    stopifnot( nrow(subjectTrain) == nrow(activityTrain) )

valuesTrain.txt <- file.path(rawFiles,"train","X_train.txt",fsep="\\")
valuesTrain     <- read.table(valuesTrain.txt)
    cat("dim(valuesTrain):", dim(valuesTrain), "\n")
    stopifnot( nrow(valuesTrain) == nrow(activityTrain) )
    stopifnot( ncol(valuesTrain) == nrow(features) )
    
    #The various *text files should have the same number of rows.
subjectTest.txt <- file.path(rawFiles,"test","subject_test.txt",fsep="\\")
subjectTest     <- read.table(subjectTest.txt)
    cat("dim(subjectTest):", dim(subjectTest), "\n")
    
activityTest.txt <- file.path(rawFiles,"test","y_test.txt",fsep="\\")
activityTest     <- read.table(activityTest.txt)
    cat("dim(activityTest):", dim(activityTest), "\n")
    stopifnot( nrow(subjectTest) == nrow(activityTest) )
    
valuesTest.txt <- file.path(rawFiles,"test","X_test.txt",fsep="\\")
valuesTest     <- read.table(valuesTest.txt)
    cat("dim(activityTest):", dim(activityTest), "\n")
    stopifnot( nrow(valuesTest) == nrow(activityTest) )
    stopifnot( ncol(valuesTest) == nrow(features) )


    #Use rbind to combine test and train data sets
values=rbind(valuesTest,valuesTrain)
subject=rbind(subjectTest,subjectTrain)
activity=rbind(activityTest,activityTrain)

    #This is as good of time as any to clean up column names
goodNames <- features[,2]
goodNames <- gsub("\\(\\)","", goodNames)   #Remove ()
goodNames <- gsub("-",".", goodNames)       #Change - to .
names(values) <- goodNames
    cat( "Varible name samples:", head(goodNames,4), "\n")
names(subject)="subject"

    #activity has activity numbers, names would be better.
    #activities is a lookup table to translate between ids and names
    #merge the two table on id, then drop everything but the name column
activityName<-merge(activity,activities,by.x=1,by.y=1)[,2]
    stopifnot( nrow(activityName) == nrow(activity) )
names(activityName) = "activity"
    
    #We need only the mean and std values. These are identified by
    #one of "mean()", "std()", meanFreq()" in the (original) variable name.
    #subset the interesting columns
valuesOfInterest<-values[,grepl("mean\\(\\)|std\\(\\)|meanFreq\\(\\)",features[,2])]
    cat("dim(valuesOfInterest):", dim(valuesOfInterest), "\n")

    #Nice names, number of rows match. Time for a cbind.
    #The resulting table is written to the working directory
    #Read back with read.table("tidy.txt",header=TRUE)
tidy<-cbind(subject,activityName,valuesOfInterest)
    cat("dim(tidy):", dim(tidy), "\n")
tidy1.txt <- "tidy.txt"
write.table(tidy, tidy.txt, row.name=FALSE)

    #Now find the average for each variable for subject+activity
    #Use ddply in plyr for this operation
    #write the results to the file means.txt in the working directory
    #Read back with read.table("means.txt",header=TRUE)
library(plyr)
means<-ddply(tidy, .(subject,activityName), numcolwise(mean))
means.txt <- "means.txt"
write.table(means, means.txt, row.name=FALSE)
    cat( "Averages written to ", means.txt, "\n")
    cat("dim(means):", dim(means), "\n")
    
    #Write out variable names for documentation
write.table(names(valuesOfInterest), "variableNames.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)
    cat( "Variable names written to variableNames.txt\n")


