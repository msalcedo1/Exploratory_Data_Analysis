NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# First filter only fips="24510". Then, using aggregate to group by year the sum of Emissions:
NEIBaltimore <- NEI[NEI$fips=="24510",]
NEI2 <- aggregate(Emissions ~ year, NEIBaltimore,sum)


#Create plot. I used barplot to improve visualization
barplot(
      (NEI2$Emissions)/10^6, names.arg=NEI2$year, xlab="Year", ylab="PM2.5 Emissions (10^6 Tons)",
      main="Total PM2.5 Emissions From All Baltimore Sources"
)

## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()