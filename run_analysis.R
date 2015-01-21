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

# Load links to the class labels with their activity name
# Read the table and give me the second column.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
# Load the list of all features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Get all Features whose names have "Mean or std" in them.
extract_measurements <- grepl("mean|std", features)
# Add the features names to the X_test and X_train data.
names(X_test) = features
names(X_train) = features
# Now only take those items that have the Features grepped for previously.
X_test = X_test[,extract_measurements]
X_train = X_train[,extract_measurements]

# 3. Uses descriptive activity names to name the activities in the data set
y_test[,2] = activity_labels[y_test[,1]]
y_train[,2] = activity_labels[y_train[,1]]


# 4. Appropriately label the data set with descriptive variable names. 
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"


test_data_table <- cbind(subject_test, y_test, X_test)
train_data_table <- cbind(subject_train, y_train, X_train)
#Bind the data tables
clean_data = rbind(test_data_table, train_data_table)

write.table(clean_data, file = "./merged_clean_data.txt") 

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

activity_labels <- as.data.frame(activity_labels)
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
		#tmp <- clean_data[clean_data$subject==s & clean_data$Activity_Label==activity_labels[a, 2], ]
		result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
		row = row+1
	}
}
write.table(result, "data_set_with_the_averages.txt")
