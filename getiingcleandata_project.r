# create a data directory if not available yet
if(!file.exists("./data")){dir.create("./data")}
#download file
fileUrl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/HAR.zip")
#unzip the folder
unzip("./data/HAR.zip", exdir="./data")
#check what has been extracted
list.files("./data")
#got the name: UCI HAR Dataset folder
#check what is in folder
list.files("./data/UCI HAR Dataset")
#folder train
list.files("./data/UCI HAR Dataset/train")
#folder test
list.files("./data/UCI HAR Dataset/test")
# read files
   y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
   X_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
   subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
   y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
   X_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
   subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
   labels<- read.table("./data/UCI HAR Dataset/activity_labels.txt") #labels are labels[,2]
  # merge indexes with the data (X and Y)

  #merge tables
    X_merged<-rbind(X_train,X_test)
    y_merged<-rbind(y_train,y_test)
    subject_merged<-rbind(subject_train,subject_test)
# Extract only the measurements on the mean and standard deviation for each measurement
    features<-read.table("./data/UCI HAR Dataset/features.txt") # column names for X data
    meanSd_features <- grep("-(mean|std)\\(\\)", features[, 2]) #returns the column numbers needed of X data
    subset_X<-X_merged[,meanSd_features]
#change the column names for X
    names(subset_X)<-features[meanSd_features,2]
# creates a second, independent tidy data 
#link labels. Replace the y with names from the 2nd column of labels data
y_merged<-labels[y_merged[,1],2]
#add y column name:
#names(y_merged)<-"activity" #ne rabotaet po4emu-to
#add subject column name
names(subject_merged)<-"subject"
# combine the data
mergedData<-cbind(subject_merged, y_merged,subset_X)
#change the name for the column y_merged to activity - doesnt work either
#names(mergedData) [2]<-'activity'
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
#wrong order here:
#aggregatedData <-aggregate(mergedData[,3:68], by =list(mergedData$subject,mergedData$y_merged),function(x) mean(x))
#names(aggregatedData)[1:2]<-c("subject", "activity")
library(plyr)
aggregateData<-ddply(mergedData, .(subject, y_merged), function(x) colMeans(x[, 3:68]))
#create a new data file, export the tidy data set
write.table(aggregateData, './data/tidyData.txt',row.names=F)
