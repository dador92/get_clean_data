## run_analysis.R

# 0. set up the environment ----------


# 1. download, unzip, load the source data sets ------------

sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=sourceUrl, destfile="./Dataset.zip", method="curl") 
unzip("Dataset.zip", exdir = "./")