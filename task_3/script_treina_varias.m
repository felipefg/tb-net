clear all

dados = load('../data/guadalupe/8v_alcione.txt');

[ treino, validacao ] = sorteia_treino_validacao(dados);

neuronios = 4;

variaveis = size(treino, 2) - 1;

n_redes = 10;

redes = cell(1, n_redes);
performances = zeros(n_redes, 6);
mses = zeros(n_redes, 1);

parfor i=1:n_redes,

    net = cria_rede(variaveis, neuronios);

    [net, tr, centros, fatores] = treina_rede(net, treino, validacao);

    [validacao_acuracia, validacao_espec, validacao_sens] = avalia_rede(net, validacao, centros, fatores);
    [treino_acuracia, treino_espec, treino_sens] = avalia_rede(net, validacao, centros, fatores);

    redes{1, i} = struct('net', net, 'tr', tr);
    performances(i,:) = [treino_acuracia treino_espec treino_sens validacao_acuracia validacao_espec validacao_sens];
    mses(i) = tr.vperf(tr.best_epoch + 1);
end;

