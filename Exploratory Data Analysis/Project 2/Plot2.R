# Plot 2


## Load Tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract Total pm25 from table
library(dplyr)
mlndpm25 <- subset(NEI, fips == "24510")
mlndpm25 <- mlndpm25 %>% group_by(year) %>% summarize(total = sum(Emissions))

## Plot graph using base plotting system
with(mlndpm25, plot(year, total, xlab = "Year", ylab = "pm2.5 Total", pch = 20, col = "blue", cex = 2))
title(main = "Total pm2.5 for Baltimore vs Year")
lines(mlndpm25$year, mlndpm25$total, lty = 2, lwd = 2, col = "blue")

## Copying created plot to png file
dev.copy(device = png, filename = 'Plot2.png')
dev.off()