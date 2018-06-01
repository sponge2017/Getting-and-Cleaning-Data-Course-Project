
## Getting and Cleaning Data Course Project

This is sponge2017's work for Getting and Cleaning Data course project. The project data sources comes from 2 groups of data sets:
1. training data: X_train, y_train, subject_train
2. testing data: X_test, y_test, subject_test.

The goal of the project is to:
1. clean and incorporate all source data sets into a single data set, 
2. calculate the mean for each selected (mean and std) varible for each subject and each activity
3. output the result from item 2 to flat file "tidy data.txt". 

My run_analysis.R script was created for this. It includes following steps:
  1. download source file package in the working directory
  2. unzip the downloaded package
  3. load activity data set
  4. load training data sets (X_train, y_train, subject_train), and add descriptive activity names from activity data set to the y_train data
  5. incorporate data sets y_train and subject_train into X_train
  6. load testing data sets (X_test, y_test, subject_test), and add descriptive activity names from activity data set to the y_test data
  7. incorporate data sets y_test and subject_test into X_test
  8. combine X_train and X_test together and save the result to X. 
  
  9. read data from features.txt file, which includes all the variable names
  10. select only the varilables related to mean and standard deviation
  11. clean up the variable names to make them more readable by removing "()" and "_", and make "mean" and "std" to become "Mean" and "Std" respectively
  12. create a data set X_MeanSDV to only include the selected varialbes with descriptive variable names
  13. calculate the mean for each variable in X_MeanSDV by each subject and each activity
  14. save the result of item 13 to file "tidy data.txt"

