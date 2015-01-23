library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- left_join(NEI,SCC,by="SCC")
png("plot4.png")
NEIcoal <- NEI[grep("coal",NEI$SCC.Level.Three,ignore.case = TRUE),]
NEIgrouped <- group_by(NEIcoal,year)
NEISummary <- summarize(NEIgrouped,totalEmission = sum(Emissions))
p <- qplot(year, totalEmission,data = NEISummary)
p <- p + geom_line()
p <- p+ggtitle("Total PM2.5 emission  from coal combustion-related from 1999-2008")
p <- p+ylab("Total emission (tons)")
print(p) 
dev.off()

