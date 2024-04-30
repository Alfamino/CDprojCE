# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data
#   set with the average of each variable for each activity and each subject.

#list.files(".")
# Activities
list.files("UCI HAR Dataset")
file_al <- "activity_labels.txt"
fp <- file.path("UCI HAR Dataset",file_al)
tab_act <- read.table(fp)
names(tab_act) <- c("nr","activity")


#
list.files( "UCI HAR Dataset")
file_name <- "features.txt"
file_path <- file.path("UCI HAR Dataset",file_name)
tab_fea <- read.table(file_path)
names(tab_fea) <- c("id","info")
head(tab_fea)

# MERGE SUBJECT
## subject_train.txt TRAIN
folder_name = "train"
list.files( file.path("UCI HAR Dataset",folder_name) )
# "subject_train.txt" "X_train.txt"       "y_train.txt"
file_name <- "subject_train.txt"
file_path <- file.path("UCI HAR Dataset",folder_name,file_name)
tab_sub_trn <- read.table(file_path)
names(tab_sub_trn) <- c("subject")
head(tab_sub_trn)

## subject_train.txt TEST
folder_name = "test"
list.files( file.path("UCI HAR Dataset",folder_name) )
# "subject_train.txt" "X_train.txt"       "y_train.txt"
file_name <- "subject_test.txt"
file_path <- file.path("UCI HAR Dataset",folder_name,file_name)
tab_sub_tst <- read.table(file_path)
names(tab_sub_tst) <- c("subject")
head(tab_sub_tst)
# test

tab_sub <- rbind( tab_sub_trn,tab_sub_tst )
(nrow( tab_sub_trn ) +nrow( tab_sub_tst ))==nrow(tab_sub)
head(tab_sub)

rm("tab_sub_trn","tab_sub_tst")
ls()

##


# MERGE X
## X_train.txt TRAIN
folder_name = "train"
list.files( file.path("UCI HAR Dataset",folder_name) )
# "X_train.txt"       "y_train.txt"
file_name <- "X_train.txt"
file_path <- file.path("UCI HAR Dataset",folder_name,file_name)
tab_X_trn <- read.table(file_path)
nrow(tab_X_trn)
names(tab_X_trn)

## X_test.txt TEST
folder_name = "test"
list.files( file.path("UCI HAR Dataset",folder_name) )
# "X_test.txt"       "y_train.txt"
file_name <- "X_test.txt"
file_path <- file.path("UCI HAR Dataset",folder_name,file_name)
tab_X_tst <- read.table(file_path)
nrow(tab_X_tst)
names(tab_X_tst)

# merge
tab_X <- rbind( tab_X_trn,tab_X_tst )
(nrow( tab_X_trn ) +nrow( tab_X_tst ))==nrow(tab_X)
names(tab_X)

rm("tab_X_trn","tab_X_tst")
ls()

# Names
names(tab_X) <- tab_fea$info
names(tab_X)

# filter mean and std
phrase = "mean|std"
keep_cols <- grep(phrase, names(tab_X))
tab_X <-  tab_X[,keep_cols]
names(tab_X)
#names(tab_X) <- tolower( names(tab_X) )

###################

# MERGE Y
## LOAD y_train.txt TRAIN
folder_name = "train"
list.files( file.path("UCI HAR Dataset",folder_name) )
# "y_train.txt"
file_name <- "y_train.txt"
file_path <- file.path("UCI HAR Dataset",folder_name,file_name)
tab_y_trn <- read.table(file_path)
names(tab_y_trn) <- c("activity")
table(tab_y_trn)

## y_test.txt TEST
folder_name = "test"
list.files( file.path("UCI HAR Dataset",folder_name) )
# LOAD "y_test.txt"
file_name <- "y_test.txt"
file_path <- file.path("UCI HAR Dataset",folder_name,file_name)
tab_y_tst <- read.table(file_path)
names(tab_y_tst) <- c("activity")
table(tab_y_tst)
# test

# merge y
tab_y <- rbind( tab_y_trn,tab_y_tst )
(nrow( tab_y_trn ) +nrow( tab_y_tst ))==nrow(tab_y)
table(tab_y)

# delete
rm("tab_y_trn","tab_y_tst")
ls()

# new names
head(tab_y)
library(stringr)
tab_y$activity <- str_replace( tolower( factor(tab_y$activity, levels = c(1,2,3,4,5,6), labels = tab_act$activity ) ) , "_" , " ")
table(tab_y)

#########################

nrow(tab_sub)
nrow(tab_y)
nrow(tab_X)

tab_all <- cbind( tab_sub , tab_y , tab_X )
head(tab_all)

str(tab_all)

####################
library(tidyr)
library(dplyr)
tab_all %>% group_by( activity , subject ) %>% summarise_all(mean)
