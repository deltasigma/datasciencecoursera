library(plyr)

# Read data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# summarise the data by year
totalEm <- ddply(NEI,c("year"),summarise, sum = sum(Emissions))

# Uggly plot that works :)
with(totalEm, plot(year, sum))
model <- lm(sum ~ year, totalEm)
abline(model)
title(main = "Total Emissions by Year")