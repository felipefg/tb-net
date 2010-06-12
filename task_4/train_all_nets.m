% train_all_nets.m - Generate multiple training/validation data set and,
% for each, use train_nets.m for training the networks in various
% configurations. The rationale behind this is to minimize the influence of
% a bad choice for training/validation sets.


%% Set up the environment
run_control
all_nets = cell(1, rc.nDraws);
results = struct();

%% Train the networks
for k=1:rc.nDraws,
    
    % Generate a training/validation sets
    load_data;
    
    % Train the networks
    train_nets;
    
    % Save the nets
    all_nets{k} = nets;
    
    % Save regrouped results for plotting
    for i=1:size(nets, 2),
        param_name = sprintf('useSP_%d', nets{i}.useSP);
        
        % First time seeing this kind of stop condition?
        if ~isfield(results, param_name),
            results.(param_name) = struct();
        end
        
        % First time seeing this batch size?
        batch_name = sprintf('batch_%04d', nets{i}.batch_size);
        if ~isfield(results.(param_name), batch_name),
            results.(param_name).(batch_name) = struct( ...
                'mses', [], ...
                'SPs', [] ...
                );
        end
        
        % Append the best MSE and SP for this configuration
        results.(param_name).(batch_name).mses = ...
            [results.(param_name).(batch_name).mses nets{i}.mse];
        results.(param_name).(batch_name).SPs = ...
            [results.(param_name).(batch_name).SPs nets{i}.SP];
    end
    
end


%% Save data
save all_nets all_nets
save results results