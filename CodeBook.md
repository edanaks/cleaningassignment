## CodeBook for derived data from the "Human Activity Recognition Using Smartphones"

### Transformations

1. Training and testing data for subjects, activities and features was combined
2. A new column corresponding to activity lables ("activitylabel") was added
3. Feature names were tidied:
    * "(", ")", "-", "," were dropped
    * Feature names are still in the abreviated form, as their explanation is available in the codebook for the original data
4. A new tidy data (meanstdaverages) was created with the average of each variable for each activity and each subject. 
   In this data, subjects go 1,2,3,...,1,2,3...,... and activities go 1,1,1,...,2,2,2,.... In other words, the data is grouped first by activities.
5. For the purposes of this analysis, Inertial Data is ignored.
6. Finally the mean and std averages data is saved as a CSV and a TXT (tab seperated) file labelled meanstdaveragesdata.csv or meanstdaveragesdata.data

### More information on the data

1. It is strongly advised to look at the original CodeBook provided with the raw data
2. The numbers are normalized to [-1,1]
3. It is possible to exclude the meanFreq features, by making appropriate changes to the run_analysis.R. See README.md.

### Citations

Raw Data from:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws

www.smartlab.ws