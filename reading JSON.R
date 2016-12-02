library(jsonlite)
jsonData <- fromJSON('https://api.github.com/users/jtleek/repos') # returns data frame
names(jsonData)

names(jsonData$owner)
jsonData$owner$login

# example of turning data frame into JSON format
myjson <- toJSON(iris, pretty=T)
cat(myjson)

# turning it back
iris2 <- fromJSON(myjson)
head(iris2)
