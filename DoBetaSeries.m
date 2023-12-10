% function BetaSeries(rootdir, subjects, spmdir, seedroi, Conds, MapNames)
% INPUT:
%  rootdir  - Path to where subjects are stored
%  subjects - List of subjects (can concatenate with brackets)
%  spmdir   - Path to folder containing SPM file
%  seedroi  - Absolute path to file containing ROI in NIFTI format
%  Conds    - List of conditions for beta series analysis
%  MapNames - Output for list of maps, one per Conds cell
%
%   Example use:
%       BetaSeries('/data/study1/fmri/',
%       'model/BetaSeriesDir/', '/data/study1/Masks/RightM1.nii',
%       {'TapLeft'}, {'TapLeft_RightM1'})
%
%       conditions to be averaged together should be placed together in a cell
%       separate correlation maps will be made for each cell
%       Conds = {'Incongruent' 'Congruent' {'Error' 'Late'}};
%
%       For MapNames, there should be one per Conds cell above
%       e.g., with the Conds above, MapNames = {'Incongruent_Map',
%       'Congruent_Map', 'Error_Late_Map'}
%
%       Once you have z-maps, these can be entered into a 2nd-level
%       1-sample t-test, or contrasts can be taken between z-maps and these
%       contrasts can be taken to a 1-sample t-test as well.
%
%
clear;
maskdir={'group_Lhipp'
    'group_LmPHC'
    'group_RMFG'
    'group_Rprec'
    'group_RmedialFG'
    'group_LMFG'
    'group_LIFG'
    'group_RIPL'
    'group_RPCC'
    'group_RACC'
    'bins_LIPL'
    'bins_LmedialFG'
    'bins_LIFG1'
    'bins_LIFG2'
    };
    subjects=[9000
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
for path=1:length(maskdir)
    rootdir='E:\SCDpattern\2023014\';
    spmdir= '\1stLevel\';
    seedroi=['E:\SCDpattern\2023014\mask\中期mask\',maskdir{path},'\r',maskdir{path},'.nii,1'];
    Conds={') 1*bf(1)',') 8*bf(1)',') 10*bf(1)'};%new,LS,LO
    %Find XYZ coordinates of ROI
    Y = spm_read_vols(spm_vol(seedroi),1);
    indx = find(Y>0.001);%解决coregister之后mask不为0的情况
    [x,y,z] = ind2sub(size(Y),indx);
    XYZ = [x y z]';
    participants=[];
    %Find each occurrence of a trial for a given condition
    %These will be stacked together in the Betas array
    for i = 1:length(subjects)
        subj = num2str(subjects(i));
        disp(['Loading SPM for subject ' subj]);
        %Can change the following line of code to CD to the directory
        %containing your SPM file, if your directory structure is different
        cd([rootdir subj spmdir]);
        load SPM.mat;
        temp=zeros(1,4);
        temp(1)=subjects(i);
        for cond = 1:length(Conds)
            Betas = [];
            currCond = Conds(cond);
            if ~iscell(currCond)
                currCond = {currCond};
            end
            for j = 1:length(SPM.Vbeta)
                for k = 1:length(currCond)
                    if ~isempty(strfind(SPM.Vbeta(j).descrip,currCond{k}))
                        Betas = strvcat(Betas,SPM.Vbeta(j).fname);
                    end
                end
            end


            %Extract beta series time course from ROI
            if ischar(Betas)
                P = spm_vol(Betas);
            end

            est = spm_get_data(P,XYZ);
            est = nanmean(est,2);
            est = nanmean(est);
            %写入excel
            temp(cond+1)=est;

        end
        participants=[participants;temp];
    end
    cd E:\SCDpattern\2023014\
    savename=[maskdir{path},'.xlsx'];
    writematrix(participants,savename);
end