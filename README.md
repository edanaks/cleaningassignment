# Getting and Cleaning Data: Peer Assignment

# Steps 
1. Clone this repository
2. You are strongly advised to read the surrounding documentation which comes with the Samsung data
3. It is assumed that the data is stored in the UCI_HAR_Dataset directory. If not, change the parentdirectory variable in run_analysis.R
4. Run run_analysis.R.
5. Output is stored in meanstdaverages.csv and meanstdaverages.txt (tab seperated) in the working directory. 

## Files
1. README.md
2. run_analysis.R
3. CodeBook.md

## Notes and assumptions on run_analysis.R works
1. You may wish to change the parentdirectory variable to the Samsung data directory.
2. If meanFreq features are to be included, uncomment lines 62 and 63.
3. In the final data, subjects go 1,2,3,...,1,2,3...,... and activities go 1,1,1,...,2,2,2,.... In other words, the data is grouped first by activities.
4. Final output is stored in both csv and tab seperated txt formats.
5. activityID column is stored in the dataset along with the activitylabel.