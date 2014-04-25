library(reshape2)

# change directory variables as per your settings
parentdirectory <- "UCI HAR Dataset"
testdirectory <- "test"
traindirectory <- "train"

# helper functions to load data from the directories
loadtestdata <- function(filename) read.table(file.path(parentdirectory,testdirectory,paste(filename,".txt",sep="")))
loadtraindata <- function(filename) read.table(file.path(parentdirectory,traindirectory,paste(filename,".txt",sep="")))


#load the training and test data sets
print("Loading X_test data ... ")
xtest <- loadtestdata("X_test")

print("Loading y_test data ... ")
atest <- loadtestdata("y_test")

print("Loading subject_test data ... ")
stest <- loadtestdata("subject_test")

print("Loading X_train data ... ")
xtrain <- loadtraindata("X_train")

print("Loading y_train data ... ")
atrain <- loadtraindata("y_train")

print("Loading subject_train data ... ")
strain <- loadtraindata("subject_train")

print("Loading features list ... ")
features <- read.table(file.path(parentdirectory,"features.txt"))

print("Loading activity lables ... ")
activitylabels <- read.table(file.path(parentdirectory,"activity_labels.txt"))
activitylabels <- as.character(activitylabels[[2]])

# tidy up feature names: drop "(", ")", "-", ","
features$V2 <- gsub("\\(|\\)|-|,","",features$V2) 

# merge the training and testing data seperately for raw data, subjects, activities
mergeddata <- rbind(xtest,xtrain)
mergedactivity <- rbind(atest,atrain)
mergedsubject <- rbind(stest,strain)

# set column names for the merged data
colnames(mergeddata) <- as.character(features[[2]])
colnames(mergedactivity) <- c("activityID")
colnames(mergedsubject) <- c("subject")

# add another column converting activity ID to activty label
mergedactivity$activitylabel <- as.character(activitylabels[mergedactivity$activityID])

# finally merge raw data, subjects data and activity data
fulldata <- cbind(mergedsubject,mergedactivity,mergeddata)


# select only the columns which correspond to mean and standard deviation features
meanstdcols <- grep("(mean|std)",colnames(fulldata))
# Uncomment the following two lines if meanfreq features are to be excluded.
#meanfreqcols <- grep("meanFreq",colnames(fulldata))
#meanstdcols <- !(meanstdcols %in% meanfreqcols)
# subset the fulldata corresponding to the mean and standard deviation features 
meanstddata <- fulldata[,c("subject","activityID","activitylabel",colnames(fulldata)[meanstdcols])]


# create meanstdaverages data frame which will hold the tidy data on means and std. deviation features
meanstdaverages <- as.data.frame(matrix(0,180,ncol(meanstddata)))
# set column names of meanstdaverages data
colnames(meanstdaverages) <- colnames(meanstddata)
# populate the subject and activity ID column
meanstdaverages$subject = rep(1:30,6) # subjects go 1,2,3...,1,2,3,...
meanstdaverages$activityID = rep(1:6,each=30) # activities go 1,1,1,...2,2,2,...,3,3,3,...
# fill in activity labels corresponding to activity IDs
meanstdaverages$activitylabel <- as.character(activitylabels[meanstdaverages$activityID])

# calculate averages by subject and activity and update the meanstdaverages data frame
for(i in 4:ncol(meanstddata)) {
    feature = colnames(meanstddata)[i]
    selectdata <- melt(meanstddata, id=1:2, measure.vars=feature)
    averagetable <- dcast(selectdata,subject ~ activityID, fun.aggregate=mean,value.var="value", margins=F)
    average <- melt(averagetable[,-1])
    meanstdaverages[,feature]<-average$value
}

# write the tidy data in the CSV file meanstdaveragesdata.csv
write.csv(meanstdaverages,file.path("meanstdaveragesdata.csv"))

# write the tidy data in the plain text TXT file meanstdaveragesdata.txt
write.table(meanstdaverages, file.path("meanstdaveragesdata.txt"), sep="\t", row.names=FALSE)
