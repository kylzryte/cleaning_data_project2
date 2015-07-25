# Getting and Cleaning Data: Course Project 2

### Intro

This repository contains work for the course project for the course "Getting and Cleaning data", 
part of the Data Science specialization on Coursera.

### raw data

For a complete explanation of the data set: read README.txt and features_info.txt.
These two files are contained in the UCI HAR dataset folder. 

### R script and tidy data output.

The script run_analysis.R will perform the following:
- Merge the training and the test data sets into 1 data set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Uses descriptive activity names to name activities in the data set
- Labels the data set with variable names
- Creates a second independent data set with an average of each variable by activity and 
  subject.


### About the Code Book

The CodeBook.md file gives a brief description of variables contained in the data.tidy
data set. 

Note: this tidy data is exported as a data set: averages.txt for later use.