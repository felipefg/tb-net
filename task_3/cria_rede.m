function [ net ] = cria_rede( variaveis_entrada, neuronios_escondida )
%CRIA_REDE Cria uma rede neural ajustada pras necessidades do ProjetoTB
%   Detailed explanation goes here

% 2 amostras representantes da entrada
P = repmat([1 -1], [variaveis_entrada 1]);

% Representantes da saida
T = [1 -1];

% Neuronios na camada escondida
S = neuronios_escondida;

% Funcoes de Transferencia da camada escondida e de saida
TF = {'tansig', 'tansig'};

% Funcao de Treinamento
BTF = 'trainrp';

% Funcao de correcao de pesos
BLF = 'learngdm';

% Funcao de Performance
PF = 'mse';

% Processamento das entradas
IPF = {};

% Processamento das saidas
OPF = {};

% Funcao de divisao de dados por indices
DDF = 'divideind';

net = newff(P, T, S, TF, BTF, BLF, PF, IPF, OPF, DDF);

% Parametros de treinamento
net.trainParam.show =         25; % Epochs between displays
net.trainParam.showCommandLine =  1; % generate command line output
net.trainParam.showWindow =    0; % show training GUI
net.trainParam.epochs =    10000; % Maximum number of epochs to train
net.trainParam.goal =          0; % Performance goal
net.trainParam.time =        inf; % Maximum time to train in seconds
net.trainParam.min_grad =   1e-6; % Minimum performance gradient
net.trainParam.max_fail =    100; % Maximum validation failures
net.trainParam.lr =         0.01; % Learning rate
net.trainParam.delt_inc =   1.20; % Increment to weight change
net.trainParam.delt_dec =    0.5; % Decrement to weight change
net.trainParam.delta0 =     0.07; % Initial weight change
net.trainParam.deltamax =   50.0; % Maximum weight change

net = init(net);

end
