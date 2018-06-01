library(plyr) #need to use join functions

#download and unzip source data sets
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "CourseProjectSource.zip",mode="wb" )

unzip("CourseProjectSource.zip")

#load activities data
activities<-read.table("UCI HAR Dataset\\activity_labels.txt", sep=" ", col.names = c("ActivityCode", "ActivityLabel"), stringsAsFactors = FALSE)


#get "train" data sets
X_train<-read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train<-read.table("UCI HAR Dataset\\train\\y_train.txt", sep=" ", col.names = "ActivityCode", stringsAsFactors = FALSE)
y_train<-join(y_train, activities) #order matters!!!
Subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt", sep=" ", col.names = "Subject", stringsAsFactors = FALSE)

#Add Suject, Activity variables to X_train
X_train<-cbind(Activity=y_train$ActivityLabel, X_train)
X_train<-cbind(Subject=Subject_train$Subject, X_train)

#get "test" data sets
X_test<-read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table("UCI HAR Dataset\\test\\y_test.txt", sep=" ", col.names = "ActivityCode", stringsAsFactors = FALSE)
y_test<-join(y_test,activities)
Subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt", sep=" ", col.names = "Subject", stringsAsFactors = FALSE)

#Add Suject, Activity variables to X_test
X_test<-cbind(Activity=y_test$ActivityLabel, X_test)
X_test<-cbind(Subject=Subject_test$Subject, X_test)

#combine X_train and X_test to X
X<-rbind(X_train, X_test)

##Step 2. Extracts only the measuresments on the mean and standard deviation for each observations.
#get all the variables from features.txt
features<-read.table("UCI HAR Dataset\\features.txt", sep=" ", col.names = c("Index", "Feature"), stringsAsFactors = FALSE)

#get std() and mean() feature names and put them in columns. columns has 2 variables: Index and FeatureName.
#columns<-filter(features,Feature %in% features$Feature[grepl("(std|mean)\\(\\)", features$Feature)]) #only basic Mean() and Std()
columns<-filter(features,Feature %in% features$Feature[grepl("(std|mean)", features$Feature)]) #include fancy means
columns<-mutate(columns,Feature=gsub("mean", "Mean", Feature))
columns<-mutate(columns,Feature=gsub("std","Std",Feature))
columns<-mutate(columns,Feature=gsub("-","",Feature))
columns<-mutate(columns,Feature=gsub("\\(\\)","",Feature))
columns$Variable<-paste("V",columns$Index,sep="")

X_MeanSDV<-select(X,"Subject", "Activity",columns$Variable )
names(X_MeanSDV)<-c("Subject", "Activity", columns$Feature)

group_by<-group_by(X_MeanSDV,Subject,Activity)
summary<-summarise_all(group_by, funs(mean=mean))

write.table(summary,file="tidy data.txt", quote=FALSE, row.names = FALSE)
