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
##   a PNG file, "plot4.png", with a width of 480 pixels 
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

## add datetime column using both Date and Time through POSIXct 
dated_power_consumption[,datetime:=as.POSIXct(paste(Date, Time))]

## convert columns Global_active_power, Global_reactive_power,
## Voltage, Sub_metering_1, Sub_metering_2 and Sub_metering_3 to numeric
dated_power_consumption[,Global_active_power:=as.numeric(Global_active_power)]
dated_power_consumption[,Global_reactive_power:=as.numeric(Global_reactive_power)]
dated_power_consumption[,Voltage:=as.numeric(Voltage)]
dated_power_consumption[,Sub_metering_1:=as.numeric(Sub_metering_1)]
dated_power_consumption[,Sub_metering_2:=as.numeric(Sub_metering_2)]
dated_power_consumption[,Sub_metering_3:=as.numeric(Sub_metering_3)]

## open a png file with a size of 480 x 480 pixels (default)
png(filename="plot4.png", bg = "transparent")

## drow the plot
## set a 2 x 2 plot
par(mfcol = c(2, 2))

with(dated_power_consumption, {
    ## top left
    plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
    
    ## bottom left
    plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
    lines(datetime, Sub_metering_1, col = "black")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright",  lwd = 2, bty = "n", col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    ## top right 
    plot(datetime, Voltage, type = "l")
    
    ## bottom left
    plot(datetime, Global_reactive_power, type = "l")
})

## close the graphics device
dev.off()
