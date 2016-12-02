# inherits from data.frame
# much faster

# https://www.datacamp.com/courses/data-analysis-the-data-table-way

library(data.table)
df <- data.frame(x=rnorm(9), y=rep(c('a','b','c'),each=3),z=rnorm(9))
head(df, 3)

dt <- data.table(x=rnorm(9), y=rep(c('a','b','c'),each=3),z=rnorm(9))
head(dt, 3)

tables() # all data tables in memory

# subsetting rows
dt[2, ]
dt[dt$y == 'a']
dt[c(2, 3)] # subsetting on one index

# subsetting columns is different
dt[,2] # doesn't work

dt[, list(mean(x), sum(z))]
dt[,table(y)]

# adding new columns or changing old
# doesn't create a new copy - more convenient with large datasets
dt[,w:=z^2]
head(dt)
dt2 <- dt
dt[,y:=2] # changes also fist table!
head(dt)
head(dt2)

# multiple operations
dt[, m:={tmp <- (x + z); log2(tmp + 5)}]
head(dt)

# plyr like operations
dt[, a:=x>0]
head(dt)
dt[, b:= mean(x+w), by=a]
head(dt)
