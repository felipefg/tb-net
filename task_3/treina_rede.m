function [ net, tr, centros, fatores ] = treina_rede( net, treino, validacao )
%TREINA_REDE Treina a rede neural para dados do Projeto TB.
%    Usar VETORES LINHA!

%% Calculo dos parametros de normalizacao
variaveis   = size(treino, 2);
n_treino    = size(treino, 1);
n_validacao = size(validacao, 1);

% Ultima variavel na verdade e o Target!
variaveis = variaveis - 1;

centros = zeros([1 variaveis]);
fatores = ones([1 variaveis]);

% Parametros de normalizacao da idade
centros(1,1) = mean(treino(:,1));
fatores(1,1) = 1.0/max(abs(treino(:,1) - centros(1,1)));

% Parametros de normalizacao da renda, caso estejamos com 26 variaveis
if variaveis == 26,
    centros(1,5) = mean(treino(:,5));
    fatores(1,5) = 1.0/max(abs(treino(:,5) - centros(1,5)));
end;

%% Montagem das matrizes de dados e alvos
dados = [ treino(:,1:variaveis); validacao(:,1:variaveis) ];
alvos = [ treino(:,variaveis+1); validacao(:,variaveis+1) ];

%% Normalizacao
dados = (dados - repmat(centros, [size(dados, 1) 1]))*diag(fatores);

%% Configuracao da rede

net.divideParam.trainInd = 1:n_treino;
net.divideParam.valInd   = (n_treino + 1):(n_treino + n_validacao);
net.divideParam.testInd  = [];

%% Treinamento

[net, tr] = train(net, dados', alvos');
end
