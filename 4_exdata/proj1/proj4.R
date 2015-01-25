library(ggplot2)

# Read data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find coal combustion sources
coal <- SCC[grep("[Cc]oal",SCC$Short.Name), ] # First find coal
coal <- coal[grep("Comb",coal$Short.Name), ]  # then find combustion

# Subset Coal (SCC in coal)
coalCombution <- NEI[NEI$SCC %in% coal$SCC, ]

# summarise the data by year
totalEm <- ddply(coalCombution,c("year"),summarise, Emissions = sum(Emissions))

# Uggly plot that works :)
with(totalEm, plot(year, Emissions))
model <- lm(Emissions ~ year, totalEm)
abline(model)
title(main = "Coal Combustion Emissions by Year")