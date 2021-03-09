%% setup directory
if ismac
    fullpt = '/Volumes/Wang/Projects/Charlotte_Psychosis_Learning/codes/models_hbi';
    outputdir = '/Volumes/Wang/Projects/Charlotte_Psychosis_Learning/results';
    datadir = '/Volumes/Wang/Projects/Charlotte_Psychosis_Learning/data';
elseif ispc
    [~,sysname] = system('hostname');
    sysname = strip(sysname);
    switch sysname
        case 'MH02217045DT' % i9 PC - remote NIH
            fullpt = 'E:\Github\Charlotte_Psychosis_Learning\codes\models_hbi';
            outputdir = 'C:\Users\wangs29\OneDrive - National Institutes of Health\HBI_Charlotte\results';
            datadir = 'E:\Github\Charlotte_Psychosis_Learning\data';
            rg = 1:3;
        case 'MH02217195LT'
            fullpt = 'C:\wangxsiyu\Github\Charlotte_Psychosis_Learning\codes\models_hbi';
            outputdir = 'C:\Users\wangs29\OneDrive - National Institutes of Health\HBI_Charlotte\results';
            datadir = 'C:\wangxsiyu\Github\Charlotte_Psychosis_Learning\data';
            rg = 4:5;
    end
end
%% set up models
mi = 0;
% model basic
mi = mi + 1;
modelname{mi} = 'model_basic';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2));
% model basic + initialB
mi = mi + 1;
modelname{mi} = 'model_basic_initialB';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2));
% model basic + initialB + wl
mi = mi + 1;
modelname{mi} = 'model_basic_initialB_2alpha';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2));
% model basic + initialB + wl + forget
mi = mi + 1;
modelname{mi} = 'model_basic_initialB_2alpha_forget';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','fr','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2), 'fr', zeros(1,2));
% model basic + initialB + wl + forget + memory
mi = mi + 1;
modelname{mi} = 'model_basic_initialB_2alpha_forget_memory';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','fr','mem','Qinit','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2), 'fr', zeros(1,2), ...
    'mem', zeros(1,2));
% model basic + initialB + wl + memory
% mi = mi + 1;
% modelname{mi} = 'model_basic_initialB_2alpha_memory';
% params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
%     'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
%     'RPE', 'Q', 'b0','mem','Qinit','noise'};
% init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
%     'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
%     'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
%     'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
%     'b0', zeros(1,2), ...
%     'mem', zeros(1,2));
% model basic + initialB + fr
mi = mi + 1;
modelname{mi} = 'model_basic_initialB_forget';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','fr','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2), 'fr', zeros(1,2));
% model basic + initialB + memory
mi = mi + 1;
modelname{mi} = 'model_basic_initialB_memory';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','mem','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2), 'mem', zeros(1,2));
% model basic + initialB + forget + memory
mi = mi + 1;
modelname{mi} = 'model_basic_initialB_forget_memory';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q', 'b0','mem','noise','fr'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'b0', zeros(1,2), 'mem', zeros(1,2), 'fr', zeros(1,2));
% model basic + wl
mi = mi + 1;
modelname{mi} = 'model_basic_2alpha';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
    'RPE', 'Q','noise'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2));
% model basic + initialB + wl + fr
mi = mi + 1;
modelname{mi} = 'model_basic_2alpha_forget';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
    'RPE', 'Q','noise','fr'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'fr', zeros(1,2));
% model basic + wl + fr + mem
mi = mi + 1;
modelname{mi} = 'model_basic_2alpha_forget_memory';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
    'RPE', 'Q','noise','fr','mem'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'fr', zeros(1,2),'mem', zeros(1,2));
% model basic + wl + mem
% mi = mi + 1;
% modelname{mi} = 'model_basic_2alpha_memory';
% params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p','alphal_n', 'alphal_p', ...
%     'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'alphal_sub', 'bias_sub', ...
%     'RPE', 'Q','noise','mem'};
% init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
%     'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
%     'alphal_n', zeros(1,2), 'alphal_p', ones(1,2), ...
%     'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
%     'mem', [0 0]);
% model basic + forget
mi = mi + 1;
modelname{mi} = 'model_basic_forget';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q','noise','fr'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'fr', zeros(1,2));
% model basic + forget + memory
mi = mi + 1;
modelname{mi} = 'model_basic_forget_memory';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q','noise','fr','mem'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), ...
    'fr', zeros(1,2), 'mem', zeros(1,2));
% model basic + memory
mi = mi + 1;
modelname{mi} = 'model_basic_memory';
params{mi} = {'noise_k','noise_lambda','alpha_n', 'alpha_p', ...
    'bias_n', 'bias_p', 'noise_sub', 'alpha_sub', 'bias_sub', ...
    'RPE', 'Q','noise','mem'};
