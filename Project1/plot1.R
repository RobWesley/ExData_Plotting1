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

# open file and plot histogram to file
png(file="plot1.png", width=480, height=480)
hist(dataOfInterest$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()