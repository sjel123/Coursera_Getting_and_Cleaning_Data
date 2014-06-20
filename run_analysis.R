#Project
#You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# Source of data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.
setwd("./Data/UCI HAR Dataset/")
#Merge Subject files
  temp1 <- read.table("./train/subject_train.txt",  header=FALSE)
  temp2 <- read.table("./test/subject_test.txt",  header=FALSE)

    subjects <- rbind(temp1,temp2)
    names(subjects) <- "Subjects"

#Merge X files
  temp1 <- read.table("./train/X_train.txt", header=FALSE)
  temp2 <- read.table("./test/X_test.txt", header=FALSE)

    X <- rbind(temp1,temp2)

#read in features and assign to X column names
  features <- read.table("./features.txt")
    names(X) <- features$V2

#Merge y files
  temp1 <- read.table("./train/y_train.txt", header=FALSE)
  temp2 <- read.table("./test/y_test.txt", header=FALSE)

    y <- rbind(temp1,temp2)
    names(y) <- "Activity"

#Merge all three files
  data <- cbind(subjects, X, y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

  X <- X[, grep('mean|std', features$V2)]
  X <- data.frame(Activity = data$Activity, X)

# Note that this includes meanFreq()s - it's not clear whether we need those,
# but they're easy to exlude if not needed. Can eliminate meanFreq() with the following

#   X <- X[,-grep('meanFreq', names(X))]

# 3. Uses descriptive activity names to name the activities in the data set AND
# 4. Appropriately labels the data set with descriptive variable names.
# Convert activity labels to meaningful names
  activityLabels<-read.table("./activity_labels.txt")
  names(activityLabels) <- c("Id", "Names")

  y$Activity <- activityLabels[y$Activity,]$Names
  X$Activity <-y$Activity

#5 Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
  data$Activity <-y$Activity
  data <- subset(data, select=c(Subjects, Activity,2:562)) #rearrange columns
    tidy = aggregate(data, by=list(activity = data$Activity, subject=data$Subjects), mean)
# Remove the subject and activity column, since a mean of those has no use
     tidy$Subjects = NULL
     tidy$Activity = NULL
write.table(tidy, file="tidy.txt", sep="\t", row.names=FALSE)
           
            