source("loadData.R")

#Change language of time to put Thu, Fri, Sat... instead jue, vie, sat (spanish PC "language")
#this works in Windows 10.
Sys.setlocale("LC_TIME",locale = "English")
par(mfrow=c(1,1))

with(electricconsumptionF,plot(datetime,Sub_metering_1, type="l", ylab="Energy sub metering",col="black",xlab=""))
with(electricconsumptionF,points(datetime,Sub_metering_2, type="l",col="red"))
with(electricconsumptionF,points(datetime,Sub_metering_3, type="l",col="blue"))
legend("topright", lty=1,col=c("black","blue","red"), legend=names(electricconsumptionF)[grepl("Sub",names(electricconsumptionF))])

dev.copy(png, file ="plot3.png")
dev.off()
