#pull data in and create headers
dataset <- read.table("household_power_consumption.txt",
                      header = TRUE, sep = ";", na.strings = "?",
                      colClasses = c('character', 'character', 'numeric',
                                     'numeric', 'numeric', 'numeric',
                                     'numeric', 'numeric', 'numeric'))
#check the data
head(dataset)

#sort out the dates
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

#filter dates to first and second of feb
dataset <- subset(dataset, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#want to remove the incompletes
dataset <- dataset[complete.cases(dataset),]

#check the data
head(dataset)

#got to get a proper date time column so lets combine
dateTime <- paste(dataset$Date, dataset$Time)

#lets set a new name
dateTime <- setNames(dateTime, "DateTime")

#remove the original date and time columns
dataset <- dataset[ ,!(names(dataset)%in% c("Date", "Time"))]

#add the new date time column using cbind
dataset <- cbind(dateTime, dataset)

#format the date time column properly
dataset$dateTime <- as.POSIXct(dateTime)

#check the data
head(dataset)
