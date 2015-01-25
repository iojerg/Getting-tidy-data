# Getting-tidy-data
Coursera data science - 03 Getting and cleaning data - Course project

First of all I have saved the UCI HAS Dataset folder in my current working directory, so to run the code you should have this folder in your current directory.
On the scrips I have added some comments to make it easier to read.

1. Merges the training and the test sets to create one data set
Firstly "test" and "train" data sets need to be prepared for merging

a. I store activity_labels (comes on the file activity_levels.txt) in a variable called "activity_labels"
b. I go to test folder and I read the 3 files: subject_test (dim[2947,1]), X_test (dim[2947,561]) and y_test (dim[2947,1]). They contain the number of the subject (1 to 30) that does the activity, the records measured by the phone and the activity number (1 to 6) respectively.
c. These 3 files contain the same number of rows, so I merge then into 1 data frame x_test_f (dim[2947,564}).
d. What I do in previous steps is to allocate the column names as it is asked on forward.
e. I create a new variable in this data frame called "Measure.type" indicating whether the activity performed is a test or a train. It is a factor with 2 possible values: "test" or "train".
f. I do the same steps for "train" folder. I save then in x_train_f (dim[7352,564}). I create a new variable in this data frame called "Measure.Type" as I did on the step e.
g. Once both data frame have been created, I merge both using the function rbind(x_test_f,x_train_f) and I store it in a variable named "dataSet" (dim[10299,564])

2. Extracts only the measurements on the mean and standard deviation for each measurement.

a. This question was not clear as we can see in discussion forums. Finally I decide to extract only the variables name on the measurements that contain mean, Mean or std, using the function grep()
b. The resulting data set is store in newdataSet (dim[10299,90]). I have 90 columns as I have included name of the  measurements containing mean, Mean and std.

3.Uses descriptive activity names to name the activities in the data set

a. Using the function merge() and assigning as key the activity number in both data set (newDataSet and activity_labels).
b. I name this new variable (column) as "Activity"
c. This new data set has been stored in dataSet_mod (dim[10299,91])

4.Appropriately labels the data set with descriptive variable names. 
a. It has been done on previous steps.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

a. Using the function aggregate(dataSet_mod,by=list(Activity,Subject),FUN=mean) we obtain the result. I store it in "tidy_data_0" (dim[35,93]). Notice that thre is not 180 rows as expected (30subjects x 6 activities), there is only 35 combination of activity and subject as well as many subjects does not do all the activities.
b. When aggregated, variables defined as factor or character, can not be aggregated, so it will generate a NA value. What I do is to select only the relevant columns. Aggregate function generates 2 new variables called "Group.1" and "Group.2" which represent Activity and subject. I have 4 additional variables as Activity.number, Activity, Measure.type (test, train) and Subject that takes value Na when aggregating, what I do is to select a sub set with only relevant columns (with values different to Na's).
c. This final and tidy data set is stored in "tidy_data" (dim[35,89])
d. The test file is generated from this data set

#dataSet Code Book

01. Activity.number
    Definition: Indicates the activity number
    Type: int 
    Range: 1:6

02. Activity
    Definition: Activity names
    Type: Factor
    Levels: "LAYING","SITTING", "STANDING","WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"

03. Measure.type
    Definition: Whether the activity was labeled as test or train
    Type: factor
    Levels: "test","train"

04. Subject
    Definition: number that identifies the subject of the activity
    Type: int 
    Range: 1:30

05 - 564. Measurements
  Definition: every measurement recorded by the phone with the accelerometer and gyroscope
  type: numeric

The rest of the data set created use some of the variables defined in this code book
