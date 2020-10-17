### Calculate mean, median, standard deviation of risks of bias across studies ###

data <- read.csv("data/overall_risk_descriptive.csv")
# Means
mean(data$Low)
mean(data$Unclear)
mean(data$High)
# Medians
median(data$Low)
median(data$Unclear)
median(data$High)
# Standard deviation
sd(data$Low)
sd(data$Unclear)
sd(data$High)
# High + Unclear
mean(data$High.Unclear)
median(data$High.Unclear)
sd(data$High.Unclear)

### Calculate mean, median, standard deviation and sum of no. tests across all studies ###

# Number of tests
tests <- c(185, 6904, 528, 742, 1319, 1075, 120620, 105651, 620, 10575, 2283, 509, 2812, 1842, 1366, 61075,
           311, 213, 878, 2766, 863, 3330, 505, 696, 917, 3658, 2138, 2640, 873, 24995, 5775, 3156, 6300,
           13111, 517, 2342)
mean(tests)
median(tests)
sd(tests)
sum(tests)