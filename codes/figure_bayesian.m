%% 
if ismac
   redir = '/Volumes/Wang/Projects/Charlotte_Psychosis_Learning/results';
elseif ispc
    redir = 'C:\Users\wangs29\OneDrive - National Institutes of Health\HBI_Charlotte\results';
end
%% model comparison
dirs = dir(fullfile(redir,'bayes*'));
nd = length(dirs);
clear stat;
for di = 1:nd
     files{di} = dir(fullfile(dirs(di).folder, dirs(di).name, '*stat.mat'));
end
fileuniq = cellfun(@(x){x.name}, files, 'UniformOutput', false);
fileuniq = [fileuniq{:}];
fileuniq = unique(fileuniq);
fileuniq = fileuniq(~contains(fileuniq, 'test'));
%% load stat files
for di = 1:nd
     for fii = 1:length(fileuniq)
         fi = find(strcmp(fileuniq{fii}, {files{di}.name}));
         if length(fi) == 1
             stat{di, fii} = importdata(fullfile(files{di}(fi).folder, files{di}(fi).name)).stats;
         end
     end
end
%%
for di = 1:nd
     for fi = 1:length(fileuniq)
         try
             dic(di,fi) = stat{di,fi}.dic;
         catch
             dic(di,fi) = NaN;
         end
     end
end
%% model comparison
plt = W_plt('fig_dir','../figures', ...
    'fig_projectname', 'Charlotte', 'fig_suffix', 'HBI');
