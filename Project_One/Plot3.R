# Project name: Plot3
# Experiment Origin: Information Forked from Github [rdpeng/ExData_Plotting1]
# Data Provider: UC Irvine Machine Learning Repository
# DataSet of Interest: Individual household electric power consumption Data Set
# Unzipped Data into working directory

# Estimate Memory Usage
# Rule of Thumb: memory required = no. of column * no. of rows * 8 bytes/numeric
# MR = 9 * 2,075,259 * 8 
# MR = ~149MB

# Loaded File in Dataset
  HousePower <- read.csv2(file = "household_power_consumption.txt",header = TRUE)

# Simple Inspection of Data
  head(HousePower)
  tail(HousePower)
  
  HousePower$Datetime <- strptime(paste(HousePower$Date, HousePower$Time), "%d/%m/%Y %H:%M:%S")

# Subsetting - Simple Approach
  Day1 <- HousePower[HousePower$Date == '1/2/2007',]
  Day2 <- HousePower[HousePower$Date == '2/2/2007',]

# Subsetting - Saved individual Day Data to separate file for fun
  write.csv(Day1, "Day1.csv", quote = FALSE, row.names = FALSE)
  write.csv(Day2, "Day2.csv", quote = FALSE, row.names = FALSE)

# Combine Two Day Datasets into single experimental working set
  Study_Data_Two_Days <- rbind.data.frame(Day1,Day2)

# Saved Two Day Dataset to separate file for fun  
  write.csv(Study_Data_Two_Days, "Study_Data_Two_Days.csv", quote = FALSE, row.names = FALSE)

# Simple Inspection of Data - Verifying front of dataset contains Feb 1 data and Tail contains Feb 2 data
  head(Study_Data_Two_Days)
  tail(Study_Data_Two_Days)

# Extract Global Active Power (GAP Data)
  GAP.Data <- data.frame(Study_Data_Two_Days$Sub_metering_1,Study_Data_Two_Days$Sub_metering_2,Study_Data_Two_Days$Sub_metering_3, Study_Data_Two_Days$Datetime)
# Label Columns for simplicity
  names(GAP.Data) <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3", "Datetime")

# Investigate Qualities of GAP Data
#   head(GAP.Data)
#   tail(GAP.Data)
#   class(GAP.Data)
#   str(GAP.Data)

# To coerce Factor Data Variables and maintain precision of values 
  GAP.Data$Sub_metering_1 <- as.numeric(levels(GAP.Data$Sub_metering_1))[GAP.Data$Sub_metering_1]
  GAP.Data$Sub_metering_2 <- as.numeric(levels(GAP.Data$Sub_metering_2))[GAP.Data$Sub_metering_2]
  GAP.Data$Sub_metering_3 <- as.numeric(levels(GAP.Data$Sub_metering_3))[GAP.Data$Sub_metering_3]

# Create Plot with appropriate adornation and send to screen
  plot(GAP.Data$Datetime, GAP.Data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
  points(GAP.Data$Datetime, GAP.Data$Sub_metering_2, col="red", type = "l", xlab = "", ylab = "Energy Sub Metering")
  points(GAP.Data$Datetime, GAP.Data$Sub_metering_3, col="blue", type = "l", xlab = "", ylab = "Energy Sub Metering")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))


# Create Plot with appropriate adornation and send to PNG
  par(mfrow = c(1,1))
  dev.copy(png,'plot3.png')

  plot(GAP.Data$Datetime, GAP.Data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
  points(GAP.Data$Datetime, GAP.Data$Sub_metering_2, col="red", type = "l", xlab = "", ylab = "Energy Sub Metering")
  points(GAP.Data$Datetime, GAP.Data$Sub_metering_3, col="blue", type = "l", xlab = "", ylab = "Energy Sub Metering")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

  dev.off()




