restData <- read.csv('./data/restaurants.csv')
head(restData)

# creating sequences
s1 <- seq(1, 1, by=2)
s1

s2 <- seq(1, 10, length=3)
s2

x <- c(1, 3, 8, 25, 100)
seq(along=x)

# subsetting variables
restData$nearMe <- restData$neighborhood %in% c('Roland Park', 'Homeland')
table(restData$nearMe)

# binary variables
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# categorical variables
restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# easier cutting
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode,g=4)
table(restData$zipGroups)

# create factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# levels of factor vars
yesno <- sample(c('yes', 'no'), size=10, replace=T)
yesnofac <- factor(yesno, levels=c('yes', 'no'))
relevel(yesnofac,ref='yes')
as.numeric(yesnofac)

# cutting produces factor variables


# using mutate function
library(plyr)
restData2 <- mutate(restData, zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

# common transforms
x <- -1.233
abs(x)
sqrt(x)
ceiling(x)
floor(x)
round(x, digits=2)
signif(x, digits=2)
cos(x)
sin(x)
log(x)
log2(x)
log10(x)
exp(x)
