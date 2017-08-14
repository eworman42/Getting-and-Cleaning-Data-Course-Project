## Getting & Cleaning Data Course Project (Final)

## Evan Worman
## 8-13-2017

## Getting & Cleaning Data Course Project (Final)

# To-do:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
# URL for data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###############################################################################

## 1. Merge the training and the test sets to create one data set.

# Set your WD to the location where UCI HAR Dataset was unzipped. Note: does not 
# need to specify sub-folders in dataset at this point.
setwd('/Users/Jenny/Documents/UCI HAR Dataset/');

# Read in the data from files.
features      = read.table('./features.txt',header=FALSE); #import features.txt
activity_Type = read.table('./activity_labels.txt',header=FALSE); #import activity_labels.txt
subject_Train = read.table('./train/subject_train.txt',header=FALSE); #import subject_train.txt
x_Train       = read.table('./train/x_train.txt',header=FALSE); #import x_train.txt
y_Train       = read.table('./train/y_train.txt',header=FALSE); #import y_train.txt

# Assign column names to the imported
colnames(activity_Type)  = c('activityId','activity_Type');
colnames(subject_Train)  = "subjectId";
colnames(x_Train)        = features[,2]; 
colnames(y_Train)        = "activityId";

# Create the final training set by merging yTrain, subjectTrain, & xTrain
trainingData = cbind(y_Train,subject_Train,x_Train);

# Read the test data
subject_Test = read.table('./test/subject_test.txt',header=FALSE); #import subject_test.txt
x_Test       = read.table('./test/x_test.txt',header=FALSE); #import x_test.txt
y_Test       = read.table('./test/y_test.txt',header=FALSE); #import y_test.txt

# Assign column names to the test data imported above
colnames(subject_Test) = "subjectId";
colnames(x_Test)       = features[,2]; 
colnames(y_Test)       = "activityId";


# Creates the final test set by merging xTest, yTest & subjectTest data
testData = cbind(y_Test,subject_Test,x_Test);


# Combine training & test data to create the final data set
finalData = rbind(trainingData,testData);

# Create a vector for the column names from the finalData, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(finalData); 

################
## 2. Extract only the measurements on the mean and standard deviation for each 
##    measurement. 

# Create variable logicalVector that contains TRUE values for the ID, mean() & 
#   stddev() columns, and FALSE for others
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | 
                     grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) 
                 & !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                     !grepl("-std()..-",colNames));

# Subset finalData table, based on the logicalVector to keep only desired columns
finalData = finalData[logicalVector==TRUE];

################
## 3. Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table to include descriptive 
# activity names
finalData = merge(finalData,activity_Type,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalData); 

################
## 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\()","",colNames[i])
    colNames[i] = gsub("-std$","StdDev",colNames[i])
    colNames[i] = gsub("-mean","Mean",colNames[i])
    colNames[i] = gsub("^(t)","time",colNames[i])
    colNames[i] = gsub("^(f)","freq",colNames[i])
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassign these new, more descriptive column names to the finalData set
colnames(finalData) = colNames;

################
## 5. Create a second, independent tidy data set with the average of each 
## variable for each activity and each subject. 

# Create a new table, finalDataNoActivityType without the activityType column
finalDataNoActivityType  = finalData[,names(finalData) != 'activity_Type'];

# Summarizing the finalDataNoActivityType table to include just the mean of each 
# variable for each activity and each subject
tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) 
                != c('activityId','subjectId')],
                by=list(activityId=finalDataNoActivityType$activityId,subjectId 
                        = finalDataNoActivityType$subjectId),mean);

# Merge tidyData with activityType to include descriptive names for activities
tidyData    = merge(tidyData,activity_Type,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=F,sep='\t'); # Writes tidyData file
message("Writing to WD") # Confirms file is written
