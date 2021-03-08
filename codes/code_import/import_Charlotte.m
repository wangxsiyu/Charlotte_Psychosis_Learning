datadirs = W.file_ls('../../data/Raw*','csv');
data = W_import.compile_csv(datadirs);
%% compute group
gps = {'Raw_csv_files_FEP_visit_A','Raw_csv_files_FEP_visit_B','Raw_csv_files_HC'};
gpname = {'FEP','FEP','HC'};
visits = [1,2,1];
for gi = 1:length(gps)
    tid = contains(data.csv_filename, gps{gi});
    data.Group(tid) = repmat(gpname(gi), sum(tid), 1);
    data.Visit(tid) = visits(gi);
end
%% read demo
[~,~,infoA] = xlsread('../../data/demo.xlsx', 'Visit A');
infoA = infoA(2:end,:);
[~,~,infoB] = xlsread('../../data/demo.xlsx', 'Matched pairs');
infoB = infoB(2:end,:);
%% Visit A - high vs low symptom
for i = 1:size(infoA,1)
    idname = strcmp(data.SubjectID, infoA{i,1}) | strcmp(data.SubjectID, [infoA{i,1} 'V1']) | strcmp(data.SubjectID, [infoA{i,1} 'V2']);
    id = find(idname & data.Visit == 1);
    if ~all(strcmp(unique(data.Group(id)), infoA{i, 2}))
        error('information mismatch - check');
    end
    data.Symptom(id) = repmat(infoA(i,3), length(id),1);
end
data.TreatmentType(:) = "";
%% Visit B - high vs low symptom, treatment type
for i = 1:size(infoB,1)
    idname = strcmp(data.SubjectID, infoB{i,2}) | strcmp(data.SubjectID, [infoB{i,2} 'B']) | strcmp(data.SubjectID, [infoB{i,2} 'V1']) | ...
        strcmp(data.SubjectID, [infoB{i,2} 'BV1']) | strcmp(data.SubjectID, [infoB{i,2} 'BV2']);
    id = find(idname & data.Visit == 2);
    data.Symptom(id) = repmat(infoB(i,4), length(id),1);
    if isnan(infoB{i,5})
        data.TreatmentType(id) = repmat("", length(id), 1);
    else
        data.TreatmentType(id) = repmat(string(infoB(i,5)), length(id), 1);
    end
end
%% have not matched the subject IDs
%% save
writetable(data, '../../data/data_compiled_Charlotte.csv');