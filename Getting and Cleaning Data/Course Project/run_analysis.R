## This script creates independent tidy data set with the average of each "mean" or "standard deviation" variable
## for each activity and each subject


## Reading "activity_labels.txt" and "features.txt"
library(readr)
activity_labels <- read_table(file = "UCI HAR Dataset/activity_labels.txt", col_names = FALSE)
features <- read_table(file = "UCI HAR Dataset/features.txt", col_names = FALSE)


## Modifying data obtained from features.txt file so that it can act as column names for the merged data
library(dplyr)
library(stringr)

### Splitting data in features variable using space and extracting second part of the string to remove numbers
features <- as_tibble(str_split_fixed(features$X1, " ", 2))
features <- features$V2

### Removing brackets from the data to make the data readable
features <- str_replace_all(features, "\\(", "")
features <- str_replace_all(features, "\\)", "")


## Reading data present in "test" folder
subject_test <- read_table(file = "UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
y_test <- read_table(file = "UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
y_test <- as.factor(activity_labels[y_test$X1,2]$X2)
x_test <- read_table(file = "UCI HAR Dataset/test/X_test.txt", col_names = FALSE)

### Assigning column names and merging all data present in "test" folder
names(x_test) <- features
merged_test_data <- cbind(activity = y_test, subject = subject_test$X1, x_test)


## Reading data present in "train" folder
subject_train <- read_table(file = "UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
y_train <- read_table(file = "UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
y_train <- as.factor(activity_labels[y_train$X1,2]$X2)

### Assigning column names and merging all data present in "train" folder
x_train <- read_table(file = "UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
names(x_train) <- features
merged_train_data <- cbind(activity = y_train, subject = subject_train$X1, x_train)


## Merging data extracted from both folders
merged_data <- rbind(merged_test_data, merged_train_data)


## Extracting data which contains "mean" and "std" values and merging them.
merged_data_mean <- merged_data[, grepl("mean", names(merged_data))]
merged_data_std <- merged_data[, grepl("std", names(merged_data))]
merged_data_final <- cbind(merged_data[,1:2], merged_data_mean, merged_data_std)


## Creating tidy data which is grouped by subjects and activity and contains average of corresponding rows.
tidy_data <- merged_data_final %>% group_by(subject, activity) %>% summarise_all("mean")


## Storing data set in a txt file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)