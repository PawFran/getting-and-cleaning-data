?subset()
?match
install.packages("dplyr")
library(dplyr)

# loading data and taking a look
unzip("chicago_data.zip")

setwd("F:/dokumenty/coursera/r/getting and cleaning data")
chicago <- readRDS("chicago.rds")
summary(chicago)
head(chicago)
str(chicago)
dim(chicago)
names(chicago)[1:3]

# select
subset <- select(chicago, city:dptp)
head(subset)

# ommiting with "-"
head(select(chicago, -(city:dptp)))

subset <- select(chicago, ends_with("2"))
str(subset)

subset <- select(chicago, starts_with("d"))
str(subset)

?select


# filter
chic.f <- filter(chicago, pm25tmean2 > 30)
str(chic.f)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
select(chic.f, date, tmpd, pm25tmean2)

# arrange
chicago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)

chicago <- arrange(chicago, desc(date))
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)


# rename
head(chicago[, 1:5], 3)

chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chicago[, 1:5], 3)


# mutate & transmute
head(chicago)
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(chicago)

head(transmute(chicago, 
     pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm = T), 
     o3detrend = o3tmean2 - mean(o3tmean2, na.rm = T)))



# group_by and summarise
head(chicago)
head(slice(chicago, 1:2))
head(select(chicago, date))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
head(chicago)

years <- group_by(chicago, year)
head(years)
head(select(years, o3tmean2:year))

summarize(years, p2m5 = mean(pm25, na.rm = T),
          o3 = max(o3tmean2, na.rm = T),
          no2 = median(no2tmean2, na.rm = T))

# pipeline
# how to do it in a few lines ?
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarise(pm25=mean(pm25, na.rm = T), o3=max(o3tmean2), no2=median(no2tmean2))

