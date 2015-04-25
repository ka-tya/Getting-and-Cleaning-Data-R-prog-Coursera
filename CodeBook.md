<p>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: </p>

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
<p><b>Variables</b></p>
The zip package has test and train data, which both include the X data sets (<code>X_test.txt</code> and <code>X_train.txt</code>), subject id(<code>subject_test.txt</code> and <code>subject_train.txt</code>), and activity labels(<code>y_train.txt</code> and <code>y_test.txt</code>). 
The X data sets include 561 features of fitbit outcomes from the accelerometer and gyroscope in estimated variables as min, max, mean, standard deviation and others.
The y labels are numerated from 1 to 6, and a separate file called <code>activity_labels.txt</code> that provides a name for each activity. It includes walking, laying, sitting, etc.

<p><b>Transformation</b></p>
First, train and test data is merged using <code>rbind()</code>for each variable separately, such as X_test is merged with X_train, y_test with y_train, and subject_test with subject_train.

Second step is creating a subset of X data, keeping only the columns for mean and standard deviation parameters.
Next, <code>features.txt</code> is used to add column names for the <code>X_merged</code> dataset.
Similarily, the labels from <code>activity_labels.txt</code> are applied to replace numbers in the <code>y_merged</code>.

The new datasets are merged with <code>cbind()</code> : subject data, y data and X data.
The columns for subject and activity are renamed accordingly.

Finally the data is aggregated by <code>ddply()</code> from the <code>plyr</code> package and saved to <code>tidyData.txt</code> file.
