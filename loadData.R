packagesToLoad <- c("stringr","rstudioapi","dplyr")
install.packages(setdiff(packagesToLoad, rownames(installed.packages()))) 
library(stringr)
library(rstudioapi)
library(dplyr)

rm(list=ls())
setwd(paste0(head(str_split(getSourceEditorContext()$path,"/")[[1]],-1),collapse="/"))
getwd()

# Load files.
folder_data <- "data"
file_data <- "household_power_consumption.txt"
urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_zip <- "getdata_projectfiles_UCI HAR Dataset.zip"
dsFile <- "electricconsumptionF.rds"

#creation folder with data
if(!dir.exists(folder_data)) {
  dir.create(folder_data)
}
#Download zip from url
if (!file.exists(paste(folder_data,file_zip, sep = "/"))) {
  download.file(urlFile,paste(folder_data,file_zip, sep = "/"),method="curl")
}
# unzip Zip to txt file
if (!file.exists(paste(folder_data, file_data, sep = "/"))) {
  unzip(paste(folder_data,file_zip, sep = "/"),exdir=folder_data)
}
# creation of Data Set using txt file or load rds file if exit
if (file.exists(paste(folder_data,dsFile, sep = "/"))) {
  electricconsumptionF <- readRDS(paste(folder_data,dsFile, sep = "/")) 
} else {
  electricconsumption <- read.csv(paste(folder_data, file_data, sep = "/"),sep = ";")
  electricconsumption$datetime <- strptime(paste(electricconsumption$Date,electricconsumption$Time), format="%d/%m/%Y %H:%M:%S")
  columsToChange <- c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  electricconsumption <-electricconsumption %>% mutate_at(columsToChange, function(x) {as.numeric(x, na.rm=TRUE)}) 

  electricconsumptionF <- electricconsumption[electricconsumption$datetime >= as.POSIXct("2007-02-01") & 
                                              electricconsumption$datetime < as.POSIXct("2007-02-03") & 
                                              !is.na(electricconsumption$datetime),]

  electricconsumptionF[electricconsumptionF$datetime == max(electricconsumptionF$datetime),]
  electricconsumptionF[electricconsumptionF$datetime == min(electricconsumptionF$datetime),]
  saveRDS(electricconsumptionF,paste(folder_data,dsFile, sep = "/")) 
}
