# get_clean_data

This is the end-of-course project for the JHU course on [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/) which is hosted on Coursera.

## Getting Started

### Background on Big Data in Sports Metrics

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. For more information, see the artcile [Big Data, Activity Tracking, And The Battle For The
world's Top Sports Brand](big_data_sports_article.pdf) written by David Stern.

### Prerequisites

This project uses the R programming language, and RStudio which is the defacto tool for working with R. This project repository is on GitHub. The specific versions used in developing this project were ...

* [R ver. 3.6.3](https://cran.r-project.org/)
* [RStudio ver. 1.2.5003](https://rstudio.com/products/rstudio/download/)
* [Project repository on GitHub](https://www.github.com/dador92/get_clean_data/)

While earlier versions of these technologies may work, the latest versions are recommended.

### Getting a Copy of the Project to Work With

Please clone the project into your own GitHub account and then access through RStudio using the `File > New Project... > Version Control > Git` command.



## Running the Project

### Master Script

The project can be run using the `run_analysis.R` script in the RStudio console as follows:
```
> source("run_analysis.R")
```

Realistically someone wanting to study the process will `Run` a few line of the script at a time in RStudio. But remember that the script is sequential and each line of execution must be run in order.

### Raw Data Set

The required raw data set represents data collected from the accelerometers from  Samsung Galaxy S smartphones. The original data was obtained from the UCI Machine Learning Repository and contains a great discussion on [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) if you're interested in the subject.

The project uses an extracted version of this data set which is downloaded by the `run_analysis.R` script directly from the JHU online repository. Due to its size (62.6 MB), the data set is *not* included in the GitHub repository.

#### Content

The raw data set consists of many files located in a nested directory structure. A description of the data contained therein is as follows:

* Thirty (30) Vounteers were split into two study groups titled "test" and "train". The division is as follows:
  + 9 volunteers in the test study group `{ 2, 4, 9, 10, 12, 13, 18, 20, 24 }`
  + 21 volunteers in the train study group `{ 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30 }`
 * Using an accelerometer and gyroscope attached to each subject, the researchers took measurements from these devices while the volunteers engaged in 6 different activities, namely ...
   1. Walking
   2. Walking Upstairs
   3. Walking Downstairs
   4. Sitting
   5. Standing
   6. Laying
* The measurements can be split between time measurements (some of which were taken in 3D) and those involving a Fast Fourier Transform (also some in 3D). Combined, they make up 33 different measurements, 8 of them with an X, Y, and Z component (i.e., 3D).
* After recording all the observations of the volunteers engaged in the 6 different activities across 33 measurements, the reasearchers statistically summarized each measurement 17 ways, including mean and standard deviation (which is the focus of the tidy data set). But that means that even the statistically summarized data contains `33 measurements x 17 statistics = 561 variables` which the researchers call "features".

#### Files of Interest

As a general observation, the data files in the raw data set are all fixed width text files. Not all the files will be used, which will be explained later. Here is a hierarchical listing of the files of interest and what they contain ...

* `HCI HAR Dataset` directory: root directory for the dataset
   + **`activity_labels.txt`** file: contains a mapping of the 6 different activities from the integer value used in the raw data set and the activities' textual descriptions
   + **`features.txt`** file: all 561 of the variable labels for the 17 statistics calculated on the 33 different measurements; in the raw data set a variable is called a "feature"
   + `test` subdirectory: where the data from the **test study group** resides
      - **`subject_test.txt`** file: a vector of the volunteer for each observation in the test main data set (which is `X_test.txt`)
      - **`y_test.txt`** file : a vector of the activity code (an integer) for each observation in the test main data set (which is `X_test.txt`); the textual description of each code is provided in the `activity_labels.txt` file located in the parent directory
      - **`X_test.txt`** file: the file for the test study group containing the 561 statistical values which breaks down into 17 statistical values for 33 measurements recorded by the accelerometer and gyroscope attached to each volunteer (2,947 rows of observations across 561 features/variables at 26.5 MB)
      - `Inertial Signals` subdirectory: ignored; more explanation later, but essentially the statistics needed for the tidy data set solution (mean and standard deviation) are already in the `X_test.txt` file in this subdrectory)

   + `train` subdirectory: where the data from the **train study group** resides
      - **`subject_train.txt`** file: a vector of the volunteer for each observation in the train main data set (which is `X_train.txt`)
      - **`y_train.txt`** file : a vector of the activity code (an integer) for each observation in the train main data set (which is `X_train.txt`); the textual description of each code is provided in the `activity_labels.txt` file located in the parent directory
      - **`X_train.txt`** file: the file for the train study group containing the 561 statistical values which breaks down into 17 statistical values for 33 measurements recorded by the accelerometer and gyroscope attached to each volunteer (7,352 rows of observations across 561 features/variables at 66 MB)
      - `Inertial Signals` subdirectory: ignored; more explanation later, but essentially the statistics needed for the tidy data set solution (mean and standard deviation) are already in the `X_train.txt` file in this subdrectory)

#### Initial Assembly of Raw Data

The initial assembly of the raw data from 4 separate files in each study group is done first to get a cohesive data set. This assembly is done for both the test study group as well as the train study group. Below is a graphic of the initial assembly of the raw data files for the test study group in order to get an initial cohesive data set from the test study group.

<div align="center">
  <img  src="./images/raw_layout_test.png"></img>
</div>

Once both study groups have been loaded and assembled, they are combined into a single data table for tidying (titled `rawAll` in the script).

## Making the Data Tidy

This section explains the fundamental steps taken by the `run_analysis.R` script to tidy up the raw data set.
