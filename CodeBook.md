# Code Book

Description of the variables, the data, and any transformations or work performed to clean up the data

## Raw Data
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. **The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.**

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

More information can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

#### For each record it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

## The Tidy Dataset

To perform analysis later using the described raw data, I produced a cleaned dataset `TidyDataSet.txt` using the `run_analysis.R` script.

## Transformations

* Merges the training and the test sets from the raw data to create one data set,
* Extracts only the measurements on the mean and standard deviation for each measurement,
* Uses descriptive activity names to name the activities in the data set,
* Appropriately labels the data set with descriptive variable names,
* Creates an independent tidy data set with the average of each variable for each activity and each subject.

## Variables

Here I describe the variables of the final `TidyDataSet.txt`:

`subject_id`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

`activity_id`: Name of the activity performed.

### Features:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals `TimeDomainAccelerometer-XYZ` and `TimeDomainGyroscope-XYZ`. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`TimeDomainBodyAccelerometer-XYZ` and `TimeDomainGravityAccelerometer-XYZ`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (`TimeDomainBodyAcceleratorJerk-XYZ` and `TimeDomainBodyGyroscopeJerk-XYZ`). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`TimeDomainBodyAccelerometerMagnitude`, `TimeDomainGravityAccelerometerMagnitude`, `TimeDomainBodyAcceleratorJerkMagnitude`, `TimeDomainBodyGyroscopeMagnitude`, `TimeDomainBodyGyroscopeJerkMagnitude`). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `FrequencyDomainBodyAccelerator-XYZ`, `FrequencyDomainBodyAcceleratorJerk-XYZ`, `FrequencyDomainBodyGyroscope-XYZ`, `FrequencyDomainBodyAcceleratorJerkMagnitude`, `FrequencyDomainBodyGyroscopeMagnitude`, `FrequencyDomainBodyGyroscopeJerkMagnitude`.

These signals were used to estimate variables of the feature vector for each pattern:  
`-XYZ` is used to denote 3-axial signals in the X, Y and Z directions.

*Features are normalized and bounded within [-1,1].*
