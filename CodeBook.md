# Code book

## Working with data
Description of the run_analysis.R process

1. Loads Data
* Downloads required data from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Merges the test and training datasets in one file for three groups of files using 
	*`Subject_train.txt`, and `Subject_test.txt` contain Subject ID's 
	*`X_train.txt`, and `X_test.txt` contain Measured variables
	*`y_train.txt`, and `y_test` contain  Activity labels
* Loads feature data set `features.txt` used to label columns
*'data' merges all three datasets
 *`X` contains a subset of 'data' for measurements for means and standard deviation
* Loading activity labels `activity_labels.txt`
* Changes the data activity row to use the activity labels
*Creates a tidy data set called 'tidy' with the average of each variable for each activity and each subject

