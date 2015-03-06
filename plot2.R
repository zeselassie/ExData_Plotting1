## This assignment uses data from the UC Irvine Machine Learning Repository,
## a popular repository for machine learning datasets. 
## In particular,
## “Individual household electric power consumption Data Set” 
## which is made available on the course web site:
## https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

## Dataset: Electric power consumption [20Mb]

## Description: Measurements of electric power consumption in 
## one household with a one-minute sampling rate over a period of 
## almost 4 years. 
## Different electrical quantities and some 
## sub-metering values are available.

## The following descriptions of the 9 variables in the 
## dataset are taken from the UCI web site:

## This R spript 
##   will load the dataset 
##   subset data from the dates 2007-02-01 and 2007-02-02
##   construct "Global Active Power" vs Time plot and save it to 
##   a PNG file, "plot2.png", with a width of 480 pixels 
##   and a height of 480 pixels.

## Load "data.table" package
library(data.table)

## read "household_power_consumption.txt" from current working directory
## into a data.table
household_power_consumption <- fread("household_power_consumption.txt",
                                     colClasses="character",
                                     na.strings="?")

## convert column "Date" to Date class
household_power_consumption[,Date:=as.Date(Date,"%d/%m/%Y")]

## set the period to be selected in a variable "period"
#period = c(as.Date("2007-02-01"), as.Date("2007-02-02"))
period = c(as.Date("2007-02-01"), 
           as.Date("2007-02-02"))

## subset the data table and select for data in between period[1]
## and period[2], inclusive and assign it to dated_power_consumption
dated_power_consumption <- household_power_consumption[Date %between% period]

## add Date_time column using both Date and Time through POSIXct 
dated_power_consumption[,Date_time:=as.POSIXct(paste(Date, Time))]

## convert column "Global_active_power" to numeric
dated_power_consumption[,Global_active_power:=as.numeric(Global_active_power)]

## open a png file with a size of 480 x 480 pixels (default)
png(filename="plot2.png", bg = "transparent")

## drow a plot "Global Active Power (kilowatts)" vs time
##   y-axis label: "Global Active Power (kilowatts)"
with(dated_power_consumption, plot(Date_time, Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     type = "l"))

## close the graphics device
dev.off()
