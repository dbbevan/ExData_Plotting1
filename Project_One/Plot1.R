# Project name: Plot1
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
  GAP.Data <- Study_Data_Two_Days$Global_active_power

# Investigate Qualities of GAP Data
  class(GAP.Data)
  str(GAP.Data)
  
# Discovered this gem on Stackoverflow - How to convert a factor to an integer\numeric without a loss of information
# as.numeric applied to a factor is meaningless, and may happen by implicit coercion. 
# To transform a factor f to approximately its original numeric values, as.numeric(levels(f))[f] is 
# recommended and slightly more efficient than as.numeric(as.character(f))
# ?factor - researched factor Warning ... Decided not to worry about supressing warning


  
# To coerce Factor Data Variables and maintain precision of values 
  GAP.Data <- as.numeric(levels(GAP.Data))[GAP.Data]

# Create Plot with appropriate adornation and send to screen
  hist(GAP.Data , xlab = 'Global Active Power (kilowatts)', breaks = c(13), main = "Global Active Power",col = "red") 

# Create Plot with appropriate adornation and send to PNG
  dev.copy(png,'plot1.png')
  hist(GAP.Data , xlab = 'Global Active Power (kilowatts)', breaks = c(13), main = "Global Active Power",col = "red") 
  dev.off()
  

  
  
  
