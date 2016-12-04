# Getting And Cleaning Data - Course Project

## Introduction
This Github repository contains my submission for the final assigment to the course Coursera "Getting And Cleaning Data". This GitHub repository contains the following files and folders (besides `README.md`):
- `avg_data.txt`: this is the tidy data set to be submitted for this assigment. This data set contains the average of each variable for each activity and each subject, which is based on the measurements contained in the Samsung dataset (the UCI HAR Dataset downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)).
- `run_analysis.R`: the script that transforms the Samsung data into the tidy data set `avg_data.txt`.
- `CodeBook.MD`: a codebook describing the variables in the tidy data set `avg_data.txt`, including any transformations or work performed to clean up the data

The remainder of this readme describes how the various components of the `run_analysis.R` script work. 

## 1. Settings
In this part of the script the working directory is set to the directory that contains the script and to which the output data (`avg_data.txt`) is exported. 
```{r eval=F}
setwd(file.path('~', 'datasciencecoursera', 'Getting and Cleaning Data Course Project'))
```
Furthermore the name is provided  of the folder with all the Samsung to the variable `datadir`, in our case the subfolder `./UCI HAR Dataset`.
```{r eval=F}
datadir<-'UCI HAR Dataset'
```

##2. Read in activity and feature names. 
The activity and feature names are read in from the files `activity_labels.txt` and `features.txt` in the Samsung data set. 
```{r eval=F}
activity_names<- read.table(file.path(datadir, 'activity_labels.txt'),stringsAsFactors = F)
features_names<- read.table(file.path(datadir, 'features.txt'), stringsAsFactors = F)
```
To improve readibility of the code, the variables from `activity_labels.txt` are relabeled to `activityid` (first column) and `activityname` (second column). The variables from `features.txt` are relabeled to `featureid` (first column) and `featurename` (second column). 
```{r eval=F}
names(activity_names)<- c("activityid", "activityname")
names(features_names)<- c("featureid", "featurename")
```
Using the `grep` function the features are selected that are only related to the mean and standard deviation of the measurements. These features are stored in the data frame `features_selected`.
```{r eval=F}
features_selected <- features_names[grep('mean[(][)]|std[(][)]',features_names$featurename),]
```

##3. Merge train and test data
This part of the script merges the train and test data. For both the train and test data the activity labels (`y_i.txt`), the measurements (`X_i.txt`) and the subject ids (`subject_i.txt`) are read in, where `i` is either equal to `train` or `test`. 
```{r eval=F}
X<-read.table(file.path(datadir,i, paste0('X_', i, '.txt')))
activity<-read.table(file.path(datadir, i, paste0('y_', i, '.txt')))
subject<-read.table(file.path(datadir, i, paste0('subject_', i, '.txt')))
```
Subsequently only the measurements related to the mean and standard deviation are selected using the selected features from part 2 (stored in the dataframe `features_selected`).
```{r eval=F}
X <- X[, features_selected$featureid]
```
The resulting variables are all combined into one dataset (`data[[i]]`), with the subject id as first variable (named `subjectid`), the activity id as second variable (named `activityid`) and the subsequent variables are the features that are only related to the mean and standard deviation of the measurements (inheriting the associated variables names). 
```{r eval=F}
data[[i]]<- cbind(subject,activity, X)
names(data[[i]])<-c("subjectid", "activityid", features_selected$featurename)
```
As a last step the resulting data frames for the train and test data are combined into one data frame (`total_data`).
```{r eval=F}
total_data<- rbind(data[["train"]], data[["test"]])
```

##4. Rename activities
As the variable `activityid` is not as descriptive, the associated activity names are added as variable (named `activityname`) by merging the dataset resulting from step 3 (`total_data`),  with the data coming from `activity_labels.txt`. 
```{r eval=F}
total_data<- merge(total_data, activity_names, all.x=T, all.y=F)
```
Subsequently the variable `activityid` is dropped from the data as this variable is not necessary anymore.
```{r eval=F}
total_data<-total_data[, c("subjectid", "activityname", features_selected$featurename)]
```

##5. Create data set with the average of each variable for each activity and each subject.
Using the data set resulting from step 4 (`total_data`), the mean of all the selected features is determined per activity (`activityname`) and subject (`subjectid`). This is done through the `aggregate` function in R. 
```{r eval=F}
avg_data<- aggregate(total_data[,features_selected$featurename], 
                     by= list(total_data$activityname, total_data$subjectid), mean)
names(avg_data)<-c("activityname", "subjectid", features_selected$featurename)
```
Before exporting the resulting tidy data set (stored in the data frame`avg_data`), the data is ordered alphabetically with variable `activityname` as first variable and `subjectid` as second variable.
```{r eval=F}
avg_data<- avg_data[order(avg_data$activityname, avg_data$subjectid),]
write.table(avg_data, "avg_data.txt", row.names=F)
```
