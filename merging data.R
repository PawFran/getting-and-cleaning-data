if(!file.exists('./peer review data')){
    dir.create('./peer review data')
}

fileUrl <- 'http://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv'
fileUrl2 <- 'http://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv'
download.file(fileUrl, destfile='./peer review data/reviews.csv', mode='wb')
download.file(fileUrl2, destfile='./peer review data/solutions.csv', mode='wb')
reviews <- read.csv('./peer review data/reviews.csv')
solutions <- read.csv('./peer review data/solutions.csv')
head(reviews, 2)
head(solutions, 2)

names(reviews)
names(solutions)
?merge

# by default merges by all columns with identical name

# all=T means that if there are no corresponding 
# values additional rows with NAs are created
mergedData <- merge(reviews,solutions,by.x='solution_id',by.y='id',all=T)
head(mergedData)

intersect(names(solutions), names(reviews))



# using join in the plyr package
# faster, less featured. only uses common names
library(plyr)
df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
df1
df2
arrange(join(df1, df2), id)

# multiple data frames
df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
df3 <- data.frame(id=sample(1:10), z=rnorm(10))
dfList <- list(df1, df2, df3)
join_all(dfList)
