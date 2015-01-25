# Getting-tidy-data
Coursera data science - 03 Getting and cleaning data - Course project

1. Merges the training and the test sets to create one data set
Firstly I have to prepare "test" and "train" data sets

a. I store activity_labels (comes on the file activity_levels.txt) in a variable called "activity_labels"
b. I go to test folder and I read the 3 files: subject_test (dim[2947,1]), X_test (dim[2947,561]) and y_test (dim[2947,1]). They contain the number of the subject (1 to 30) that does the activity, the records measured by the phone and the activity number (1 to 6) respectively.
c. These 3 files contain the same number of rows, so I merge then into 1 data frame x_test_f (dim[2947,564}).
d. What I do in previous steps is to allocate the column names as it is asked on forward.
e. I create a new variable in this data frame called "Measure.time" indicating whether the activity performed is a test or a train. It would be a factor with 2 possible values: "test" or "train".
f. I do the same steps for "train" folder. I save then in x_train_f (dim[7352,564}). I create a new variable in this data frame called "Measure.Type" as I did on the step e.
g. Once both data frame have been created, I merge both using the function rbind(x_test_f,x_train_f) and I store it in a variable named "dataSet" (dim[10299,564])

2. Extracts only the measurements on the mean and standard deviation for each measurement.

a. This question was not clear as we can see in discussion forums. Finally I decide to extract the only the variable names on the measurements that contain mean, Mean or std, using the function grep()
b. The resulting data set is store in newdataSet (dim[10299,90]). I have 90 columns as I have included measurements containing mean, Mean and std.

3.Uses descriptive activity names to name the activities in the data set
a. Using the function merge() and assigning as key the activity number in both data set (newDataSet and activity_labels).
b. I name this new variable (column) as "Activity"
c. It has been store in dataSet_mod

4.Appropriately labels the data set with descriptive variable names. 
a. It has been done on orevious steps.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
a. Using the function aggregate(dataSet_mod,byActivity,Subject),FUN=mean) we obtain the result. I store it in a "tidy_data"
b. As when aggregated the variables defined as factor or character, can not be aggregated, so it will generate a NA value. What I do is to select only the relevant columns



