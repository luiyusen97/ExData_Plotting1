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
powerdat[ , 1] <- apply(powerdat[ , 1, drop = F], 2, function(x){
    gsub(pattern = "/", replacement = "", x = x)
})
powerdat[ , 1] <- apply(powerdat[ , 1, drop = F], 2, function(x){
    as.numeric(x)
})
subset_dat <- subset(powerdat, Date == 01022007|Date == 02022007)

# open png file and export a histogram of Global Active Power
png(filename = "plot1.png", width = 480, height = 480)
hist(subset_dat$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red",
     main = "Global Active Power")
dev.off()