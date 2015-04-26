# This script takes data from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# and creates a tidy data set that combines both the training and the test data sets.
# The tidy data set contains only the measurements that have mean or std in there names.
# It uses this tidy data set to summerize the data and get a mean value for each measurement 
# by the activity type and the subject ID
#  
# It uses functions from the tidyr and the dplyr libraries and assumes that the data is in a directory 
# off the current working directory with the name "UCI HAR Dataset".  The commands to download the data
# are commented out below
#
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#              destfile="dataset.zip", mode="wb")
#unzip("dataset.zip")

#loads libraries that are needed to run the source code

library(tidyr)
library(dplyr)


# Reads in the file that contains the column names for the data set

colnames <- read.table("UCI HAR Dataset/features.txt")


# Reads in the data set for the test group

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")


# Reads in the data set that has the id for the test subject and the activity type for the test data set

test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectid")
activitytype <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activitytype")


# Sets the column names for the test data set

colnames(X_test) <- colnames$V2


# Uses cbind to add columns for the test subject ID and the activity type and then adds a column for the
# subject group which had "test" in it so that data is not lost when the data is merged

X_test <- cbind(test_subject, activitytype, subjectgroup = "test", X_test)


# Reads in the data set for the training group

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")


# Reads in the data set that has the id for the test subject and the activity type for the training data set

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectid")
activity_type_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activitytype")


# Sets the column names for the training data set

colnames(X_train) <- colnames$V2


# Uses cbind to add columns for the test subject ID and the activity type and then adds a column for the
# subject group which had "train" in it so that data is not lost when the data is merged

X_train <- cbind(train_subject, activity_type_train, subjectgroup = "train", X_train)


# Merges the test and train data

activity_data <- rbind(X_test, X_train)


# Cleans up the names of the columns removing '(', ')' and '-'

names(activity_data) <- gsub("\\(","",names(activity_data))
names(activity_data) <- gsub("\\)","",names(activity_data))
names(activity_data) <- gsub("-","",names(activity_data))


# Makes all the names of the columns to be lower case

names(activity_data) <- tolower(names(activity_data))


# After analysis of the data I observed that there were duplicate column names that all had "bandsenergy"
# in the name and that there were no mean or std names that included this so I removed all columns with
# "bandsenergy" in the name

activity_data <- activity_data[, -grep("bandsenergy", names(activity_data))]


# Selecting all columns with "mean" or "std" in the name

sum_activity_data <- select(activity_data, subjectid, activitytype, subjectgroup,
                            contains("mean"), contains("std"))


# Change the activitytype to a factor with the correct labels for the activity type to make the 
# data more readable

sum_activity_data$activitytype <- factor(sum_activity_data$activitytype, levels = 1:6, labels =
                                                         c("walking", "walking_upstairs", 
                                                           "walking_downstairs", "sitting", "standing",
                                                           "laying"))


# Create a tidy data set by taking all of the measurement columns and turning them into rows with the 
# column name as the variabletype and the value of the measurement as value

tidy_activity_data <- sum_activity_data %>%
        gather(variabletype, value, tbodyaccmeanx:fbodybodygyrojerkmagstd)


# Summerize the data grouped by the variabletype, activitytype and subjectid

tidy_sum_data <- tidy_activity_data %>%
        group_by(variabletype, activitytype, subjectid) %>%
        summarize(meanvalue = mean(value))

#writes the final data table with the averages to a text file
write.table(tidy_sum_data, file="tidydataset.txt", row.names=FALSE)