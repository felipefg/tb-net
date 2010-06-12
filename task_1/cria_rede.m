function [ net ] = cria_rede( variaveis_entrada, neuronios_escondida )
%CRIA_REDE Cria uma rede neural ajustada pras necessidades do ProjetoTB
%   Detailed explanation goes here

% 2 amostras representantes da entrada
P = repmat([1 -1], [variaveis_entrada 1]);

% Representantes da sa?da
T = [1 -1];

% Neuronios na camada escondida
S = neuronios_escondida;

% Fun??es de Transfer?ncia da camada escondida e de sa?da
TF = {'tansig', 'tansig'};

% Fun??o de Treinamento
BTF = 'traingdx';

% Fun??o de corre??o de pesos
BLF = 'learngdm';

% Fun??o de Performance
PF = 'mse';

% Processamento das entradas
IPF = {};

% Processamento das sa?das
OPF = {};

% Fun??o de divis?o de dados por ?ndices
DDF = 'divideind';

net = newff(P, T, S, TF, BTF, BLF, PF, IPF, OPF, DDF);

% Par?metros de treinamento

net.trainParam.show =            25; % Epochs between displays
net.trainParam.showCommandLine =  0; % generate command line output
net.trainParam.showWindow =       0; % show training GUI
net.trainParam.epochs =       10000; % Maximum number of epochs to train
net.trainParam.goal =             0; % Performance goal
net.trainParam.lr =             0.9; % Learning rate
net.trainParam.lr_inc =        1.10; % Ratio to increase learning rate
net.trainParam.lr_dec =        0.95; % Ratio to decrease learning rate
net.trainParam.max_fail =       inf; % Maximum validation failures
net.trainParam.max_perf_inc =  1.04; % Maximum performance increase
net.trainParam.mc =             0.7; % Momentum constant.
net.trainParam.min_grad =         0; % Minimum performance gradient
net.trainParam.time =           inf; % Maximum time to train in seconds

% Inicializacao aleatoria de pesos entre -0.1 e 0.1

% Configura rede para inicializar com funcao RANDS, que d? valores
% aleatorios entre -1 e 1
net.layers{1}.initFcn = 'initwb';
net.layers{2}.initFcn = 'initwb';
net.inputWeights{1}.initFcn = 'rands';
net.layerWeights{2,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net.biases{2}.initFcn = 'rands';

net = init(net);

% Multiplica pesos por 0.1 para ter valores aleatorios entre -0.1 e 0.1
net.IW{1,1} = net.IW{1,1} * 0.1;
net.LW{2,1} = net.LW{2,1} * 0.1;
net.b{1} = net.b{1} * 0.1;
net.b{2} = net.b{2} * 0.1;

end