init0{mi} = struct('noise_k', ones(1,2), 'noise_lambda', ones(1,2), ...
    'alpha_n', zeros(1,2), 'alpha_p', ones(1,2), ...
    'bias_n', zeros(1,2), 'bias_p', ones(1,2), 'mem', zeros(1,2));
%% setup JAGS/params
wj = W_JAGS();
wj.setup_params;
wj.setup_params(4, 3000, 2000);
%% run models
datalists = dir(fullfile(datadir,'bayes*'));
for di = rg%1:length(datalists)
    %% load data
    bayesdata = importdata(fullfile(datalists(di).folder, datalists(di).name));
    wj.setup_data_dir(bayesdata, fullfile(outputdir, datalists(di).name));
    %% run
    for mmi = 1:mi
        disp(sprintf('running dataset %d, model %d/%d: %s', di, mmi,mi,modelname{mmi}));
        wj.setup(fullfile(fullpt, modelname{mmi}), params{mmi}, init0{mmi});
        wj.run;
    end
end
%% model minimum
% outputdir = '/Volumes/Lab/Lab_Averbeck/Projects_Averbeck/Project_Charlotte';
% load(fullfile(outputdir, 'bayes_Charlotte'));
% params = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_emotion_n2X5', ...
%     'prior_emotion', 'bias_n2X5', 'Q', 'P'};
% modelfile = '/Volumes/Lab/Lab_Averbeck/Projects_Averbeck/Project_Charlotte/model_minimum.txt';
% outfile = 'resultCharlotte_minimum';
% init0 = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_emotion_n2X5', zeros(2,5), ...
%     'prior_emotion', repmat(0.5, 2, 5, 2), ...
%     'bias_n2X5', zeros(2,5));
% istest = [];%'no';
% SW_JAGS(bayesdata, modelfile, outfile, params, init0, istest);



