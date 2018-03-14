NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

#First check for matching with "vehicle" related records from Level.Two
SCCvehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

#Using previous vectors, I subset the NEI and SCC files:
vehicleSCC <- SCC[SCCvehicle,]$SCC
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

#Next create a subset for each city:
vehicleBaltimoreNEI <- vehicleNEI[vehicleNEI$fips == 24510,]
vehicleBaltimoreNEI$city <- "Baltimore City"
vehicleLANEI <- vehicleNEI[vehicleNEI$fips=="06037",]
vehicleLANEI$city <- "Los Angeles County"

#Finally I bind both cities under a unique dataset
NEI6 <- rbind(vehicleBaltimoreNEI,vehicleLANEI)


#plot
plotNEI6 <- ggplot(NEI6, aes(x=factor(year), y=Emissions, fill=city)) +
            geom_bar(aes(fill=year),stat="identity") +
            facet_grid(scales="free", space="free", .~city) +
            guides(fill=FALSE) + theme_bw() +
            labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
            labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(plotNEI6)

## Save file and close device
dev.copy(png,"plot6.png", width=480, height=480)
dev.off()

