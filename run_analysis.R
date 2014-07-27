# Raymond Nelson - Coursera Getting and Cleaning Data July 7 to August 4

# WARNING # this script runs SLOW (as in SSSLLLOOOWWW), but it does run and complete
# so please wait. 
# Thanks. rn

########### ASSIGNMENT ############

# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

######## I did these parts in a different sequence due to the way I addressed the problems

####################################

######## 1) Merges the training and the test sets to create one data set.
# also 3) Uses descriptive activity names to name the activities in the data set
# and 4) Appropriately labels the data set with descriptive variable names.



#### first select the directory with the data
# setwd("UCI HAR Dataset")


#### make some needed functions

# make a function to change the numeric activity vector to descrive activity names
######## this is part 3 of the assignment #########
yFix <- function(x, y) {
        # to change numeric activity names to descriptive words
        # x is the name of a dataFrame of 1 column that holds numeric values for each activity
        # y is the name of a dataFrame of 2 columns that holds the descriptive activity names
        for (i in 1:nrow(x)) {
                x[i,1] <- as.character(y[x[i,1],2])
        }
        return(x)
} 

# make a function to add a column for the type of data - training or test
########## this is for part 1 of the assignment ######## 
dataSetType <- function (x, y) {
        # add a column for training or test data
        # x is a dataframe or matrix
        # y is a scalar, either "TRAINING" or "TEST"
        setType <- c(rep(y, times = nrow(x)))
        x <- cbind(x, setType)
        return(x)
}


#### import the activities and feature variable list
######## this is for part 4 of the assignment ########

# import the vector of activities
activity_labels <- read.table("activity_labels.txt", quote="\"")

# import the vector of features (i.e., variable names)
features <- read.table("features.txt", quote="\"")

# fix the untidy issues with the variable names ########## this is part 4 of the assignment #########
features[,2] <- gsub("()", "", features[,2], fixed = TRUE)
features[,2] <- gsub(",", ".", features[,2], fixed = TRUE)
features[,2] <- gsub("(", "", features[,2], fixed = TRUE)
features[,2] <- gsub(")", "", features[,2], fixed = TRUE)
features[,2] <- gsub("BodyBody", "Body", features[,2], fixed = TRUE) # not sure why BodyBody was used
# features[,2] <- gsub("Mean", "-mean", features[,2], fixed = TRUE) # decided against this
features[,2] <- gsub("tBody", "timeBody", features[,2], fixed = TRUE)
features[,2] <- gsub("tGravity", "timeGravity", features[,2], fixed = TRUE)
features[,2] <- gsub("fBody", "freqBody", features[,2], fixed = TRUE)
features[,2] <- gsub("fGravity", "freqGravity", features[,2], fixed = TRUE)
features[,2] <- gsub("Acc", "Acceleration", features[,2], fixed = TRUE)
features[,2] <- gsub("Gyro", "Gyroscope", features[,2], fixed = TRUE)
features[,2] <- gsub("mean", "Mean", features[,2], fixed = TRUE)
features[,2] <- gsub("std", "StDev", features[,2], fixed = TRUE) # seems clearer to me a less like an STD
features[,2] <- gsub("-", "", features[,2], fixed = TRUE)
features[,2] <- gsub(".", "", features[,2], fixed = TRUE)
features[,2] <- gsub("iqr", "Iqr", features[,2], fixed = TRUE)
features[,2] <- gsub("energy", "Energy", features[,2], fixed = TRUE)
features[,2] <- gsub("entropy", "Entropy", features[,2], fixed = TRUE)
features[,2] <- gsub("min", "Min", features[,2], fixed = TRUE)
features[,2] <- gsub("max", "Max", features[,2], fixed = TRUE)
features[,2] <- gsub("mad", "Mad", features[,2], fixed = TRUE)
features[,2] <- gsub("correlation", "Correlation", features[,2], fixed = TRUE)
features[,2] <- gsub("sma", "Sma", features[,2], fixed = TRUE)
features[,2] <- gsub("maxInds", "MaxIndex", features[,2], fixed = TRUE)
features[,2] <- gsub("meanFreq", "MeanFreq", features[,2], fixed = TRUE) # I think this was already fixed
# features[,2] <- gsub("angle", "Angle", features[,2], fixed = TRUE) # not needed
# features[,2] <- tolower(features[,2]) # seems clearer without this
############# seems a bit difficult to make very adequate variable names


