library(reshape2)
library(dplyr)

#Reading in data
classes<-c("character","character",rep("numeric",7))
proj<-read.table("../data/household_power_consumption.txt",na.strings="?",colClasses=classes,nrows=100000,sep=";",header=TRUE)

#Filtering down to the desired dates
final<-filter(proj,grepl("^[12]/2/2007",proj$Date))

#Combining the Date and Time variables for plots 2-4
dateTime<-paste(final$Date,final$Time,sep=" ")
final<-cbind(final,dateTime)
final$dateTime<-as.POSIXlt(final$dateTime,format="%d/%m/%Y %H:%M:%S")

png(file="plot4.png")
par(mfrow=c(2,2))
with(final, {
    plot(dateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power")
    plot(dateTime,Voltage,type="l",xlab="datetime",ylab="Voltage")
    plot(dateTime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
    lines(dateTime,Sub_metering_2,col="red")
    lines(dateTime,Sub_metering_3,col="blue")
    legend("topright",col=c("black","blue","red"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
    plot(dateTime,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
})
dev.off()