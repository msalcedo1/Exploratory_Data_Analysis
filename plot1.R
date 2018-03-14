NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Using aggregate to group by year the sum of Emissions:
NEI1 <- aggregate(Emissions ~ year,NEI, sum)


#Create plot. I used barplot to improve visualization
barplot(
      (NEI1$Emissions)/10^6, names.arg=NEI1$year, xlab="Year", ylab="PM2.5 Emissions (10^6 Tons)",
      main="Total PM2.5 Emissions From All US Sources"
)

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()