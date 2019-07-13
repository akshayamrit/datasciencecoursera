rankall <- function(outcome, num = "best") {
      ## Read outcome data
      library(readr)
      outcome_of_care_measures <- suppressWarnings(
            suppressMessages(
                  read_csv("outcome-of-care-measures.csv", 
                           col_types = cols(`Hospital 30-Day Death (Mortality) Rates from Heart Attack` = col_number(), 
                                            `Hospital 30-Day Death (Mortality) Rates from Heart Failure` = col_number(), 
                                            `Hospital 30-Day Death (Mortality) Rates from Pneumonia` = col_number()))
            )
      )
      
      ## Create valid scenarios
      outcome_of_care_measures.Outcome <- c("heart attack", "heart failure", "pneumonia")
      
      ## Check that state and outcome are valid
      if (!is.element(outcome,outcome_of_care_measures.Outcome)) {
            stop("invalid outcome")
      }
      if (!is.numeric(num) & !is.element(num, c("best", "worst"))) {
            stop("invalid num")
      }
      
      ## Create relevent table 
      usableTable <- data.frame("Hospital Name" = outcome_of_care_measures$`Hospital Name`,
                                "State" = outcome_of_care_measures$State,
                                "Heart Attack" = outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Heart Attack`,
                                "Heart Failure" = outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Heart Failure`,
                                "Pneumonia" = outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Pneumonia`)
      
      if (outcome == "heart attack") {
            usableTable <- usableTable[!is.na(usableTable$Heart.Attack),]
            usableTable <- usableTable[order(usableTable$State, usableTable$Heart.Attack, usableTable$Hospital.Name),]
      }
      else if (outcome == "heart failure") {
            usableTable <- usableTable[!is.na(usableTable$Heart.Failure),]
            usableTable <- usableTable[order(usableTable$State, usableTable$Heart.Failure, usableTable$Hospital.Name),]
      }
      else {
            usableTable <- usableTable[!is.na(usableTable$Pneumonia),]
            usableTable <- usableTable[order(usableTable$State, usableTable$Pneumonia, usableTable$Hospital.Name),]
      }
      
      ## For each state, find the hospital of the given rank
      finalTable <- NULL
      numStore <- num
      for (i in levels(usableTable$State)) {
            subTable <- subset(usableTable, usableTable$State == i)
            subTable <- data.frame(subTable, "Rank" = 1:nrow(subTable))
            
            if (!is.numeric(numStore)){
                  ifelse(numStore == "best", num <- 1, num <- nrow(subTable))
            }
            
            if (num > nrow(subTable)) {
                  finalTable <- rbind.data.frame(finalTable, data.frame("Hospital Name" = NA,
                                                                        "State" = i))      
            }
            else {
                  finalTable <- rbind.data.frame(finalTable,subTable[num,c(1,2)])
            }
      }
      ## Return a data frame with the hospital names and the
      ## (abbreviated) state name
      return(finalTable)
}
