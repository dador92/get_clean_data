## misc_functions.R
## contains functions to supplement the main run_analysis.R script


library(readr)
library(data.table)


dataRoot <- "./UCI\ HAR\ Dataset"









## loads and assembles the data for a given study group
## since the layout for both study groups (test and train) are the same,
## consolidtaing the load and assembly into a single funtion simplifies
## the scripting
loadAssembleSourceData <- function(studyGroup) {
    
    # 1. load the source data
    #    a. load the variables (features.txt)
    variablesFile <- sprintf("%s/features.txt", dataRoot)
    vars <- read_table2(variablesFile, col_names=FALSE, col_types=c(col_integer(), col_character()))
    
    #    b. load the volunteers (subject_test.txt or subject_train.txt)
    volunteersFile <- sprintf("%s/%s/subject_%s.txt", dataRoot, studyGroup, studyGroup)
    vols <- read_table(volunteersFile, col_names=FALSE, col_types=cols(col_integer()))
    
    #    c. load the activities (y_test.txt or y_train.txt)
    activitiesFile <- sprintf("%s/%s/y_%s.txt", dataRoot, studyGroup, studyGroup)
    acts <- read_table(activitiesFile, col_names=FALSE, col_types=cols(col_integer()))
    
    #    d. load the measured stats (X_test.txt or X_train.txt)
    measuredStatsFile <- sprintf("%s/%s/X_%s.txt", dataRoot, studyGroup, studyGroup)
    measStats <- read_table(measuredStatsFile, col_names=FALSE, col_types=cols(.default = col_double()))
    
    # 2. assemble the different loads into a single data table
    #    a. prepend the study group, volunteers, and activities to the measured stats
    assembled <- cbind(studyGroup, vols, acts, measStats)
    
    #    b. add column labels
    setnames(assembled, c("study", "vols", "acts", vars[[2]]))

    # 3. return the assembled raw data set
    assembled
}


## computes and returns the average of a vector of standard deviations
## designed to be used from within in a plydr summarize() call
averageOfStd <- function(dat) {
    n = length(dat)
    sumVar = 0.0
    for (aStd in dat) {
        aVar <- aStd^2            # square each standard deviation to get its corresponding variance
        sumVar <- sumVar + aVar   # sum up the variances
    }
    avgStd <- sqrt(sumVar / n)    # divide the sum of the variances by their count, then take the square root
}
