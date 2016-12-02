# baltimore data
if(!file.exists('./baltimore data')){
    dir.create('./baltimore data')
}

fileUrl <- 'http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(fileUrl, destfile = './baltimore data/cameras.csv', mode = 'wb')
cameraData <- read.csv('./baltimore data/cameras.csv')
names(cameraData)

# changing to lower case
tolower(names(cameraData)) # mutates, not returns

# splitting
splitNames <- strsplit(names(cameraData), '\\.')
splitNames[5]
splitNames[6]

# fixing character vectors - sapply
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)


# fixing character vectors - sub() and gsub()
reviews <- read.csv('./peer review data/reviews.csv')
solutions <- reviews <- read.csv('./peer review data/solutions.csv')
head(reviews,2)
head(solutions,2)
names(reviews)
?sub
sub('_','',names(reviews)) # returns

testName <- 'this_is_a_test'
sub('_','',testName)
gsub('_','',testName)


# finding values - grep() and grepl()
cameraData$intersection
?grep
grep('Alameda',cameraData$intersection) # returns indices
grep('Alameda',cameraData$intersection, value=T)
grep('JeffStreet',cameraData$intersection)
length(grep('JeffStreet',cameraData$intersection))
grepl('Alameda',cameraData$intersection) # returns a logical vector
table(grepl('Alameda',cameraData$intersection))
cameraData2 <- cameraData[!grepl('Alameda',cameraData$intersection),]


# other string functions
library(stringr)
nchar('Jeffrey Leek')
substr('Jeffrey Leek', 1, 7)
paste('Jeffrey', 'Leek')
paste('Jeffrey', 'Leek', sep=', ')
paste0('Jeffrey', 'Leek')
str_trim(' Jeff   ')
