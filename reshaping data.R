library(reshape2)
head(mtcars)

# melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c('carname', 'gear', 'cyl'), measure.vars = c('mpg', 'hp'))
head(carMelt, n=3)
tail(carMelt, n=3)

# casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData # shows how many measurements has been made

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData


# averaging values
head(InsectSprays)
# apply to count along index spray function sum
tapply(InsectSprays$count, InsectSprays$spray, sum)
# another method
spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount <- lapply(spIns, sum)
sprCount
unlist(sprCount)
# another way
library(plyr)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

# creating a new variable
spraySums <- ddply(InsectSprays,.(spray),summarize, sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)
