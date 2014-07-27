---
title: "ReadMe"
output: html_document
---

Raymond Nelson
Course project for Coursera course Getting and Cleaning Data July 7 to August 4, 2014
getdata-005

This project repository includes 4 files

* ReadMe.Md - this file which contains information about the project, including the original README.txt from the input data
* run_analysis.R - an R script to import the data and complete the analysis
* tydyDF.csv - a comma-separated-value output of the means.
* CodeBook.md - which contains information about the data in the tydyDF.csv output file

More information.

run_analysis.R will must be run from the directory that contains the input data, and will complete all analaysis. Two data frams will be left in the Global Environment when the script completes, "selectedDF" and "tidyDF". 

Source the run_analysis.R script and it will import the data, complete the analysis and save the output.

Be aware that the script is slow, as in SLOW. It does complete and works as intended. I suspect there are ways to optimize the speed and efficiency but I am new to this, and my first objective was to get it working.

tidyDF is the final output, and is also saved to tidyDF.csv. 

selectedDF is a tidy dataframe of 10299 rows and 89 variables made from the following input files:

* X_train.txt - the training data consisting of 7352 rows of 561 variables
* y_train.txt - the vector of activities for the 7352 training observations
* X_test.txt - the test data consisteing of 2947 rows of 561 variables
* y_test.txt - the vector of activitis for the 2947 test observations
* features.txt - the vector of variable names for the training and test data

Anther input file "activity_labels.txt" contains d matrix of descriptive names of the numerically coded activities.

There are no subjects/participants in both the training and test data.

The run_analysis.R script will import the data and complete the following tasks.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Note that the tasks are not completed in that order due to the need to solve some tasks in order to make a single tidy dataset. There are comments in the run_analysis.R script indicating which parts of the script pertain to which parts.

In addition to selectedDF and tidyDF, a number of other objects are created by the script and then cleaned up when they are not needed, before the script completes.

The run_analysis.R script uses 2 custom functions: yFix() and dataSetType(). 

yFix() is used to replace the numerically coded activity lables with descriptive activity lables for the trainging and test data. I used a function to do this because I had to do the same process with both the training and test data before combining the data.

dataSetType() is used to add a factor variable to the training and test data indicating whether the observation/row came from the training or test set. It was not needed by this project, but seemed like a good idea in case there is ever a need to work separately with the training and test data in a more tidy form than originally provided. Again, I used a function because I did the same process with both training and test data, only changing the content of the factor variable for the two data sets.

Some changes were made to the input variable names to conform to R requirements for variable names, and to improve the clarity and tidyness of the variable names. 

Numeric activity codes were replaced with descriptive activity codes with the yFix() function.

The selectedDF data frame consists of 86 variables, along with the subjectID and activity, in addition to a factor variable indicating trainging and test data. Variables in the selectedDF data frame are all variables that involve mean and standard deviation statistics, indicated by the strings "Mean" and "StDev" in the variable name.

The aggregate() function was used to calculate the tidyDF data frame and tidyDF.csv file output by calculating the mean() function for subjectID + activity for all variables in the selectedDF data frame. aggregate() seems similar to Excel crosstabs, so I will need to spend more time learning to use this important function.

After completing this assignment I realized I could have been done it more easily by using rbind() on the X_train and X_test data earlier, along with rbind() on the y_train and y_test vectors. In completion of this project I started by working with the training and test data separately and then combining them after adding a column to indicate which rows are from the training and test data.

Overall, a fun challenging project that I learned a lot from.

Below is the original README.txt file from the data 

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.






