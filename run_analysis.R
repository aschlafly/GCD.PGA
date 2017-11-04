## Step 1: Merge the training and test data sets to create one data set

## Set working directory to be the home of the UCI HAR Dataset
setwd("./UCI HAR Dataset")

## Read in the label names and features.
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

## For the test and training data, read in the subject file, and X and Y files.
setwd("./test")
subject_test <- read.table("subject_test.txt", col.names = "subject")
X_test <- read.table("X_test.txt", col.names = features[,2])
Y_test <- read.table("Y_test.txt", col.names = "activity_code")

setwd("../train")
subject_train <- read.table("subject_train.txt", col.names = "subject")
X_train <- read.table("X_train.txt", col.names = features[,2])
Y_train <- read.table("Y_train.txt", col.names = "activity_code")

## Append the training data to the end of the test data
subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test,X_train)
Y_all <- rbind(Y_test,Y_train)

## Step 3: (I will do step 3 before step 2, since it is easier to layer in 
## with labels already attached)
## 

library(plyr)
## Add a column to Y_all which maps the codes to descriptive labels
Y_all <- mutate(Y_all, activity_labels = activity_labels[Y_all[,1],2])



## Back to step 1:
## Now combine the subject codes, activities (with descriptors), and all X data
XY_all <- cbind(subject_all, Y_all, X_all)


## Step 2: Extract only the measurements on the mean and standard deviation
## for each measurement
## I interpret "mean" and "standard deviation" to only be those variables which
## have mean() or std() in the name, in which I search for "mean(" or "std("

## First, select only those indices which have "mean(" or "std("
mean_sd_indices <- grep("mean\\(|std\\(",features$V2)

## Select the first three columns along with the columns with "mean(" or "std("
indices <- c(c(1:3),mean_sd_indices + 3)

## Then select only those columns corresponding to "mean(" or "std("
XY <- XY_all[,indices]

## Use plyr fucntions to split by subject and descriptive activity
## then calculate the mean, removing NAs

library(dplyr)
tidydt <- XY %>% 
    group_by(subject, activity_labels) %>% 
    summarize_at(vars(tBodyAcc.mean...X:fBodyBodyGyroJerkMag.std..),
                 mean, na.rm = TRUE) 

## Write the file to the correct directory
setwd("../..")
write.table(tidydt,file = "tidydt.csv")
tidydf <- as.data.frame(tidydt)
write.table(tidydf,file = "tidydf.txt", row.names = FALSE)
