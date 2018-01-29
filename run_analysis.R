URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, "WC.zip")
unzip(zipfile="wc.zip")

testx <- read.delim("X_test.txt", header = FALSE, sep = "")
trainx <- read.delim("X_train.txt", header = FALSE, sep = "")
testy <- read.delim("Y_test.txt", header = FALSE, sep = "")
trainy <- read.delim("Y_train.txt", header = FALSE, sep = "")
activity <- read.delim("activity_labels.txt", header = FALSE, sep = "")

header = read.table("features.txt", header = FALSE)
name1 = c(header)
colnames(testx) = name1$V2
colnames(trainx) = name1$V2
names(testy)[1]<-"activityNumber"
names(trainy)[1]<-"activityNumber"
names(activity)[1]<-"activityNumber"
names(activity)[2]<-"activityName"

testym = merge(testy,activity,by = "activityNumber", sort = FALSE)
trainym = merge(trainy,activity,by = "activityNumber", sort = FALSE)

testm <- cbind(testym,testx)
trainm <- cbind(trainym,trainx)

merge1 = rbind(testm, trainm)
merge1ex = merge1[,grep("mean|std",names(merge1), value = TRUE)]
merge1mean = colMeans(merge1ex)

write.table(merge1mean, "CleanData_v1.txt", sep="\t", row.names = FALSE)
