# Quiz Answers
## Questtion 1

library(readr)
us_communities <- read_csv("us_communities.csv")
strsplit(names(us_communities), split = "wgtp")[[123]]

## Question 2

GDP <- read_csv("GDP.csv")
GDP$X5 <- gsub(",", "", GDP$X5)
class(GDP$`Gross domestic product 2012`) = "numeric"
class(GDP$X5) = "numeric"
GDP <- filter(GDP, !is.na(GDP$`Gross domestic product 2012`))
mean(GDP$X5)

## Question 3

length(grep("^United",GDP$X4))

## Question 4

edu_data <- read_csv("edu_data.csv")
merged_fisc <- merge(GDP[,1:2], edu_data[,c(1,10)], by.x = "X1", by.y = "CountryCode")
length(grep("end: June", merged_fisc$`Special Notes`))

## Question 5

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
dt_Table <- as_tibble(sampleTimes)
count(dt_Table[year(dt_Table$value) == "2012",])
count(dt_Table[year(dt_Table$value) == "2012" & wday(dt_Table$value) == "2",])