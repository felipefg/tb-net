% train_nets.m - Train all the nets for all the configurations being
% studied

NUM_TRAINS = 10; % Number of trains for each database

%% Find the files that will be visited
if exist('filename', 'var'),
    files = { sprintf('../data/guadalupe/%s', filename) };
else,
    files = {};
    dir_list = dir('../data/guadalupe');
    for i=1:length(dir_list),

        filename = dir_list(i).name;

        if findstr('txt', filename),
            files{end+1} = filename;
        end

    end
end


for i=1:length(files),

    filename = files{i}(1:end-4);
    fprintf('Processing %s...', filename);

    %% Setup environment
    nets = cell(1, NUM_TRAINS);
    trs  = cell(1, NUM_TRAINS);

    % Train this network
    parfor j=1:NUM_TRAINS,

        % Get a random train and validation group for this file
        [train validation] = load_data(files{i});

        % Create the network
        net = newff2(train, [-1 1], [4], {'tansig', 'tansig'});

        % Setting train parameters
        net.trainParam.batchSize = 255;
        net.trainParam.useSP     = 1;
        net.trainParam.epochs    = 10000;
        net.trainParam.max_fail  = 10000;
        net.trainParam.showWindow= 0;
        net.trainParam.show = 2000;

        % Train
        [net, tr] = ntrain(net, train, validation);

        nets{j} = net;
        trs{j} = tr;
    end

    save(sprintf('results_%s.mat',filename), 'nets', 'trs');
end
