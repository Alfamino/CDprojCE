# Clean data project

## Solution

The solution for the project.

* *run_analysis.R* the script that transform the data, the comments are added to the code.
* *code_book.txt* the sample codebook that can be used to the merged *tab_all* that I generated.

## Data set analysis

There are several files that needed to be analized:
* "features.txt" it contain the names of the features, in the merged data the columns will be replaced with this table


It is obivious to combine (rcombine) the train and test folder so I will say about files:
* "subject_train.txt"/"subject_test.txt" it contians the number of the participant - form 1 to 30
* "y_train.txt"/"y_test.txt" it contains the activity number, it will be replaced with "activity_labels.txt"
* "X_train.txt"/"X_test.txt" all the data of the mesurments
