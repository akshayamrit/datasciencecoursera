## To rank hospital for the requested state.
rankhospital <- function(state, outcome, num = "best") {
      
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
      
      ## Create valid state and outcome scenarios.
      outcome_of_care_measures.State <- unique(outcome_of_care_measures$State)
      outcome_of_care_measures.Outcome <- c("heart attack", "heart failure", "pneumonia")
      
      ## Check that state and outcome are valid
      if (!is.element(state,outcome_of_care_measures.State)) {
            stop("invalid state")
      }
      if (!is.element(outcome,outcome_of_care_measures.Outcome)) {
            stop("invalid outcome")
      }
      if (!is.numeric(num) & !is.element(num, c("best", "worst"))) {
            stop("invalid num")
      }
      
      ## Create table with relevent info
      usableTable <- data.frame("Hospital Name" = outcome_of_care_measures$`Hospital Name`,
                                "State" = outcome_of_care_measures$State,
                                "Heart Attack" = outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Heart Attack`,
                                "Heart Failure" = outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Heart Failure`,
                                "Pneumonia" = outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Pneumonia`)
      usableTable <- usableTable[which(usableTable$State == state),]
      
      if (outcome == "heart attack") {
            usableTable <- usableTable[order(usableTable$Heart.Attack,usableTable$Hospital.Name),]
            usableTable <- usableTable[!is.na(usableTable$Heart.Attack),]
      }
      else if (outcome == "heart failure") {
            usableTable <- usableTable[order(usableTable$Heart.Failure,usableTable$Hospital.Name),]
            usableTable <- usableTable[!is.na(usableTable$Heart.Failure),]
      }
      else {
            usableTable <- usableTable[order(usableTable$Pneumonia,usableTable$Hospital.Name),]
            usableTable <- usableTable[!is.na(usableTable$Pneumonia),]
      }
      
      ## Add ranking column to usableTable
      rankedTable <- data.frame(usableTable, "Rank" = 1:nrow(usableTable))
      
      ## Compute num and return NA if num is greater than the number of entries to rank
      if (!is.numeric(num)){
            ifelse(num == "best", num <- 1, num <- nrow(usableTable))
      }
      else if (num > nrow(rankedTable)) {
            return(NA)
      }
      
      ## Return hospital name in that state with the given rank
      ## 30-day death rate
      return(as.character(rankedTable[which(rankedTable$Rank == num),1]))
}