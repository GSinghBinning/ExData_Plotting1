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

#create plot
with(data, hist(Global_active_power, col = "red", 
                main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)"))

dev.copy(png, file ="plot1.png", width= 480, height = 480)

dev.off()