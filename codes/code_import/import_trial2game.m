data = readtable('../../data/data_compiled_Charlotte.csv');
%% exclude NaNs
data = data(~isnan(data.TrialNo),:);
%%
idxsub = W_sub.selectsubject(data, {'SubjectID','BlockNo'});
%%
game = W_sub.tab_trial2game(data, idxsub);
%% preprocess 
% 1 - angry, 2 - happy
c = cellfun(@(x)contains(x, 'Angry'), game.ChosenFace) + cellfun(@(x)contains(x, 'Happy'), game.ChosenFace) * 2;
c(cellfun(@(x)contains(x, 'None'), game.ChosenFace) == 1) = NaN;
game.ChosenEmotion = c;

c = cellfun(@(x)strcmp(x(end), 'A'), game.ChosenFace) + cellfun(@(x)strcmp(x(end), 'B'), game.ChosenFace) * 2;
c(cellfun(@(x)contains(x, 'None'), game.ChosenFace) == 1) = NaN;
game.ChosenFaceID = c;

c = cellfun(@(x)contains(x, 'Left'), game.ChosenSide) + cellfun(@(x)contains(x, 'Right'), game.ChosenSide) * 2;
c(cellfun(@(x)contains(x, 'None'), game.ChosenSide) == 1) = NaN;
game.ChosenSide = c;

game.Rewarded = cellfun(@(x)contains(x, 'Yes'), game.Rewarded);

% 0 - emotional, 1 - neutral
game.cond_block = any(game.ChosenEmotion' == 0)';
%% save game version
writetable(game, '../../data/game_Charlotte.csv');