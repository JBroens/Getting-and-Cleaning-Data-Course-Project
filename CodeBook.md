#Code Book for `avg_data.txt`

##Source
The basis for this data is the UCI HAR Dataset (Samsung data) downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
This data consists of various records representing measurements with the accelerometers and gyroscope from the Samsung Galaxy S smartphone. For each record in the dataset the following information is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

More information regarding the data is provided in the file `README.txt` associated to this data set. Three other important accompanying files are as follows:
- `features_info.txt`: shows information about the variables used on the feature vector.
- `features.txt`: list of all features.
- `activity_labels.txt`: links the class labels with their activity name.

Another important feature of this data is that it is split into a data set intended for training and another data set intended for testing.

##Manipulations
The manipulations on this data are performed with the `run_analysis.R` script. The workings of this script are further described in `README.MD`. The script basically merges all the test and train data. Subsequently it calculates the average per activity and subject for the variables associated to the mean and standard deviation for each measurement. The end result is an independent tidy data set with the average of each variable for each activity and each subject.

##Variables
The first two variables are as follows:

1. `activityname`: a description of the activity for which the measurements have taken place. This variable can take one of the following values:
    + WALKING
    + WALKING_UPSTAIRS
    + WALKING_DOWNSTAIRS
    + SITTING
    + STANDING
    + LAYING

2. `subjectid`: this variable identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The remainder of the variables are the averages of the mean value (`mean()`) and the standard deviation (`std()`) corresponding to the followig signals ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.):

 | | |
--- | --- | ---
tBodyAcc-XYZ |tGravityAccMag |fBodyGyro-XYZ |
tGravityAcc-XYZ |tBodyAccJerkMag |fBodyAccMag |
tBodyAccJerk-XYZ |tBodyGyroMag |fBodyAccJerkMag |
tBodyGyro-XYZ |tBodyGyroJerkMag |fBodyGyroMag |
tBodyGyroJerk-XYZ |fBodyAcc-XYZ |fBodyGyroJerkMag |
tBodyAccMag |fBodyAccJerk-XYZ |  |

The average is taken over all measurements corresponding to one specific combination of activity and subject. The units for the various variables are as follows:
- Variables related to acceleration (the name contains 'Acc', but not 'AccJerk') are expressed in standard gravity units 'g'. 
- Variables related to Jerk signals of acceleration (the name contains 'AccJerk') are expressed in standard gravity units 'g' over seconds.
- Variables related to angular velocity (the name contains 'Gyro', but not 'GyroJerk') are expressed in radians/second.
- Variables related to Jerk signals of angular velocity (the name contains 'GyroJerk') are expressed in radians/second^2.

The full list of the remaining variables is:

3.`tBodyAcc-mean()-X`  
4.`tBodyAcc-mean()-Y`  
5.`tBodyAcc-mean()-Z`  
6.`tBodyAcc-std()-X`  
7.`tBodyAcc-std()-Y`  
8.`tBodyAcc-std()-Z`  
9.`tGravityAcc-mean()-X`  
10.`tGravityAcc-mean()-Y`  
11.`tGravityAcc-mean()-Z`  
12.`tGravityAcc-std()-X`  
13.`tGravityAcc-std()-Y`  
14.`tGravityAcc-std()-Z`  
15.`tBodyAccJerk-mean()-X`  
16.`tBodyAccJerk-mean()-Y`  
17.`tBodyAccJerk-mean()-Z`  
18.`tBodyAccJerk-std()-X`  
19.`tBodyAccJerk-std()-Y`  
20.`tBodyAccJerk-std()-Z`  
21.`tBodyGyro-mean()-X`  
22.`tBodyGyro-mean()-Y`  
23.`tBodyGyro-mean()-Z`  
24.`tBodyGyro-std()-X`  
25.`tBodyGyro-std()-Y`  
26.`tBodyGyro-std()-Z`  
27.`tBodyGyroJerk-mean()-X`  
28.`tBodyGyroJerk-mean()-Y`  
29.`tBodyGyroJerk-mean()-Z`  
30.`tBodyGyroJerk-std()-X`  
31.`tBodyGyroJerk-std()-Y`  
32.`tBodyGyroJerk-std()-Z`  
33.`tBodyAccMag-mean()`  
34.`tBodyAccMag-std()`  
35.`tGravityAccMag-mean()`  
36.`tGravityAccMag-std()`  
37.`tBodyAccJerkMag-mean()`  
38.`tBodyAccJerkMag-std()`  
39.`tBodyGyroMag-mean()`  
40.`tBodyGyroMag-std()`  
41.`tBodyGyroJerkMag-mean()`  
42.`tBodyGyroJerkMag-std()`  
43.`fBodyAcc-mean()-X`  
44.`fBodyAcc-mean()-Y`  
45.`fBodyAcc-mean()-Z`  
46.`fBodyAcc-std()-X`  
47.`fBodyAcc-std()-Y`  
48.`fBodyAcc-std()-Z`  
49.`fBodyAccJerk-mean()-X`  
50.`fBodyAccJerk-mean()-Y`  
51.`fBodyAccJerk-mean()-Z`  
52.`fBodyAccJerk-std()-X`  
53.`fBodyAccJerk-std()-Y`  
54.`fBodyAccJerk-std()-Z`  
55.`fBodyGyro-mean()-X`  
56.`fBodyGyro-mean()-Y`  
57.`fBodyGyro-mean()-Z`  
58.`fBodyGyro-std()-X`  
59.`fBodyGyro-std()-Y`  
60.`fBodyGyro-std()-Z`  
61.`fBodyAccMag-mean()`  
62.`fBodyAccMag-std()`  
63.`fBodyBodyAccJerkMag-mean()`  
64.`fBodyBodyAccJerkMag-std()`  
65.`fBodyBodyGyroMag-mean()`  
66.`fBodyBodyGyroMag-std()`  
67.`fBodyBodyGyroJerkMag-mean()`  
68.`fBodyBodyGyroJerkMag-std()`  


