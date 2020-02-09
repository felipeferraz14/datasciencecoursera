## Downloading the data

library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip", exdir = getwd())
}


## Readind the data

features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

data_train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
data_train_activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data_train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
data_test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data_test_activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data_test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

#Creating the data frames and changing the columns names

data_train <-  data.frame(data_train_subject, data_train_activity, data_train_x)
names(data_train) <- c(c('subject', 'activity'), features)
data_test <-  data.frame(data_test_subject, data_test_activity, data_test_x)
names(data_test) <- c(c('subject', 'activity'), features)

## Merges the training and the test sets to create one data set.

all_data <- rbind(data_train, data_test)

##Extracts only the measurements on the mean and standard deviation for each measurement.


mean_std <- grep('mean|std', features)
data_mean_std <- all_data[,c(1,2,mean_std + 2)]

##Uses descriptive activity names to name the activities in the data set


activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
data_mean_std$activity <- activity_labels[data_mean_std$activity]

##Appropriately labels the data set with descriptive variable names.


name.new <- names(data_mean_std)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data_mean_std) <- name.new

##From the data set in step 4, creates a second, independent 
##tidy data set with the average of each variable for each activity and each subject


tidy_data <- aggregate(data_mean_std[,3:81], by = list(activity = data_mean_std$activity, subject = data_mean_std$subject),FUN = mean)
write.table(x = tidy_data, file = "data_tidy.txt", row.names = FALSE)