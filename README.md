==================================================================
**Getting and Cleaning Data - Course Project**

*Version 1.0*

*Module3CourseProject*

This repo contains a ReadMe.md file, a Codebook and an R sript describing the details on my project  

**Author: Sandra Vilchis Bernal**

==================================================================

Project's main tasks
====================

1. Download the data for the project from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Create one R script called run_analysis.R that does the following:

	- Merges the training and the test sets to create one data set.

	- Extracts only the measurements on the mean and standard deviation for each measurement.

	- Uses descriptive activity names to name the activities in the data set

	- Appropriately labels the data set with descriptive variable names.

	- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



Data used in the project
=========================

From the zip file (see task # 1 above), the data used in the project was the following:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

   

The analysis and R coding
===========================
The data should be available in the working directory in an unzipped UCI HAR Dataset folder with the following structure (folder and subfolders):

*Note: see the description given above, before the file name comes their folder name.

      .\\UCI HAR Dataset
                      \\train
                      \\test


The script called "run_analysis.R" contains all the R functions needed to carry out the tasks of the project described above in the following sequence: 

1. Reading the files assuming all is in the working directory as described above.  

2. Exploring the data (a few steps to get familiar with the data):
	- Identifying variables and type of variables in the tables, 
	- Identifying how many records each subject/activity has  
	- Identifying the subjects that participated in the training/test phase 
	- Making sure all activities where performed in the training/test phase
	- Checking that the values in the "X_train" and "X_test"tables are numeric

3. Merging the training and test sets to create one data set, carrying out the following subtasks:
	- Naming the columns with the "subject id" and "activity" information before merging the data to ease the process
	- Creating a table with: id, Activity and measurements for the training and test phases separately to avoid mixing data
	- Merging the training and test sets to create one data set

4. Extracting only the measurements on the mean and standard deviation for each measurement, by:
	- Identifying all the measurement names with the word "-mean()" or "-std()" in the table "featLabels", which lists all the measurements names; all the other measurements containing the words "mean" or "std" in another format were ignored since they were out of the scope of this project
	- Putting together all the positions/indices where the word "-mean()" or "-std()" were found since the search was done in separately steps (one for "-mean()" and another for "-std()")
	- Sorting the positions/indices so that the measurements can be selected in the same order as in the original files
	- Creating a data set "T_dataMeanStd" with only the identified required measurements (mean and standard deviation for each measurement)

5. Naming the activities in the data set, using descriptive activity names: 
	- Converting to "character" the activity labels, since they are factors
	- Replacing the activity number by the activity name mapping the numbers in the "Activity" column of the "T_dataMeanStd" table to the numbers in the first column of the "actLabels" table, and then replacing the first ones with the names in the second column of the "actLabels" table accordingly 
	- Checking that the replacements were done correctly

6. Labeling the data set with descriptive variable names:
	- Converting to character the feature/measurement labels in the "featLabels" table to ease the matching
	- Creating an OldNames vector to use it in the replacement
	- Creating a copy of the "featLabels" table to avoid confusion, naming it "featMod"
	- Creating a vector/column (featMod$varName) with the corresponding "variable name" in the  format "V1", "V2",.., using the values in the "featMod$V1" column; this step will ease the matching with the oldNames vector to appropriately name the variables/columns    
	- Matching "oldNames" vector (which only has the selected measurements in step 2.) with the content in the "featMod" table using the "featMod$varName" column, and then copying the matched rows to a new table "featMatch"
	- Ensuring that all the wanted "new names" be in the featMatch$V2 column (2nd column)
	- Assigning the "new names" to the variables/columns in the data set "T_dataMeanStd", using the better-descriptive names from the "featMatch" table  

7. Creating a second, independent tidy data set with the average of each variable for each activity and each subject, using the data set in step 6 
	- Creating a "long format" version of the data set "dataMelt" to be able to apply a function (the mean() ) over all the measurements/variables on a grouped information by id" and "Activity" 
	- Grouping the data and applying the function mean() and then reorganizing the data in a new table "sumDF" to have all the measurements as variables/columns; the grouping was done by "Activity" and "id", in this order since the analysis shall focus on activities been performed rather that on the subjects who performed them. 
	- Making sure that there are not duplicated columns in the table 
	- Saving the data set as a txt file called "MyTidyData.txt" with write.table() and using "row.name=FALSE"

The final tidy data set
-----------------------

For each record of the final tidy data set "MyTidyData.txt", it is provided:
- The activity label. 
- An identifier of the subject who carried out the experiment.
- The mean of 66 measurements (variables) on the mean and standard deviation for each measurement.
	

Final notes on the project
===========================
- In this repo you will find a **Codebook.md** file that explains/describes each of the variables in the "MyTidyData.txt" data set.
- To download the txt file in R, if you right click on the file name in the submission box and copy the web address, you can paste it into a script and do as follows:

	address <- "https://s3.amazonaws.com/coursera-uploads/user-81f94bb905e3099d2b0d4458/973498/asst-3/41c23060b95d11e4aad015c7027333dd.txt"
	
	address <- sub("^https", "http", address)
	
	dataIN <- read.table(url(address), header = TRUE, dec = ".",check.names=FALSE) 

- It is important to mention that decimal precision is lost from the write.table() to the read.table(), but nothing to worry about, it is in the very last last decimal 
- My profound gratitude to the **"Discussion Forum"** on the course project, all the people who contributed, really helped me a lot to understand the problem and to come up with ideas to solve it; my sincere thank you to everybody in https://class.coursera.org/getdata-011/forum/list?forum_id=10009

- For more information about the dataset contact: activityrecognition@smartlab.ws


License:
========
Use of this R code **"run_analysis.R"** must be acknowledged by referencing the author's work and the following publications. 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