%% comparison of a single dicmodel
plt.figure(1,1);
plt.new;
plt.setfig('xtick', 1:5, 'ylabel', 'DIC', 'xticklabel', {dirs.name});
plt.lineplot(dic(:, 1)');
set(gca, 'XTickLabelRotation', 45);
plt.update;
%%
plt.figure(7, 2);
plt.param_figsetting.linewidth = 2;
name = {'alpha1_n','alpha2_n','alphal1_n','alphal2_n', 'bias_n', 'fr', 'noise'};
xb = {[-10:0.01:10],[-10:0.01:10],[-10:0.01:10],[-10:0.01:10], [-10:0.01:10], [-10:0.01:10], [0:.2:100]};
xlm = {[-1.5,1.5],[-1.5,1.5],[-1.5,1.5],[-1.5,1.5], [-1,1], [-0.1,1.1], [0,100]};
legs = {'h1','h2','l1','l2','hc'};
for fi = 1:7
    for i = 1:2
        plt.ax(fi,i);
        plt.setfig_ax('xlim', xlm{fi}, 'ylabel', name{fi});
        if (fi == 5) && i == 1
            plt.setfig_ax('legend', legs,'legloc','SouthWestOutSide');
        else
            plt.setfig_ax('legend', '');
        end
        te = [];
        for di = 1:nd
            if strcmp(name{fi}, 'noise')
                tt = sp{di}.noise_k./sp{di}.noise_lambda;
            else
                tt = sp{di}.(name{fi});
            end
             te(di,:) = hist(reshape(tt(:,:, i), 1, []), xb{fi});
        end
        plt.lineplot(te,[], xb{fi});
    end
end
plt.update;
plt.save('temp')
%%
plt.figure(5,1, 'margin', [0.3 0.15 0.05 0.05]);
plt.param_figsetting.fontsize_face = 15;
plt.param_figsetting.fontsize_axes = 15;
plt.param_figsetting.fontsize_leg = 10;
plt.setfig('xtick', 1:14, 'ylabel', 'DIC');
% set(
for i = 1:nd
    plt.ax(i,1);
    plt.setfig_ax('title', dirs(i).name);
    if i == nd
        plt.setfig_ax('xticklabel', fileuniq);
    end
    plt.lineplot(dic(i,:));
    set(gca, 'XTickLabelRotation', 45);
end
plt.update;
plt.save('dic');
%%
%%
for di = 1:nd
    files{di} = dir(fullfile(dirs(di).folder, dirs(di).name, '*samples.mat'));
    id =  find(strcmp({files{di}.name}, 'HBI_model_basic_4alpha_forget_samples.mat'));
    sp{di} = importdata(fullfile(files{di}(id).folder, files{di}(id).name));
end
%%
plt.figure(6, 2);
plt.param_figsetting.linewidth = 2;
name = {'alpha_n','alphal_n', 'bias_n', 'b0', 'fr', 'noise'};
xb = {[-10:0.01:10],[-10:0.01:10],[-10:0.01:10], [-10:0.01:10], [-10:0.01:10], [0:.2:100]};
xlm = {[-1.5,1.5],[-1.5,1.5], [-0.2,0.5], [-1,1], [-0.1,1.1], [0,10]};
legs = {'h1','h2','l1','l2','hc'};
for fi = 1:6
    for i = 1:2
        plt.ax(fi,i);
        plt.setfig_ax('xlim', xlm{fi}, 'ylabel', name{fi});
        if (fi == 5) && i == 1
            plt.setfig_ax('legend', legs,'legloc','SouthWestOutSide');
        else
            plt.setfig_ax('legend', '');
        end
        te = [];
        for di = 1:nd
            if strcmp(name{fi}, 'noise')
                tt = sp{di}.noise_k./sp{di}.noise_lambda;
            else
                tt = sp{di}.(name{fi});
            end
             te(di,:) = hist(reshape(tt(:,:, i), 1, []), xb{fi});
        end
        plt.lineplot(te,[], xb{fi});
    end
end
plt.update;
plt.save('temp')
%%
figure
for di = 1:nd
    for ei = 1:length(nm)
    end
end
%%
fi = 4;

 sp = load(fullfile(files2(fi).folder, files2(fi).name));
    mdname = SW_old.str_selectbetween2patterns(files2(fi).name,'_','_bayes',1,1);
    sp = sp.samples;
    sp.noise = sp.Noise_k_p2X5./sp.Noise_lambda_p2X5;
    %
    vars = {'noise', 'alpha_n', 'beta_n', 'memrate','b0'};
    fnms = fieldnames(sp);
    tidx = contains(fnms, vars);
    fnms = fnms(tidx);
    vars = setdiff(vars, 'memrate');
    od = cellfun(@(x)SW.extend(find(contains(fnms, x)),1 ), vars);
    fnms = fnms(od(~isnan(od)));
    sz = SW.get_fieldsize(sp, fnms,1:5);
    mathole = [];
    %%
    tlt = {'noise', 'learning rate', 'action bias', 'memory weight','initial bias'}';
    xlm = {[0 5], [-0.5 1.5], [-1 1], [-0.5 1.5], [-1 1]}';
    bin = {0:0.01:1, -1:0.02:1, -1:0.02:1, -10:0.02:10, -0:0.02:5}';
    st = table(tlt, xlm, bin);
    st = st(~isnan(od),:);
    cond = sum(~isnan(sz'))';
    for i = 1:size(sz,1)
        switch cond(i)
            case 3
                thole = [1 0];
            case 4
                thole = [1 1];
            case 5
                thole = [1 1;1 1];
        end
        mathole = vertcat(mathole, thole);
    end
    gpname = {'HC', 'Psychosis A', 'Psychosis B'};
    %%
%     SW_plt_figure(size(mathole,1),2,'matrix_hole', mathole,'gap',[0.08 0.1]);
%     SW_plt_setparams('fontsize_leg', 10);
%     SW_plt_setparams('fontsize_face', 20);
    for xx = 1:size(fnms,1)
        %     if isnan(od(xx))
        %         continue;
        %     end
        nrow = (cond(xx) == 5) + 1;
        for ri = 1:nrow
            for j = 1:((cond(xx) > 3) + 1)
                dn{j} = [];
                for i = 1:3
                    switch cond(xx)
                        case 3
                            dn{j}(i,:) = hist(reshape(sp.(fnms{xx})(:,:,i),1,[]), st.bin{xx});
                        case 4
                            dn{j}(i,:) = hist(reshape(sp.(fnms{xx})(:,:,j,i),1,[]), st.bin{xx});
                        case 5
                            dn{j}(i,:) = hist(reshape(sp.(fnms{xx})(:,:,j,i,ri),1,[]), st.bin{xx});
                    end
                end
            end
            subplot(4,2,(xx-1)*2 + 1);
%             SW_plt_setfig_ax('xlim', st.xlm{xx}, 'color', {'AZblue','RSyellow','RSred','RSgreen','RSblue'}, ...
%                 'legend', SW_if(xx ==1 ,gpname,''), 'title', SW_if(xx == 1, 'emotional',''), ...
%                 'xlabel', st.tlt{xx}, 'ylabel', SW_if(xx == round(size(fnms,1)/2), 'posterior density',''));
            plot(bin{xx},dn{1});
            if cond(xx) > 3
            subplot(4,2,(xx-1)*2 + 2);
%                 SW_plt_setfig_ax('xlim', st.xlm{xx}, 'color', {'AZblue','RSyellow','RSred','RSgreen','RSblue'}, ...
%                     'legend', '','title', SW_if(xx == 1, 'neutral',''), ...
%                     'xlabel', st.tlt{xx}, 'ylabel', '');%'legend', gpname,
                plot(bin{xx},dn{2});
            end
        end
    end
    %%
    SW_plt_update;
    SW_plt_save(mdname);

%%
SW_plt_initialize('fig_dir', fullfile(redir, 'figures'), ...
    'fig_projectname', 'Charlotte_bayes');
%
for fi = 1:length(files)
    sp = load(fullfile(files(fi).folder, files(fi).name));
    mdname = SW_str_selectbetween2patterns(files(fi).name,'_','_bayes',1,1);
    sp = sp.samples;
    sp.noise = sp.Noise_k_p2X5./sp.Noise_lambda_p2X5;
    %
    vars = {'noise', 'alpha_n', 'beta_n', 'memrate','b0'};
    fnms = fieldnames(sp);
    tidx = contains(fnms, vars);
    fnms = fnms(tidx);
    od = cellfun(@(x)SW_extend(find(contains(fnms, x)),1 ), vars);
    fnms = fnms(od(~isnan(od)));
    sz = SW_get_fieldsize(sp, fnms,1:5);
    mathole = [];
    tlt = {'noise', 'learning rate', 'action bias', 'memory weight','initial bias'}';
    xlm = {[0 30], [-0.5 1.5], [-1 1], [-0.5 1.5], [-1 1]}';
    bin = {0:1:100, -10:0.02:10, -10:0.02:10, -10:0.02:10, -10:0.02:10}';
    st = table(tlt, xlm, bin);
    st = st(~isnan(od),:);
    cond = sum(~isnan(sz'))';
    for i = 1:size(sz,1)
        switch cond(i)
            case 3
                thole = [1 0];
            case 4
                thole = [1 1];
            case 5
                thole = [1 1;1 1];
        end
        mathole = vertcat(mathole, thole);
    end
    gpname = {'HC', 'Psychosis A', 'Psychosis B'};
    %
    SW_plt_figure(size(mathole,1),2,'matrix_hole', mathole,'gap',[0.08 0.1]);
    SW_plt_setparams('fontsize_leg', 10);
    SW_plt_setparams('fontsize_face', 20);
    for xx = 1:size(fnms,1)
        %     if isnan(od(xx))
        %         continue;
        %     end
        nrow = (cond(xx) == 5) + 1;
        for ri = 1:nrow
            for j = 1:((cond(xx) > 3) + 1)
                dn{j} = [];
                for i = 1:3
                    switch cond(xx)
                        case 3
                            dn{j}(i,:) = hist(reshape(sp.(fnms{xx})(:,:,i),1,[]), st.bin{xx});
                        case 4
                            dn{j}(i,:) = hist(reshape(sp.(fnms{xx})(:,:,j,i),1,[]), st.bin{xx});
                        case 5
                            dn{j}(i,:) = hist(reshape(sp.(fnms{xx})(:,:,j,i,ri),1,[]), st.bin{xx});
                    end
                end
            end
            SW_plt_new;
            SW_plt_setfig_ax('xlim', st.xlm{xx}, 'color', {'AZblue','RSyellow','RSred','RSgreen','RSblue'}, ...
                'legend', SW_if(xx ==1 ,gpname,''), 'title', SW_if(xx == 1, 'emotional',''), ...
                'xlabel', st.tlt{xx}, 'ylabel', SW_if(xx == round(size(fnms,1)/2), 'posterior density',''));
            SW_plt_lineplot(dn{1}, [], bin{xx});
            if cond(xx) > 3
                SW_plt_new;
                SW_plt_setfig_ax('xlim', st.xlm{xx}, 'color', {'AZblue','RSyellow','RSred','RSgreen','RSblue'}, ...
                    'legend', '','title', SW_if(xx == 1, 'neutral',''), ...
                    'xlabel', st.tlt{xx}, 'ylabel', '');%'legend', gpname,
                SW_plt_lineplot(dn{2}, [], bin{xx});
            end
        end
    end
    SW_plt_update;
    SW_plt_save(mdname);
end
%%
% bin = -2:0.02:10;
% dd = samples.prior_emotion;
% svnm = 'prior';
% SW_plt_figure(2,2);
% cols = {'AZblue','RSyellow','RSred','RSgreen','RSblue'};
% SW_plt_setfig('xlim',[-1 2],'color',{cols,cols,cols,cols} , ...
%     'legend', {gpname, gpname, gpname, gpname},...
%     'xlabel', {'emotional','emotional','neutral','neutral'}, ...
%         'ylabel', 'posterior density', 'title', {'Angry','Happy','A','B'}, 'legloc', 'NorthWest');
% for xx = 1:2
%     SW_plt_new;
%     for j = 1:2
%         dn{j} = [];
%         for i = 1:5
%             dn{j}(i,:) = hist(reshape(dd(:,:,j,i,xx),1,[]), bin);
%             
%         end
%     end
%     SW_plt_lineplot(dn{1}, [], bin);
%     SW_plt_new;
%     SW_plt_lineplot(dn{2}, [], bin);
% end
%     SW_plt_update;
%     SW_plt_save(svnm);
