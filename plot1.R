library(tidyverse)
library(lubridate)
if (!file.exists("rawdata//powerdata.zip")){
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "rawdata//powerdata.zip")
}
if (!file.exists("rawdata//powerdata//household_power_consumption.txt")){
    unzip(zipfile = "rawdata//powerdata.zip",
          exdir = "rawdata//powerdata")
}
powerdat <- read.table(file = "rawdata//powerdata//household_power_consumption.txt", header = TRUE,
                       sep = ";", na.strings = "?")
powerdat[ , 1] <- apply(powerdat[ , 1, drop = F], 2, function(x){
    gsub(pattern = "/", replacement = "", x = x)
})
powerdat[ , 1] <- apply(powerdat[ , 1, drop = F], 2, function(x){
    as.numeric(x)
})
subset_dat <- subset(powerdat, Date == 01022007|Date == 02022007)
