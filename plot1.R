
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



## Drawing Plot 1
par(mfrow=c(1,1), mar=c(5,4,4,2))
with(sub_data, hist(Global_active_power, col="red", 
                    xlab = "Global Active Power(kilowatts)",
                    main = "Global Active Power"))



## Copy plot 1 to png file("plot1.png")
dev.copy(png, file=paste(fileDir,"plot1.png",sep="/"), width=480, height=480, units="px")
dev.off()
