## check for data directory and create if necessary
if (!file.exists("data")) {
        dir.create("data")
}
## check for data file, if not found download and extract archive to data
## directory
dataFile = "data/household_power_consumption.txt"
if (!file.exists(dataFile)) {
        fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
        download.file(fileUrl, destfile="data/data.zip", method="curl")
        unzip("data/data.zip", exdir="data")
}

## read data into dataframe
dataTable <- read.table(
                dataFile, 
                sep=";", 
                header=TRUE, 
                na.strings="?", 
                stringsAsFactors=FALSE)

## create a combined date and time object
## will be used as the X-axis
dataTable$DateTime <- as.POSIXct(paste(dataTable$Date, dataTable$Time),
                        format="%d/%m/%Y %H:%M:%S")

## convert dates
## needed to subset the data to the two days we're interested in
dataTable[,"Date"] <- as.Date(dataTable[,"Date"], format="%d/%m/%Y")

## subset the data based on date
subset <- dataTable[
                dataTable$Date %in% as.Date(c("1/2/2007", "2/2/2007"), 
                format="%d/%m/%Y"),]

## set up the png image
png("plot3.png", width=480, height=480)

## start the plot
plot(subset$DateTime, 
     subset$Sub_metering_1, 
     type="n",
     xlab="",
     ylab="Energy sub metering") 

## add lines
lines(subset$DateTime, 
      subset$Sub_metering_1, 
      type="l", 
      col="black")
lines(subset$DateTime, 
      subset$Sub_metering_2, 
      type="l", 
      col="red")
lines(subset$DateTime, 
      subset$Sub_metering_3, 
      type="l", 
      col="blue")

## add legend
legend("topright",
       pch="—",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## close the png image
dev.off()
