# Getting and cleaning data

The data for this assignment was acquired from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data instructions were acquired from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data files
Data files used for this project:
- activity_labels.txt
- features.txt
- X_test.txt
- Y_test.txt
- X_train.txt
- Y_train.txt

## Step by step instructions
1. A variable URL was created to stored the data download link: URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. The data was download to the working directory, stored as WC.zip: download.file(URL, "WC.zip")
3. The data was extracted from the Zip file: unzip(zipfile="wc.zip")
4. In total five data files were read into R as variables:
testx <- read.delim("X_test.txt", header = FALSE, sep = "")
trainx <- read.delim("X_train.txt", header = FALSE, sep = "")
testy <- read.delim("Y_test.txt", header = FALSE, sep = "")
trainy <- read.delim("Y_train.txt", header = FALSE, sep = "")
activity <- read.delim("activity_labels.txt", header = FALSE, sep = "")

5. The header names for the main data were updated:
header = read.table("features.txt", header = FALSE)
name1 = c(header)
colnames(testx) = name1$V2
colnames(trainx) = name1$V2

6. The header names for the supporting files were updated:
names(testy)[1]<-"activityNumber"
names(trainy)[1]<-"activityNumber"
names(activity)[1]<-"activityNumber"
names(activity)[2]<-"activityName"

7. The Y_test and Activity data was merged using the activityNumber variable, with no sorting: testym = merge(testy,activity,by = "activityNumber", sort = FALSE)
8. The Y_train and Activity data was merged using the activityNumber variable, with no sorting: trainym = merge(trainy,activity,by = "activityNumber", sort = FALSE)

9. The X_test and merged data from 7. above were merged to create a complete test dataset: testm <- cbind(testym,testx)
10. The X_train and merged data from 8. above were merged to create a complete train dataset: trainm <- cbind(trainym,trainx)

11. The two datasets from 9. and 10. above were merged to create one complete dataset: merge1 = rbind(testm, trainm)
12. An extract containing the columns with "std" or "mean" was created: merge1ex = merge1[,grep("mean|std",names(merge1), value = TRUE)]
13. An extract containing only one row with average values was created from the dataset from 12.: merge1mean = colMeans(merge1ex)

14. The dataset from 13. was exported to a txt file: write.table(merge1mean, "CleanData_v1.txt", sep="\t", row.names = FALSE)

