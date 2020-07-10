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

full_data<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")
#data_dates<-subset(full_data,full_data$Date=="1/2/2007"|full_data$Date=="2/2/2007")
#make a subset
data1 <- subset(full_data, full_data$Date %in% c("1/2/2007","2/2/2007"))
#open Device
png("plot1.png", width=480, height=480)
#plot the histogram
hist(data1$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
#close device
dev.off()