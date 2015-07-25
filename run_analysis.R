library(plyr)

setwd("~/Desktop/Coursera/cleaning data/prjoect 2/cleaning_data_project2")

# The data is in the current WD in a folder called UCI HAR Dataset
# Read data in R

path.data <- file.path(getwd(),"UCI HAR Dataset")

subject_test <- read.table(file.path(path.data,"test", "subject_test.txt"))
subject_train <- read.table(file.path(path.data,"train", "subject_train.txt"))

X_train <- read.table(file.path(path.data,"train", "X_train.txt"))
Y_train <- read.table(file.path(path.data,"train", "Y_train.txt"))

X_test <- read.table(file.path(path.data,"test", "X_test.txt"))
Y_test <- read.table(file.path(path.data,"test", "Y_test.txt"))

# Read activity and feature labels into R

activity_labels <- read.table(file.path(path.data,"activity_labels.txt"), 
                              col.names=c("ID", "Activity"))
feature_labels <- read.table(file.path(path.data,"features.txt"), 
                             colClasses=c("numeric","character"))

# Rbind the data sets into 3 sets. subjects, labels and activity
# Add labels to the column names
# Cbind the three data sets into 1 data set
# remove unneccassary data from global enviroment to free up working memory

subject.dat <- rbind(subject_train, subject_test)
labels.dat <- rbind(Y_train, Y_test)
activity.dat <- rbind(X_train, X_test)

names(subject.dat) <- "Subject"
names(labels.dat) <- "ID"
names(activity.dat) <- feature_labels$V2

data <- cbind(subject.dat, labels.dat, activity.dat)

str(data)

#rm(X_test,Y_test,X_train,Y_train, subject_test, subject_train, subject.dat)
#rm(labels.dat, activity.dat, feature_labels)

# Extract the mean and standard deviation for each measurement

mean.sd <- data[,grepl("mean|std|Subject|ID", names(data))]

# use activity_labels to name activities in new data

mean.sd <- join(mean.sd, activity_labels, by="ID", match="first")
mean.sd <- mean.sd[,-1]

# move last column to second column
col.index <- grep("Activity", names(mean.sd))
mean.sd <- mean.sd[,c(col.index, (1:ncol(mean.sd))[-col.index])]
col.index <- grep("Subject", names(mean.sd))
mean.sd <- mean.sd[,c(col.index, (1:ncol(mean.sd))[-col.index])]

# Label data set with descriptive variable names:

names(mean.sd) <- gsub('\\(|\\)',"", names(mean.sd), perl=TRUE)
names(mean.sd) <- make.names(names(mean.sd))

# Clean up variable names
names(mean.sd) <- gsub("^t","Time.", names(mean.sd))
names(mean.sd) <- gsub("^f","Freq.", names(mean.sd))
names(mean.sd) <- gsub("Body","Body.", names(mean.sd))
names(mean.sd) <- gsub("mean","Mean", names(mean.sd))
names(mean.sd) <- gsub("std", "Sd", names(mean.sd))
names(mean.sd) <- gsub("Gravity", "Gravity.", names(mean.sd))

# create second independent tidy data set with the average of each variable for 
# each activity and subject

data.tidy <- ddply(mean.sd, c("Subject","Activity"), numcolwise(mean))
head(data.tidy)

# Export Data set as text file using write.table() and row.name=FALSE
write.table(data.tidy, file="averages.txt", row.name=FALSE)

colnames(data.tidy)
str(data.tidy)
levels(data.tidy$Activity)

