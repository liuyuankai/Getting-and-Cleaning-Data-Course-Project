This is a guide for how the script run_analysis.R works:

1.how to run run_analysis.R
  * I assume that run_analysis.R in the working directory, and Samsung data files location as below:
  * ./UCI HAR Dataset/features.txt
  * ./UCI HAR Dataset/features.txt
  * ./UCI HAR Dataset/train/subject_train.txt
  * ./UCI HAR Dataset/train/X_train.txt
  * ./UCI HAR Dataset/train/y_train.txt
  * ./UCI HAR Dataset/test/subject_test.txt
  * ./UCI HAR Dataset/test/X_test.txt
  * ./UCI HAR Dataset/test/y_test.txt
  
  you can run source("./run_analysis.R") to run run_analysis.R script, and the output file tidydataset.txt will be got in the working directory;

2.how the script works
* load package plyr
* read files in the directory "./UCI HAR Dataset"
* create train_set which consist of subject,activity and X_train information, this use cbind command;
* create test_set which consist of subject,activity and X_test information, this use cbind command;
* merge train-set and test_set
* find cols to be extracted
* Extracts only the measurements on the mean and standard deviation for each measurement
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. this use ddply and sapply command;
* write tidy data set into file "tidydataset.txt",which is saved in the working directory;


