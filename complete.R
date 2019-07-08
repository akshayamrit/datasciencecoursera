complete <- function(directory, id = 1:332) {
      dFrame <- data.frame("id" = NULL, "nobs" = NULL)
      
      #Check whether directory exists
      assertthat::is.dir(directory)
      
      #Build dFrame
      for (i in id) {
            tFile <- paste0(directory,"/",formatC(i,width = 3,format = "d", flag = "0"),".csv")
            tCSV <- suppressMessages(read_csv(tFile, col_types = "Dddd"))
            tTable <- data.frame("id" = i, "nobs" = nrow(tCSV[complete.cases(tCSV),]))
            dFrame <- rbind(dFrame,tTable)
      }
      return(dFrame)
}