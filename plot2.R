library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510",]
png("plot2.png")
NEIgrouped <- group_by(NEI,year)
NEISummary <- summarize(NEIgrouped,totalEmission = sum(Emissions))
NEISummary$totalEmission <- NEISummary$totalEmission/1000
with(NEISummary,plot(year,totalEmission, 
                     xlab="Year", 
                     ylab = "Total emmision (in Kilo Tons)",
                     pch=16))
title("Total emission of PM2.5 from 1999-2008 in Baltimore City, Maryland")
lines(NEISummary$year,NEISummary$totalEmission)
dev.off()
