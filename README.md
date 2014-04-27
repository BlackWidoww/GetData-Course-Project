==================================================================
Coursera Getting and Cleaning Data Course Project
Human Activity Recognition Using Smartphones Dataset
==================================================================

Courtney Shelley

UC Davis Graduate Group in Epidemiology
5215 VM3A
One Shields Avenue
C/O VM: PMI 
Davis, CA 95616-5294

==================================================================

Data was collected while study participants performed various activities with the Samsung Galaxy S3 smartphone in their pockets.   Activities included: laying (1407 cases), sitting (1286 cases), standing (1374 cases), walking (1226 cases), walking downstairs (986 cases), and walking upstairs (1073 cases) for a total of 7352 subjects with no missing data in the set.   Data consists of acceleration measurements taken over the X-, Y-, and Z-axis, as well as pre-calculated mean acceleration rates and standard deviation of the mean over each axis for each activity type.   

Training and test data sets were provided and merged to form one complete data set.  This data set was ammended to included unique IDs for all data points as well as labelling of the physical activities performed that generated the results.  This complete data set was then subsetted to retain only those data points that related to means and standard deviations of measurements, saved as 'tidy.txt'.    A second data set was also formed which contains only the column means for each measurement, saved as 'meanData.txt'.  

The GetData-Course-Project repository includes the following files:
======================================


- 'README.txt'

- 'tidy.txt':  Tidy data set for further analysis.

- 'meanData.txt': Calculated means of all columns in tidy.txt.

- 'run_analysis.R': Code to reproduce tidy data set and means data set.

- 'CodeBook.Md' : A more detailed description of steps conducted in R code.
 

