% train_nets.m - Train all the nets for all the configurations being
% studied

%% Load Dependencies

% Load data if needed.
if exist('train', 'var') == 0,
   if exist('train_validation_data.mat', 'file'),
       load train_validation_data
   else
       load_data
   end
end

% Loading run control configuration
if exist('rc', 'var') == 0,
    run_control
end

%% Setup environment
n_train_c1 = size(train{1}, 2);
n_train_c2 = size(train{1}, 2);
batch_size = linspace(10, min(n_train_c1, n_train_c2), rc.nBatchSize);
batch_size = round(batch_size);

useSP_options = [0 1];

% Deal the configurations
nets = cell(1, size(batch_size, 2)*size(useSP_options, 2));
for i=1:size(batch_size, 2),
    for j=1:size(useSP_options, 2),
        nets{ (j-1)*size(batch_size, 2) + i} = struct( ...
            'useSP', useSP_options(j), ...
            'batch_size', batch_size(i));
    end
end

%% Train the networks
parfor i=1:size(nets, 2),
    
    trained_nets = cell(1, rc.trainsPerDeal);
    trained_trs  = cell(1, rc.trainsPerDeal);
    mses = zeros(1, rc.trainsPerDeal);
    SPs  = zeros(1, rc.trainsPerDeal);
    
    for j=1:rc.trainsPerDeal,
        % Create the network
        net = newff2(train, [-1 1], [rc.neurons], rc.functions);

        % Setting train parameters
        net.trainParam.batchSize = nets{i}.batch_size;
        net.trainParam.useSP     = nets{i}.useSP;
        net.trainParam.epochs    = rc.trainParam.epochs;
        net.trainParam.max_fail  = rc.trainParam.max_fail;
        net.trainParam.showWindow= 0;
        
        % Train
        [net, tr] = ntrain(net, train, validation);
        
        % Extract performances
        mses(j) = min(tr.mse_val);
        
        out_positive = sim(net, validation{1});
        out_negative = sim(net, validation{1});
        [spVec, cutVec, detVec, faVec] = genROC(out_positive, out_negative);
        SPs(j) = max(spVec);
        
        % Save data
        trained_nets{j} = net;
        trained_trs{j} = tr;
    end
    
    nets{i}.nets = trained_nets;
    nets{i}.trs = trained_trs;
end

%% Save

%% Cleanup
clear n_train_c1 n_train_c2