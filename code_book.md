# Code Book

This document contains the code book for the final project of the Getting and Cleaning Data course offered by JHU on Coursera.

## Composition

The data set resides in a single table with 6 columns and 5,490 rows.

The data is stored to disk in the CSV file `tidyData.csv`.

## Columns

| | name | type | range | notes                                    |
|:-|-----:|:----:|:-----:|------------------------------------------|
| **ID** | `volunteer` | integer | 1-30 | data was provided on 30 volunteers identified only by a number |
| | `study` | string | test, train | volunteers were assigned to one of two study groups |
| | `activity` | string | (see below) | measurements were taken while volunteers engaged in an activity |
| | `measurement` | string | (see below) | 33 different measurment were taken on each activity performed by each volunteer |
| **data** | `mean` | double | unconstrained | several observations were made for each activity undertaken by a volunteer and their mean is included |
| | `std.dev` | double | unconstrained | several observations were made for each activity undertaken by a volunteer and the standard deviation is included |


### Range of Values

#### activity

1. Walking
2. Walking Upstairs
3. Walking Downstairs
4. Sitting
5. Standing
6. Laying

#### measurement

1. tBodyAcc-X
2. tBodyAcc-Y
3. tBodyAcc-Z
4. tGravityAcc-X
5. tGravityAcc-Y
6. tGravityAcc-Z
7. tBodyAccJerk-X
8. tBodyAccJerk-Y
9. tBodyAccJerk-Z
10. tBodyGyro-X
11. tBodyGyro-Y
12. tBodyGyro-Z
13. tBodyGyroJerk-X
14. tBodyGyroJerk-Y
15. tBodyGyroJerk-Z
16. tBodyAccMag
17. tGravityAccMag
18. tBodyAccJerkMag
19. tBodyGyroMag
20. tBodyGyroJerkMag
21. fBodyAcc-X
22. fBodyAcc-Y
23. fBodyAcc-Z
24. fBodyAccJerk-X
25. fBodyAccJerk-Y
26. fBodyAccJerk-Z
27. fBodyGyro-X
28. fBodyGyro-Y
29. fBodyGyro-Z
30. fBodyAccMag
31. fBodyBodyAccJerkMag
32. fBodyBodyGyroMag
33. fBodyBodyGyroJerkMag

## Meaning of the Measurements

This information is provided in the source document titled `features_info.txt`. The key part provides ...

> **Feature Selection**
> 
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.