library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
NEI <- left_join(NEI,SCC,by="SCC")
png("plot6.png")
NEImotor <- NEI[grep("vehicles",NEI$SCC.Level.Two,ignore.case = TRUE),]
NEImotor <- mutate(NEImotor, city = ifelse(fips=="24510", "Baltimore City","Los Angeles County"))
NEIgrouped <- group_by(NEImotor,year,city)
NEISummary <- summarize(NEIgrouped,totalEmission = sum(Emissions))

p <- qplot(year, totalEmission,data = NEISummary,color = city)
p <- p + geom_line()
p <- p+ggtitle("Total PM2.5 emissions from motor vehicle sources from 1999–2008 in Baltimore City and Los Angeles County")
p <- p+ylab("Total emission (tons)")
print(p) 
dev.off()

