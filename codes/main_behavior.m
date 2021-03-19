%% main behavioral analysis
game = readtable('../data/game_charlotte.csv');
game = W.tab_autofieldcombine(game);
%%
tab = W_sub.display_conditions(game, {'Group','Symptom','Visit'}, 'csv_filename');
disp(tab);
table2latex(tab, '../report/tab_participants');
%%
game = preprocess_Charlotte(game);
%%
idxsub = W_sub.selectsubject(game, {'csv_filename','name_block'});
%%
sub = W_sub.analysis_sub(game, idxsub, 'behavior_Charlotte');
%%
gp = W_sub.analysis_group(sub, {'Group', 'Symptom','name_block','Visit'},1);
gp = gp(~(gp.group_analysis.Symptom == 'UNKNOWN'),:);
%% figure setting
plt = W_plt('fig_dir','../figures', 'fig_projectname', 'Charlotte', 'fig_suffix', '');
%% plotting names
cols = {'AZblue','RSyellow','RSred','RSgreen','RSblue'};
gpname = W_sub.tab_jointcondition(gp.group_analysis);
blocktype = {'emotional', 'neutral'};
btid = cellfun(@(x) strcmp(gp.group_analysis.name_block, x), blocktype, 'UniformOutput', false);
%% figure p(reward)
plt.figure(1,2);
plt.setfig('ylim', [0.35 0.65], 'xlim', [0.5 3.5], ...
    'color', cols, 'xlabel', 'bin #', 'ylabel', 'p(reward)', 'title', blocktype);
for i = 1:2
    plt.ax(1,i);
    plt.setfig_ax('legend', gpname(btid{i}));
    tgp = gp(btid{i},:);
    plt.lineplot(tgp.av_bin_all_Rewarded, tgp.ste_bin_all_Rewarded);
end
plt.update;
plt.save('preward');
%% figure p(repeat)
plt.figure(1,2);
plt.setfig('ylim', [0.4 0.8], 'xlim', [0.5 3.5], ...
    'color', cols, 'xlabel', 'bin #', 'ylabel', 'p(repeat)', 'title', blocktype);
for i = 1:2
    plt.ax(1,i);
    plt.setfig_ax('legend', gpname(btid{i}));
    tgp = gp(btid{i},:);
    plt.lineplot(tgp.av_bin_all_c_repeat, tgp.ste_bin_all_c_repeat);
end
plt.update;
plt.save('prepeat');
%% figure p(ac)
plt.figure(1,2);
plt.setfig('ylim', [0.4 0.75], 'xlim', [0.5 3.5], ...
    'color', cols, 'xlabel', 'bin #', 'ylabel', 'p(correct)', 'title', blocktype, ...
    'legloc', 'NorthWest');
for i = 1:2
    plt.ax(1,i);
    plt.setfig_ax('legend', gpname(btid{i}));
    tgp = gp(btid{i},:);
    plt.lineplot(tgp.av_bin_all_c_ac_X, tgp.ste_bin_all_c_ac_X);
end
plt.update;
plt.save('pcorrect');
%% figure RT
plt.figure(1,2);
plt.setfig( 'xlim', [0.5 3.5], ...
    'color', cols, 'xlabel', 'bin #', 'ylabel', 'RT', 'title', blocktype, ...
    'legloc', 'NorthWest');
for i = 1:2
    plt.ax(1,i);
    plt.setfig_ax('legend', gpname(btid{i}));
    tgp = gp(btid{i},:);
    plt.lineplot(tgp.av_bin_all_RT, tgp.ste_bin_all_RT);
end
plt.update;
plt.save('RT');
%% figure p(happy vs angry)
plt.figure(1,2);
plt.setfig('ylim', [0.3 0.7], 'xlim', [0.5 3.5], ...
    'color', cols, ...
    'xlabel', 'bin #', 'ylabel', {'p(happy)-p(angry)'}, 'title', blocktype, ...
    'legloc', {'NorthEast'});
for i = 1:2
    plt.ax(1,i);
    tgp = gp(btid{i},:);
    plt.setfig_ax('legend', gpname(btid{1}));
    plt.lineplot(tgp.av_bin_all_c_X, tgp.ste_bin_all_c_X);
