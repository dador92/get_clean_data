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
data.raw.test <- loadAssembleSourceData("test")    # function defined in misc_functions.R file
data.raw.train <- loadAssembleSourceData("train")  # function defined in misc_functions.R file
data.raw.all <<- rbindlist(list(data.raw.test, data.raw.train))

rm(data.raw.test, data.raw.train)

object.size(data.raw.all)


# 3. tidy up the raw data ----------

#    a. Step 1 ->keep only the variables (features) that measure mean() or std()
keepVars <- list("study", "vols", "acts", "mean\\(\\)", "std\\(\\)")
keepPattern <- paste(keepVars, collapse="|")
rawColNames <- colnames(data.raw.all)
keepNames <- rawColNames[grep(keepPattern, rawColNames)]
data.s1 <<- data.raw.all[, keepNames, with = FALSE]

dim(data.s1)
object.size(data.s1)

rm(rawColNames, keepVars, keepPattern, keepNames)


#    b. Step 2 ->average the measurements of the observations for each study/volunteer/activity combination

# group the data by study/volunteer/activity
data.grp.sva <- data.s1 %>% group_by(study, vols, acts)

# get the mean of the mean variables
data.grp.mean <- data.grp.sva %>% summarize_at(.vars = colnames(.)[grep("mean\\(\\)", colnames(data.grp.sva))], mean)

# compute the average standard deviation (note: averageOfStd() defined in misc_functions.R)
data.grp.std <- data.grp.sva %>% summarize_at(.vars = colnames(.)[grep("std\\(\\)", colnames(data.grp.sva))], averageOfStd)

# merge the data back together
data.s2 <<- merge(data.grp.mean, data.grp.std, by=c("study", "vols", "acts"))

object.size(data.s2) # 105.6 KB
dim(data.s2)         # 6 activities and 30 subjects remaining, so 6 * 30 = 180 records/rows

rm(data.grp.sva)      # keeping dataGrpMean, dataGrpStd for reshaping step


#    c. Step 3 -> melt the data table so that the 33 measurements are now individual observations
#       with two actual variables: mean and std
data.melt.mean <- meltData(data.grp.mean, "mean")  # function defined in misc_functions.R file
data.melt.std <- meltData(data.grp.std, "std")     # function defined in misc_functions.R file
data.s3 <<- merge(data.melt.mean, data.melt.std, by=c("study", "vols", "acts", "measure"))

object.size(data.s3) # 188.4 KB (the data set got bigger)
dim(data.s3)         # 180 rows flattened for 33 measure pairs, so 180 * 333 = 5,940 records/rows

rm(data.grp.mean, data.melt.mean, data.grp.std, data.melt.std)


#    d. Step 4 -> clean up the labels, write out the file

# set up some helper vectors
labelActivities = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
niceColNames <- c("volunteer", "study", "activity", "measure", "mean", "std.dev")

# one big pipe
data.s4 <<- data.s3 %>% 
            mutate(activity = labelActivities[acts]) %>%           # swap out the activity codes for actual activity names
            select(vols, study, activity, measure, mean, std) %>%  # sequence the columns
            setnames(niceColNames) %>%                             # retitle the columns to more readable terms
            arrange(volunteer, study, activity, measure)           # sort the rows

# save the tidy data
write_csv(data.s4, "./tidyData.csv", append=FALSE)

object.size(data.s4)

rm(labelActivities, niceColNames)
