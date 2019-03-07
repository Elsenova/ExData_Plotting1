#plot4.png
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

## four figures
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(epc, {
        plot(Global_active_power~fxTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~fxTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~fxTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~fxTime,col='Red')
        lines(Sub_metering_3~fxTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~fxTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

###############################################################################################################

## Save file W480, H480 png
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()