#load package plyr
library(plyr)

#read files in the directory "./UCI HAR Dataset"
features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

#create train_set which consist of subject,activity and X_train information
train_set<-cbind(subject_id=subject_train[,1],activity=y_train[,1],X_train)

#create test_set which consist of subject,activity and X_test information
test_set<-cbind(subject_id=subject_test[,1],activity=y_test[,1],X_test)

#merge train-set and test_set
merge_set<-merge(train_set,test_set,all=TRUE)

#Extracts only the measurements on the mean and standard deviation for each measurement
#find cols to be extracted
cols_extract<-grep("mean\\()|std\\()",features[,2])
cols_extract<-cols_extract+2
extract_mergeset<-merge_set[,c(1,2,cols_extract)]

#Uses descriptive activity names to name the activities in the data set
for(i in activity_labels[,1]) {
        tmprepalcement<-sub(pattern=i,replacement=activity_labels[i,2],extract_mergeset[,2])
        extract_mergeset[,2]<-tmprepalcement
}

#Appropriately labels the data set with descriptive variable names. 
variblenames<-c("subject_id","activity",as.character(features[cols_extract-2,2]))
names(extract_mergeset)<-variblenames

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidydataset<-ddply(extract_mergeset, .(subject_id, activity), function(x){tmp<-sapply(x[,3:ncol(extract_mergeset)],mean)
                                                                          sapply(tmp,function(x)format(x,scientific=TRUE,digit=8))
})

#write tidy data set into file "tidydataset.txt",which is saved 
#in the working directory;
write.table(tidydataset,file="./tidydataset.txt",quote = FALSE,row.names = FALSE)

