# Getting-and-Cleaning-Data
## Course Project for the Coursera course in Getting and Cleaning Data
### Important files in the Repo 
	1. README.md - This file that explains what analysis was done on the data and what is in the other files
	2. Codebook.md - This file explains the different variables in the tidydataset.txt
	3. run_analysis.R - This is the R script that performs the data manipulation and analysis
	3. titdydataset.txt - This is a text file for the output data from the run_analysis.R script
	
The R script assumes that the data is in a directory off the current working directory called UCI HAR Dataset and 
has the data structure from the zip file which is available at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The script has the commands that would download the data on a windows machine commented out but it can be run if 
the computer does not have the data already on it and you are on a windows machine.

The script also assumes that the tidyr and dplyr packages have been installed and loads the libraries in at the 
start of the scripts.

The script merges the testing and training data sets into one data set with the appropriate column names, subject ID's and activity types
and then produces a tidy data set in the long form.  I opted for the long form because I found it easier to work with.  The paper by 
Hadley Wickham http://vita.had.co.nz/papers/tidy-data.pdf also influenced my decision to use the long form.  The script also 
removes any "()" and "-" from the column names and removes any uppercase.  I did this because of the preference listed in the lecture for 
Week 4 - Editing Text Variables. The final output from the script calculates averages for each variable for each activity and each subject. 




