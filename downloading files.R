?download.file
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file(fileURL, destfile = "cameras.csv")
dir()

dateDownloaded <- date()
dateDownloaded
