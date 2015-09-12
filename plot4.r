# Plot4.r - Draw four graphs included in a 2-by-2 array

src_cleandata_filename <- file.path(".", "data", "household_power_consumption_scoped.txt")
if (!file.exists(src_cleandata_filename)) {
	source(file.path(".", "cleaning_scoping_data.r"))
}

# 1 - Load Data and convert columns in the good format
mydf <- read.csv(src_cleandata_filename, sep = ";", na.strings = "?")
mydf <- transform(mydf, Time = strptime(paste0(Date, " ", Time), format = "%d/%m/%Y %H:%M:%S"))
mydf <- transform(mydf, Date = as.Date(Date, format = "%d/%m/%Y"))

# 2.1 - Write next graph to a png file
png(
  filename = file.path(".", "plot4.png"),
  width = 480,
  height = 480
)

# 2.2 - Figures will be drawn in an 2-by-2 array on the device
par(mfrow = c(2, 2))
par(cex.axis = 0.9) # Initialize magnification to be used for axis annotation
par(cex.lab = 0.9)  # Initialize magnification to be used for x and y labels


# 2.2.1 - Graph1 - Draw a line graph of "Global_active_power" by "Time"
plot(
  x = mydf$Time,
  y = mydf$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# 2.2.2 - Graph2 - Draw a line graph of "Voltage" by "Time"
plot(
  x = mydf$Time,
  y = mydf$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)


# 2.2.3 - Graph3 - Draw the first graph line of "Sub_metering_1" by "Time"
plot(
  x = mydf$Time,							# The coordinates of points in the plot
  y = mydf$Sub_metering_1,                  # The y coordinates of points in the plot
  type = "l",                               # "l" for lines
  xlab = "",                                # Title on X-AXIS
  ylab = "Energy sub-metering",             # Title on Y-AXIS
  #pin = c(0.1, 0.1),                        # Size of the plotting in inch
  col = "black"
)

# 2.2.3.1 - Graph3 - Add to the graph a 2nd graph line of "Sub_metering_2" by "Time"
points(
  x = mydf$Time,							# The coordinates of points in the plot
  y = mydf$Sub_metering_2,                  # The y coordinates of points in the plot
  type = "l",                               # "l" for lines
  col = "red"
)

# 2.2.3.2 - Graph3 - Add to the graph a 3rd graph line of "Sub_metering_3" by "Time"
points(
  x = mydf$Time,							# The coordinates of points in the plot
  y = mydf$Sub_metering_3,                  # The y coordinates of points in the plot
  type = "l",                               # "l" for lines
  col = "blue"
)

# 2.2.3.3 - Graph3 - Add to the graph a legend
legend(
  x = "topright",     # Draw the legend on the top right of the legend
  bty = "n",          # No box around the legend
  cex = 0.9,          # 
  legend = c(
    "Sub_metering_1",
	"Sub_metering_2",
	"Sub_metering_3"
  ),
  col = c(
	"black",
	"red",
	"blue"
  ),
  lty = "solid"       # Draw a line of the color specified beside the legend
)

# 2.2.4 - Graph4 - Draw a line graph of "Global_reactive_power" by "Time"
plot(
  x = mydf$Time,
  y = mydf$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

# 2.3 - Close png file device (current graphic device)
dev.off(which = dev.cur())
