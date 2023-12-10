%-----------------------------------------------------------------------
% Job saved on 28-Nov-2023 17:41:35 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear;clc;
subj=[9000
        9001
        9003
        9004
        9005
        9009
        9014
        9015
        9017
        9018
        9020
        9021
        9022
        9024
        9026
        9027
        9028
        9029
        9031
        9033
        9034
        9036
        9037
        9038
        9039
        9040
        9041
        9043
        9044
        9045
        9046
        9047
        9049
        9050
        9051
        9052
        9053
        9054
        9055
        9058
        9059
        9060
        9061
        9062
        9063
        9064
        9065
        9066
        9067
        9068
        9069
    ];
for i=1:length(subj)%删除以前的
    jobs{1}.spm.stats.con.spmmat = {['E:\SCDpattern\2023014\',num2str(subj(i)),'\1stlevel\SPM.mat']};
    jobs{1}.spm.stats.con.consess = {};
    jobs{1}.spm.stats.con.delete = 1;
    spm_jobman('run',jobs);
    clear jobs
end
for num=1:length(subj)%写现在的
    matrixnum=readmatrix(['E:\SCDpattern\2023014\',num2str(subj(num)),'\matrixnum.xlsx']);
    filename=['E:\SCDpattern\2023014\',num2str(subj(num)),'\1stLevel\SPM.mat'];
    jobs{1}.spm.stats.con.spmmat = {filename};
    jobs{1}.spm.stats.con.consess{1}.tcon.name = 'TH';
    jobs{1}.spm.stats.con.consess{1}.tcon.weights = matrixnum(:,2)';
    jobs{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    jobs{1}.spm.stats.con.consess{2}.tcon.name = 'LS';
    jobs{1}.spm.stats.con.consess{2}.tcon.weights = matrixnum(:,3)';
    jobs{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    jobs{1}.spm.stats.con.consess{3}.tcon.name = 'LO';
    jobs{1}.spm.stats.con.consess{3}.tcon.weights = matrixnum(:,4)';
    jobs{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
    jobs{1}.spm.stats.con.delete = 0;
    spm_jobman('run',jobs);
    clear jobs
end
clear;clc;