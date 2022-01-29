source("loadData.R")

par(mfrow=c(1,1))

hist(electricconsumptionF$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.copy(png, file ="plot1.png")
dev.off()