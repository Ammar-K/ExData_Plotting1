library(readr)
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", exdir = getwd())

power <- read_delim("household_power_consumption.txt", 
                    ";",
                    escape_double = FALSE,
                    col_types = cols(Date = col_date(format = "%d/%m/%Y"),
                                     Time = col_time(format = "%H:%M:%S")), 
                    trim_ws = TRUE)

power <- power %>% filter(Date >=  "2007-02-02" & Date <= "2007-02-03")


dateTime <- paste(power$Date, power$Time)
power$DateTime <- as.POSIXct(dateTime)


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(power, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="", cex=0.8)
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="", cex=0.8)
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()