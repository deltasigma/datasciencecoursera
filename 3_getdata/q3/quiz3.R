## Quiz 3

# Q1
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./acs.csv", method = "curl")

# Read downloaded file
ACS <- read.table("acs.csv", sep=",", header=T)

# Logical vector
agricultureLogical <- ACS$AGS == 6 & ACS$ACR == 3

# Q2
library(jpeg)
imgUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(imgUrl, destfile = "./img.jpg", method = "curl")
img <- readJPEG("img.jpg", native=T)
quantile(img,probs=c(0.3,0.8))

# Q3
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileUrl1, destfile = "./gdp.csv", method = "curl")
download.file(fileUrl2, destfile = "./edc.csv", method = "curl")

# Read GDP file
GDP <- read.table("gdp.csv", header=F, sep=",", fileEncoding="latin1",
                  quote="\"", as.is = TRUE, dec = ".",
                  strip.white=T, skip=5, nrows = 190)
# Read Education data
EDC <- read.table("edc.csv", header=T, sep=",", fileEncoding="latin1", quote="\"")

# Merge both data
mergedData <- merge(GDP, EDC, by.x="V1", by.y="CountryCode")

# Sort
library(plyr)
mergedData <- arrange(mergedData,desc(V2))

# Convert GDP to numeric
mergedData$V5 <- as.numeric(gsub(",", "", mergedData$V5))
mergedData$V2 <- as.numeric(mergedData$V2)

# Averages
nonOECD <- mergedData[mergedData$Income.Group == "High income: nonOECD", ]
mean(nonOECD$V2)
OECD <- mergedData[mergedData$Income.Group == "High income: OECD", ]
mean(OECD$V2)

# Quantile CUT
library(Hmisc)
mergedData$Group <- cut2(mergedData$V2,g=5)
