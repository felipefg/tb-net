%% Configuration for this run

rc = struct();
rc.neurons = 4;    % Neurons in the hidden layer
rc.nBatchSize = 5; % Number of different batch sizes that will be tested
rc.functions = {'tansig', 'tansig'};
rc.trainsPerDeal = 2;
rc.nDraws = 2; % Number of times that a test/validation set will be created

rc.trainParam = struct();
rc.trainParam.epochs  = 10000;
rc.trainParam.max_fail = 10000;
