## Q1
# Download file
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,"./hid.csv", method="curl")

# read table
hid <- read.table("./hid.csv", sep=",", header=T)

## Q2
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,"./gdp.csv", method="curl")

# read table
gdp <- read.table("gdp.csv", header=F, sep=",", fileEncoding="latin1",
                  quote="\"", as.is = TRUE, dec = ".",
                  strip.white=T, skip=5, nrows = 190)

# Strip commas
gdp$V5 <- as.numeric(gsub(",", "", gdp$V5))

# Calculate mean
mean(gdp$V5)

## Q3
# Count names starting by United
grep("^United",gdp$V4)

## Q4
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1,"./gdp.csv", method="curl")
download.file(fileUrl2,"./edu.csv", method="curl")

# read GDO table
gdp <- read.table("gdp.csv", header=F, sep=",", fileEncoding="latin1",
                  quote="\"", as.is = TRUE, dec = ".",
                  strip.white=T, skip=5, nrows = 190)
# Read Education data
edu <- read.table("edu.csv", header=T, sep=",", fileEncoding="latin1", quote="\"")

# Match two files
matchedDF <- merge(gdp, edu, by.x="V1", by.y="CountryCode")

# Find informed fiscal year end
fiscal <- grep("Fiscal year end",matchedDF$Special.Notes, value=T)

# Count fiscal year end = June
fiscalJune <- grepl("[Jj]une",fiscal)
names(matchedDF)

## Q5
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
length(sampleTimes[year(sampleTimes) == "2012"])
