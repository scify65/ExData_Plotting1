library(reshape2,dplyr)

#Reading in data
classes<-c("character","character",rep("numeric",7))
proj<-read.table("./household_power_consumption.txt",na.strings="?",colClasses=classes,nrows=100000,sep=";",header=TRUE)

#Filtering down to the desired dates
final<-filter(proj,grepl("^[12]/2/2007",proj$Date))

#Combining the Date and Time variables for plots 2-4
dateTime<-paste(final$Date,final$Time,sep=" ")
final<-cbind(final,dateTime)
final$dateTime<-as.POSIXlt(final$dateTime,format="%d/%m/%Y %H:%M:%S")

png(file="plot1.png")
hist(final$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",breaks=8)
dev.off()