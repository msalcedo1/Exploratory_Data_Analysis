NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

#First check for matching with "combustion" related records from Level.One
SCCcombustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)

#Then check for matching with "coal" related records from Level.Four
SCCcoal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)

#Finally combine the two vectors to find the matches for both words:
SCCcoalCombustion <- (SCCcombustion & SCCcoal)

#Using previous vectors, I subset the NEI and SCC files:
combustionSCC <- SCC[SCCcoalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

#Plot
NEI4 <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
      geom_bar(stat="identity",fill="grey",width=0.75) +
      theme_bw() +  guides(fill=FALSE) +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
      labs(title=expression("PM"[2.5]*" Coal combustion-related Emissions Across US from 1999-2008"))

print(NEI4)

## Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()