library(dplyr)
library(ggplot2)
library(ggrepel)

# reading downloaded file from EPA National Emissions Inventory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## NEI for Baltimore
NEI_24510 <- subset(NEI, fips=="24510")
NEI.24510.type <- NEI_24510 %>% 
      group_by(type, year) %>% 
      summarise(Emissions=sum(Emissions))


p1 <- ggplot(NEI.24510.type,aes(x=year, y=Emissions, color=type))+
      geom_line()
p1 + geom_text_repel(aes(label = round(NEI.24510.type$Emissions,2)), size = 3)
ggsave("plot3.png", width = 5, height = 4)