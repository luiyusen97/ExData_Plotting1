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

# plot a line graph. Line instead of position graphing is done with type argument
# suppress x-axis with xaxt argument
# create labels by first plotting with no extra arguments, then find the indices of the auto-calced ticks,
# then use those positions to manually set the positions of the 3 day ticks with at argument in axis function
png(filename = "plot2.png")
plot(subset_dat$Global_active_power, xaxt = "n", type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
axis(side = 1, at = c(0, 1500, 2900),
     labels = c("Thu", "Fri", "Sat")
)
dev.off()