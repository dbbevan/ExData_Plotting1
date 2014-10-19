setwd("G:/Projects/Coursera/Exploratory Class 4/ProjectTwo")

# Load Libraries Used
  library(plyr)
  require(plyr)
  library(ggplot2)
## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Add a column blank NEI called FuelType
  NEI$FuelType <- "NA"

# Add Fuel Labels EI.Sector to new FuelType Column in NEI
  NEI$FuelType <- SCC$EI.Sector[match(NEI$SCC, SCC$SCC)]

# Extract Coal Emissions - rows that only use Coal as Burning Fuel Type
  coal.emissions = NEI[grep("Coal", NEI$FuelType),]

# head(coal.scc)
# head(coal.emissions)

# Summarize the Emissions 
  TotalCoalEmissions <- with(data = coal.emissions, expr = aggregate(Emissions, by = list(year), FUN = sum))
  colnames(TotalCoalEmissions) <- c("year", "Emissions")

# Create Plot with appropriate adornation and send to Screen
  gp = ggplot(TotalCoalEmissions, aes(x=year, y=Emissions)) 
  gp + geom_point(color = "red") + geom_line(color = "orange") + labs(x = "Year") + 
    labs(y = "Total Emissions, PM 2.5") + labs(title = "Emissions from Coal Combustion in US")



# Create Plot with appropriate adornation and send to PNG
  png(filename = "plot4.png", width=580, height=480, units = "px")

  gp = ggplot(TotalCoalEmissions, aes(x=year, y=Emissions)) 
  gp + geom_point(color = "red") + geom_line(color = "orange") + labs(x = "Year") + 
  labs(y = "Total Emissions, PM 2.5") + labs(title = "Emissions from Coal Combustion in US")

dev.off()



