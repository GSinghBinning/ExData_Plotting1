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
plot(data$DateandTime, data$Global_active_power, 
     type = "n", 
     ylab = "GLobal Active Power (kilowatts)", 
     xlab = "" )

with(data, lines(DateandTime, Global_active_power))

dev.copy(png, file ="plot2.png", width= 480, height = 480)

dev.off()