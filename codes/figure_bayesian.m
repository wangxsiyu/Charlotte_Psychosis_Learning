%% 
if ismac
   redir = '/Volumes/Lab/Lab_Averbeck/Projects_Averbeck/Project_Charlotte';
elseif ispc
    redir = 'C:\Users\wangs29\OneDrive - National Institutes of Health\HBI_Charlotte\results';
end
%% model comparison
files = dir(fullfile(redir, '*result.mat'));
names = SW.arrayfun(@(x)SW_old.str_selectbetween2patterns(x.name, 'resultCharlotte_','_bayes',1,1), files);
clear stat;
for fi = 1:length(files)
    stat(fi) = importdata(fullfile(files(fi).folder, files(fi).name)).stats;
end
%% model comparison
plt = SW_plt('fig_dir','../figures', ...
    'fig_projectname', 'Charlotte', 'fig_suffix', 'HBI');
%%
figure
plot([stat.dic]);
xlim([0.5 9.5]);
set(gca, 'xtick', 1:9, 'xticklabel', tool_de_(names), 'XTickLabelRotation', 45);
ylabel('DIC');
%%
files2 = dir(fullfile(redir, '*samples.mat'));
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
