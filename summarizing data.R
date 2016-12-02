# getting data from the web
if(!file.exists('./data')){
    dir.create('./data')
}
fileUrl <- 'http://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD'
download.file(fileUrl, destfile = './data/restaurants.csv', method = 'curl')
restData <- read.csv('./data/restaurants.csv')

# first look
head(restData, 3)
tail(restData, 3)
summary(restData)
str(restData)


# quantiles of quantitative variables
quantile(restData$councilDistrict, na.rm = T)
quantile(restData$councilDistrict,probs = c(.5, .75, .9))

# make table
table(restData$zipCode, useNA = 'ifany')
table(restData$councilDistrict, restData$zipCode)

# checking for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

# row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

# values with specific characteristics
table(restData$zipCode %in% c('21212'))
table(restData$zipCode %in% c('21212', '21213'))
restData[restData$zipCode %in% c('21212', '21213'), ]

# cross tabs
data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
summary(df)

xt <- xtabs(Freq ~ Gender + Admit, data=df)
xt

data("warpbreaks")
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~., data=warpbreaks)
xt

# flat tables
ftable(xt)

# size of a data set
fakeData <- rnorm(1e5)
object.size(fakeData)
print (object.size(fakeData),units="Mb")
