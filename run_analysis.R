## run_analysis.R
## Master script for executing the final project
## for the course Getting and Cleaning Data
## offered by JHU on Coursers


# 0. set up the environment ----------
library(curl)
library(dplyr)
source("misc_functions.R")

if (file.exists("./Dataset.zip")) file.remove("./Dataset.zip") # remove any downloaded data
if (file.exists(dataRoot)) unlink(dataRoot, recursive=TRUE)    # remove any old data sets


# 1. download, unzip the source data sets ------------
sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
curl_download(url=sourceUrl, destfile="./Dataset.zip", quiet=FALSE) 
unzip("Dataset.zip", exdir = "./")


# 2. load, assemble, and combine the source data sets ------------
dataRawTest <- loadAssembleSourceData("test")    # function defined in misc_functions.R file
dataRawTrain <- loadAssembleSourceData("train")  # function defined in misc_functions.R file
dataRawAll <- rbindlist(list(dataRawTest, dataRawTrain))

rm(dataRawTest, dataRawTrain)

object.size(dataRawAll)


# 3. tidy up the raw data ----------

#    a. Step 1 ->keep only the variables (features) that measure mean() or std()
keepVars <- list("study", "vols", "acts", "mean\\(\\)", "std\\(\\)")
keepPattern <- paste(keepVars, collapse="|")
rawColNames <- colnames(dataRawAll)
keepNames <- rawColNames[grep(keepPattern, rawColNames)]
dataS1 <- dataRawAll[, keepNames, with = FALSE]

dim(dataS1)
object.size(dataS1)

rm(keepVars, keepPattern, keepNames)


#    b. Step 2 ->average the measurements of the observations for each study/volunteer/activity combination

# group the data by study/volunteer/activity
dataGrpSVA <- dataS1 %>% group_by(study, vols, acts)

# get the mean of the mean variables
dataGrpMean <- dataGrpSVA %>% summarize_at(.vars = colnames(.)[grep("mean\\(\\)", colnames(dataGrpSVA))], mean)

# compute the average standard deviation (note: averageOfStd() defined in misc_functions.R)
dataGrpStd <- dataGrpSVA %>% summarize_at(.vars = colnames(.)[grep("std\\(\\)", colnames(dataGrpSVA))], averageOfStd)

# merge the data back together
dataS2 <- merge(dataGrpMean, dataGrpStd, by=c("study", "vols", "acts"))

object.size(dataS2) # 105.6 KB
dim(dataS2)         # 6 activities and 30 subjects remaining, so 6 * 30 = 180 records/rows

rm(dataGrpSVA)      # keeping dataGrpMean, dataGrpStd for reshaping step


#    c. Step 3 -> melt the data table so that the 33 measurements are now individual observations
#       with two actual variables: mean and std
dataMeltMean <- meltData(dataGrpMean, "mean")
dataMeltStd <- meltData(dataGrpStd, "std")
dataS3 <- merge(dataMeltMean, dataMeltStd, by=c("study", "vols", "acts", "measure"))

object.size(dataS3) # 188.4 KB (the data set got bigger)
dim(dataS3)         # 180 rows flattened for 33 measure pairs, so 180 * 333 = 5,940 records/rows

rm(dataGrpMean, dataMeltMean, dataGrpStd, dataMeltStd)


#    d. Step 4 -> clean up the labels, write out the file

# retitle the columns to more readable terms
niceColNames <- c("study", "volunteer", "activity", "measure", "mean", "std.dev")
setnames(dataS3, niceColNames)

# swap out the activity codes for actual activity names


# add indexes

#Definitions: Variable is a synonym for feature, attribute, or column. Record is a synonym for instance, tuple, or row.