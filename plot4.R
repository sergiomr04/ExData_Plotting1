library(data.table)

filename <- "exdata_data_household_power_consumption.zip"
# Checking if archieve already exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method="curl")
}

# Checking if folder exists
if (!file.exists("household_power_consumption.txt")) { 
    unzip(filename) 
}
#read data
full_data<-data.table::fread("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")
data1 <- subset(full_data, full_data$Date %in% c("1/2/2007","2/2/2007"))
date_time<-strptime(paste(data1$Date, data1$Time), "%d/%m/%Y%H:%M:%S")
#open the device
png("plot4.png", width=480, height=480)

#to fix the space for 4 plots 2 columns and two rows
par(mfrow = c(2, 2),mar=c(4, 4, 2, 1))

plot(x = date_time, y = data1$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

plot(x = date_time, y = data1$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

#bty remove the box of legend and we can use cex to reduce the font number of legend such as cex=0.6
#try it
plot(x = date_time, y = data1$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")
lines(x = date_time, y = data1$Sub_metering_2,col='Red')
lines(x = date_time, y = data1$Sub_metering_3,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty = "n")

plot(x = date_time, y = data1$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

#close the device
dev.off()
