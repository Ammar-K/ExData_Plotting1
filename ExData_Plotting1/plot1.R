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


hist(power$Global_active_power,
     main="Global Active Power", 
     xlab="Global Active Power (Killowatts)",
     col="red")


dev.copy(png, file="plot1.png", 
         height=480, width=480)
dev.off()
