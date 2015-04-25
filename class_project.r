download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="dataset.zip", mode="wb")
unzip("dataset.zip", exdir = "C:/Users/Meredith/datasciencecoursera/data")

colnames <- read.table("UCI HAR Dataset/features.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
activity_type <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_type")

colnames(X_test) <- colnames$V2

X_test <- cbind(test_subject, activity_type, subject_group = "test", X_test)

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
activity_type_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_type")

colnames(X_train) <- colnames$V2
X_train <- cbind(train_subject, activity_type_train, subject_group = "train", X_train)

activity_data <- rbind(X_test, X_train)

valid_column_names <- make.names(names=names(activity_data), unique=TRUE, allow_ = TRUE)
names(activity_data) <- valid_column_names

sum_activity_data <- select(activity_data, subject_id, activity_type, subject_group,
                            contains("mean\\(\\)"), contains("std\\(\\)"))

