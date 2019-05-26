library(data.table)
library(tidyr)
library(dplyr)
library(stringr)

#-------------------------------------------------------

#Part 1

wd <- "D:/Dokumenti/Coursera/Assignment" #set working directory to the location where you extracted the zip file to

{setwd(paste(wd, "/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test",
             sep = ""))}

x_test <- {read.csv("X_test.txt", header = FALSE, sep = "", 
                    as.is = FALSE, colClasses = "numeric")}

y_test <- {read.csv("y_test.txt", header = FALSE, sep = "", 
                    as.is = FALSE, colClasses = "numeric")}

subject_test <- {read.csv("subject_test.txt", header = FALSE, sep = "", 
                          as.is = FALSE, colClasses = "numeric")}

{setwd(paste(wd, "/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset",
             sep = ""))}

activity_labels <- {read.csv("activity_labels.txt", header = FALSE, sep = "",
                             as.is = FALSE, colClasses = "character")}

features <- {read.csv("features.txt", header = FALSE, sep = "", 
                      as.is = FALSE, colClasses = "character")}

{setwd(paste(wd, "/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train",
             sep = ""))}

subject_train <- {read.csv("subject_train.txt", header = FALSE, sep = "", 
                           as.is = FALSE, colClasses = "numeric")}

X_train <- {read.csv("X_train.txt", header = FALSE, sep = "", 
                     as.is = FALSE, colClasses = "numeric")}

Y_train <- {read.csv("y_train.txt", header = FALSE, sep = "", 
                     as.is = FALSE, colClasses = "numeric")}


#-------------------------------------------------------

#Part 2

y_test$V1 <- {unlist(lapply(y_test$V1, 
                            function(x) x <- activity_labels[x, 2]))}

Y_train$V1 <- {unlist(lapply(Y_train$V1, 
                             function(x) x <- activity_labels[x, 2]))}

names(y_test) <- "Activity"
names(Y_train) <- "Activity"
names(subject_test) <- "Subject"
names(subject_train) <- "Subject"

test_data <- cbind(subject_test, y_test, x_test)
train_data <- cbind(subject_train, Y_train, X_train)

merged_data <- data.frame(rbind(test_data, train_data))

#-------------------------------------------------------

#Part 3

colnames(merged_data)[3:ncol(merged_data)] <- c(1:(ncol(merged_data)-2))

merged_data <- {gather(merged_data, 
                       colnames(merged_data)[3:ncol(merged_data)],
                       key = "Feature", value = "Value")}

merged_data$Feature <- {unlist(lapply(merged_data$Feature, 
                                      function(x) features$V2[as.numeric(x)]))}


#-------------------------------------------------------

#Part 4

pattern <- c("mean", "std")

row_remain <- {features$V2[sort(unlist(lapply(pattern, 
                                              function(x) grep(x, features$V2))))]}

merged_data <- filter(merged_data, merged_data$Feature %in% row_remain)

merged_data <- as.data.table(merged_data)

#-------------------------------------------------------

#Part 5

merged_data_2 <- {merged_data[, list(Mean = mean(Value)), 
                              by = c("Subject", "Activity", "Feature")]}
