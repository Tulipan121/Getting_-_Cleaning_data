``` r
knitr::opts_chunk$set(echo = TRUE)
```

R script to get a tidy data set
===============================

### Libraries used

Libraries used in the script were:

``` r
library(data.table)
library(tidyr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:data.table':
    ## 
    ##     between, first, last

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(stringr)
```

### Part 1

The user has to define the working directory in first line where he/she
extracted the zip file to.

In the firts part of the script we load all the relevant data to R. All
data is imported in the form of a data frame with the read.csv command.
For the variable names we use the file names for clear labelling.

With reading the data, we already define and transform the data from the
files to appropriate class - numeric for all measurements and character
for all labels and features with the colClasses argument.

``` r
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
```

### Part 2

The original data sets use numbers instead of activity labels to label
measurements. In Part 2 of our script we replace the values in the first
column in y\_test and y\_train from numbers to appropriate activity
labels.

We rename the single columns in data frames y\_test, Y\_train,
subject\_test and subject\_train.

We then join all columns from subject\_test, y\_test, x\_test to create
a complete data set named test\_data with the cbind command. We do the
same with subject\_train, Y\_train, X\_train to create train\_data.

Then we join rows from both data sets to create a complete data set
names merged\_data with the rbind command.

``` r
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
```

### Part 3

To get the final tidy data set, we first rename columns with
measurements (3 - 563) with integers 1 - 561. We then transform the
whole data frame so that each measurement is in a separete row, thus
creating a data frame with only 4 columns. We replace the numbers in the
Feature colummn with appropriate feature names from the features data
frame. Thus we get a tidy data set.

``` r
colnames(merged_data)[3:ncol(merged_data)] <- c(1:(ncol(merged_data)-2))

merged_data <- {gather(merged_data, 
                       colnames(merged_data)[3:ncol(merged_data)],
                       key = "Feature", value = "Value")}

merged_data$Feature <- {unlist(lapply(merged_data$Feature, 
                              function(x) features$V2[as.numeric(x)]))}
```

### Part 4

We still need to filter only measurement that contain the mean and
standard deviation from the whole data set. We do that by first
identifying which features’ names in the features data frame contain
either “mean” or “std”. We name the list containing those features’
names row\_remain. We then filter the Feature column of the merged\_data
to only those rows that contain names that are also present in the
row\_remain list.

We then transform merged\_data to a data table. This way we completed
the assignment till point 4, providing a tidy data set of merged data
sets for test and train measurements, with only those measurements that
contain information for mean and standard deviation and with all
appropriate labels.

``` r
pattern <- c("mean", "std")

row_remain <- {features$V2[sort(unlist(lapply(pattern, 
                  function(x) grep(x, features$V2))))]}

merged_data <- filter(merged_data, merged_data$Feature %in% row_remain)

merged_data <- as.data.table(merged_data)
```

### Part 5

In our last part of the script, we use the data.table command to group
merged\_data by Subject, Activity and Feature to calculate the mean of
means and standard deviations for each subject and for each activity. We
name it merged\_data\_2, thus completing point 5 in the assignment.

``` r
merged_data_2 <- {merged_data[, list(Mean = mean(Value)), 
                  by = c("Subject", "Activity", "Feature")]}
```
