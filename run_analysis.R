#1. Settings. 
##The working directory is set to the directory that contains the script, the folder with all the Samsung data. 
##The output data is also exported to this directory.
setwd(file.path('~', 'datasciencecoursera', 'Getting and Cleaning Data Course Project'))

##Provide name of the folder with all the Samsung data, in our case the folder 'UCI HAR Dataset'
datadir<-'UCI HAR Dataset'

#2. Read in activity and feature names. 
activity_names<- read.table(file.path(datadir, 'activity_labels.txt'),stringsAsFactors = F)
features_names<- read.table(file.path(datadir, 'features.txt'), stringsAsFactors = F)

##Label variables for better readibility of code
names(activity_names)<- c("activityid", "activityname")
names(features_names)<- c("featureid", "featurename")

##Select the features that are only related to the mean and standard deviation of the measurements
features_selected <- features_names[grep('mean[(][)]|std[(][)]',features_names$featurename),]

#3. Merge train and test data

##Create list to store train and test data in
data<- list()

##Loop over train and test data
for(i in c("train", "test")){
    ##Read in measurements, activities and subjects
    X<-read.table(file.path(datadir,i, paste0('X_', i, '.txt')))
    activity<-read.table(file.path(datadir, i, paste0('y_', i, '.txt')))
    subject<-read.table(file.path(datadir, i, paste0('subject_', i, '.txt')))
    
    ##Select only the measurements related to the mean and standard deviation
    X <- X[, features_selected$featureid]
    
    ##Combine all variables and label the variables
    data[[i]]<- cbind(subject,activity, X)
    names(data[[i]])<-c("subjectid", "activityid", features_selected$featurename)

}

##Combine train and test data 
total_data<- rbind(data[["train"]], data[["test"]])

#4. Rename activities
##Merge total data with activity names
total_data<- merge(total_data, activity_names, all.x=T, all.y=F)

##Remove activity id and reorder variables
total_data<-total_data[, c("subjectid", "activityname", features_selected$featurename)]

#5. Create data set with the average of each variable for each activity and each subject.
##Here we use the aggregate function to compute the mean
avg_data<- aggregate(total_data[,features_selected$featurename], 
                     by= list(total_data$activityname, total_data$subjectid), mean)
names(avg_data)<-c("activityname", "subjectid", features_selected$featurename)
    
##Order dataset in logical order and export avg data set
avg_data<- avg_data[order(avg_data$activityname, avg_data$subjectid),]
write.table(avg_data, "avg_data.txt", row.names=F)


