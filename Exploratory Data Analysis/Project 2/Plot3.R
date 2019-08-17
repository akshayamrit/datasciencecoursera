# Plot 3


## Load Tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract Total pm25 from table
library(dplyr)
baltpm25 <- subset(NEI, fips == "24510")
baltpm25 <- baltpm25 %>% group_by(type, year) %>% summarize(total = sum(Emissions))

## Plot graph using ggplot2
library(ggplot2)
rng <- c(min(baltpm25$total), max(baltpm25$total)+500)
xrng <- range(baltpm25$year)
xrng[2] <- xrng[2] + 1
g <- ggplot(data = baltpm25, aes(year, total))
g + geom_point(aes(color = type)) + facet_grid(type~.) + geom_text(aes(label = total), hjust = 0, vjust = -0.2) + ylim(rng) + xlim(xrng)

## Copying created plot to png file
dev.copy(device = png, filename = 'Plot3.png')
dev.off()