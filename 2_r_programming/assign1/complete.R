complete <- function(directory, id = 1:332) {
    ## Store count in this data frame
    #cases <- data.frame("id"=integer(),"nobs"=integer())
    cases <- data.frame()
    
    ## Read files from directory
    for (i in id) {
        # Format the name of the necessary files
        sensor <- paste(directory,"/",sprintf("%03d",i),".csv",sep = "")
        
        # Read file to variable
        data <- read.table(sensor,header=TRUE,sep=",")
        ok <- complete.cases(data)
        #print(sum(ok))
        #cases <- rbind(cases, c("id"=i, "nobs"=sum(ok)))
        cases <- rbind(cases, c(i, sum(ok)))
    }
    
    # Give names to the columns
    colnames(cases) <- c("id","nobs")
    
    return(cases)
}