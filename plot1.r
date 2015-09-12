# Plot1.r - Draw an histogram in a png file

src_cleandata_filename <- file.path(".", "data", "household_power_consumption_scoped.txt")
if (!file.exists(src_cleandata_filename)) {
	source(file.path(".", "cleaning_scoping_data.r"))
}

# 1 - Load Data and convert columns in the good format
mydf <- read.csv(src_cleandata_filename, sep = ";", na.strings = "?")

# 2.1 - Write next graph to a png file
png(
  filename = file.path(".", "plot1.png"),
  width = 480,
  height = 480
)

# 2.2 - Draw an histogram of "count of Global_active_power values" by "Global_active_power values" 
hist(
  x = mydf$Global_active_power,
  col = "red",
  border = "black",
  main = "Global Active Power",
  xlim = range(mydf$Global_active_power),
  ylim = NULL,
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency",
  axes = TRUE
)

# 2.3 - Close png file device (current graphic device)
dev.off(which = dev.cur())
