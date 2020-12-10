install.packages("vistime")
install.packages("orca")
library(vistime)
library(plotly)
library(orca)
library(scales)
Sys.setlocale("LC_TIME", "C")

### Plot timeline of population-based prevalence surveys until September 5 ###

data <- read.csv("data/timeline.csv", header=T)
data$start <- as.POSIXct(strptime(data$start, "%Y-%m-%d"), tz = "GMT")
data$end <- as.POSIXct(strptime(data$end, "%Y-%m-%d"), tz = "GMT")
timeline <- gg_vistime(data)
timeline
timeline + scale_x_datetime(date_breaks = "1 month", date_labels = "%b %Y") + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor.y  = element_blank(), panel.grid.minor = element_blank()) 
ggsave(filename="plots/Figure31.jpg", units="in", dpi=600, height=5, width=8.75, device="jpeg", scale=1)
dev.off()