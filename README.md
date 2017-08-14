# Getting and Cleaning Data - Course Project

Evan Worman

# Getting and Cleaning Data Project
Author: Michael Galarnyk <br />
Blog Post: [Getting and Cleaning Data Review](https://medium.com/@GalarnykMichael/review-course-1-the-data-scientists-toolbox-jhu-coursera-4d7459458821#.5jpg133ln "Click to go to Repo") <br />
Data Zip File Location: [UC Irvine Repo](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Clicking will download the data")

## Project Notes

* Specific analysis notes can be found both on the script notation and in the codebook.
* Codebook also contains information about main variables, what the dataset is, and where it is available from.

## Review Criteria

Goal | Item | Link to Item
--- | --- | ---
Analysis R Script |  run_analysis.R |  [R Script Link](https://github.com/eworman42/Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R "run_analysis.R")
Tidy Data Set |  Final Data Set |  [Data Set Link](https://github.com/eworman42/Getting-and-Cleaning-Data-Course-Project/blob/master/tidy.txt "tidyData.txt")
Overall Repo | Repo |  [Repo Link](https://github.com/eworman42/Getting-and-Cleaning-Data-Course-Projecto")
Codebook | CodeBook.md |  [Repo Link](https://github.com/eworman42/Getting-and-Cleaning-Data-Course-Project/blob/master/codebook.MD "CodeBook.md")
README | Here! |  [Repo Link](https://github.com/eworman42/Getting-and-Cleaning-Data-Course-Project/blob/master/README.md "README.md")


## Project Requirements
This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidy.txt`.
