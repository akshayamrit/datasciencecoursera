---
title: "ReadMe"
author: "akshayamrit"
date: "24/07/2019"


---
# Introduction

The objective of this project is to prepare tidy data using provided raw data that can be used for later analysis.
This folder contains all the documents which will be required for Getting and Cleaning Data Course Project.
Folders present in the directory:

      - "UCI HAR Dataset" : Raw data which needs to be processed.
      - "run_analysis.R" : R script required to read raw data and write tidy data.
      - "tidy_data.txt" : Tidy data created using "run_analysis.R".
      - "Data Dictionary.md" : Dictionary describing the data present in the "tidy_data.txt".


---
# Running R script to obtain tidy data

**Note: Every file and folder listed in this "ReadMe" file should be present in the same directory and it should be set as working directory.**
Make sure that the following packages are installed before running the script:

      - readr
      - dplyr
      - stringr**


---
# Steps involved in tidy data from raw data in "run_analysis.R"

1. Reading "activity_labels.txt" and "features.txt". "activity_labels" contains the activities assigned to each number in raw data so this file was used to convert numbers to descriptive text for activity column. "features.txt" contains the type of data present in each column so this file is used to assign descriptive name to each column.

2. Modifying data obtained from features.txt file so that it can act as column names for the merged data. The format for data present in "features.txt" is not suitable to be column name without any modification. To make data present in this file readable, number present in each feature and brackets are removed.

3. Reading data present in "test" folder. Data which has to be merged to make the raw data look sensible is present in different files so each file is loaded and the data extracted from these files are merged into a single table named "merged_test_data".

4. Reading data present in "train" folder. Data which has to be merged to make the raw data look sensible is present in different files so each file is loaded and the data extracted from these files are merged into a single table named "merged_train_data".

5. Merging data extracted from both folders. The only difference between files present in both "test" and "train" directory is that they contain data for different subjects so the tables created in 3rd and 4th step is merged by rows to create a table "merged_data" which contains data present in both the folders.

6. Extracting data which contains "mean" and "std" values and merging them. As per the requirement of the assignment, a new table has been created which contains only average and standard deviation values of each measurement. This table has been assigned to the object "merged_data_final".

7. Creating tidy data which is grouped by subjects and activity and contains average of corresponding rows. A new table is created which contains tidy data according to the requirement of the assignment. It is assigned to the object "tidy_data".

8. Storing data set in a txt file. "tidy_data" is stored in file named "tidy_data.txt" using write.table() function.


---
# Reading tidy data
The final output of the script is stored in "tidy_data.txt" file. It contains header of each column as well so read.table() function should be used to load it and view properly. exact command to be used :
```
data <- read.table(file = "tidy_data.txt", header = TRUE)
view(data)
```
