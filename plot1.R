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

## convert dates
## needed to subset the data to the two days we're interested in
dataTable[,"Date"] <- as.Date(dataTable[,"Date"], format="%d/%m/%Y")

## subset the data based on date
subset <- dataTable[
                dataTable$Date %in% as.Date(c("1/2/2007", "2/2/2007"), 
                format="%d/%m/%Y"),]

## set up the png image
png("plot1.png", width=480, height=480)

## draw histogram
hist(subset$Global_active_power, 
        col="red", 
        main="Global Active Power", 
        xlab="Global Active Power (kilowatts)")

## close the png image
dev.off()
