%% data preparation
game = readtable('../../data/game_Charlotte.csv');
game = W.tab_autofieldcombine(game);
%% display conditions
W_sub.display_conditions(game, {'Group','Symptom','Visit'},{'csv_filename'});
%% select subjects
[idx, tab] = W_sub.selectsubject(game, {'Group','Symptom','Visit'});
idx = idx(tab.Symptom ~= "UNKNOWN", :);
tab = tab(tab.Symptom ~= "UNKNOWN", :);
%% set up savedir
outputdir = '../../data';
%%
for ii = 1:length(idx)
    %% set up bayesdata by condition
    tgame = game(idx{ii},:);
    tname = W_sub.tab_jointcondition(tab(ii,:),[], '_');
    tfile = fullfile(outputdir, strcat('bayes_Charlotte_', tname, '.mat'));
    %% compute last session
    for i = 1:size(tgame,1)
        if tgame.BlockNo(i) > 2
            lss(i) = find(strcmp(tgame.csv_filename, tgame.csv_filename(i)) & ...
                tgame.BlockNo(i) > tgame.BlockNo & ...
                tgame.cond_block == tgame.cond_block(i));
        else
            lss(i) = 0;
        end
    end
    lss = W.vert(lss);
    %% compute subjects
    subs = unique(tgame.csv_filename);
    subID = cellfun(@(x)find(strcmp(subs,x)), tgame.csv_filename);
    %%
    bayesdata = [];
    bayesdata.nSubject = length(subs);
    bayesdata.nSessions = height(tgame);
    bayesdata.nTrial = size(tgame.ChosenSide,2);
    bayesdata.nCondition = 2;
    bayesdata.subID = subID; % subject ID
    bayesdata.r = tgame.Rewarded; % whether it's rewarded
    bayesdata.lastsession = lss;
    tidx = tgame.cond_block == 0; % 0 - neutral, 1 - emotional
    bayesdata.blocktype = 2 - tidx; % 1 - emotional, 2 - neutral
    c1 = W.nan_changem(tgame.ChosenEmotion, 0);
    bayesdata.c(tidx,:) = c1(tidx,:);
    c2 = W.nan_changem(tgame.ChosenFaceID, 0);
    bayesdata.c(~tidx,:) = c2(~tidx,:);
    bayesdata.choice = (bayesdata.c == 2) + 0; % choose B or choose Happy
    bayesdata.choice(bayesdata.c == 0) = NaN;
    %% save
    save(tfile, 'bayesdata');
end