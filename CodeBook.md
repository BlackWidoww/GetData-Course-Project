setwd("./UCI HAR Dataset")


Download data package from course website 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data package must then be unzipped.  Unzipped data file contains the following files:
- activity_labels.txt: Descriptive labels of code values used in physical activities data column
- features_info.txt: Codebook of labeling used in column names and their derivations.
- features.txt: column names used in data sets
- README.txt: introductory reading for experiment and resulting data
- test folder: testing data consisting of 2947 observations
- train folder: training data consisting of 7352 observations.  

test and train folders contain:
- Inertial Signals folder (ignored for this project)
- subject_test.txt or subject_train.txt (ignored for this project)
- X_test.txt or X_train.txt: data set of recordered phone readings
- y_test.txt or y_train.txt: coded activity labels for each data point, decoded using activity_labels.txt


Load training and testing data sets into R using read.table(), as well as file containing descriptive column names.
```{r}
train<-read.table("./train/X_train.txt")                     # Load training data set
test<-read.table("./test/X_test.txt")                        # Load test data set
features<-read.table("./UCI HAR Dataset/features.txt")       # Load descriptive column names
```

Rename column labels using descriptive column names file, and create additional column of unique IDs for each
line of observations.  Column bind IDs, activity codes, and training or testing data, then row bind training and 
testing data into a single data set.  
```{r}
colnames(train)<-features[,2]                                # Rename training columns
colnames(test)<-features[,2]                                 # Rename test columns

ID<-c(1:7352)                                                        # Unique ID label for each row
activity_labels<-read.table("./UCI HAR Dataset/train/y_train.txt")   # Activity labels
training<-cbind(ID,activity_labels,train)

ID<-c(7353:7353+2947)
activity_labels<-read.table("./UCI HAR Dataset/test/y_test.txt")
testing<-cbind(ID,activity_labels,test)

data<-rbind(training,testing)                                # Merged data set
```

To subset data set to only include mean and standard deviation columns, identify only those column names containing
"mean" or "standard deviation".  

```{r}
toMatch <- c("mean\\(\\)[-]", "std\\(\\)[-]", "meanFreq\\(\\)[-]")   # Match any column name
                                                # that includes "mean", "std", or "meanFreq" 
matches <- unique(grep(paste(toMatch,collapse="|"), features$V2, value=TRUE))  
                                                # List of desired column names
shortData<-data[matches]
```

Replace coded activity_labels with their more descriptive worded labels.  Combine this vector with ID vector
and subsetted data created above into completed Tidy Data Set.  Write a new .txt file to submit for grading.

```{r}
library(plyr)
revalue(activities,c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", 
                     "4"="SITTING", "5"="STANDING", "6"="LAYING"))
IDs<-data[,1]; activities<-as.factor(data[,2])
MyData<-cbind(IDs,activities,shortData)
write.table(MyData, file = "tidy.txt")             # Create new tidy data file
```

Finally, create a new data set consisting of the column means for each column found in the Tidy Data Set.  
Write a new .txt file to submit for grading.  

```{r}
newData<-MyData
meanData<-apply(newData[,3:59],2,mean)
write.table(meanData, file = "meanData.txt")
```
