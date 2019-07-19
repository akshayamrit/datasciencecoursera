# Quiz Answers
## Questtion 1

library(readr)
housing_Idaho <- read_csv("housing-Idaho.csv")
agricultureLogical <- housing_Idaho$ACR == 3 & housing_Idaho$AGS ==6
which(agricultureLogical)

## Question 2

library(jpeg)
jpegFile <- readJPEG("instructor.jpg", native = T)
quantile(jpegFile, probs = c(0.3,0.8))

## Question 3

library(readr)
library(dplyr)
GDP <- read_csv("GDP.csv")
Edu_Data <- read_csv("Edu Data.csv")
merged_data <- merge(GDP[,1:2], Edu_Data[,1:3], by.x = "X1", by.y = "CountryCode")
merged_data <- merged_data[complete.cases(merged_data),]
merged_data <- rename(merged_data, GDP = "Gross domestic product 2012", IncGrp = "Income Group")
class(merged_data$GDP) <- "numeric"
merged_data <- arrange(merged_data, desc(GDP))
length(merged_data$X1)
merged_data[13,3]

## Question 4

merged_data %>% group_by(IncGrp) %>% summarize(mean(GDP, na.rm = T))

## Question 5

count(merged_data[merged_data$GDP<=38 & merged_data$IncGrp == "Lower middle income",])