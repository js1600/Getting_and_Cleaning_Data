The dataset for this project was derived from the link supplied in the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The README.MD file helps to describe the contents of the GITHUB repository which is the contents of the unzipped file.

The experiment for the collection of the data consisted of the following parameters as described in the include readme file in the zipped file:
1. Experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
2. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
3. Using the samrtphone embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity were captured. 
4. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
5. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
- 
For the purpose of this assignment the data was collected, merged both test and train data, then from the merged data only the Mean and STD ( standard deviation) data was kept and represented as the final result for the Tidy_data_set.


