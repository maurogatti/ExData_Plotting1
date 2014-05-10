#Check whether file exists and if not issue an error message
if(!file.exists("household_power_consumption.txt"))
{
        path<-getwd()
        stop(paste("File household_power_consumption.txt not found. Your current directory is: ",path))
}else{
        #Column types
        columnClasses<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
        
        #Load the data from file
        householdPowerDataAll<-read.table("household_power_consumption.txt",header=TRUE, sep=";", 
                                          nrows=2075260, stringsAsFactors=FALSE, colClasses=columnClasses,
                                          na.strings=c("?")) 
        
        #Select the data whose dates are between February 1st, 2007 and Feburary 2nd, 2007
        householdPowerDataSubset<-subset(householdPowerDataAll,
                                         strptime(householdPowerDataAll$Date,format="%d/%m/%Y")>=strptime("1/2/2007",format="%d/%m/%Y") &strptime(householdPowerDataAll$Date,format="%d/%m/%Y")<=strptime("2/2/2007",format="%d/%m/%Y"))
        
        #Plot the data (3rd plot)
        par(mfrow=c(1,1))
        plot(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Sub_metering_1, 
                type="l",xlab="",ylab="Energy submetering",col="black")
        points(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Sub_metering_2,
                type="l", col="red")
        points(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Sub_metering_3, 
               type="l", col="blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col=c("black","red","blue"),lty=c(1,1,1),bty="n")
}
        
        
