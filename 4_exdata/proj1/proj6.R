library(ggplot2)

# Read data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore (fips == "24510")
cities <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]

# Assign name to the cities
cities$name <- ifelse(cities$fips == "24510", "Baltimore City", "Los Angeles County")

# Find vehicle emissions sources
vehicle <- SCC[grep("Vehicle",SCC$SCC.Level.Two), ]

# Subset vehicle (SCC %in% vehicle)
vehicleCombustion <- cities[cities$SCC %in% vehicle$SCC, ]

# summarise the data by year
totalEm <- ddply(vehicleCombustion,c("year","name"),summarise, Emissions = sum(Emissions))

# Plot graphics with baltimore data
qplot(year,Emissions,
      data = totalEm,
      color = name, 
      facets = . ~ name) + 
        theme(axis.text.x=element_text(angle=90)) +
        geom_smooth(method="lm", se=FALSE) 