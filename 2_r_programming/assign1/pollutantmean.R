# pollutantmean.R

# This function calculates the mean of pollutant
pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## Data will be saved in this dataframe
    data <- data.frame()
    sensors <- list()
    
    ## Read files from directory
    for (i in id) {
        # Format the name of the necessary files
        sensor <- paste(directory,"/",sprintf("%03d",i),".csv",sep = "")
        
        # Append data from new file to variable
        data <- rbind(data,read.table(sensor,header=TRUE,sep=","))
    }
    
    # Calculate the selected pollutant mean 
    if (pollutant == "sulfate") {
        mean(data$sulfate, na.rm = TRUE)
    } else if (pollutant == "nitrate") {
        mean(data$nitrate, na.rm = TRUE)
    }
}