
# 1. Reading the files ----
# The working directory should have the following structure (folder and subfolders):
#      .\\UCI HAR Dataset
#                      \\train
#                      \\test

X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", sep = "", header = FALSE)  
Y_train <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt", header = FALSE)  
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)  

X_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",sep = "", header = FALSE)  
Y_test <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt", header = FALSE)  
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)  

actLabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", header = FALSE)  
featLabels <- read.table(".\\UCI HAR Dataset\\features.txt", header = FALSE)  


# 2. Exploring the data to get familiar with it -----
#### Identifying variables and type of variables in the table
str(subject_train) 
str(subject_test)  
str(Y_train)
str(Y_test)

#### Identifying how many records each subject/activity has
table(subject_train)     
table(subject_test)      
table(Y_train)           
table(Y_test)            

#### Identifying the subjects that participated in the training/test phase 
unique(subject_train$V1) 
unique(subject_test$V1)  

#### Making sure all activities where performed in the training/test phase
sort(unique(Y_train$V1))     
sort(unique(Y_test$V1)) 

#### Checking that the values in the "X_train" and "X_test"tables are numeric
class(X_train$V1)        
class(X_test$V1)         

# 3. Merge the training and test sets to create one data set.
#### Naming some of the columns before merging the data
names(subject_train)[1]<-"id"  
names(subject_test)[1]<-"id"
names(Y_train)[1]<-"Activity"
names(Y_test)[1]<-"Activity"

#### Creating a table with: id, Activity and measurements for the training and test phases separately
T_train<-cbind(subject_train,Y_train,X_train)  
T_test<-cbind(subject_test,Y_test,X_test)      

#### Merging the training and test sets to create one data set
T_data<-rbind(T_train,T_test)   


# 4. Extract only the measurements on the mean and standard deviation for each measurement.
#### Identifying all the measurement names with the word "-mean()" or "-std()" in the table "featLabels", which lists all the measurements names   
colsMean<-grep("-mean()",featLabels[,2],fixed = TRUE)  # fixed = TRUE for a exact search
colsStd<-grep("-std()",featLabels[,2],fixed = TRUE)    

#### Putting together all the positions/indices where the word "-mean()" or "-std()" were found
colsMeanStd<-c(colsMean,colsStd)

#### Sorting the positions/indices so that the measurements can be selected in the same order as in the original files
colsMeanStd<-sort(colsMeanStd)

#### Creating a data set with only the identified required measurements (mean and standard deviation for each measurement)
library(dplyr)
T_dataMeanStd<-select(T_data,id,Activity,num_range("V",colsMeanStd)) 


# 5. Use descriptive activity names to name the activities in the data set
#### Converting to "character" the activity labels, since they are factors
actLabels[,2]<-as.character(actLabels[,2])

#### Replacing the activity number by the activity name
#### mapping the numbers in the "Activity" column of the "T_dataMeanStd" table to the numbers in the first column of the "actLabels" table, 
#### and then replacing the first ones with the names in the second column of the "actLabels" table accordingly 
library(plyr)
T_dataMeanStd[,2]<-mapvalues(T_dataMeanStd[,2],from=actLabels[,1],to= actLabels[,2])

#### Checking that the replacements were done correctly
unique(T_dataMeanStd[,2])
table(T_dataMeanStd[,2])


# 6. Appropriately label the data set with descriptive variable names.
#### Converting to character the feature/measurement labels
featLabels[,2]<-as.character(featLabels[,2])

#### Creating the OldNames vector to use it in the replacement
oldNames<-names(T_dataMeanStd)

#### Creating a vector/column (featMod$varName) with the corresponding "variable name" in the  format "V1", "V2",.., 
#### using the values in the "featLabels$V1" column
#### all this in a copy of the "featLabels" table; 
#### this step will ease the matching with the oldNames vector to appropriately name the variables/columns    
featMod<-featLabels
featMod$varName<-paste("V",featMod[,1],sep="")

#### Matching "oldNames" vector (which only has the selected measurements in step 2.) with the content in the "featMod" table  
#### using the "featMod$varName" column, and then copying the matched rows to a new table "featMatch"
featMatch<-featMod[match(oldNames,featMod$varName,nomatch=0),]

#### Ensuring that all the wanted "new names" be in the featMatch$V2 column (2nd column)
featMatch[1,2]<-"id"
featMatch[2,2]<-"Activity"

#### Assigning the "new names" to the variables/columns in the data set "T_dataMeanStd", 
#### using the better-descriptive names from the "featMatch" table  
names(T_dataMeanStd)<-featMatch[,2]


# 7. From the data set in step 6, create a second, independent tidy data set with the average of each variable for each activity and each subject.
#### Creating a "long format" version of the data set to be able to apply a function (the mean() ) 
#### over all the measurements/variables on a grouped information by id" and "Activity"
library(reshape2)
dataMelt <- melt(T_dataMeanStd, id = c("id","Activity"), measure.vars = 3:68)

#### Grouping the data and applying the function mean()
#### and then reorganizing the data to have all the measurements as variables/columns
sumDF <- dataMelt %>% dcast( Activity + id ~ variable, mean) 

#### Making sure that there are not duplicated columns in the table 
NodupCols<-!duplicated(names(sumDF)) 
length(which(NodupCols)) == ncol(sumDF) # If TRUE, then no duplicated columns!

#### Saving my data set as a txt file with write.table() and using "row.name=FALSE"
write.table(sumDF,file = "MyTidyData.txt",row.name=FALSE)
