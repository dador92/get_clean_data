# get_clean_data

This is the end-of-course project for the JHU course on [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/) which is hosted on Coursera.

## Getting Started

### Background

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
The project can be run using the `run_analysis.R` script in the RStudio console as follows:
```
> source("run_analysis.R")
```

Realistically someone wanting to study the process will `Run` a few line of the script at a time in RStudio. But remember that the script is sequential and each line of execution must be run in order.

## Data Set

The required raw data set represents data collected from the accelerometers from  Samsung Galaxy S smartphones. The original data was obtained from the UCI Machine Learning Repository and contains a great discussion on [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) if you're interested in the subject.

The project uses an extracted version of this data set which is downloaded by the `run_analysis.R` script. Due to its size (59.7 mb), the data set is *not* included in the GitHub repository.