#### import the training data
########## this is for part 1 of the assignment ########

# import the vector of activities for each observation in the training dataset
y_train <- read.table("train/y_train.txt", quote="\"")

# use the function to change the numeric activity values to descriptive activity names us
y_train[,1] <- yFix(y_train, activity_labels)

# set the column name for the activity column of the training set
colnames(y_train) <- c("activity")
# y_trainF <- as.factor(y_train[,1])

# import the training data
X_train <- read.table("train/X_train.txt", quote="\"")

# set set variable names for the training dataset
colnames(X_train) <- features[,2] ######## includes part 4 ######## 

# import the subject IDs for the training dataset
subject_train <- read.table("train/subject_train.txt", quote="\"")

# set the column name for the training subject IDs
colnames(subject_train) <- c("subjectID")

# bind the subject, activity, and data tables together
X_train <- cbind(subject_train, y_train, X_train) ######## includes part 3 #########

# change the activity labels variable of the training data to a factor
X_train$activity <- as.factor(X_train$activity)


#### import the test data
######### this is still for part 1 ########

# import the vector of activities for each observation in the training dataset
y_test <- read.table("test/y_test.txt", quote="\"")

# use the function to change the numeric activity values to descriptive activity names us
y_test[,1] <- yFix(y_test, activity_labels)

# set the column name for the activity column of the test set
colnames(y_test) <- c("activity")

# import the test data
X_test <- read.table("test/X_test.txt", quote="\"")

# set set variable names for the test dataset
colnames(X_test) <- features[,2] ######## includes part 4 complete #########

# import the subject IDs for the test dataset
subject_test <- read.table("test/subject_test.txt", quote="\"")

# set the column name for the test subject IDs
colnames(subject_test) <- c("subjectID")

# bind the subject, activity, and data tables together
X_test <- cbind(subject_test, y_test, X_test) ######### includes part 3 complete ########

# change the activity labels variable of the test data to a factor
X_test$activity <- as.factor(X_test$activity)


#### add a factor variable column to indicate training data or test data

# add the factor to the training set
X_train <- dataSetType(X_train, c("TRAIN"))
colnames(X_train)[564] <- "set"
X_train$set <- as.factor(X_train$set)

# add the factor to the test set
X_test <- dataSetType(X_test, c("TEST"))
colnames(X_test)[564] <- "set"
X_test$set <- as.factor(X_test$set)


#### now bind the training set and test set into a single tidy dataset

trainAndTest <- rbind(X_train, X_test) ######## part 1 is complete #########


#### clean up a little bit
rm(yFix)
rm(dataSetType)
rm(X_test)
rm(X_train)
rm(y_test)
rm(y_train)
rm(subject_train)
rm(subject_test)
rm(features)
rm(activity_labels)


######## 2) Extracts only the measurements on the mean and standard deviation for each measurement.

#### includes any variable with "Mean" or "StDev" in the variable name

# first make a new vector of features to include the added columns
features <- as.data.frame(colnames(trainAndTest))

# make a vector of variables involving mean values
meanVars <- grep("Mean", features[,1])

# make a vector of variables involving standard deviation values
stDevVars <- grep("StDev", features[,1])

# combine and sort the selected variables
meanAndStDev <- sort(c(meanVars, stDevVars))

# include subject, activity and set variables
meanAndStDev <- c(1, 2, meanAndStDev, 564)

# now make a new data frame of mean and standard deviation variables,
selectedDF <- trainAndTest[,meanAndStDev]

######### part 2 is complete ##########


######### 5. Creates a second, independent tidy data set 
#            with the average of each variable for each activity and each subject.

#### I think this is a bit like using crosstabs in Excel

# compute the mean summary for subjectID and activity
tidyDF <- aggregate(. ~ subjectID + activity, data = selectedDF, FUN = mean)

# write the tidy data to a file
write.csv(tidyDF, file = "tidyDF.csv", row.names = FALSE)

######## part 5 is complete ########


#### clean up
rm(meanVars)
rm(stDevVars)
rm(trainAndTest)
rm(meanAndStDev)
rm(features)


