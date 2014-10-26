## Global

library(plyr)

## url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
project_dir <- "C:/Users/user/Documents/R/Course 3 DataCleaning/projectfiles UCI HAR Dataset/UCI HAR Dataset"
setwd(project_dir)

Files <- list.files(project_dir)
## Files
## [1] "activity_labels.txt" "features.txt"        "features_info.txt"  
## [4] "README.txt"          "test"                "train"   

## Extract features in a vector
features <- read.table(paste(project_dir, "/", Files[2], sep = ""))
features <- as.vector(features$V2)

## Extract Activities into labels
labels <- read.table(paste(project_dir, "/", Files[1], sep = ""))
labels <- as.vector(labels$V2)

mergedataUCIHAR <- function(Data1, Data2) {
    
    ## 1 Merges the training and the test sets to create one data set.
    Data1 <- mergedata(Data1)
    Data2 <- mergedata(Data2)
    DataMerged <- rbind(Data1, Data2)
    cols <- c("Blocks", "Subject", "Activity_label", "Activity", features)
    colnames(DataMerged) <- cols
    
    ## Test & Training Data are Merged 
    DataMerged
    
    dim(DataMerged)
    ## [1] 10299   565
    
    ## 2 Extracts only the measurements on the mean and standard deviation for each measurement
    pattern <- c("mean", "std")
    measurements <- unique(grep(paste(pattern, collapse = "|"), colnames(DataMerged), value = TRUE))
    Mean_Std <- DataMerged[, measurements]
    
    ##Creates a second, independent tidy data set with the 
    ## average of each variable for each activity and each subject.
    DataTable <- split(DataMerged[, 5:565], list(DataMerged$Activity, DataMerged$Subject))
    Averagedata <- sapply(DataTable, colMeans)
    write.table(Averagedata, file = "avg_tidy_data.txt",sep = ",",row.names=FALSE)
}

mergedata <- function(test_train_file) {
        
    ## Set Data Test or Train directory
    setwd(paste(project_dir, "/", test_train_file, sep = ""))

    ## List files in Working Directory
    DFiles <- list.files(getwd())
    S <- DFiles[2]
    X <- DFiles[3]
    Y <- DFiles[4]
    
    ## Extracting data files and merging data
    Data <- do.call("cbind", lapply(c(S, Y, Y, X), function(dn) data.frame(read.table(dn))))
    Activity <- Data[, 3]
    
    for (i in Activity) {
        Activity[Activity == i] = labels[i]
    }
    
    Data[, 3] <- Activity
    
    ## Blocks column to identify subject groupings
    Blocks <- rep(paste(test_train_file, "set", sep = ""), nrow(Data))
    Data <- cbind(data.frame(Blocks), Data)
    Data
    
}

