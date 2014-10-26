The analysis is divided into the following parts:

1. Loading of required libraries
2. Reading the raw data and constructing the whole matrix of required data
	* Read the measurements
	* Choose only the variables representing the mean and standard deviation
	* Read the activity IDs and the subject ids
	* Combine everything into one matrix
3. Translate the activity "ID" (numeric) into the clearer activity names
4. Reshape the data to get the average per activity and subject
5. Writing the tidy data

The analysis used two external packages: *stringr* and *reshape2*. The reason will be explained in the sections where they are used.

The features are read and then they are used as column names in reading the measurements of the test and training sets. After that the two data frames are merged with the test set and then the training set. The *stringr* package is used for the function *str_detect* in order to find out which columns will be retained.

The activity IDs and the subject IDs are loaded in the same way and given column names appropriate for the tidy data. After this, all the data frames are merged by *cbind*.

The activity IDs are translated into activity names using the activity_labels text file and the *merge* command. 

The *reshape2* package is used to specify the variables and the IDs *activity.name* and *subject.id*. Then it is modified to get the mean for each activity and subject.

The resulting tidy data set is written to a text file named *tidyData.txt* in the current working directory.