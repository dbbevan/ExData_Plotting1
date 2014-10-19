setwd("G:/Projects/Coursera/Exploratory Class 4/ProjectTwo")

## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore Data
  NEI.Baltimore <- NEI[which(NEI$fips == "24510"), ]

# Summarize the Emissions for Baltimore on type per years
  totalemissions.baltimore <- with(data = NEI.Baltimore, expr = aggregate(Emissions, by = list(year), FUN=sum))
  colnames(totalemissions.baltimore) <- c("year", "Emissions")

# Plot Emissions results for Baltimore to Screen
  plot(totalemissions.baltimore$year, totalemissions.baltimore$Emissions, type = "b", 
  pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")

# Plot Emissions results for Baltimore to png
  png(filename = "plot2.png", width = 480, height = 480, units = "px")
  plot(totalemissions.baltimore$year, totalemissions.baltimore$Emissions, type = "b", 
  pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")
  dev.off()


