##To find out the best hospital using State and Outcome
best <- function(state, outcome) {
   
   ## Read outcome data
   library(readr)
   outcome_of_care_measures <- suppressWarnings(
      suppressMessages(
         read_csv("outcome-of-care-measures.csv",
                  col_types = cols("Hospital 30-Day Death (Mortality) Rates from Heart Attack"=col_number(), 
                                   "Hospital 30-Day Death (Mortality) Rates from Heart Failure"=col_number(), 
                                   "Hospital 30-Day Death (Mortality) Rates from Pneumonia"=col_number()))))
   
   ## Check that state and outcome are valid
   ###Define valid entries
   outcome_of_care_measures.States <- unique(outcome_of_care_measures$State)
   outcome_of_care_measures.Outcome <- c("heart attack", "heart failure", "pneumonia")
   
   ###Check Validity of parameters
   if (!is.element(state, outcome_of_care_measures.States)) {
      stop("invalid state")      
   }
   if (!is.element(outcome, outcome_of_care_measures.Outcome)) {
      stop("invalid outcome")
   }
   
   ###Create new table without unnecessary data
   usableTable <- data.frame("Hospital Name"=outcome_of_care_measures$"Hospital Name",
                             "State"=outcome_of_care_measures$State,
                             "Hospital 30-Day Death (Mortality) Rates from Heart Attack"=outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Heart Attack`, 
                             "Hospital 30-Day Death (Mortality) Rates from Heart Failure"=outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Heart Failure`, 
                             "Hospital 30-Day Death (Mortality) Rates from Pneumonia"=outcome_of_care_measures$`Hospital 30-Day Death (Mortality) Rates from Pneumonia`)
   usableTable <- usableTable[which(usableTable$State == state),]
   
   ## Return hospital name in that state with lowest 30-day death
   ## rate
   bestHospital <- NULL
   if (outcome == "heart attack") {
      bestHospital <- usableTable[which.min(usableTable$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
   }
   else if (outcome == "heart failure") {
      bestHospital <- usableTable[which.min(usableTable$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),]
   }
   else {
      bestHospital <- usableTable[which.min(usableTable$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
   }
   
   ##Check if there are multiple hospitals with minimum mortality
   if (nrow(bestHospital) > 1) {
      return(as.character(bestHospital[order(bestHospital$Hospital.Name),1][1]))
   }
   else {
      return(as.character(bestHospital[1,1]))
   }
}