library("dplyr") #used for filter function

# read in data
data <- data.frame(
    read.table(
        "household_power_consumption.txt",
        header=TRUE,
        sep =";",
        na.strings="?",
    )
)

# convert Date Column to date type and add a DateTime column
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(data$DateTime, format = "%Y-%m-%d %H:%M:%S")

# filter to only days of interest
dataOfInterest <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

with (dataOfInterest, {
# open file and plot histogram to file
png(file="plot4.png", width=480, height=480)
    #set up 2 x 2 plotting
    par(mfrow = c(2,2))
    plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")
    
    plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       lwd=c(2.5,2.5,2.5)) 
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime")
dev.off()
})
