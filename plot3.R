library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510",]
NEI <- left_join(NEI,SCC,by="SCC")
NEI <- NEI[as.character(NEI$Data.Category) %in% c("Point","Onroad","Nonroad","Nonpoint"),]
png("plot3.png")
NEIgrouped <- group_by(NEI,year,Data.Category)
NEISummary <- summarize(NEIgrouped,totalEmission = sum(Emissions))
p <- qplot(year, totalEmission,data = NEISummary,facets = .~Data.Category, geom=c("line"))
p <- p+ggtitle("Total PM2.5 emission in Baltimore City from 1999-2008")
print(p) 
dev.off()

