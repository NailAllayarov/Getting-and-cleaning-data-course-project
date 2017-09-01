# Getting-and-cleaning-data-course-project
Programming assignment

R-Script ***"run_analysis.R"*** performs the following steps described in the course project's definition:

1 Step.  Merges the training and the test sets to create one data set: The train and test data was merged using the rbind() and cbind() functions. By similar, we address those files having the same number of columns and referring to the same entities.

Source of the data: Human Activity Recognition Using Smartphones http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

2 Step. Extracts only the measurements on the mean and standard deviation for each measurement:
Using the regular expressions we chose the columns with the mean and standard deviation measures from the merged dataset from the last step.

3 Step. Uses descriptive activity names to name the activities in the data set: 
Match the data in the column activity, which are the integers 1:6 with the descriptive name from the activity_labels.txt file.

4 Step. Appropriately labels the data set with descriptive variable names:
The special characters and the abbreviations were edited in this step. 

5 Step. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
New dataset with all the average measures for each subject and activity type is saved in the file "averages_data.txt".



# Other files

***CodeBook.md*** contains description of the variables and transformations that were used to manipulate the data.

***tidy_data.txt*** contains the tidy data set which was created in the final step of the R-Script.




