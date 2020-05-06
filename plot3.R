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

#create plot
plot(x= data$DateandTime, 
     y=  data$Sub_metering_1, 
     type = "n", 
     ylab = "Energy sub metering", 
     xlab = "" )

with(data, lines(DateandTime, Sub_metering_1))

with(data, lines(DateandTime, Sub_metering_2, col = "red"))

with(data, lines(DateandTime, Sub_metering_3, col = "blue"))

with(data, legend("topright", 
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  col=c("black","red","blue"), lty=1))

dev.copy(png, file ="plot3.png", width= 480, height = 480)

dev.off()