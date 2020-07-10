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
#read the document with fread function is faster that read.table
full_data<-data.table::fread("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")
#data_dates<-subset(full_data,full_data$Date=="1/2/2007"|full_data$Date=="2/2/2007")
data1 <- subset(full_data, full_data$Date %in% c("1/2/2007","2/2/2007"))
#open device 
png("plot2.png", width=480, height=480)
#create acolumn (list) changuing a character vector to POSIXct/POSIXlt
#data1$timef<-strptime(paste(data1$Date, data1$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
# if we don't specify the sep, we changue the format "%d/%m/%Y %H:%M:%S"
#with data.table we can't use data1$timedate to add a column cause it generate a list
date_time<-strptime(paste(data1$Date, data1$Time), "%d/%m/%Y%H:%M:%S")
# it create an error 
#data1$td<-data1_timef
plot(x = date_time, y = data1$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
#close device
dev.off()