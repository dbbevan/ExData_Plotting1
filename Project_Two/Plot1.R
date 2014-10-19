setwd("G:/Projects/Coursera/Exploratory Class 4/ProjectTwo")

## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Summerize Emissions
  TotalEmissions <- with(data = NEI, expr = aggregate(Emissions, by = list(year), FUN = sum))

# Create Plot with appropriate adornation and send to Screen
  Plot Emissions
  opar <- par(lwd=1)
  plot(TotalEmissions, type = "b", pch = 23, col = "orange", ylab = "Emissions Summary" , xlab = "Year", main = "Total U.S. Emissions [Observed: 1999, 2002, 2005, 2008]")
  par(opar)
  text(TotalEmissions$Group.1,TotalEmissions$x,TotalEmissions$Group.1, cex=1, pos=4.9, col="red") 

#Results show declining total PM2.5 emissions from all sources for each of the sampled years 1999, 2002, 2005, and 2008

# Create Plot with appropriate adornation and send to PNG
  png(filename = "plot1.png", width=580, height=480, units = "px")
  opar <- par(lwd=1)
  plot(TotalEmissions, type = "b", pch = 23, col = "orange", ylab = "Emissions Summary" , xlab = "Year", main = "Total U.S. Emissions [Observed: 1999, 2002, 2005, 2008]")
  par(opar)
  text(TotalEmissions$Group.1,TotalEmissions$x,TotalEmissions$Group.1, cex=1, pos=4.9, col="red") 

dev.off()
