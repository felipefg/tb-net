function [ acuracia, sensibilidade, especificidade ] = avalia_rede( net, teste, centros, fatores )
%avalia_rede Summary of this function goes here
%   Detailed explanation goes here

%% Preparacao dos dados
variaveis = size(teste,2) - 1;
dados = teste(:,1:variaveis);

alvos = teste(:,variaveis+1);

%% Normalizacao como a do script da Alcione. Isso esta errado!!

dados(:,1)=(dados(:,1)-mean(dados(:,1)))/max(dados(:,1)-mean(dados(:,1)));

if variaveis == 26,
    dados(:,5)=(dados(:,5)-mean(dados(:,5)))/max(dados(:,5)-mean(dados(:,5)));
end;

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

