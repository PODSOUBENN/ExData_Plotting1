# Plot3.r - Draw 3 lines graph with a legend in a png file

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
  filename = file.path(".", "plot3.png"),
  width = 480,
  height = 480
)

# 2.2 - Draw the first graph line of "Sub_metering_1" by "Time"
plot(
  x = mydf$Time,							# The coordinates of points in the plot
  y = mydf$Sub_metering_1,                  # The y coordinates of points in the plot
  type = "l",                               # "l" for lines
  xlab = "",                                # Title on X-AXIS
  ylab = "Energy sub-metering",             # Title on Y-AXIS
  #pin = c(0.1, 0.1),                        # Size of the plotting in inch
  col = "black"
)

# 2.2.1 - Add to the graph a 2nd graph line of "Sub_metering_2" by "Time"
points(
  x = mydf$Time,							# The coordinates of points in the plot
  y = mydf$Sub_metering_2,                  # The y coordinates of points in the plot
  type = "l",                               # "l" for lines
  col = "red"
)

# 2.2.2 - Add to the graph a 3rd graph line of "Sub_metering_3" by "Time"
points(
  x = mydf$Time,							# The coordinates of points in the plot
  y = mydf$Sub_metering_3,                  # The y coordinates of points in the plot
  type = "l",                               # "l" for lines
  col = "blue"
)

# 2.2.3 - Add to the graph a legend
legend(
  x = "topright",
  cex = 0.75,
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
  lty = "solid"
)

# 2.3 - Close png file device (current graphic device)
dev.off(which = dev.cur())
