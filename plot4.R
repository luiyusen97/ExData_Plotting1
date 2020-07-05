library(tidyverse)
library(lubridate)
# download and unzip files
if (!file.exists("rawdata//powerdata.zip")){
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "rawdata//powerdata.zip")
}
if (!file.exists("rawdata//powerdata//household_power_consumption.txt")){
    unzip(zipfile = "rawdata//powerdata.zip",
          exdir = "rawdata//powerdata")
}

# subset the required data. All data from 2 days, 01/02/2007 and 02/02/2007
powerdat <- read.table(file = "rawdata//powerdata//household_power_consumption.txt", header = TRUE,
                       sep = ";", na.strings = "?")
subset_dat <- powerdat[powerdat$Date %in% c("1/2/2007", "2/2/2007"), ]
# parse_date_time first creates a character from the input that can be converted into Date class
# as.Date then takes the tidied character value to convert to Date class
subset_dat[ , 1] <- as.Date(parse_date_time(subset_dat$Date, c("dmy")))

# open file
png(filename = "plot4.png")
# setting number of rows and columns of plots
# using mfcol means that the graphics device will start plotting from topleft then bottomleft then
# topright then bottomright
par(mfcol = c(2, 2))

# plot 2 first at the topleft corner
# plot a line graph. Line instead of position graphing is done with type argument
# suppress x-axis with xaxt argument
# create labels by first plotting with no extra arguments, then find the indices of the auto-calced ticks,
# then use those positions to manually set the positions of the 3 day ticks with at argument in axis function
plot(subset_dat$Global_active_power, xaxt = "n", type = "l", ylab = "Global Active Power", xlab = "")
axis(side = 1, at = c(0, 1500, 2900),
     labels = c("Thu", "Fri", "Sat")
)
# then plot 3 at the bottomleft corner
# plot with the meter with the largest range, suppress the plot and the x-axis ticks
# set the labels as well
plot(subset_dat$Sub_metering_1, xaxt = "n", type = "n",
     ylab = "Energy sub metering", xlab = "")
axis(side = 1, at = c(0, 1500, 2900),
     labels = c("Thu", "Fri", "Sat")
)
# plot the lines for each column one by one
lines(subset_dat$Sub_metering_1, col = "purple")
lines(subset_dat$Sub_metering_2, col = "red")
lines(subset_dat$Sub_metering_3, col = "blue")
# create a legend to explain the graph
# x is the position of the legend
# legend is the vector specifying what is to be written, this is positionally matched
# with col argument
# col argument is the colour of the lines/point characters to be explained
# lty and lwd specify the type and thickness of the lines to be explained in the 
# legend
# cex argument sets the size of the legend
# box.lty sets the type of border of the legend. blank means no border
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("purple", "red", "blue"), lty = "solid", lwd = 1, cex = 0.75, box.lty = "blank")

# voltage plot on the topright
plot(subset_dat$Voltage, xaxt = "n", type = "l", xlab = "datetime", ylab = "Voltage")
axis(side = 1, at = c(0, 1500, 2900),
     labels = c("Thu", "Fri", "Sat")
)

# Global_reactive_power plot at bottomright
plot(subset_dat$Global_reactive_power, xaxt = "n", yaxt = "n", type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")
axis(side = 1, at = c(0, 1500, 2900),
     labels = c("Thu", "Fri", "Sat")
)
axis(side = 2, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),
     labels = as.character(c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5)))
# close png graphics device
dev.off()