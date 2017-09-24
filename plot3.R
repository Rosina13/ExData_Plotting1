
#downloading and reading in data
setwd("F:/Coursera - Data Science/Course 4/week  1")
ifelse(file.exists("powerconsumption.zip"),
       print("file already downloaded"),
       download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="powerconsumption.zip")
)
ifelse(file.exists("household_power_consumption.txt"),
       print("file unzipped"),
       unzip("powerconsumption.zip")
)
data<- read.table("household_power_consumption.txt", header=TRUE, na.strings="?",sep=";")

#select data from 2007-02-01 and 2007-02-02
#convert data and time variables 
data$Date_time <- paste(data$Date,data$Time,sep="_")
data$Date_time <- strptime(data$Date_time, "%d/%m/%Y_%T")
#select data
data_select<-subset(data,data$Date_time>=as.POSIXct("2007-02-01 00:00:00") & data$Date_time<as.POSIXct("2007-02-03 00:00:00"))

#plot3: 
plot(data_select$Date_time,data_select$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(data_select$Date_time,data_select$Sub_metering_1,col="black")
lines(data_select$Date_time,data_select$Sub_metering_2,col="red")
lines(data_select$Date_time,data_select$Sub_metering_3,col="blue")
legend("topright",pch="-", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 

#copy to png
dev.copy(png,file="plot3.png")
dev.off()