
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



##Drawing Plot 3
par(mfrow=c(1,1), mar=c(5,4,4,2))
with(sub_data, plot(Date, Sub_metering_1, type="l", col="black",
                    xlab="",
                    ylab="Energy sub metering"))
with(sub_data, points(Date, Sub_metering_2, type="l", col="red"))
with(sub_data, points(Date, Sub_metering_3, type="l", col="blue"))
## As the legend of the exporting image file doesn't look good, here I came up
## with different solution, which is drawing legend twice. At the first legend
## it draws only the box, and from the second legend function put all contents.
legend("topright", cex=1.2, legend="                      ")
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       y.intersp=0.7, cex=0.7, inset=c(0.05,0), bty="n")




## Copy plot 3 to png file("plot3.png")
dev.copy(png, file=paste(fileDir,"plot3.png",sep="/"), width=480, height=480, units="px")
dev.off()
