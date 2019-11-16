# The run_analysis script performs five specific tasks:
# It (1) merges test and training data sets; (2) extracts mean and # sd measures; 
# adds (3) descriptive activity and (4) variable names; and (5) creates a new 
# tidy data set with the average of each variable for each activity and each subject. 

# TASK 1: Merge the training and test data sets to create one data set

# import the various pieces of data table
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# transpose the features column vector[2] to a row to use as colnames
features <- as.character(features[, 2])
features <- t(features)

# merge X_train and X-test sets; name columns using features
X <- as.data.frame(matrix(NA, ncol=561, nrow=0))
X <- rbind(X_train, X_test)
colnames(X) <- features

# merge y_train and y_test sets; merge subject_train and subject_test sets;
# bind subject and y columns to the left of the dataframe
y <- rbind(y_train, y_test)
subj <- rbind(subject_train, subject_test)
merged.df <- cbind(subj, y, X)

# add descriptive names for subject and y columns
names(merged.df)[1:2] <- c("Subject", "Activity")

# TASK 2: Extract measurements on mean and sd for each measurement

# eliminate columns with identical names. (thanks to 
# https://stackoverflow.com/questions/54932063/ and 
# https://stackoverflow.com/questions/2370515 for their helpful
# insights into how to identify and remove duplicate column names.)

names_freq <- as.data.frame(table(names(merged.df)))
repeated <- names_freq[names_freq$Freq > 1, ]
repeatedIndex <- as.integer(rownames(repeated))
merged.df2 <- (merged.df[, -repeatedIndex])

# select for columns containing mean or standard deviation
merged.df3 <- select(merged.df2, contains("Activity"), contains("Subject"), 
                    contains("mean"), contains("std"))

#TASK 3: give descriptive activity names

merged.df3$Activity <- gsub("1", "Walking", merged.df3$Activity)
merged.df3$Activity <- gsub("2", "Walking_Upstairs", merged.df3$Activity)
merged.df3$Activity <- gsub("3", "Walking_Downstairs", merged.df3$Activity)
merged.df3$Activity <- gsub("4", "Sitting", merged.df3$Activity)
merged.df3$Activity <- gsub("5", "Standing", merged.df3$Activity)
merged.df3$Activity <- gsub("6", "Laying", merged.df3$Activity)

# TASK 4: Label data set with descriptive variable names -- completed as 
#         part of TASK 1, above, when "features" were added as colnames.

# TASK 5: Create a second, independent tidy data set with the average of each variable
#         for each activty and each subject

# Thanks to https://dplyr.tidyverse.org/reference/summarise_all.html and
# https://dplyr.tidyverse.org/reference/group_by.html for coding tips.

byActSubj <- merged.df3 %>% group_by(Activity, Subject)
res <- byActSubj %>% summarize_all(list(mean))

print(res)
