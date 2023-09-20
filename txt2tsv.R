setwd('E:/SCDpattern/2023014/9004/')
lf <-list.files(pattern = "bins.txt$") #end with report.tsv
files <- gsub("\\.txt", "", lf)   #cut the .txt and acquire the names
files
lf
for (i in seq_along(files))
  assign(files[i], read.table(lf[i], sep = '\t', header = FALSE))
write.table(run_1_bins,"IPCAS2023014_Lijuan_part_3_task1_events.tsv",sep = '\t', row.names = F,col.names=c("ONSET","DURATION","TRIAL_TYPE"), quote=F)
write.table(run_2_bins,"IPCAS2023014_Lijuan_part_4_task2_events.tsv",sep = '\t', row.names = F,col.names=c("ONSET","DURATION","TRIAL_TYPE"), quote=F)
write.table(run_3_bins,"IPCAS2023014_Lijuan_part_5_task3_events.tsv",sep = '\t', row.names = F,col.names=c("ONSET","DURATION","TRIAL_TYPE"), quote=F)
write.table(run_4_bins,"IPCAS2023014_Lijuan_part_7_task4_events.tsv",sep = '\t', row.names = F,col.names=c("ONSET","DURATION","TRIAL_TYPE"), quote=F)
write.table(run_5_bins,"IPCAS2023014_Lijuan_part_8_task5_events.tsv",sep = '\t', row.names = F,col.names=c("ONSET","DURATION","TRIAL_TYPE"), quote=F)
write.table(run_6_bins,"IPCAS2023014_Lijuan_part_9_task6_events.tsv",sep = '\t', row.names = F,col.names=c("ONSET","DURATION","TRIAL_TYPE"), quote=F)