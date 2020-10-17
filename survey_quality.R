install.packages("devtools")
devtools::install_github("mcguinlu/robvis")
library(robvis)

### Plot trafficlight plot of the domain-level judgements for each individual study ###

# Generate here
jbi <- read.csv("data/survey_quality.csv")
trafficlight <- rob_traffic_light(data = jbi, tool = "Generic")
trafficlight
rob_save(trafficlight, "plots/Appendix2_Figure.jpeg")

### Plot summary of each domain across studies ###

# Generate in the Shiny app (customize "no information")
summary <- rob_summary(data = jbi, tool = "Generic", weighted=FALSE, overall=TRUE)
summary
rob_save(summary, "plots/Figure4.jpeg")
dev.off()