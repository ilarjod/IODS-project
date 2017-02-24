library(tidyverse)
library(dplyr)
library(stringr)
library(GGally)
#read data to rstudio from web
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#check out the data
str(hd)
str(gii)
summary(hd)
summary(gii)

#rename columns
colnames(hd) <- c("HDI_rank", "country", "HDI", "life_exp", "edu_exp", "edu_mean", "GNI.capita", "GNIrank-HDIrank")

colnames(gii) <- c("GII_rank", "country", "GII", "mat_mort", "adol_birth", "parl_rep_f", "edu_2nd_f", "edu_2nd_m", "lab_f", "lab_m")

#check the results
str(hd)
str(gii)

#create two new variables
gii <-  mutate(gii, edu_2nd_ratio = edu_2nd_f/edu_2nd_m)
gii <- mutate(gii, lab_ratio = lab_f / lab_m)
str(gii)

#combine datasets to a new dataset called "human"
human <-  inner_join(gii, hd, by="country")

#how does it look
str(human)

#save the data to file
write.table(human, "human.txt")

human <- mutate(human,GNI.capita=str_replace(human$GNI.capita, pattern=",", replace ="") %>% as.numeric())

keep <- c("country", "edu_2nd_ratio", "lab_ratio", "life_exp", "edu_exp", "GNI.capita", "mat_mort", "adol_birth", "parl_rep_f")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human)==TRUE)


last <- nrow(human_) - 7
last
# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$country

# remove the Country variable
human_ <- select(human_, -country)

write.table(human_, "human_.txt")