% % model memory
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_memory.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model memory + forget
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5), ...
%     'memrate', ones(2,3)/2);
% % model memory + forget + b0
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate','b0'};
% modelfile{mi} = fullfile(fullpt,'Models','model_memory_forget_initialB.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_initialB');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5), ...
%     'memrate', ones(2,3)/2, ...
%     'b0', zeros(2,3));
% % model memory + forget + b0 + 2alpha
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate','b0'};
% modelfile{mi} = fullfile(fullpt,'Models','model_memory_forget_initialB_2alpha.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_initialB_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5,2), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5), ...
%     'memrate', ones(2,3)/2, ...
%     'b0', zeros(2,3));
% % reduced model - memory + forget
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced');
% init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
%     'alpha_n2X5', ones(2,3)/2, ...
%     'alpha_p2X5', ones(2,3), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,3), ...
%     'memrate', ones(1,3)/2);
% % reduced model - memory + forget + 2alpha
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced_2alpha.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,3), ...
%     'memrate', ones(1,3)/2);
% % reduced model - memory + forget + initialB + 2alpha
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced_initialB_2alpha.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced_initialB_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,3), ...
%     'memrate', ones(1,3)/2, ...
%     'b0', zeros(2,3));
% % reduced model - memory + forget + initialB + 2alpha(wl)
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','memrate','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced_initialB_2alphawl.txt');
% outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced_initialB_2alphawl');
% init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,3), ...
%     'memrate', ones(1,3)/2, ...
%     'b0', zeros(2,3));
% model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_initialB.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_initialB');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', ones(2,5)/2, ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5),...
%     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_initialB_2alpha.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_initialB_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(2,3), 'Noise_lambda_p2X5', ones(2,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,5),...
%     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_initialB_2alphawl.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_initialB_2alphawl');
% init0{mi} = struct('Noise_k_p2X5', ones(2,3), 'Noise_lambda_p2X5', ones(2,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,5),...
%     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_2alpha.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(2,3), 'Noise_lambda_p2X5', ones(2,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget_both.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget_both');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget_nodrift.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget_nodrift');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget_both_nodrift.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget_both_nodrift');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % % model memory
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub'};
% % modelfile{mi} = fullfile(fullpt,'/Models/model_memory.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory');
% % init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
% %     'alpha_n2X5', zeros(2,5), ...
% %     'alpha_p2X5', ones(2,5), ...
% %     'beta_n2X5', zeros(2,5), ...
% %     'beta_p2X5', ones(2,5));
% % % model memory + forget
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate'};
% % modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget');
% % init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
% %     'alpha_n2X5', zeros(2,5), ...
% %     'alpha_p2X5', ones(2,5), ...
% %     'beta_n2X5', zeros(2,5), ...
% %     'beta_p2X5', ones(2,5), ...
% %     'memrate', ones(2,3)/2);
% % % model memory + forget + b0
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate','b0'};
% % modelfile{mi} = fullfile(fullpt,'Models','model_memory_forget_initialB.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_initialB');
% % init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
% %     'alpha_n2X5', zeros(2,5), ...
% %     'alpha_p2X5', ones(2,5), ...
% %     'beta_n2X5', zeros(2,5), ...
% %     'beta_p2X5', ones(2,5), ...
% %     'memrate', ones(2,3)/2, ...
% %     'b0', zeros(2,3));
% % % model memory + forget + b0 + 2alpha
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate','b0'};
% % modelfile{mi} = fullfile(fullpt,'Models','model_memory_forget_initialB_2alpha.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_initialB_2alpha');
% % init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
% %     'alpha_n2X5', zeros(2,5), ...
% %     'alpha_p2X5', ones(2,5,2), ...
% %     'beta_n2X5', zeros(2,5), ...
% %     'beta_p2X5', ones(2,5), ...
% %     'memrate', ones(2,3)/2, ...
% %     'b0', zeros(2,3));
% % % reduced model - memory + forget
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate'};
% % modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced');
% % init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
% %     'alpha_n2X5', ones(2,3)/2, ...
% %     'alpha_p2X5', ones(2,3), ...
% %     'beta_n2X5', zeros(2,3), ...
% %     'beta_p2X5', ones(2,3), ...
% %     'memrate', ones(1,3)/2);
% % % reduced model - memory + forget + 2alpha
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate'};
% % modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced_2alpha.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced_2alpha');
% % init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
% %     'alpha_n2X5', ones(2,3,2)/2, ...
% %     'alpha_p2X5', ones(2,3,2), ...
% %     'beta_n2X5', zeros(2,3), ...
% %     'beta_p2X5', ones(2,3), ...
% %     'memrate', ones(1,3)/2);
% % % reduced model - memory + forget + initialB + 2alpha
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate','b0'};
% % modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced_initialB_2alpha.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced_initialB_2alpha');
% % init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
% %     'alpha_n2X5', ones(2,3,2)/2, ...
% %     'alpha_p2X5', ones(2,3,2), ...
% %     'beta_n2X5', zeros(2,3), ...
% %     'beta_p2X5', ones(2,3), ...
% %     'memrate', ones(1,3)/2, ...
% %     'b0', zeros(2,3));
% % % reduced model - memory + forget + initialB + 2alpha(wl)
% % mi = mi + 1;
% % params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
% %     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
% %     'beta_sub','memrate','b0'};
% % modelfile{mi} = fullfile(fullpt,'/Models/model_memory_forget_reduced_initialB_2alphawl.txt');
% % outfile{mi} = fullfile(outputdir, 'resultCharlotte_memory_forget_reduced_initialB_2alphawl');
% % init0{mi} = struct('Noise_k_p2X5', ones(1,3), 'Noise_lambda_p2X5', ones(1,3), ...
% %     'alpha_n2X5', ones(2,3,2)/2, ...
% %     'alpha_p2X5', ones(2,3,2), ...
% %     'beta_n2X5', zeros(2,3), ...
% %     'beta_p2X5', ones(2,3), ...
% %     'memrate', ones(1,3)/2, ...
% %     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_initialB.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_initialB');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', ones(2,5)/2, ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5),...
%     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_initialB_2alpha.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_initialB_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(2,3), 'Noise_lambda_p2X5', ones(2,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,5),...
%     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub','b0'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_initialB_2alphawl.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_initialB_2alphawl');
% init0{mi} = struct('Noise_k_p2X5', ones(2,3), 'Noise_lambda_p2X5', ones(2,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,5),...
%     'b0', zeros(2,3));
% % model minimum initialB
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_basic_2alpha.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_basic_2alpha');
% init0{mi} = struct('Noise_k_p2X5', ones(2,3), 'Noise_lambda_p2X5', ones(2,3), ...
%     'alpha_n2X5', ones(2,3,2)/2, ...
%     'alpha_p2X5', ones(2,3,2), ...
%     'beta_n2X5', zeros(2,3), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget_both.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget_both');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget_nodrift.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget_nodrift');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
% % model forget term
% mi = mi + 1;
% params{mi} = {'Noise_k_p2X5','Noise_lambda_p2X5','alpha_n2X5', 'alpha_p2X5', ...
%     'beta_n2X5', 'beta_p2X5', 'Q', 'Noise_sub', 'alpha_sub', ...
%     'beta_sub'};
% modelfile{mi} = fullfile(fullpt,'/Models/model_forget_both_nodrift.txt');
% outfile{mi} = fullfile(outputdir,'resultCharlotte_forget_both_nodrift');
% init0{mi} = struct('Noise_k_p2X5', ones(2,5), 'Noise_lambda_p2X5', ones(2,5), ...
%     'alpha_n2X5', zeros(2,5), ...
%     'alpha_p2X5', ones(2,5), ...
%     'beta_n2X5', zeros(2,5), ...
%     'beta_p2X5', ones(2,5));
