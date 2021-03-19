function out = behavior_Charlotte(x)
    % trial number analysis
    bin = [0.5:10:30.5];
    nbin = length(bin)-1;
    out = W_tools.analysis_bincurve(x, {'c_X', 'c_repeat', 'c_ac_X', ...
        'Rewarded', 'RT'}, [], bin,'all');
    
    
    te = W_tools.analysis_bincurve_bygroup(x, {'c_X', 'c_repeat', 'c_ac_X', ...
        'Rewarded', 'RT'}, 'win_X',[1:2],[], bin,'all');
    out = catstruct(out, te);
   
    tt = abs(diff(x.win_X)) + 1; % 1-same,2-diff
    te = W_tools.analysis_bincurve(x, {'c_ac_X'}, [], bin);
    out.ps_cons(tt, :) = te.bin_byrow_c_ac_X(:, nbin);
    out.ps_cons(3-tt, :) = NaN;
    % needs to add RT
end