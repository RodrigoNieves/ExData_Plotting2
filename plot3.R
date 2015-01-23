library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510",]
png("plot3.png")
NEIgrouped <- group_by(NEI,year,type)
NEISummary <- summarize(NEIgrouped,totalEmission = sum(Emissions))
p <- qplot(year, totalEmission,data = NEISummary,facets = .~type, geom=c("line"))
p <- p+ggtitle("Total PM2.5 emission in Baltimore City from 1999-2008")
p <- p+ylab("Total emission (tons)")
print(p) 
dev.off()
