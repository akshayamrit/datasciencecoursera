# Plot 1


## Load Tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract Total pm25 from table
library(dplyr)
totalpm25 <- NEI %>% group_by(year) %>% summarize(Total = sum(Emissions))

## Plot graph using base plotting system
with(totalpm25, plot(year, Total, xlab = "Year", ylab = "pm2.5 Total", pch = 20, col = "blue", cex = 2))
title(main = "Total pm2.5 vs Year")
lines(totalpm25$year, totalpm25$Total, lty = 2, lwd = 2, col = "blue")

## Copying created plot to png file
dev.copy(device = png, filename = 'Plot1.png')
dev.off()