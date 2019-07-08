corr <- function(directory, threshold = 0) {
      #Check whether the directory exists.
      assertthat::is.dir(directory)
      
      #Create vector with all correlations.
      corrVector <- NULL
      j = 1
      for (i in 1:length(list.files(directory))) {
            tFile <- paste0(directory,"/",formatC(i,width = 3,format = "d", flag = "0"),".csv")
            tCSV <- read_csv(tFile,col_types = "Dddd")
            tTable <- tCSV[complete.cases(tCSV),]
            
            #Filter Data using threshold
            if (nrow(tTable) > threshold) {
                  corrVector[j] <- cor(tTable$sulfate, tTable$nitrate)
                  j=j+1
            }
      }
      return(corrVector)      
}