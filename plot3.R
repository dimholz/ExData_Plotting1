################################################
############## Code for Plot 3 #################
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

#plot3
png(file = 'plot3.png', width = 480, height = 480)
with(hpc, {
  plot(datetime,
       Sub_metering_1,
       type = 'l',
       xlab = '',
       ylab = 'Energy sub metering')
  lines(datetime,
        Sub_metering_2,
        type = 'l',
        col = 'red')
  lines(datetime,
        Sub_metering_3,
        type = 'l',
        col = 'blue')
  legend('topright',
         c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
         lty = 1,
         col = c('black','red','blue'))
})
dev.off()


