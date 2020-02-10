---
title: "CodeBook"
author: "Felipe Torres"
date: "2/10/2020"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# CodeBook


## The Data
This project uses data from the Human Activity Recognition Using Smartphones Data Set. The data is available in the script.

## The Variables
run_analysis.R imports the train data from '/train/X_train.txt', '/train/y_train.txt', and '/train/subject_train.txt' into x.train, y.train, and subject.train respectively. It imports the test data from '/test/X_test.txt', '/test/y_test.txt', and '/test/subject_test.txt' into x.test, y.test, and subject.test respectively. 
The activity labels are imported from '/activity_labels.txt' into activity.labels, and the names of the measurements are imported from '/features.txt' into features.

## Identifyers

"subject"                     
"activity"

## Activity Labels

"WALKING"  
"WALKING_UPSTAIRS"  
"WALKING_DOWNSTAIRS"
"SITTING"         
"STANDING"        
"LAYING"     

## The Transformations

run_analysis.R does the following steps:

1. Merges training and test data
2. Extracts only mean and std measurements
3. Use descriptive activity names
4. Labal the data set
5. Independent Tidy Data Set and exported as 'tidy_data.txt'.