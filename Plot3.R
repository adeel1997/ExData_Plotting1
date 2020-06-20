df <- read.table("household_power_consumption.txt",sep = ";",header = TRUE,na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
df$Date <- as.Date(df$Date,"%d/%m/%Y")
# Subsetting the data
str(df)
df1 <- subset(df, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

df1 <- df1[complete.cases(df1),]
## Combine Date and Time column
dateTime <- paste(df1$Date, df1$Time)
## Change the Name of the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
df1 <- df1[ ,!(names(df1) %in% c("Date","Time"))]

## Add DateTime column
df1 <- cbind(dateTime, df1)

## Format dateTime Column
df1$dateTime <- as.POSIXct(dateTime)

# Creating a plot 3
# Creating a plot 3

with(df1, {plot(Sub_metering_1~dateTime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue') })
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
)
dev.copy(png,"plot3.png",width=480, height=480)
dev.off()

