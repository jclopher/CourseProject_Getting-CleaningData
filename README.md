Run_Analysis.R contains the functions:

mergedata <- function(test_train_file)

+	One parameter --> a data folder with datafiles test or train.
+	Sets the current working directory to datafolder directory.
+	Extracts three files from the each folder, subject file, X file and y file.
+	Links activity labels to activities by comparing to the labels vector.
+	Merges with column index of subject file, activities, y file, X file
+	Returns a data frame of merged data.

Example: The test set data can be extracted with: Test_data <- mergedata(“test”)
Example: The training set data can be extracted with: Train_data <- mergedata(“train”)

mergedataUCIHAR <- function(Data1, Data2)

+	Two parameters “test” and “train” in any sequence.
+	Merges test and train data with row index according to specified sequence.
+	Returns a (10299 x 565) labelled dataframe.
+ Extracts only the measurements on the mean and standard deviation for each measurement
+ Returns a independent tidy data set with the average of each variable for each activity and each subject

Example: AVG_TIDY_DATA <- mergedataUCIHAR("test", "train")