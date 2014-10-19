setwd("G:/Projects/Coursera/Exploratory Class 4/ProjectTwo")

# Load Libraries Used
  require(plyr)
  library(plyr)
  library(ggplot2)

## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore Data
  NEI.Baltimore <- NEI[which(NEI$fips == "24510"), ]

# Summarize the Emissions for Baltimore on type per years
  totalemissionstype.baltimore <- ddply(NEI.Baltimore, c("type", "year"), .fun = summarize, Emissions = sum(Emissions))

# Build the plot layout and display on screen 
 p <- qplot(year,Emissions,  
      group = type, 
      data = totalemissionstype.baltimore, 
      geom = c("point","line"), 
      colour= type ,
      xlab="Year",
      ylab="Total Emissions [PM 2.5]",
      main="Total Pollution Emissions by Type in Baltimore Area")
p + labs(colour = "Type of Pollutant")
plot(p)


# Create Plot with appropriate adornation and send to PNG
png(filename = "plot3.png", width=580, height=480, units = "px")
p <- qplot(year,Emissions,  
           group = type, 
           data = totalemissionstype.baltimore, 
           geom = c("point","line"), 
           colour= type ,
           xlab="Year",
           ylab="Total Emissions [PM 2.5]",
           main="Total Pollution Emissions by Type in Baltimore Area")
p + labs(colour = "Type of Pollutant")
dev.off()


