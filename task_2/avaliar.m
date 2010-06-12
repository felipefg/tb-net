function [ acuracia, especificidade, sensibilidade ] = avaliar(dados)
% [ acuracia, especificidade, sensibilidade ] = avaliar(dados)
%     Calcula Especificidade e Sensibilidade para a rede do Joao para os
%     dados da Alcione.

%% Carrega dados
load('../data/guadalupe/rede_joao.mat');

entrada = dados(:,1:12);
alvos = dados(:,13);

%% Normalizacao da idade
entrada(:,1) = entrada(:,1)*fator_normalizacao;

%% Propaga 

y_prim = tanh(mat_W1*entrada'+repmat(B1,1,size(entrada,1)));
y_out  = tanh(mat_W2*y_prim+repmat(B2,1,size(y_prim,2)));

%% Resultados com corte em zero
result = sign(y_out);

%% Calcula indices de falso positivo e falso negativo
vp = 0; % Verdadeiro positivo
fp = 0; % Falso positivo
vn = 0; % Verdadeiro negativo
fn = 0; % Falso negativo

for i=1:size(result,2),
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
acuracia = (vp+vn)/size(result,2);
sensibilidade = vp/(vp+fn);
especificidade = vn/(vn+fp);
end
