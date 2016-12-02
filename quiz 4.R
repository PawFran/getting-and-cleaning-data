survey <- read.csv('American community survey.csv')

# q1 Apply strsplit() to split all the names 
# of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the 
# resulting list?
names(survey)
?strsplit
strsplit(names(survey), 'wgtp')[123]

# q2 Remove the commas from the 
# GDP numbers in millions of dollars and 
# average them. What is the average? 
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(fileUrl, destfile = 'quiz 4 GDP data.csv')
GDP <- read.csv('quiz 4 GDP data.csv', skip = 4, stringsAsFactors = F)
names(GDP)
head(GDP)
numbers <- GDP[1:190,5]
numbers <- gsub(",", "", numbers)
numbers <- as.numeric(numbers)
numbers
average <- mean(numbers, na.rm = T)
average

# q3 In the data set from Question 2 
# what is a regular expression that would 
#allow you to count the number of countries 
#whose name begins with "United"? Assume that 
#the variable with the country names in it is 
#named countryNames. How many countries begin 
#with United? 
head(GDP)
countryNames <- GDP[1:190, 4]
countryNames
grep("^United",countryNames)
countryNames[c(1, 6, 32)]

# q4 Match the data based on the country 
# shortcode. Of the countries for which the 
# end of the fiscal year is available, how 
# many end in June?
fileUrl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(fileUrl2, destfile = 'quiz4 edu data.csv')
edu <- read.csv('quiz4 edu data.csv')
head(edu)
names(edu)
edu$CountryCode
mergedData <- merge(GDP, edu, by.x = 'X', by.y = 'CountryCode', all = T)
names(mergedData)
grep('[Ff]iscal', names(mergedData))

# q5 How many values were collected in 2012? 
# How many values were collected on Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes)
library(lubridate)
sample_2012 <- sampleTimes[which(format(sampleTimes, '%Y') == '2012')]
length(sample_2012)
# monday is second!
length(sample_2012[which(wday(sample_2012) == 2)])
