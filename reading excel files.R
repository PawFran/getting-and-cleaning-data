setwd("F:/dokumenty/coursera/r/getting and cleaning data")

fileURL = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURL, destfile = "cameras.xlsx", mode = "wb")

dateDownloaded <- date()
dateDownloaded

library(xlsx)

?read.xlsx
cameraData <- read.xlsx("cameras.xlsx", sheetIndex=1, header=T)
head(cameraData)

?write.xlsx()

# read2.xlsx is much faster but sometimes unstable
# XLConnect has more options
# XLConnetc vignette is a place to start