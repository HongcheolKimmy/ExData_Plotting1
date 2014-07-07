
## Check whether the file already exists.

if(!file.exists("./exploratory/project1/household_power_consumption.txt")){
        
        ##Download file and unzip it
        if(!file.exists("./exploratory/project1")){dir.create("./exploratory/project1")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, "./exploratory/project1/dataset.zip")
        unzip(zipfile="./exploratory/project1/dataset.zip", exdir="./exploratory/project1")
        
        ## Loading the data
        fileDir <- "./exploratory/project1"
        my_data <- read.table(paste(fileDir,"household_power_consumption.txt",sep="/"), header=T, sep=";", stringsAsFactors=FALSE)       
        
        ## and make a subset table only with date= 1/2/2007, 2/2/2007
        sub_data <- with(my_data, subset(my_data, Date=="1/2/2007" | Date=="2/2/2007")) ##Subsetting
        sub_data$Date <- with(sub_data, paste(Date, Time, sep=",")) ## Combine Date and Time
        sub_data$Date <- strptime(sub_data$Date, "%d/%m/%Y, %X") ## Transform the format 
        sub_data <- sub_data[-2] ## Remove Time Value 
        for(i in 2:8){
                sub_data[[i]] <- as.numeric(sub_data[[i]])
        }
}

## Note : As I live in Korea, some values are coming up automatically in Korean.
## That's why the x-axis(weekdays) of four graphs here are also written in Korean.
## But I am sure if you read this code in your country, you will get it by yours.

##Drawing Plot 4
par(mfrow=c(2,2), mar=c(5,4,4,2))

##Plot(up,left)
with(sub_data, plot(Date, Global_active_power, type="l",
                    xlab="",
                    ylab="Global Active Power"))

##Plot(up,right)
with(sub_data, plot(Date, Voltage, type="l",
                    xlab="datetime",
                    ylab="Voltage"))

##Plot(down,left)
with(sub_data, plot(Date, Sub_metering_1, type="l", col="black",
                    xlab="", ylab="Energy sub metering"))
with(sub_data, points(Date, Sub_metering_2, type="l", col="red"))
with(sub_data, points(Date, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, bty="n", cex=0.7, y.intersp=0.5, inset=c(0.1,-0.05),
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Plot(down,right)
with(sub_data, plot(Date, Global_reactive_power, type="l",
                    xlab="datetime"))



## Copy plot 4 to png file("plot4.png")
dev.copy(png, file=paste(fileDir,"plot4.png",sep="/"), width=480, height=480, units="px")
dev.off()