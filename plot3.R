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
##   construct of Sub_metering_1, Sub_metering_2 and Sub_metering_3
##   in one plot using different colors( black, red and blue)
##   a PNG file, "plot3.png", with a width of 480 pixels 
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

## convert columns Sub_metering_1, Sub_metering_2, and 
## Sub_metering_3 to numeric
dated_power_consumption[,Sub_metering_1:=as.numeric(Sub_metering_1)]
dated_power_consumption[,Sub_metering_2:=as.numeric(Sub_metering_2)]
dated_power_consumption[,Sub_metering_3:=as.numeric(Sub_metering_3)]
## open a png file with a size of 480 x 480 pixels (default)
png(filename="plot3.png", bg = "transparent")

## drow the plot
with(dated_power_consumption, plot(Date_time, Sub_metering_1,
                                   ylab = "Energy sub metering",
                                   xlab = "",
                                   type = "n"))
with(dated_power_consumption, lines(Date_time, Sub_metering_1, col = "black"))
with(dated_power_consumption, lines(Date_time, Sub_metering_2, col = "red"))
with(dated_power_consumption, lines(Date_time, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"),
       lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## close the graphics device
dev.off()
