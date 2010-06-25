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
    files = { sprintf('../data/guadalupe/%s', filename) };
else,
    files = {};
    dir_list = dir('../data/guadalupe');
    for i=1:length(dir_list),

        filename = dir_list(i).name;

        if findstr('txt', filename),
            files{end+1} = sprintf('../data/guadalupe/%s', filename);
        end

    end
end

for k=1:length(neuronList),

    neurons = neuronList(k);

    %% Perform the cross validation for each file
    rets = cell(1, length(files));
    parfor i=1:length(files),

        data = load_data(files{i});

        %% Setup the template network
        net = newff2(data, [-1 1], [neurons], {'tansig', 'tansig'});

        % Setting train parameters
        net.trainParam.batchSize = 255;
        net.trainParam.useSP     = 1;
        net.trainParam.epochs    = 2000;
        net.trainParam.max_fail  = 2000;
        net.trainParam.showWindow= 0;
        net.trainParam.show = 1000;
        net.trainParam.sp_signal_weight=1.5;
        net.trainParam.sp_noise_weight=0.5;

        % Preprocessing structure
        pp = struct();
        pp.func = @normalize_tb;
        pp.par = struct();

        rets{i} = crossVal(data, net, pp, true, 12, 20, 5);
    end

    save(sprintf('results_%d_neurons.mat', neurons), 'rets', 'files', 'neurons');

end
