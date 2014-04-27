setwd("./UCI HAR Dataset")


######  STEP 1:  Merging Two Data Sets  ##########

train<-read.table("./train/X_train.txt")     # Load training data set
test<-read.table("./test/X_test.txt")        # Load test data set

features<-read.table("./UCI HAR Dataset/features.txt")       # Load descriptive column names
colnames(train)<-features[,2]                                # Rename training columns
colnames(test)<-features[,2]                                 # Rename test columns

ID<-c(1:7352)                                                        # Unique ID label for each row
activity_labels<-read.table("./UCI HAR Dataset/train/y_train.txt")   # Activity labels
training<-cbind(ID,activity_labels,train)

ID<-c(7353:7353+2947)
activity_labels<-read.table("./UCI HAR Dataset/test/y_test.txt")
testing<-cbind(ID,activity_labels,test)

data<-rbind(training,testing)                                # Merged data set


######  STEP 2:  Subsetting into Mean and Standard Deviation Columns Only   ##########

toMatch <- c("mean\\(\\)[-]", "std\\(\\)[-]", "meanFreq\\(\\)[-]")   # Match any column name
                                                # that includes "mean", "std", or "meanFreq" 
matches <- unique(grep(paste(toMatch,collapse="|"), features$V2, value=TRUE))  
                                                # List of desired column names
shortData<-data[matches]


######  STEP 3:  Descriptive Activity Names   ##########

library(plyr)
revalue(activities,c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", 
                     "4"="SITTING", "5"="STANDING", "6"="LAYING"))
IDs<-data[,1]; activities<-as.factor(data[,2])
MyData<-cbind(IDs,activities,shortData)
write.table(MyData, file = "tidy.txt")             # Create new tidy data file

######   STEP 4:  Second Data Set with Average Values    #########

newData<-MyData
meanData<-apply(newData[,3:59],2,mean)
write.table(meanData, file = "meanData.txt")
