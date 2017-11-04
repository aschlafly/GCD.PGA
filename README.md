---
title: "README.md"
author: "Aaron Schlafly"
date: "10/28/2017"
output: html_document
---

## Objective

The objective of this assignment is to merge data files, extract the relevant columns, create descriptive labels, and then extract a second, independent "tidy" data set with summary statistics.

## Data description

The data come from 
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

The data were collected from researchers studying human movement and smartphone sensor readings. The data are based on:  
    * 30 volunteers (anonymous)  
    * 6 activities performed (walking, walking upstairs, walking downstairs, sitting, standing, and laying)  
    * A variable number of readings per volunteer x activity.  
    * The total number of readings is 10,299.  
    * For each reading, 561 relevant attributes are measured.  

More details about the original dataset can be found at
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## How the data fit together
The heart of the data comes from two files of readings, collectively called "X". One set is called "train" and one set is called "test." For the purpose of this assignment, the two datasets are merged. The total number of samples is 10,299.  

Two vectors, collectively called "Y", tells which of the 6 activities was being performed in each sample. 

Finally, another pair of vectors, collectively called "subject", tells which of the 30 subjects was being measured in each sample.

Appending "subject" and "Y" to "X" thus labels each sample with a subject and with an activity.

There are 10,299 samples collected, and for each sample, there are 561 attributes, meaning that there are 561 columns of data for each of the 10,299 rows. A file, "features.txt" contains the labels for each of the 561 attributes. Another file, "features_info.txt" contains more information about the features.

## The crazy ordering

The steps I take do not follow the order in the assignment instructions. Sorry.  
As I assemble the data, it is easier to add a column of activity descriptions to the activity column before merging it into the marged table XY. This is because the cbind() command can easily concatenate the vectors / tables in the order of my choosing. As a result, I add in the descriptive activity labels in the middle of step 1, merging the tables.  




## The high-level process
Put simply, the data are processed using the following steps:
1. Read in the relevant labels (activities for each activity code to label each reading with an activity, attribute names to label the variables used in each column)
2. Read in the vector of subjects (Y) for each reading and the matrix containing the 561 attributes for each reading. [^1]
3. Make a vector of activity labels for each activity code.
4. Assemble the data frame to contain a column of subjects, a column of activity codes, a column of activity names, then 561 columns of the measurements.
5. Get rid of the measurements other than mean() and std(). This pares the number of columns down to 66 [^2]  
6. After creating the data set of means and standard deviations, I use plyr functions to group by subject x activity (30 x 6 = 180 combinations), then take the means of each column, then assemble into a smaller tidy data set containing 180 rows and 68 columns (2 for labels and 66 for the means)

[^1]: Note that more detailed results are available, but since the objective of the assignment is focused on summarized statistics, the more detailed data is ignored.  
[^2]: I choose the varables with mean() or std(). I don't choose meanFreq(), since it seems as though the assignment is only looking for pure means.  


## Is the tidy data really tidy?

YES!  

1. Each column contains only one variable.
2. Each observation of each variable is in single row.
3. All of the elements of the tidy data represent means, so they are of one "kind"
4. Since I don't have multiple tables, I don't have to link them.

In addition, 
1. There is a row at the top with variable names.
2. Arguably, the variable names are not human readable. However, if the varaible names were human readable, then the users would have a hard time printing out or typing the variable names. "Result of Fast Fourier Transform applied to time domain signals for Jerk signals of the acceleration of the body in the X-direction" is too long for a single variable name, so 66 more would be unreadable due to space limitations. Therefore, I rely on the codebook to help the user understand what the variables mean.
3. The data are saved as one file per table.

The columns are arguably not tidy - the 


