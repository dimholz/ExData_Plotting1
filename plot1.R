################################################
############## Code for Plot 1 #################
################################################

library(readr)
library(plyr)
library(dplyr)
library(ggplot2)

#read in the data file, subsetting on the fly
#nrow = 2880 = 60 minutes * 24 hours * 2 days
hpc <- read.table('household_power_consumption.txt',
                   sep = ';',
                   skip = grep('1/2/2007', readLines('household_power_consumption.txt'))[1],
                   nrows = 2880,
                   na.strings = '?',
                   col.names = c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity','Sub_metering_1','Sub_metering_2','Sub_metering_3'))

#reformat date and time columns
hpc$Date <- hpc$Date %>%
  as.Date(format = '%d/%m/%Y')
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time, sep = ' '),
                         '%Y-%m-%d %T')

#plot1
png(file = 'plot1.png', width = 480, height = 480)
with(hpc, hist(Global_active_power,
               col = 'red',
               xlab = 'Global Active Power (kilowatts)',
               main = 'Global Active Power'))
dev.off()


