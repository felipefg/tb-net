% do_crossval.m - Perform cross validation. If a 'filename' variable is
% present, it will be the only file for cross validation. Otherwise, all files
% in the data directory will be visited.

%% Assembly the list of number of neurons in the hidden layer that will be
% tried
if ~exist('neuronList', 'var'),
    neuronList = 2:20;
end

%% Find the files that will be visited
if exist('filename', 'var'),
    files = { sprintf('../data/guadalupe/cluster/%s', filename) };
else
    files = {};
    dir_list = dir('../data/guadalupe/cluster');
    for i=1:length(dir_list),

        filename = dir_list(i).name;

        if findstr('ART', filename),
            files{end+1} = sprintf('../data/guadalupe/cluster/%s', filename);
        end

    end
end

for k=1:length(neuronList),

    neurons = neuronList(k);

    %% Perform the cross validation for each file
    rets = cell(1, length(files));
    parfor i=1:length(files),

        data = load(files{i});
        
        [ trn, val, tst, norm_info ] = normalize_tb(data.trn, data.val, data.val, struct());


        %% Setup the template network
        net = newff2(trn, [-1 1], [neurons], {'tansig', 'tansig'});

        % Setting train parameters
        net.trainParam.batchSize = 255;
        net.trainParam.useSP     = 1;
        net.trainParam.epochs    = 2000;
        net.trainParam.max_fail  = 2000;
        net.trainParam.showWindow= 0;
        net.trainParam.show = 1000;
        net.trainParam.sp_signal_weight=1.5;
        net.trainParam.sp_noise_weight=0.5;

        % Train many nets for avoiding local minima
        nTrains = 200;
        nets = cell(1, nTrains);
        trs = cell(1, nTrains);
        sps = zeros(1, nTrains);
        for j=1:nTrains,
            [nets{j}, trs{j}] = ntrain(net, trn, val);
            sps(j) = max(trs{j}.sp_val);
        end
        
        [max_sp, i_max_sp] = max(sps);
        
        rets{i}.net = nets{i_max_sp};
        rets{i}.tr = trs{i_max_sp};
        rets{i}.sp = max_sp;
    end

    save(sprintf('results_%d_neurons.mat', neurons), 'rets', 'files', 'neurons');

end
