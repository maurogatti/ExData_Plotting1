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
                                          nrows=2075260,stringsAsFactors=FALSE,colClasses=columnClasses,
                                          na.strings=c("?"))
        
        #Select the data whose dates are between February 1st, 2007 and Feburary 2nd, 2007
        householdPowerDataSubset<-subset(householdPowerDataAll,
                                         strptime(householdPowerDataAll$Date,format="%d/%m/%Y")>=strptime("1/2/2007",format="%d/%m/%Y") &strptime(householdPowerDataAll$Date,format="%d/%m/%Y")<=strptime("2/2/2007",format="%d/%m/%Y"))
        #Plot the data (4h plot)
        par(mfrow=c(2,2))
        plot(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Global_active_power, 
             xlab="",ylab="Global Active Power",frame=TRUE,type="l",col="black",lwd=2)
        plot(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Voltage, 
             xlab="datetime",ylab="Voltage", type="l", col="black",lwd=2)
        #energy submetering plot block START
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
               col=c("black","red","blue"),lty=c(1,1,1),bty="n",cex=0.75)
        #energy submetering plot block END
        plot(strptime(paste(householdPowerDataSubset$Date,householdPowerDataSubset$Time),
                      format="%d/%m/%Y %H:%M:%s"),householdPowerDataSubset$Global_reactive_power, 
             xlab="datetime",ylab="Global_reactive_power",type="l", col="black",lwd=2)
}