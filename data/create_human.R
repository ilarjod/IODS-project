library(tidyverse)

#read data to rstudio from web
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#check out the data
str(hd)
str(gii)
summary(hd)
summary(gii)

#rename columns
colnames(hd) <- c("HDI_rank", "country", "HDI", "life_exp", "edu_exp", "edu_mean", "GNI/capita", "GNIrank-HDIrank")

colnames(gii) <- c("GII_rank", "country", "GII", "mat_mort", "adol_br", "parl_rep", "edu_2nd_f", "edu_2nd_m", "lab_f", "lab_m")

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