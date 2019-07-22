######################
#### Housekeeping ####
######################

library(dplyr)
setwd("~/Desktop/Coursera Data Science Specialization JHU/3. Getting and Cleaning Data/Project")


##############################
#### Download the dataset ####
##############################

dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "~/Desktop/Coursera Data Science Specialization JHU/3. Getting and Cleaning Data/Project/DATASET.zip"
download.file(dataURL,dest,method="curl")

if(!file.exists("UCI HAR Dataset")){unzip(dest)}


##################################
#### Read relevant data files ####
##################################

features <- read.table("./UCI HAR Dataset/features.txt",col.names = c("no","signal"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activity_id","activity"))
# test series
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = c("subject_id"))
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names=features$signal)
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names="activity_id")
# train series
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = c("subject_id"))
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names=features$signal)
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names="activity_id")


#########################################################################
#### 1. Merge the training and the test sets to create one data set ####
#########################################################################
set <- rbind(test_set,train_set)
labels <- rbind(test_labels,train_labels)
subject <- rbind(test_subject,train_subject)
merged_data <- cbind(subject,labels,set)

# Remove temporary data tables to save space in memory
rm("test_subject","test_set","test_labels","train_subject","train_set",
   "train_labels","set","labels","subject")

##################################################################################################
#### 2. Extract only the measurements on the mean and standard deviation for each measurement ####
##################################################################################################

cond_to_extract <- grepl("subject_id|activity_id|mean|std",colnames(merged_data))
extracted_data <- merged_data[,cond_to_extract]

###################################################################################
#### 3. Use descriptive activity names to name the activities in the data set ####
###################################################################################

extracted_data$activity_id <- factor(extracted_data$activity_id,levels=activities$activity_id,
                                     labels=activities$activity)


#############################################################################
#### 4. Appropriately label the data set with descriptive variable names ####
#############################################################################

var_names <- colnames(extracted_data)

var_names <- gsub("[\\(\\).]","",var_names)
var_names <- gsub("^f","FrequencyDomain",var_names)
var_names <- gsub("^t","TimeDomain",var_names)
var_names <- gsub("mean","Mean",var_names)
var_names <- gsub("std","StandardDeviation",var_names)
var_names <- gsub("Acc","Accelerometer",var_names)
var_names <- gsub("Gyro","Gyroscope",var_names)
var_names <- gsub("Mag","Magnitude",var_names)
var_names <- gsub("BodyBody","Body",var_names)
var_names <- gsub("Freq","Frequency",var_names)


colnames(extracted_data) <- var_names

##################################################################################################
#### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject ####
##################################################################################################

tidy_data <- extracted_data %>%
        group_by(subject_id,activity_id) %>%
        summarize_all(funs(mean))

write.table(tidy_data,"TidyDataSet.txt",row.name=F)



