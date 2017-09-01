# GCD Week 4 Project

library(readr); library(tibble); library(dplyr)

#################################################################
# STEP 1 - read the files and merge the train and test data sets#
#################################################################

setwd("/Users/Nael/Desktop/Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset")

# read the features and activities data

features<-t(read.table("features.txt")[,2])  
activities<-read.table("activity_labels.txt")

#first we construct the data frame for the test data set - we read all the data files and name them accordingly

setwd("/Users/Nael/Desktop/Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test")

subject_test<-as.tibble(read.table("subject_test.txt")); names(subject_test)<-"subject"    
X_test<-as_tibble(read.table("X_test.txt")); names(X_test)<-features
y_test<-as_tibble(read.table("y_test.txt")); names(y_test)<-"activity"

test_df<-cbind(X_test, y_test, subject_test)  # data frame with test data set

#secondly we construct the data frame for the train data set - analog to the first step

setwd("/Users/Nael/Desktop/Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train")

subject_train<-as.tibble(read.table("subject_train.txt")); names(subject_train)<-"subject"
X_train<-as_tibble(read.table("X_train.txt")); names(X_train)<-features
y_train<-as_tibble(read.table("y_train.txt")); names(y_train)<-"activity"

train_df<-cbind(X_train, y_train, subject_train) # data frame with train data set

all_df<-rbind(test_df, train_df)   # data frame with both test and train data set


##################################################################################
# STEP 2 - Extraction of the measurements on the mean and sd for each measurement#
##################################################################################

# determine columns of data set to keep based on column name - 
# note: we want to have the columns on subjects and activities

columnsToKeep <- grepl("activity|subject|mean|std", colnames(all_df))
# keep data in these columns + the activity and subject column

all_df2<-all_df[,columnsToKeep]

##################################################################################
# STEP 3 - Use descriptive activity names to name the activities in the data set #
##################################################################################

# replace activity values with named factor levels
all_df2[,"activity"]<-activities$V2[all_df2[,"activity"]]

##################################################################################
# STEP 4 - Appropriately labels the data set with descriptive variable names     #
##################################################################################

# get column names
ColumnNames <- names(all_df2)

# remove special characters
ColumnNames <- gsub("[\\(\\)-]", "", ColumnNames)

# expand abbreviations and clean up names
ColumnNames <- gsub("^f", "frequencyDomain", ColumnNames)
ColumnNames <- gsub("^t", "timeDomain", ColumnNames)
ColumnNames <- gsub("Acc", "Accelerometer", ColumnNames)
ColumnNames <- gsub("Gyro", "Gyroscope", ColumnNames)
ColumnNames <- gsub("Mag", "Magnitude", ColumnNames)
ColumnNames <- gsub("Freq", "Frequency", ColumnNames)
ColumnNames <- gsub("mean", "Mean", ColumnNames)
ColumnNames <- gsub("std", "StandardDeviation", ColumnNames)

# correct typo (see for example the last columns)
ColumnNames <- gsub("BodyBody", "Body", ColumnNames)

# use new labels as column names
names(all_df2) <- ColumnNames

##################################################################################
# STEP 5 - From the data set in step 4, creates a second, independent tidy data  #
# set with the average of each variable for each activity and each subject.      #
##################################################################################

# group by subject and activity and summarise using mean
all_df2<-as.tbl(all_df2)
tidy_dataset<-summarise_all(group_by(all_df2, subject, activity), funs(mean))

# output to file "tidy_data.txt"
setwd("/Users/Nael/Desktop/Coursera/Getting and Cleaning Data/Week 4")
write.table(tidy_dataset, "tidy_data.txt", row.names = FALSE, quote = FALSE)