end
plt.update;
plt.save('p_emotion');
% %% figure correct happy/angry accuracy
% plt.figure(1,2);
% plt.setfig('legend', gpname,'ylim', [0 1], 'xlim', [0.5 2.5], ...
%     'color', {'AZblue','RSyellow','RSred','RSgreen','RSblue'}, ...
%     'xlabel', '', 'ylabel', {'p(correct|emotion)','p(correct|face)'}, 'title', '', ...
%     'legloc', {'SouthWest','SouthWest'},'xtick',1:2, 'xticklabel', {{'angry','happy'},{'faceA','faceB'}});
% plt.new;tgp = gp(btid{1},:);
% 
% plt.lineplot(tgp.av_ph_emotion, tgp.ste_ph_emotion);
% yline(0.5, '--r');
% plt.new;tgp = gp(btid{2},:);
% 
% plt.lineplot(tgp.av_ph_face, tgp.ste_ph_face);
% yline(0.5, '--r');
% plt.update;
% plt.save('p_correct_emotion');
% 
%% figure memory effect
plt.figure(2,2,'gap',[0.2,0.1]);
plt.setfig('ylim', [0.4 0.9], 'xlim', [0.5 2.5], ...
    'color', cols, ...
    'xlabel', '', 'ylabel', {'p(correct, consistent)','p(correct, inconsistent)', ...
    'p(correct, consistent)','p(correct, inconsistent)'}, ...
    'title', {'emotional','emotional', ...
    'neutral','neutral'}, ...
    'legloc', {'SouthWest'}, 'xtick', {1:2,1:2,1:2,1:2}, ...
    'xticklabel', {{'1st','2nd'},{'1st','2nd'},{'1st','2nd'},{'1st','2nd'}});
for i = 1:2
    for j = 1:2
        tgp = gp(btid{j},:);
        plt.ax(j,i);
        av = W.cellfun(@(x)x(i,:), tgp.av_ps_cons);
        av = vertcat(av{:});
        se = W.cellfun(@(x)x(i,:), tgp.ste_ps_cons)
        se = vertcat(se{:});
        plt.lineplot(av, se);
    end
end
plt.update;
plt.save('p_memory');
%% split by which wins
plt.figure(2,2,'gap',[0.2,0.1]);
plt.setfig('ylim', [0.4 0.8], 'xlim', [0.5 3.5], ...
    'color', cols, ...
    'xlabel', '', 'title', {'happy win','angry win', ...
    'faceA win','faceB win'}, ...
    'ylabel', 'p(repeat)', ...
    'legloc', {'SouthWest'});
for i = 1:2
    for j = 1:2
        tgp = gp(btid{j},:);
        plt.ax(j,i);
        av = W.cellfun(@(x)x(i,:), tgp.av_bygp_bin_all_c_repeat);
        av = vertcat(av{:});
        se = W.cellfun(@(x)x(i,:), tgp.ste_bygp_bin_all_c_repeat)
        se = vertcat(se{:});
        plt.lineplot(av, se);
    end
end
plt.update;
plt.save('p_em');













% 
% 








% %% figure memory effect
% plt.figure(1,2);
% plt.setfig('legend', gpname,'ylim', [0 1]);
% plt.new;tgp = gp(btid{1},:);
% 
% plt.lineplot(tgp.av_phav_emotion_cons, tgp.ste_phav_emotion_cons);
% plt.new;tgp = gp(btid{2},:);
% 
% plt.lineplot(tgp.av_phav_face_cons, tgp.ste_phav_face_cons);
% plt.update;
% 
% %%
% plt.figure(1,2);
% plt.setfig('legend', gpname,'ylim', [-0.3 0.3]);
% plt.new;tgp = gp(btid{1},:);
% 
% plt.lineplot(tgp.av_phdf_emotion_cons, tgp.ste_phdf_emotion_cons);
% plt.new;tgp = gp(btid{2},:);
% 
% plt.lineplot(tgp.av_phdf_face_cons, tgp.ste_phdf_face_cons);
% plt.update;