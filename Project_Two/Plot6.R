setwd("G:/Projects/Coursera/Exploratory Class 4/ProjectTwo")

# Load Libraries Used
  library(plyr)
  require(plyr)
  library(ggplot2)
  library(grid)
  library(gridExtra)

## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Add a column blank NEI called FuelType
  NEI$FuelType <- "aaaa"

# Add Fuel Labels EI.Sector to new FuelType Column in NEI
  NEI$FuelType <- SCC$EI.Sector[match(NEI$SCC, SCC$SCC)]

# Subsetting Baltimore and LA Data
  NEI.Baltimore <- NEI[which(NEI$fips == "24510"), ]
  NEI.LA <- NEI[which(NEI$fips == "06037"), ]

# Extract Baltimore Motor Vechicle Emissions
  MotorEmissions.Baltimore = NEI.Baltimore[grep("Mobile - On-Road", NEI.Baltimore$FuelType),]

# Extract LA Motor Vechicle Emissions
  MotorEmissions.LA = NEI.LA[grep("Mobile - On-Road", NEI.LA$FuelType),]

# Total Motor Vehicle Baltimore and LA
  TotalMotorEmissions.Baltimore <- with(data = MotorEmissions.Baltimore, expr = aggregate(Emissions, by = list(year), FUN = sum))
  colnames(TotalMotorEmissions.Baltimore) <- c("year", "Emissions")
  
  TotalMotorEmissions.LA <- with(data = MotorEmissions.LA, expr = aggregate(Emissions, by = list(year), FUN = sum))
  colnames(TotalMotorEmissions.LA) <- c("year", "Emissions")


# Plot Motor Vehicle Baltimore and LA Emissions to Screen
  p1 <- ggplot(TotalMotorEmissions.Baltimore, aes(x=year, y=Emissions)) +  ylim(c(0,4800)) +  stat_smooth(method='glm', size = 1, alpha = .5, fullrange = TRUE) +
    geom_point(color = "orange") + geom_line(color = "orange") + labs(x = "Year") + labs(y = "Total Emissions (tons), PM 2.5") + labs(title = "Baltimore, MD")
  
  p2 <- ggplot(TotalMotorEmissions.LA, aes(x=year, y=Emissions)) +  ylim(c(0,4800))  + stat_smooth(method='glm', size = 1, alpha = .5, fullrange = TRUE) +
    geom_point(color = "blue") + geom_line(color = "blue") + labs(x = "Year") + labs(y = "Total Emissions (tons), PM 2.5") + labs(title = "Los Angeles, CA")
  
  grid.newpage()
  pushViewport(viewport(layout=grid.layout(3, 2, heights = unit(c(1,8,4), "null"))))
  grid.text("Total Motor Vehicle Emissions", vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
  print(p1, vp=viewport(layout.pos.row=2, layout.pos.col=1))
  print(p2, vp=viewport(layout.pos.row=2, layout.pos.col=2 ))
  print(NULL, vp=viewport(layout.pos.row=1, layout.pos.col=1:2))


# Create Plot with appropriate adornation and send to PNG
  png(filename = "plot6.png", width=480, height=480, units = "px")

  p1 <- ggplot(TotalMotorEmissions.Baltimore, aes(x=year, y=Emissions)) +  ylim(c(0,4800)) +  stat_smooth(method='glm', size = 1, alpha = .5, fullrange = TRUE) +
    geom_point(color = "orange") + geom_line(color = "orange") + labs(x = "Year") + labs(y = "Total Emissions (tons), PM 2.5") + labs(title = "Baltimore, MD")
  
  p2 <- ggplot(TotalMotorEmissions.LA, aes(x=year, y=Emissions)) +  ylim(c(0,4800))  + stat_smooth(method='glm', size = 1, alpha = .5, fullrange = TRUE) +
    geom_point(color = "blue") + geom_line(color = "blue") + labs(x = "Year") + labs(y = "Total Emissions (tons), PM 2.5") + labs(title = "Los Angeles, CA")
  
  grid.newpage()
  pushViewport(viewport(layout=grid.layout(3, 2, heights = unit(c(1,10,4), "null"))))
  grid.text("Total Motor Vehicle Emissions", check.overlap = TRUE,vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
  print(p1, vp=viewport(layout.pos.row=2, layout.pos.col=1))
  print(p2, vp=viewport(layout.pos.row=2, layout.pos.col=2 ))
  print(NULL, vp=viewport(layout.pos.row=1, layout.pos.col=1:2))
  

dev.off()

