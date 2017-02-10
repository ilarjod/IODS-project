alc <- read.table("alc.txt")

colnames(alc)

#survey data from high school classes regarding studying and life in general. 
#data has been manipulated to focus on alcohol consumption

#I'll examine students' alcohol consumption habits with 4 other variables
#I choose address (Urban or Rural), famsize (bigger than 3 or not),
#Pstatus (parents living together or not) and
# Medu (mother's education level)

#i'd guess parents living apart and mother's low level of education 
#could be positively correlated with high alcohol consumption

#correlations with living area and familysize are hard to evaluate

# initialize a plot of high_use and G3
g1 <- ggplot(alc, aes(x = high_use, y = G3, col = sex))
g1
# define the plot as a boxplot and draw it
g1 + geom_boxplot() + ylab("grade") + xlab("high use of alcohol")

g2 <- ggplot(alc, aes(x = Medu, col = sex, fill = sex)) + geom_bar()
g2 

g3 <- ggplot(alc, aes(x = Pstatus, col = sex, fill = sex)) + geom_bar()
g3 

g4 <- ggplot(alc, aes(x = address, col = sex, fill = sex)) + geom_bar()
g4 

table(high_use = alc$high_use, address = alc$address)   %>% addmargins()  %>% prop.table()

table(high_use = alc$high_use, parents_living_together = alc$Pstatus) %>% prop.table() %>% addmargins()

table(high_use = alc$high_use, mothers_education_level = alc$Medu) %>% addmargins()  %>% prop.table()

table(high_use = alc$high_use, address = alc$famsize) %>% addmargins() %>% prop.table()


gather(alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()




