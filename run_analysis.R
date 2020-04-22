## run_analysis.R
## Master script for executing the final project
## for the course Getting and Cleaning Data
## offered by JHU on Coursers


# 0. set up the environment ----------
library(curl)
source("misc_functions.R")

if (file.exists("./Dataset.zip")) file.remove("./Dataset.zip") # remove any downloaded data
if (file.exists(dataRoot)) unlink(dataRoot, recursive=TRUE)    # remove any old data sets


# 1. download, unzip the source data sets ------------
sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
curl_download(url=sourceUrl, destfile="./Dataset.zip", quiet=FALSE) 
unzip("Dataset.zip", exdir = "./")


# 2. load, assemble, and combine the source data sets ------------
rawTest <- loadAssembleSourceData("test")    # function defined in misc_functions.R file
rawTrain <- loadAssembleSourceData("train")  # function defined in misc_functions.R file
rawAll <- rbindlist(list(rawTest, rawTrain))


# 3. tidy the raw data



# 6 activities and 30 subjects, there will be 6 * 30 = 180 records

#Definitions: Variable is a synonym for feature, attribute, or column. Record is a synonym for instance, tuple, or row.