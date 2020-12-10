install.packages("gpclib", type="source")
install.packages("rgdal")
install.packages("mapproj")
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(maptools)
library(gpclib)
library(rgdal)
library(mapproj)

### Plot map colored by frequency of prevalence studies ###

visited <- read.csv("data/covered_countries_map.csv", header = T)
# determine how often a country was visited
ncountry <- as.data.frame(table(visited$ISO3))
colnames(ncountry)[1] <- "ISO3" 
# add frequency to visited
visited <- merge(visited, ncountry, by = "ISO3")
head(visited)

# load world data for plotting 
data(wrld_simpl)
pal <- colorRampPalette(brewer.pal(6, 'Greens'), 
                        bias = 10)(length(visited$Freq.y))
pal <- pal[with(visited, findInterval(Freq.y, sort(unique(Freq.y))))]
# define color for countries not in visited
countrycolor <- rep("darkgray", length(wrld_simpl@data$NAME))
# define colors for countries in visited
countrycolor[match(visited$Country, wrld_simpl@data$NAME)] <- pal

# plot map
plot(wrld_simpl, ylim=c(-40, 85), xlim = c(-180, 180),
     mar=c(0,0,0,0), bg="aliceblue", border = NA, 
     col=countrycolor)
# add points
points(visited$Longitude, visited$Latitude, col="red", pch=20, cex = .5)

# use the contry name instead of 3-letter ISO as id
gpclibPermit()
wrld_simpl@data$id <- wrld_simpl@data$NAME
wrld <- fortify(wrld_simpl, region="id")
# remove Antarctica from map
wrld <- subset(wrld, id != "Antarctica") 
# change column names of visited
colnames(visited) <- ifelse(colnames(visited) == "Country", 
                            "id", 
                            colnames(visited))
# combine visited and wrld
worlddata <- full_join(wrld, visited, by = "id")
# change NA to 0
worlddata$Freq.y <- ifelse(is.na(worlddata$Freq.y) == T, 0, worlddata$Freq.y)
# convert freq into factor
worlddata$Freq.y <- as.factor(worlddata$Freq.y)
# start plotting
palette <- colorRampPalette(brewer.pal(n=7, name='BuGn'))(7)

ggmapplot <- ggplot() + 
  geom_map(data=worlddata, map=worlddata, 
           aes(map_id=id, x=long, y=lat, 
               fill=Freq.y), color="gray70", size=0.25) + 
  geom_point(data = visited,
             aes(x = Longitude, y = Latitude), 
             col = "red", size = 1) +
  scale_fill_manual(values=c("white", palette),
                    name="Number of surveys") +
  coord_map() +
  labs(x="", y="") + 
  theme(plot.background = element_rect(fill = "transparent", colour = "transparent"),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "transparent", colour = "transparent"),
        panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "right")
ggmapplot
ggsave(filename="plots/Figure2.jpg", units="in", dpi=600, height=5, width=10, device="jpeg", scale=1)
dev.off()