pollutantmean <- function(directory, pollutant, id = 1:332) {
      tableData <- NULL
      
      #Check whether the directory exists
      assertthat::is.dir(directory)
      
      #Create table which will have value from files specified in "id"
      for (i in id) {
            tFile <- paste0(directory,"/",formatC(i,width = 3,format = "d", flag = "0"),".csv")
            tableData <- rbind(tableData,suppressMessages(read_csv(tFile, col_types = "Dddd")))
      }
      
      #Find the mean of specified pollutant
      if (pollutant %in% "sulfate") {
            return(mean(tableData$sulfate, na.rm = T))
      } else if (pollutant %in% "nitrate") {
            return(mean(tableData$nitrate, na.rm = T))
      } else {
            stop("Invalid Pollutant")
      }
}