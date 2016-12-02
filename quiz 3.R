# q1 first three indices where household > 10acr and ags > 10000
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl, destfile = 'quiz3 data.csv')
survey <- read.csv('quiz3 data.csv')
head(survey)
names(survey)

agricultureLogical <- (survey$ACR == 3 & survey$AGS == 6)
head(which(agricultureLogical), 3)

# q2 - What are the 30th and 80th quantiles of resulting image data ?
library(jpeg)
?readJPEG
sourceFile <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(sourceFile, destfile = 'quiz3 image.jpg', mode='wb')
image <- readJPEG('quiz3 image.jpg', native=T)
image
?quantile
quantile(image, probs = c(.3, .8)) 

# q3 mathing data based on the country shortcode
# how many matches ?
# descending order by GDP. what is 13th country ?
library(dplyr)
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
fileUrl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(fileUrl, destfile = 'quiz3 GDP data.csv', mode = 'wb')
download.file(fileUrl2, destfile = 'quiz3 educational data.csv', mode = 'wb')
GDP <- read.csv('quiz3 GDP data.csv')
# cleaning GDP data
head(GDP)
GDP <- GDP[5:194,]
head(GDP)
tail(GDP)
all(is.na(GDP$X.1)) # true
all(is.na(GDP$X.4))
all(is.na(GDP$X.5)) # true
all(is.na(GDP$X.6)) # true
all(is.na(GDP$X.7)) # true
all(is.na(GDP$X.8)) # true

# removing unnecessary columns
GDP <- GDP[, c(1, 2, 4, 5)]
head(GDP)
# renaming
GDP <- rename(GDP, shortCode = X, ranking = Gross.domestic.product.2012, longName = X.2, GDP = X.3)
head(GDP)
tail(GDP)

# sth strange with ranking
length(GDP$ranking)
length(unique(GDP$ranking))
r <- as.numeric(paste(GDP$ranking))
r
b <- numeric(0)
for(i in r){
    b[i] <- (r[i+1] - r[i])
}
b
r[178]
r[179]
r[180]
r[180] - r[179]

# loading second data set
edu <- read.csv('quiz3 educational data.csv')
head(edu)
which(edu$CountryCode == 'USA')
which(GDP$shortCode == 'USA')

# merging
mergedData <- merge(GDP, edu, by.x = 'shortCode', by.y = 'CountryCode')
nrow(mergedData)
class(mergedData$ranking)
mergedData$ranking <- as.numeric(paste(mergedData$ranking))
mergedData$ranking

result <- arrange(mergedData, desc(ranking))
result$longName
head(result$longName, n=15)
tail(result$shortCode)
which(result$longName == 'Spain')
which(result$ranking == 13)
which(result$longName == 'St. Kitts and Nevis')


# q4 average GDP ranking for the "High income: OECD" and "High income: nonOECD" 
names(result)
result$Income.Group
mean(result$ranking[result$Income.Group == 'High income: OECD'])
mean(result$ranking[result$Income.Group == 'High income: nonOECD'])


# q5 Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?
?cut
result$ranking <- as.numeric(paste(result$ranking))
result$ranking
?quantile
breaks <- quantile(result$ranking, seq(0, 1, .2)); breaks
groups <- cut(result$ranking, breaks=breaks); groups
table(groups, result$Income.Group)
