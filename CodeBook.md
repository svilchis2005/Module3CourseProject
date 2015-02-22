DATA DICTIONARY -MyTidyData.txt
===============================

Activity
  
      Type: factor
      
      Activity being performed while the measurements where taken
      
      - WALKING
      - WALKING_UPSTAIRS
      - WALKING_DOWNSTAIRS
      - SITTING
      - STANDING
      - LAYING

Id

      Type: integer
      
      Identification number of the subject performing the "Activity" 
      
      - 1: subject # 1
      - 2: subject # 2
      - 3: subject # 3
      - ...
      - 30: subject # 30
      
      
**General description of the last and following 66 variables**

- '**t**': Refers to time domain signals
- '**f**': Refers to frequency domain signals (Fast Fourier Transform (FFT) was applied)
- '**Acc**': Refers to accelerometer 3-axial signals
- '**Gyro**': Refers to gyroscope 3-axial signals
- '**Body**': Refers to body signals
- '**Gravity**': Refers to gravity signals
- '**Jerk**': Refers to Jerk signals (body linear acceleration and angular velocity were derived in time)
- '**Mag**': Refers to Euclidean norm
- '**-X**': Refers to signals in the X direction
- '**-Y**': Refers to signals in the Y direction
- '**-Z**': Refers to signals in the Z direction
- '**-mean()**': mean of the measurement
- '**-std()**': standard deviation of the measurement

Type: numeric

The information contained in each of the following 66 variables, is the **mean** of the original measurements, calculated by group of *Activity + Id*. For more details on how the grouping was performed and on how the mean was calculated, please refer to the **ReadMe.md** file in this repo.  

tBodyAcc-mean()-X

tBodyAcc-mean()-Y

tBodyAcc-mean()-Z

tBodyAcc-std()-X

tBodyAcc-std()-Y

tBodyAcc-std()-Z

tGravityAcc-mean()-X

tGravityAcc-mean()-Y

tGravityAcc-mean()-Z

tGravityAcc-std()-X

tGravityAcc-std()-Y

tGravityAcc-std()-Z

tBodyAccJerk-mean()-X

tBodyAccJerk-mean()-Y

tBodyAccJerk-mean()-Z

tBodyAccJerk-std()-X

tBodyAccJerk-std()-Y

tBodyAccJerk-std()-Z

tBodyGyro-mean()-X

tBodyGyro-mean()-Y

tBodyGyro-mean()-Z

tBodyGyro-std()-X

tBodyGyro-std()-Y

tBodyGyro-std()-Z

tBodyGyroJerk-mean()-X

tBodyGyroJerk-mean()-Y

tBodyGyroJerk-mean()-Z

tBodyGyroJerk-std()-X

tBodyGyroJerk-std()-Y

tBodyGyroJerk-std()-Z

tBodyAccMag-mean()

tBodyAccMag-std()

tGravityAccMag-mean()

tGravityAccMag-std()

tBodyAccJerkMag-mean()

tBodyAccJerkMag-std()

tBodyGyroMag-mean()

tBodyGyroMag-std()

tBodyGyroJerkMag-mean()

tBodyGyroJerkMag-std()

fBodyAcc-mean()-X

fBodyAcc-mean()-Y

fBodyAcc-mean()-Z

fBodyAcc-std()-X

fBodyAcc-std()-Y

fBodyAcc-std()-Z

fBodyAccJerk-mean()-X

fBodyAccJerk-mean()-Y

fBodyAccJerk-mean()-Z

fBodyAccJerk-std()-X

fBodyAccJerk-std()-Y

fBodyAccJerk-std()-Z

fBodyGyro-mean()-X

fBodyGyro-mean()-Y

fBodyGyro-mean()-Z

fBodyGyro-std()-X

fBodyGyro-std()-Y

fBodyGyro-std()-Z

fBodyAccMag-mean()

fBodyAccMag-std()

fBodyBodyAccJerkMag-mean()

fBodyBodyAccJerkMag-std()

fBodyBodyGyroMag-mean()

fBodyBodyGyroMag-std()

fBodyBodyGyroJerkMag-mean()

fBodyBodyGyroJerkMag-std()

**Notes**
- It is important to mention that decimal precision is lost from the write.table() to the read.table(), but in the very last decimal, nothing to worry about.

  
