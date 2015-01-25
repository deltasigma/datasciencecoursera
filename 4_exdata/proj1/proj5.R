library(ggplot2)

# Read data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore (fips == "24510")
baltimore <- NEI[NEI$fips == "24510", ]

# Find vehicle emissions sources
vehicle <- SCC[grep("Vehicle",SCC$SCC.Level.Two), ] # First find coal

# Subset vehicle (SCC %in% vehicle)
vehicleCombustion <- baltimore[baltimore$SCC %in% vehicle$SCC, ]

# summarise the data by year
totalEm <- ddply(vehicleCombustion,c("year"),summarise, Emissions = sum(Emissions))

# Uggly plot that works :)
with(totalEm, plot(year, Emissions))
model <- lm(Emissions ~ year, totalEm)
abline(model)
title(main = "Vehicle Emissions in Baltimore by Year")