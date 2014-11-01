best <- function(state, outcome) {
        ## Read outcome data
        o_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        ##s_data <- read.csv("hospital-data.csv", colClasses = "character")
        
        ## Check that state is valid
        if (is.null(state) | !is.element(state,unique(o_data$State))) {
                stop("invalid state")
        }
        
        ## Check that outcome is valid
        #o_valid <- c("heart attack", "heart failure", "pneumonia")  # List valid outcomes
        #if (!is.element(outcome,o_valid)) {
        #        stop("invalid outcome")
        #}
        field <- numeric()
        if (outcome == "heart attack") {
                field <- 11
        } else if (outcome == "heart failure") {
                field <- 17
        } else if (outcome == "pneumonia") {
                field <- 23
        } else { stop("invalid outcome") }
        
        ## Select only the hospital and outcome before sorting
        shortlist <- o_data[o_data$State == state,c(2,field)]
        shortlist[,2] <- as.numeric(shortlist[,2])
        
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        shortlist <- shortlist[order(shortlist[2],shortlist[1]),]
        as.character(head(shortlist[1],1))
}