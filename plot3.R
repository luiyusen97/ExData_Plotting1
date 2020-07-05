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
subset_dat[ , 1] <- as.Date(parse_date_time(subset_dat$Date, c("dmy")))

png(filename = "plot3.png")
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
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("purple", "red", "blue"), lty = "solid", lwd = 1)
dev.off()