function [ net, tr, centros, fatores ] = treina_rede( net, treino, validacao )
%TREINA_REDE Treina a rede neural para dados do Projeto TB.
%    Usar VETORES LINHA!

%% C?lculo dos par?metros de normaliza??o
variaveis   = size(treino, 2);
n_treino    = size(treino, 1);
n_validacao = size(validacao, 1);

% ?ltima variavel na verdade ? o Target!
variaveis = variaveis - 1;

centros = zeros([1 variaveis]);
fatores = ones([1 variaveis]);

% Par?metros de normaliza??o da idade
centros(1,1) = mean(treino(:,1));
fatores(1,1) = 1.0/max(abs(treino(:,1) - centros(1,1)));

% Par?metros de normaliza??o da renda, caso estejamos com 26 vari?veis
if variaveis == 26,
    centros(1,5) = mean(treino(:,5));
    fatores(1,5) = 1.0/max(abs(treino(:,5) - centros(1,5)));
end;

%% Normalizacao como a do script da Alcione. Isso est? errado!!

treino(:,1)=(treino(:,1)-mean(treino(:,1)))/max(treino(:,1)-mean(treino(:,1)));
validacao(:,1)=(validacao(:,1)-mean(validacao(:,1)))/max(validacao(:,1)-mean(validacao(:,1)));

if variaveis == 26,
    treino(:,5)=(treino(:,5)-mean(treino(:,5)))/max(treino(:,5)-mean(treino(:,5)));
    validacao(:,5)=(validacao(:,5)-mean(validacao(:,5)))/max(validacao(:,5)-mean(validacao(:,5)));
end;

%% Montagem das matrizes de dados e alvos
dados = [ treino(:,1:variaveis); validacao(:,1:variaveis) ];
alvos = [ treino(:,variaveis+1); validacao(:,variaveis+1) ];

%% Normaliza??o
% Usando o da Alcione!
%dados = (dados - repmat(centros, [size(dados, 1) 1]))*diag(fatores);

%% Configura??o da rede

net.divideParam.trainInd = 1:n_treino;

% Conjunto de validacao = conjunto de treino para evitar que o matlab
% selecione bestnet baseado no conjunto de testes. Isso eh pra tentar
% replicar a forma como foi feito o treinamento pela Alcione
net.divideParam.valInd   = 1:n_treino;

net.divideParam.testInd  = (n_treino + 1):(n_treino + n_validacao);

%% Treinamento

[net, tr] = train(net, dados', alvos');
end
