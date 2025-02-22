# MST_fMRI_Analysis
Tiny plugins to analyze the fMRI data acquired in our MST exp.

These are tiny plugins (or just simple codes) used for fMRI analysis in our experiments (in press).
to use these plugins, pls follow the procedure listed below.

0. preprocessing the data
   put your raw DICOM in the following files:
   
fieldmap: part_1\2\DICOM
1 run: part_1\nodummy\3\DICOM (9102 files/slices)
2 run: part_1\nodummy\4\DICOM (9102 files/slices)
3 run: part_1\nodummy\5\DICOM (9102 files/slices)
T1_w:  part_1\6\DICOM (192 files)
4 run: part_1\nodummy\7\DICOM (9102 files/slices)
5 run: part_1\nodummy\8\DICOM (9102 files/slices)
6 run: part_1\nodummy\9\DICOM (9102 files/slices)
  
   prepare 3 BIDS structure folders:
   
sub-xx\anat\         ——> to convert T1 image
sub-xx\func\         ——> to convert all runs fMRI
sub-xx\func\fmap\         ——> to convert B0
   
   open MRIcroGL, convert these DICOM files to .nii (WARNING: not .nii.gz!) in the corresponding folders. Remember to change the "output filename" to "%p_%s_%d"
   Waiting for 10 minutes. Correct names are listed as below:
   
IPCAS2023014_Lijuan_part_6_ABI1_t1iso_fspgr.nii
IPCAS2023014_Lijuan_part_3_task1.nii
IPCAS2023014_Lijuan_part_4_task2.nii
IPCAS2023014_Lijuan_part_5_task3.nii
IPCAS2023014_Lijuan_part_7_task4.nii
IPCAS2023014_Lijuan_part_8_task5.nii
IPCAS2023014_Lijuan_part_9_task6.nii
   
1. turn the MST file into a .csv file
   When a participant completed his/her/you-know-who's exp, the psychopy programm would generate a MST_ID.txt
   open the file, you will see such sentences:

%MST Task
%Started at 2023-09-07 15:21:28.464731
%ID: XXXX
%Duration: 3.0
%ISI: 1.0
%Set: 6
%Lag set: AllShort_Set1
%Order: 19
%Respkeys: 12 12 12
%Self-paced: False
%Two-choice: False
%Rnd-mode: -1 with seed 9004
%Raw params: {'default'}

%Task started at 2023-09-07 15:22:20.236557
%Trial,Stim,Cond,Lag,LBin,StartT,Resp,Corr,RT
1,Set 6\012a.jpg,0,-1,2,0.000,3,1,1.199          ——> we only want the data start at this line.

   Merely copy the data of each run, paste them into different files. Remember to delete the set and RT column (we only need 7 columns): {1	0	-1	2	0.000	3	1} (corresponding to the data listed above)

1_events.csv
2_events.csv
...

   Generally speaking, there would be 6 files (1-6 run). if NAs generated by PsychoPy3 remain in the csv file, delete them. the blanks would be considered as "nan" in MATLAB.

2. open condsplit.m in MATLAB.
   Set the working path to ..\sub-xx\
   Run the condsplit.m
   Generating 6 run_ID_bins.txt
   This is a 13 bins version. Later we would upload a 10 bins version.
3. open txt2tsv.R in Rstudio
   open the txt2tsv.R
   run the first sentence (change the pathway in this sentence to your current ..\sub-xx\)
   click the settings button, go to the current working path
   run all. then there would be 6 .tsv files could be used in CONN (gPPI) and SPM12 (design matrix)
   Here is the format of such .tsv files:

ONSET	DURATION	TRIAL_TYPE
0	2	5
6	2	5
12	2	5
...

  When you want to design the matrix, just open a blank excel and paste each run's .tsv in it. Sort function in excel would help a lot in writing the onsets and condition names.
  Also, if you expect to do gPPI, just move the .tsv files into ..\sub-xx\func\

# Some personal thoughts
Thanks for focusing on our work! We do hope that this work could open up new pathways to understanding the underlying mechanisms of SCD patients for all clinicians!
Also, the MATLAB codes could be downloaded and adopted to deal with MVPA (using SPM12). What a surprise we didn't expect at all.

Please cite us in AMA format:
Tang W, Zeng Q, Xie K, et al. Disrupted brain networks underlying high-fidelity memory retrieval in subjective cognitive decline: A task-based fMRI study. Alzheimer's Dement. 2024; 1-13. https://doi.org/10.1002/alz.14431
![image](https://github.com/user-attachments/assets/f60af9cc-e71a-4c69-8866-705c5424c1cb)
