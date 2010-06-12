% Esse script depende que as variaveis "treino", "teste" e neuronios j?
% estejam definidas no ambiente de trabalho.

variaveis = size(treino, 2) - 1;

net = cria_rede(variaveis, neuronios);

[net, tr, centros, fatores] = treina_rede(net, treino, teste);

[teste_acuracia, teste_espec, teste_sens] = avalia_rede(net, teste, centros, fatores);
[treino_acuracia, treino_espec, treino_sens] = avalia_rede(net, treino, centros, fatores);
