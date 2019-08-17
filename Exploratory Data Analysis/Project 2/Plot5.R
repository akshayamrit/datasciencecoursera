# Plot 5


## Extract SCC number from table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
vehicleSCC <- SCC %>% filter(grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))
vehicleSCC <- unique(vehicleSCC$SCC)

## Create table with data which will be required to plot the graph
NEI.vehicle.balt <- NEI %>% filter(fips == "24510", SCC %in% vehicleSCC)
NEI.vehicle.balt <- NEI.vehicle.balt %>% group_by(year) %>% summarize(median = median(Emissions), total = sum(Emissions))

## Plot the graph
par(mfcol = c(2,1), mar = c(4,4,1,1))
with(NEI.vehicle.balt, plot(year, total, xlab = "Year", ylab = "Total pm2.5", pch = 20,  col = "blue", cex = 2))
title(main = "Emissions from motor vehicle sources in Baltimore")
with(NEI.vehicle.balt, plot(year, median, xlab = "Year", ylab = "Median pm2.5", pch = 18,  col = "blue", cex = 2))

## Copying created plot to png file
dev.copy(device = png, filename = "Plot5.png")
dev.off()
