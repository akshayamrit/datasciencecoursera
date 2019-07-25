## Updated R script to create tidy data

library(dplyr)
library(stringr)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

features <- features$V2
features <- str_replace_all(features, "\\(\\)", replacement = "")
features <- str_replace_all(features, "^t", replacement = "Time ")
features <- str_replace_all(features, "^f", replacement = "Frequency ")
features <- str_replace_all(features, "-", replacement = " ")
features <- str_replace_all(features, "_", replacement = " ")
features <- str_replace_all(features, "X$", replacement = "x axis")
features <- str_replace_all(features, "Y$", replacement = "y axis")
features <- str_replace_all(features, "Z$", replacement = "z axis")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test <- rename(subject_test, subject = V1)
subject_train <- rename(subject_train, subject = V1)

y_test <- rename(y_test, activity = V1)
y_train <- rename(y_train, activity = V1)

colnames(x_test) <- features
colnames(x_train) <- features

test <- cbind(subject_test, y_test, x_test)
train <- cbind(subject_train, y_train, x_train)

merged_data <- rbind(test,train)
merged_data$activity <- activity_labels[merged_data$activity, 2]
selective_merged_data <- merged_data[ , grepl("mean|std", colnames(merged_data))]
selective_merged_data <- cbind(merged_data[,1:2], selective_merged_data)

tidy_data <- selective_merged_data %>% group_by(subject, activity) %>% summarize_all(mean)

write.table(tidy_data, file = "tidy_data.txt", col.names = FALSE)