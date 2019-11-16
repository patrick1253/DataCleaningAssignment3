# DataCleaningAssignment3
Final Project for JHU online course on Data Cleaning and Tidying

The run_analysis script performs five specific tasks:
It (1) merges test and training data sets; (2) extracts mean and sd measures; 
adds (3) descriptive activity and (4) variable names; and (5) creates a new 
tidy data set with the average of each variable for each activity and each subject. 

It does so through the following steps:
 
TASK 1: Merge the training and test data sets to create one data set
- import the various pieces of data table
- transpose the features column vector[2] to a row to use as colnames
- merge X_train and X-test sets; name columns using features
- merge y_train and y_test sets; merge subject_train and subject_test sets;
- bind subject and y columns to the left of the dataframe
- add descriptive names for subject and y columns

TASK 2: Extract measurements on mean and sd for each measurement
- eliminate columns with identical names. (thanks to 
  https://stackoverflow.com/questions/54932063/ and 
  https://stackoverflow.com/questions/2370515 for their helpful
  insights into how to identify and remove duplicate column names.)
- select for columns containing mean or standard deviation.

TASK 3: give descriptive activity names

TASK 4: Label data set with descriptive variable names -- completed as 
         part of TASK 1, above, when "features" were added as colnames.

TASK 5: Create a second, independent tidy data set with the average of each variable
         for each activty and each subject

(Thanks to https://dplyr.tidyverse.org/reference/summarise_all.html and
https://dplyr.tidyverse.org/reference/group_by.html for coding tips.)

To load the script:

address <- "https://coursera-assessments.s3.amazonaws.com/assessments/1573930446807/c68fe4c6-3e3b-49e7-8c1a-cf1586f605c2/secondTidyDataSet.txt"

address <- sub("^https", "http", address)

data <- read.table(url(address), header = TRUE)

View(data)

(Thanks to https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ for this excellent suggestion.)
