# Getting And Cleaning Data - Course Project

## Introduction
This Github repository contains my submission for the final assigment to the course Coursera "Getting And Cleaning Data". This GitHub repository contains the following files and folders (besides `README.md`):
- `avg_data.txt`: this is the tidy data set to be submitted for this assigment. This data set contains the average of each variable for each activity and each subject, which is based on the measurements contained in the Samsung dataset (the UCI HAR Dataset downloaded from [link] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)).
- `run_analysis.R`: the script that transforms the Samsung data into the tidy data set `avg_data.txt`.
- `CodeBook.MD`: a codebook describing the variables in the tidy data set `avg_data.txt`, including any transformations or work performed to clean up the data

The remainder of this readme describes how the various components of the `run_analysis.R` script work. 

## 1. Settings
In this part of the scropt the working directory is set to the directory that contains the script, the folder with all the Samsung data. The output data is also exported to this directory. Furthermore the name is provided of the folder with all the Samsung data, in our case the folder `./UCI HAR Dataset`.

##2. Read in activity and feature names. 
The activity and feature names are read in from the files `activity_labels.txt` and `features.txt` in the Samsung data set. To improve readibility of the code, the variables from `activity_labels.txt` are relabeled to `activityid` (first column) and `activityname` (second column). The variables from `features.txt` are relabeled to `featureid` (first column) and `featurename` (second column). Using the grep function the features are selected that are only related to the mean and standard deviation of the measurements. 

##3. Merge train and test data
This part of the script merge the train and test data. For both the train and test data (the variable test or train denoted as `i`) the activity labels (`y_i.txt`), the measurements (`X_i.txt`) and the subject ids (`subject_i.txt`) are read in. Subsequently only the measurements related to the mean and standard deviation are selected using the selected features from part 2. The resulting variables are all combined into one dataset, with the subject id as first variable (named `subjectid`), the activity id as second variable (named `activityid`) and the subsequent variables are the features that are only related to the mean and standard deviation of the measurements (inheriting the associated variables names). As a last step the resulting data frames for the train and test data are combined into one data set.

##4. Rename activities
As the variable `activityid` is not as descriptive, the associated activity names are added as variable (named `activityname`) by merging the dataset resulting from step 3, with the data coming from `activity_labels.txt`. Subsequently the variable `activityid` is dropped from the data as this variable is not necessary anymore.

##5. Create data set with the average of each variable for each activity and each subject.
Using the data set resulting from step 4, the mean of all the selected features is determined per activity (`activityname`) and subject (`subjectid`). This is done through the aggregate function in R. Before exporting the resulting tidy data set, the data is ordered alphabetically with variable `activityname` as first variable and `subjectid` as second variable.

