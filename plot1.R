#plot1.png
##############################################################################################################
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File <- "epc.zip"
epcFile <- "epc.txt"
##
if (!file.exists(epcFile)) {
        download.file(URL, File)
        unzip(File, overwrite = T)
}

#Read tidy
epc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#Time Correction
epc <- epc[epc$Date %in% c("1/2/2007","2/2/2007"),]
fxTime <-strptime(paste(epc$Date, epc$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
epc <- cbind(fxTime, epc)

###############################################################################################################

## histogram
hist(epc$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

###############################################################################################################

## Save file W480, H480 png
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()