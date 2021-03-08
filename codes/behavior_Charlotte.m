function out = behavior_Charlotte(x)
    % trial number analysis
    bin = [0.5:10:30.5];
    nbin = length(bin)-1;
    te = W_tools.analysis_bincurve(x, {'c_X', 'c_ac_X', ...
        'Rewarded'}, [], bin);
    out = W_tools.analysis_bincurve(x, {'c_X', 'c_ac_X', ...
        'Rewarded'}, [], bin,'all');
    win = x.win_X;
    for wi = 1:2
        out.p_ac_byX(wi) = nanmean(te.bin_byrow_c_ac_X(wi == win, nbin));
    end
    tt = abs(diff(win)) + 1; % 1-same,2-diff
    out.ps_cons(tt, :) = te.bin_byrow_c_ac_X(:, nbin);
    out.ps_cons(3-tt, :) = NaN;
    % needs to add RT
end