# Plot2.r - Draw a line graph in a png file

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
  filename = file.path(".", "plot2.png"),
  width = 480,
  height = 480
)

# 2.2 - Draw a line graph of "Global_active_power" by "Time"
plot(
  x = mydf$Time,
  y = mydf$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)",
  pin = c(0.1, 0.1)
)

# 2.3 - Close png file device (current graphic device)
dev.off(which = dev.cur())
