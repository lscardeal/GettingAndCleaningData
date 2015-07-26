# DATA CLEANING COURSE
# LUCAS CARDEAL
# COURSE PROJECT
# 2015-07-25

#You should create one R script called run_analysis.R that does the following. 
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# Good luck!

# --- SETTING VARIABLES ---

setwd("C:\\Users\\Lucas\\Desktop\\DataScience\\Project")

# --- TOPIC 1 ---

# Root tables
rootActivity = read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE)
rootFeatures = read.table('./UCI HAR Dataset/features.txt',header=FALSE)

# Train tables
trainX = read.table('./UCI HAR Dataset/train/X_train.txt',header=FALSE)
trainY = read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE)
trainSubject = read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE)

# Test tables
testSubject = read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE)
testX = read.table('./UCI HAR Dataset/test/X_test.txt',header=FALSE)
testY = read.table('./UCI HAR Dataset/test/Y_test.txt',header=FALSE)

# Naming Columns
colnames(rootActivity) = c("ActivityID", "ActivityType")
colnames(trainSubject) = "SubjectID"
colnames(trainY) = "ActivityID"
colnames(testSubject) = "SubjectID"
colnames(testY) = "ActivityID"
colnames(trainX) = rootFeatures[,2]
colnames(testX) = rootFeatures[,2]

# Binding tables
trainData = cbind(trainY, trainX, trainSubject)
testData = cbind(testY, testX, testSubject)
data = rbind(trainData, testData)

# --- TOPIC 2 ---

# Preparing variables
columns = colnames(data)
columnsLog = (grepl("ID",columns) | grepl("-mean..",columns) & !grepl("-meanFreq..",columns) & !grepl("mean..-",columns) | grepl("-std..",columns) & !grepl("-std()..-",columns))

# Extracting the measurements
data2 = data[columnsLog==T]

# --- TOPIC 3 ---

data3 = merge(data2,rootActivity,by='ActivityID',all.x=T)

# --- TOPIC 4 ---

# Preparing variables
columns = colnames(data3)

# Renaming columns
for (i in 1:length(columns)) {
  columns[i] = gsub("\\()","",columns[i])
  columns[i] = gsub("-std$","StdDev",columns[i])
  columns[i] = gsub("-mean","Mean",columns[i])
  columns[i] = gsub("^(t)","time",columns[i])
  columns[i] = gsub("^(f)","freq",columns[i])
  columns[i] = gsub("([Gg]ravity)","Gravity",columns[i])
  columns[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",columns[i])
  columns[i] = gsub("[Gg]yro","Gyro",columns[i])
  columns[i] = gsub("AccMag","AccMagnitude",columns[i])
  columns[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columns[i])
  columns[i] = gsub("JerkMag","JerkMagnitude",columns[i])
  columns[i] = gsub("GyroMag","GyroMagnitude",columns[i])
}

colnames(data3) = columns

# --- TOPIC 5 ---

# Aggregating
tidyData = aggregate(data3[,names(data3)!= c("ActivityType","ActivityID","SubjectID")],by=list(activityId=data3$ActivityID,subjectId = data3$SubjectID),mean)

# Fixing activity type
tidyData = tidyData[,names(tidyData) != 'activityType']
tidyData = merge(tidyData,rootActivity,by='ActivityID',all.x=T)

# Writing
write.table(tidyData, './tidyData.txt',row.names=F,sep='\t')

