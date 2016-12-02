fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, destfile = 'dataset.zip')
unzip("dataset.zip")

test_data <- read.table('./test/X_test.txt')
head(test_data)
str(test_data)
train_data <- read.table('./train/X_train.txt')
head(train_data)
str(train_data)

# merging two datasets into one
?rbind
ncol(test_data)
ncol(train_data)
data <- rbind(train_data, test_data)
head(data)
nrow(data)

# extract only mean and sd for each measurement
features <- read.table("features.txt", stringsAsFactors = F)
head(features)
head(features$V2)
columns <- grep('(mean|std)[^[:alnum:]]', features$V2)
features2 <- features[columns, ]
features2
nrow(features2)

library(dplyr)
?select
data2 <- select(data, columns)
ncol(data2)

# name activities
train_activities <- read.table('./train/y_train.txt', stringsAsFactors = F)
train_activities <- as.character(train_activities[, 1])
head(train_activities)
# one command ?
train_activities <- sub("1", "WALKING", train_activities)
train_activities <- sub("2", "WALKING_UPSTAIRS", train_activities) 
train_activities <- sub("3", "WALKING_DOWNSTAIRS", train_activities)
train_activities <- sub("4", "SITTING", train_activities)
train_activities <- sub("5", "STANDING", train_activities)
train_activities <- sub("6", "LAYING", train_activities)
head(train_activities, 150)

test_activities <- read.table('./test/y_test.txt', stringsAsFactors = F)
test_activities <- as.character(test_activities[, 1])
head(test_activities)
test_activities <- sub("1", "WALKING", test_activities)
test_activities <- sub("2", "WALKING_UPSTAIRS", test_activities) 
test_activities <- sub("3", "WALKING_DOWNSTAIRS", test_activities)
test_activities <- sub("4", "SITTING", test_activities)
test_activities <- sub("5", "STANDING", test_activities)
test_activities <- sub("6", "LAYING", test_activities)
head(test_activities, 150)

all_activities <- c(train_activities, test_activities)
length(all_activities)

?mutate
data2 <- mutate(data2, activity = all_activities)

names <- as.character(features2[,2])
names
colnames(data2) <- c(names, 'activity')
colnames(data2)
head(data2)


# creating a second data set with averages of each variable for each subject and activity
data_avg <- data2
train_subject <- read.table('./train/subject_train.txt', stringsAsFactors = F)
train_subject <- as.numeric(train_subject[,1])
head(train_subject)
test_subject <- read.table('./test/subject_test.txt', stringsAsFactors = F)
test_subject <- as.numeric(test_subject[,1])
head(test_subject)
all_subject <- c(train_subject, test_subject)
length(all_subject)

data_avg <- mutate(data_avg, subject = all_subject)
head(data_avg)

avg <- select(data_avg, -c(activity, subject))

avg_activity <- select(data_avg, -c(subject))
activityMelt <- melt(avg_activity, id=c('activity'))
head(activityMelt)
activityData <- dcast(activityMelt, activity ~ variable, mean)
head(activityData)
colnames(activityData)
new_names <- colnames(activityData)[-1]
# changing column names leaving first one as it is
for(i in seq_along(new_names)){
    new_names[i] <- sub('.+', paste('average', new_names[i]), new_names[i])
}
new_names
colnames(activityData) <- c('activity', new_names)
colnames(activityData)
head(activityData)

avg_subject <- select(data_avg, -c(activity))
subjectMelt <- melt(avg_subject, id=c('subject'))
head(subjectMelt)
subjectData <- dcast(subjectMelt, subject ~ variable, mean)
head(subjectData, n=10)
colnames(subjectData) <- c('subject', new_names)
colnames(subjectData)
head(subjectData)

