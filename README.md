# Getting and Cleaning Data

### Description of the variables used in my cod

* rootActivity = the table read from the file ./UCI HAR Dataset/activity_labels.txt
* rootFeatures = the table read from the file ./UCI HAR Dataset/features.txt
* trainX = the table read from the file ./UCI HAR Dataset/train/X_train.txt
* trainY = the table read from the file ./UCI HAR Dataset/train/y_train.txt
* trainSubject = the table read from the file ./UCI HAR Dataset/train/subject_train.txt
* testSubject = the table read from the file ./UCI HAR Dataset/test/subject_test.txt
* testX = the table read from the file ./UCI HAR Dataset/test/X_test.txt
* testY = the table read from the file ./UCI HAR Dataset/test/Y_test.txt
* trainData = a table including all the train data
* testData = a table including all the test data
* data = a table inclugin all the data. The result of Topic 1
* columns = used to keep the name of the current table
* columnsLog = used keep the logical value of the tables who will remain in working
* data2 = a new table, cleaner than data. The result of Topic 2
* data3 = including the activity type names in data2. The result of Topic 3
* tidyData = the last table after all cleaning process