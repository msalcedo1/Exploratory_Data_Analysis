NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# First filter only fips="24510". Then, using aggregate to group by year the sum of Emissions:
NEIBaltimore <- NEI[NEI$fips=="24510",]

#First check for matching with "vehicle" related records from Level.Two
SCCvehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

#Using previous vectors, I subset the NEI and SCC files:
vehicleSCC <- SCC[SCCvehicle,]$SCC
vehicleNEI <- NEIBaltimore[NEIBaltimore$SCC %in% vehicleSCC,]

#Plot
NEI5 <- ggplot(vehicleNEI,aes(factor(year),Emissions)) +
      geom_bar(stat="identity",fill="grey",width=0.75) +
      theme_bw() +  guides(fill=FALSE) +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
      labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(NEI5)

## Save file and close device
dev.copy(png,"plot5.png", width=480, height=480)
dev.off()