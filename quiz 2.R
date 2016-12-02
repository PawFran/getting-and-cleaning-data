# q2
library(sqldf)
acs <- read.csv("getdata_data_ss06pid.csv")
names(acs)
dim(acs)
head(acs$pwgtp1)
head(acs$AGEP)

r1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
r2 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")
head(r1)
head(r2)


# q3 - equivalent to unique(acs$AGEP)
r3 <- sqldf("select distinct AGEP from acs")
r3 - unique(acs$AGEP)

# q4
con <- url('http://biostat.jhsph.edu/~jleek/contact.html')
html <- readLines(url)
close(con)
head(html)
nchar(html[10])
nchar(html[20])
nchar(html[30])
nchar(html[100])

# q5
con <- url('https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for')
data <- read.fwf(con, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
close(con)
head(data)
class(data)

data2 <- data[,4]
head(data2)
class(data2)
data3 <- data2[5:length(data2)]
class(data3)
# doesn't work without paste() on factor!
sum(as.numeric(paste(data3)))
