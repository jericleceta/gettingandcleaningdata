#used to match strings (find measurements of mean and std only)
library(stringr)
#used to reshape the data and find the mean for each variable, activity and subject
library(reshape2)

#read data
#construct the matrix of measurements
var.name <- read.table("features.txt")
var.name <- var.name$V2
meas.test <- read.table("test/X_test.txt", col.names = var.name)
meas.test$set <- "test"
meas.train <- read.table("train/X_train.txt", col.names = var.name)
meas.train$set <- "train"
meas <- rbind(meas.test, meas.train)
#retain only the measurements containing the mean and standard deviations
mean.std.name <- (str_detect(var.name, "mean") | str_detect(var.name, "std")) & !str_detect(var.name, "meanFreq")
meas <- meas[, mean.std.name]

#construct the vector of activities done
activity.test <- read.table("test/y_test.txt")
activity.train <- read.table("train/y_train.txt")
activity <- rbind(activity.test, activity.train)
colnames(activity) <- "activity.id"

#construct the vector of subject IDs
subject.test <- read.table("test/subject_test.txt")
subject.train <- read.table("train/subject_train.txt")
subject <- rbind(subject.test, subject.train)
colnames(subject) <- "subject.id"

#merge the different variables
data <- cbind(activity, subject, meas)

#translate the activity IDs into activity names
activity.map <- read.table("activity_labels.txt", col.names = c("activity.id", "activity.name"))
data <- merge(data, activity.map)
data <- cbind(data[, 70], data[, 2:69])
colnames(data)[1] <- "activity.name"

#set the measurements as variables
dataMelt <- melt(data, id = c("activity.name", "subject.id"), measure.vars = colnames(data)[3:68])

#get the mean for each activity and subject
tidyData <- dcast(dataMelt, activity.name + subject.id ~ variable, mean)

#write the tidy data set
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)
