## Scoping - Extract and construct a csv file containing only '2007­02­01' and '2007­02­02' dates
# !!! Not efficient but working

#Source data file
src_data_filename <- file.path(".", "data", "household_power_consumption.txt")
#Target data file
tgt_data_filename <- file.path(".", "data", "household_power_consumption_scoped.txt")

if (!file.exists(src_data_filename)) {
	stop("Please add 'data' folder in the current directory. 'household_power_consumption.txt' file have to be in it.")
}

# 1 - Load data file
print('Load data file... Get data to analysed and write it on disk. Wait a minute please')
mydf <- read.csv(src_data_filename, sep = ";", na.strings = "?")

# 2 - Filter data frame
mydf <- mydf[mydf$Date == '1/2/2007' | mydf$Date == '2/2/2007',]

# 3 - Write filtered data frame in a csv file
#   Lose trailing zero - Not important
write.table(mydf, file = tgt_data_filename, sep = ";", quote = FALSE, na = "?", row.names=FALSE, dec = ".")

# 4 - Clean memory
mydf <- NULL
src_data_filename <- NULL
tgt_data_filename <- NULL
