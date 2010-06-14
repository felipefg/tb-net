% Make the plots for the result of the processing. Perform the processing if
% needed.

if exist('results.mat', 'file') == 0,
    train_all_nets
end

!./plots.py
!open sp_evolution.png
