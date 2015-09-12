# Plot2.r - Draw a line graph in a png file

## 1 - Scoping - Put in memory data containing only '2007­02­01' and '2007­02­02' dates
# !!! Not efficient but working - no dynamic reading filter
# !!! This block as been copied to each plotX.r script

# 1.1 - Control that the variable mydf in memory could be reused
mydf_ok <- FALSE
if(!is.null(mydf)) {
  mydf_class <- lapply(mydf, class)	
  mydf_ok <- (
      mydf_class$Date == "Date" &&
      all(mydf_class$Time == c("POSIXlt","POSIXt")) &&
	  mydf_class$Global_active_power == "numeric" &&
      mydf_class$Global_reactive_power == "numeric" &&
      mydf_class$Voltage == "numeric" &&
      mydf_class$Global_intensity == "numeric" &&
	  mydf_class$Sub_metering_1 == "numeric" &&
      mydf_class$Sub_metering_2 == "numeric" &&
      mydf_class$Sub_metering_3 == "numeric" && 
      nrow(mydf) == 2880
  )
  mydf_class <- NULL
}

# 1.2 - If mydf couldn't be reused, load it
if (!mydf_ok) {
  #Source data file
  src_data_filename <- file.path(".", "data", "household_power_consumption.txt")
  if (!file.exists(src_data_filename)) {
    stop("Please add 'data' folder in the current directory. 'household_power_consumption.txt' file have to be in it.")
  }

  print('Load data file... Get data to analysed and write it on disk. Wait a minute please')

  # 1.1 - Load data file
  mydf <- read.csv(src_data_filename, sep = ";", na.strings = "?")

  # 1.2 - Filter data frame
  mydf <- mydf[mydf$Date == '1/2/2007' | mydf$Date == '2/2/2007',]

  # 1.3 - Convert columns in the good format
  mydf <- transform(mydf, Time = strptime(paste0(Date, " ", Time), format = "%d/%m/%Y %H:%M:%S"))
  mydf <- transform(mydf, Date = as.Date(Date, format = "%d/%m/%Y"))
  
  src_data_filename <- NULL
}
mydf_ok <- NULL

# 2.1 - Write next graph to a png file
print('Print graph in plot2.png in current directory')
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
  ylab = "Global Active Power (kilowatts)"
)

# 2.3 - Close png file device (current graphic device)
dev.off(which = dev.cur())

#Keep mydf in memory
