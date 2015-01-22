# Project for class Getting and Cleaning Data through Coursera
# Source of data for Project
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Script will perform the following steps.
# 1. Merges the training and the test sets to create one data set.
# Load the test data to corresponding variables for binding later.
require("data.table")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Load the train data to corresponding variables for binding later.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

subject_combined <- rbind(subject_test, subject_train)

X_comb <- rbind(X_test, X_train)
y_comb <- rbind(y_test, y_train)

# Load links to the class labels with their activity name
# Read the table and give me the second column.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Load the list of all features
features <- read.table("./UCI HAR Dataset/features.txt")
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Get all Features whose names have "Mean or std" in them.
extract_measurements <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
# Add the features names to the X_test and X_train data.
# Now only take those items that have the Features grepped for previously.
X_comb <- X_comb[ ,extract_measurements]
names(X_comb) <- features[extract_measurements, 2]
names(X_comb) <- gsub("\\(|\\)", "", names(X_comb))
names(X) <- tolower(names(X))  

# 3. Uses descriptive activity names to name the activities in the data set
y_comb[,1] = activity_labels[y_comb[,1], 2]
names(y_comb) <- "activity"

# 4. Appropriately label the data set with descriptive variable names. 
names(subject_combined) <- "subject"

#Bind the data tables
clean_data = cbind(subject_combined,y_comb,X_comb)
write.table(clean_data, file = "./merged_clean_data.txt") 

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(subject_combined)[,1]
numSubjects = length(unique(subject_combined)[,1])
numActivities = length(activity_labels[,1])
numCols = dim(clean_data)[2]
result = clean_data[1:(max(uniqueSubjects)*numActivities), ]

row = 1
for (s in 1:numSubjects) {
	for (a in 1:numActivities) {
		result[row, 1] = uniqueSubjects[s]
		result[row, 2] = activity_labels[a, 1]
		tmp <- clean_data[clean_data$subject==s , ]
		tmp <- clean_data[clean_data$subject==s & clean_data$activity==activity_labels[a, 2], ]
		result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
		row = row+1
	}
}
write.table(result, "tidy_data_set.txt")
