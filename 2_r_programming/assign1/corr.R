corr <- function(directory, threshold = 0) {
    # Find complete cases number in directory
    cases <- data.frame(complete(directory,1:332))
    #cases <- data.frame(complete(directory,1:5))
    
    # Store correlations in this vector
    correlations <- vector()
    
    # Find which cases are above threshold
    trcases <- cases$nobs >= threshold
    casesok <- cases[trcases,]$id
    
    ## Iterate over cases to processes the ones above threshold
    for (case in casesok) {
        ## Load file for that case
        sensor <- paste(directory,"/",sprintf("%03d",case),".csv",sep = "")
        datafile <- read.table(sensor,header=TRUE,sep=",")
        
        ## Find complete cases
        okcases <- complete.cases(datafile)
        
        ## Calculate the correlation in corrvector
        corrvector <- datafile[okcases,]
        correlations <- c(correlations, cor(corrvector$nitrate,corrvector$sulfate))
    }
    
    return(correlations)
}