# Plot 6


## Extract SCC number from table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
vehicleSCC <- SCC %>% filter(grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))
vehicleSCC <- unique(vehicleSCC$SCC)

## Create table with data which will be required to plot the graph
NEI.vehicle.balt <- NEI %>% filter(fips == "24510" | fips == "06037", SCC %in% vehicleSCC)
NEI.vehicle.balt <- NEI.vehicle.balt %>% group_by(fips, year) %>% summarize(median = median(Emissions), total = sum(Emissions))

## Plot the graph
library(ggplot2)
gtot <- ggplot(NEI.vehicle.balt, aes(year, total))
gmed <- ggplot(NEI.vehicle.balt, aes(year, median))
gtot1 <- gtot + geom_point(aes(color = fips)) + labs(title = "Emissions from motor vehicle sources in Los Angeles County vs Baltimore", x = "Year", y = "Total pm2.5")
gmed1 <- gmed + geom_point(aes(color = fips)) + labs(x = "Year", y = "Median pm2.5")
gridExtra::grid.arrange(gtot1, gmed1, nrow = 2)

## Copying created plot to png file
dev.copy(device = png, filename = "Plot6.png")
dev.off()
