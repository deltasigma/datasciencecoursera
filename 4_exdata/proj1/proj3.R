library(ggplot2)

# Read data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore (fips == "24510")
baltimore <- NEI[NEI$fips == "24510", ]

# summarise the data by year
totalEm <- ddply(baltimore,c("year","type"),summarise, Emissions = sum(Emissions))

# Plot graphics with baltimore data
qplot(year,Emissions,
      data = totalEm,
      color = type, 
      facets = . ~ type) + 
        theme(axis.text.x=element_text(angle=90)) +
        geom_smooth(method="lm", se=FALSE) 