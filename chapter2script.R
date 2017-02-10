library(dplyr)
library(ggplot2)
library(GGally)
lrn14 <- read.table("learning2014.txt")

# Some background and other variables are omitted from this version, 
#otherwise all 183 responses are included. There are no missing values.

# Let's see some visualizations of the data

pairs(lrn14[-1])

ggpairs(lrn14, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))


#linear model for 3 variables
model1 <- lm(points ~ age + attitude + stra, data = lrn14)
summary(model1)
par(mfrow = c(2,2))
plot(model1, which = c(1,2,5)) 

qplot(attitude, points, data = lrn14) + geom_smooth(method = "lm")
qplot(age, points, data = lrn14) + geom_smooth(method = "lm")
qplot(stra, points, data = lrn14, color = gender) + geom_smooth(method = "lm")


