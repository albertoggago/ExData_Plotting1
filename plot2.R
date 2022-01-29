source("loadData.R")

#Change language of time to put Thu, Fri, Sat... instead jue, vie, sat (spanish PC "language")
#this works in Windows 10.
Sys.setlocale("LC_TIME",locale = "English")
par(mfrow=c(1,1))

with(electricconsumptionF,plot(datetime,Global_active_power, type="l", ylab="Global Active Power (kilowatts)",xlab=""))

dev.copy(png, file ="plot2.png")
dev.off()
