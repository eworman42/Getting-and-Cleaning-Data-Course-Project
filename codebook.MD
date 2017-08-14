## Getting and Cleaning Data Course Project

Evan Worman

### Description
Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

### Source Data

**Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors**

Citation: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

A full description of this dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data used for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A video of this experiment is available [here](https://www.youtube.com/watch?v=XOEN9W05_4A).

**Note:** this dataset is outdated. An updated version of the dataset is available [here](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions)

### Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Section 1. Merge the training and the test sets to create one data set.

#### Reading Files

After setting the working directory, read the following files using read.tables so that they can be merged later. For the purposes of this project, features, activity_labels, subject_train and x/y_train were done separate from subject_test & x/y_test for ease of coding.

- features.txt,
- activity_labels.txt,
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

For example: 
```
y_Train       = read.table('./train/y_train.txt',header=FALSE); #import y_train.txt
```

### Assign column names and merge to create one data set.

Now, we add in the column names using colnames that correspond to the appropriate file. For activity_labels we use "activityID" *and* "activity_Type" because activities are numbered and named.

A line from the run_analysis.R file for example:

```colnames(activity_Type)  = c('activityId','activity_Type');
```

### Combining

Now that these are read into R and we're sure they're speaking the smae language, we can combine them as two halves (the "train" and "test" sets), and then into one final data set.

Example:

```
trainingData = cbind(y_Train,subject_Train,x_Train);
testData = cbind(y_Test,subject_Test,x_Test);
finalData = rbind(trainingData,testData);
```

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement.

Create a logical vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset this data to keep only the necessary columns and save it as its own vector (here, named "logicalVector") so that we can refer to it easily later.

## Section 3. Use descriptive activity names to name the activities in the data set

Here, we merge the vector from section 2 with the activityType table so that it includes the descriptive activity names.

## Section 4. Appropriately label the data set with descriptive activity names.

"Triaxial acceleration", "estimated body acceleration", "Triaxial Angular velocity"? These are horrible to have to read so they were summarized in the files, but now we have to make this look pretty and tidy again. Use the gsub function for pattern replacement to clean up the data labels so that it reads like something a human would actually want to look at without gouging their eyes out.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Here, we finally create a new table with the combined information with the vector "finalDataNoActivityType". Then, we take this information and use write.table to create the tidyData file, and finally it produces a confirmation message to ensure the user knows it is being written (and a gentle reminder that it is in the working directory so you don't do what I did and spend more than 5 minutes wondering where it went).
