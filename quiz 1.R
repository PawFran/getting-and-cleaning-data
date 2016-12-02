# q1 - How many properties are worth $1,000,000 or more
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile='American community survey.csv')
data <- read.csv('American community survey.csv')
head(data)
names(data)

# why && doesn't work properly here ?
d <- data[data$VAL == 24 & !is.na(data$VAL), ]$VAL
length(d)

# q3
library(xlsx)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx', destfile = 'Natural Gas Aquisition Program.xlsx', mode = 'wb')
dat <- read.xlsx('Natural Gas Aquisition Program.xlsx', sheetIndex = 1, startRow = 18, endRow = 23, colIndex = 7:15)
?read.xlsx
sum(dat$Zip*dat$Ext,na.rm=T)

# q4 - How many restaurants have zipcode 21231?
library(XML)
# must remove 's' from 'https'!
fileURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(fileURL, useInternal=T)

rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

zp <- xpathSApply(rootNode, '//zipcode', xmlValue)
length(zp[zp == '21231'])


# q5