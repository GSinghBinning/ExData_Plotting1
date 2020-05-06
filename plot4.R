#reading in data
data <- read.table('./household_power_consumption.txt', 
                   header = FALSE, sep = ";",
                   skip = 66637, nrow = (48*60))
#adding headers
header <- read.table('./household_power_consumption.txt', 
                     header = FALSE, sep = ";",  nrow = 1)

colnames(data) <- unlist(header)

#create a column with Date and Time merged
data$DateandTime <- paste(data$Date, data$Time , sep = " ")

#delete old Date and Time columns
data <- data %>% select(DateandTime,  everything(), -c(Date, Time))

#convert character to Date
strptime(data$DateandTime, "%d/%m/%Y %H:%M:%S")

#changing parameters, so that 2x2 plots are on the graphic device and
#margins are like the example plot in the instructions
par(mfcol = c(2,2))
par(mar = c(4,4,3,2))

#upper left plot
plot(data$DateandTime, data$Global_active_power, 
     type = "n", 
     ylab = "GLobal Active Power ", 
     xlab = "" )

with(data, lines(DateandTime, Global_active_power))

# lower left plot
plot(x= data$DateandTime, 
     y=  data$Sub_metering_1, 
     type = "n", 
     ylab = "Energy sub metering", 
     xlab = "" )

with(data, lines(DateandTime, Sub_metering_1))

with(data, lines(DateandTime, Sub_metering_2, col = "red"))

with(data, lines(DateandTime, Sub_metering_3, col = "blue"))

with(data, legend("topright",  cex = 1,
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  col=c("black","red","blue"), lty=1,  bty = "n", y.intersp = 0.3))


#upper right plot
with(data, plot(DateandTime, Voltage, type = "n" , xlab = "datetime"))
with(data, lines(DateandTime, Voltage))

# lower right plot

with(data, plot(DateandTime, Global_reactive_power, 
                type = "n", xlab = "datetime"))
with(data, lines(DateandTime, Global_reactive_power))

#saving the png
dev.copy(png, "plot4.png", width= 480 , height = 480)
dev.off()