Code Book
=========

### Authors

All data is gathered from:

================================================================== Human
Activity Recognition Using Smartphones Dataset Version 1.0
================================================================== Jorge
L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab -
Non Linear Complex Systems Laboratory DITEN - Universitŕ degli Studi di
Genova. Via Opera Pia 11A, I-16145, Genoa, Italy.
<a href="mailto:activityrecognition@smartlab.ws" class="email">activityrecognition@smartlab.ws</a>
&lt;www.smartlab.ws&gt;
==================================================================

### Features

The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
signals (prefix ‘t’ to denote time) were captured at a constant rate of
50 Hz. Then they were filtered using a median filter and a 3rd order low
pass Butterworth filter with a corner frequency of 20 Hz to remove
noise. Similarly, the acceleration signal was then separated into body
and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
using another low pass Butterworth filter with a corner frequency of 0.3
Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for
each pattern:  
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ tGravityAcc-XYZ tBodyAccJerk-XYZ tBodyGyro-XYZ
tBodyGyroJerk-XYZ tBodyAccMag tGravityAccMag tBodyAccJerkMag
tBodyGyroMag tBodyGyroJerkMag fBodyAcc-XYZ fBodyAccJerk-XYZ
fBodyGyro-XYZ fBodyAccMag fBodyAccJerkMag fBodyGyroMag fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

mean(): Mean value std(): Standard deviation

### Variables used

-   *features*: List of all features.

-   *activity\_labels*: Links the class labels with their activity name.

-   *X\_train*: Training set.

-   *y\_train*: Training labels.

-   *X\_test*: Test set.

-   *y\_test*: Test labels.

-   *subject\_train*: Each row identifies the subject who performed the
    activity for each window sample. Its range is from 1 to 30.

-   *test\_data* - bind data frame with all relevant columns for test
    measurements.

-   *train\_data* - bind data frame with all relevant columns for train
    measurements.

-   *pattern* - strings to determine which feature names to select

-   *row\_remain* - list of feature names describing means and standard
    deviations of measurements.

-   *merged\_data* - first tidy data set, containing all measurements
    for selected features

-   *merged\_data\_2* - second tidy data set, containing means of
    measurements for selected features grouped by participant and
    activity.

### Transformations

All measurements were transformed from scientific notation to decimal
notation.

Measurement labels in data sets were replaced from integers to
appropriate features’ names.

The data sets for test and train measurements were merged to form a
single data set.

The merged data set was filtered to contain only measurements of means
and standard deviations.

The merged data set was used to derive a merged\_data\_2, were
measurements from individual participant and individual feature were
grouped to calculate the mean.

### Units

-   *total\_acc* - All acceleration signals from the smartphone
    accelerometer for X, Y and Z axis are in standard gravity units ‘g’.

-   *body\_acc*: The body acceleration signal obtained by subtracting
    the gravity from the total acceleration.

-   *body\_gyro*: The angular velocity vector measured by the gyroscope
    for each window sample. The units are radians/second.
