library(plyr)

# Read data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore (fips == "24510")
baltimore <- NEI[NEI$fips == "24510", ]

# summarise the data by year
totalEm <- ddply(baltimore,c("year"),summarise, sum = sum(Emissions))

# Uggly plot that works :)
with(totalEm, plot(year, sum))
model <- lm(sum ~ year, totalEm)
abline(model)
title(main = "Total Emissions in Baltimore")
