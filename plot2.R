#Check whether file exists and if not issue an error message
if(!file.exists("household_power_consumption.txt"))
{
        path<-getwd()
        stop(paste("File household_power_consumption.txt not found. Your current directory is: ",path))
}else{
        #Column types
        columnClasses<-c("character","character","numeric","numeric","numeric","numeric",
                         "numeric","numeric","numeric")
        
        #Load the data from file
        householdPowerDataAll<-read.table("household_power_consumption.txt",header=TRUE, sep=";", 
                                          nrows=2075260,stringsAsFactors=FALSE, colClasses=columnClasses,
                                          na.strings=c("?")) 
        
        #Select the data whose dates are between February 1st, 2007 and Feburary 2nd, 2007
        householdPowerDataSubset<-subset(householdPowerDataAll,
                                         strptime(householdPowerDataAll$Date,format="%d/%m/%Y")>=strptime("1/2/2007",format="%d/%m/%Y") 
                                         &strptime(householdPowerDataAll$Date,format="%d/%m/%Y")<=strptime("2/2/2007",format="%d/%m/%Y"))
        
        #Plot the data (2nd plot)
        plot(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Global_active_power, 
             xlab="",ylab="Global Active Power (kilowatts)",frame=TRUE,type="l",lwd=2)
}
