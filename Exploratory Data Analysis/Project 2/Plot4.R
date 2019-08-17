# Plot 4


## Load Tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract SCC numbers from table
library(dplyr)
coaltable <- SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE),]
coalSCC <- unique(coaltable$SCC)

## Create table filtered using SCC numbers extracted.
coalNEI <- NEI %>% filter(SCC %in% coalSCC)

## Create table with data which will be required to plot the graph
coalNEI <- coalNEI %>% group_by(year) %>% summarize(median = median(Emissions), total = sum(Emissions))

## Plot the graph
par(mfcol = c(2,1), mar = c(4,4,1,1))
with(coalNEI, plot(year, total, xlab = "Year", ylab = "Total pm2.5", pch = 20,  col = "blue", cex = 2))
title(main = "Emissions from coal combustion-related sources")
with(coalNEI, plot(year, median, xlab = "Year", ylab = "Median pm2.5", pch = 18,  col = "blue", cex = 2))

## Copying created plot to png file
dev.copy(device = png, filename = "Plot4.png")
dev.off()
