function [ acuracia, sensibilidade, especificidade ] = avalia_rede( net, teste, centros, fatores )
%avalia_rede Summary of this function goes here
%   Detailed explanation goes here

%% Normaliza dados
variaveis = size(teste,2) - 1;
dados = teste(:,1:variaveis);
dados = (dados - repmat(centros, [size(teste,1) 1]))*diag(fatores);

alvos = teste(:,variaveis+1);

saidas = sim(net, dados');

corte = 0;
result = sign(saidas - corte);

%% Calcula indices de falso positivo e falso negativo
vp = 0; % Verdadeiro positivo
fp = 0; % Falso positivo
vn = 0; % Verdadeiro negativo
fn = 0; % Falso negativo

for i=1:size(dados,1),
    if alvos(i) == 1,
        if result(i) == 1,
            vp = vp + 1;
        else
            fn = fn + 1;
        end
    else
        if result(i) == -1,
            vn = vn + 1;
        else
            fp = fp + 1;
        end
    end    
end

%% Calcula indices
acuracia = (vp+vn)/size(dados,1);
sensibilidade = vp/(vp+fn);
especificidade = vn/(vn+fp);
end

