## load feature, test and train data
features <- read.csv("./UCI HAR Dataset/features.txt", sep = "", header = FALSE)
testDS <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
trainDS <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
trainAL <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
testAL <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
activityL <- read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")
## change colname of train & test data
colnames(trainDS) <- features[,2]
colnames(testDS) <- features[,2]
mergeDS <- trainDS ## mergeDS for merging train and test data
## merging data
for(i in 1:2947) {
        mergeDS[7352+i,] = testDS[i,]
}

## No.2 get mean and std only
meanNstdFlag <- grepl("mean|std", features[,2])
meanNstdOntyDS <- mergeDS[,meanNstdFlag]

## No.3 get discriptive activity names
mergeAL <- trainAL
for(i in 1:2947) {
        mergeAL[7352+i,] = testAL[i,]
}
colnames(mergeAL) <- c("mergeAL") # add column name
colnames(activityL) <- c("activityLabel","activityName") # add column name
meanNstdOntyDS$activityL <- mergeAL$mergeAL # add column to mergeDS
meanNstdOntyDSwithLabelName <- merge(meanNstdOntyDS, activityL, by.x = "activityL", by.y = "activityLabel")