%% Configuracoes
opcoes_variaveis = [8 12 26];
opcoes_neuronios = [3 4];
n_redes = 200;

%% Carrega as melhores redes, segundo Alcione
load performances_alcione

%% Monta array com todas as combinacoes que serao visitadas
melhores = cell(1, size(opcoes_variaveis,2)*size(opcoes_neuronios,2));

for i=1:size(opcoes_variaveis, 2),
    for j=1:size(opcoes_neuronios, 2),
        melhores{1, (i-1)*size(opcoes_neuronios,2) + j} = ...
            struct('variaveis', opcoes_variaveis(1,i), ...
                   'neuronios', opcoes_neuronios(1,j));
    end
end

%% Busca por redes
for i=1:size(melhores, 2),

    variaveis = melhores{1,i}.variaveis;
    neuronios = melhores{1,i}.neuronios;

    %% Le arquivo de dados
    filename = sprintf('dados-%dv', variaveis);
    load(filename)
    clear filename;

    %% Pega a performance da Alcione para essa configuracao
    chave = sprintf('r%d_%d', variaveis, neuronios);
    perf_alcione = performances_alcione.(chave);
    clear chave

    %% Treina todas as redes nessa configuracao
    redes = cell(1, n_redes);
    performances = zeros(n_redes, 6);
    mses = zeros(n_redes, 1);

    parfor n=1:n_redes,
        net = cria_rede(variaveis, neuronios);

        [net, tr, centros, fatores] = treina_rede(net, treino, teste);

        [teste_acuracia, teste_espec, teste_sens] = avalia_rede(net, teste, centros, fatores);
        [treino_acuracia, treino_espec, treino_sens] = avalia_rede(net, treino, centros, fatores);

        redes{1, n} = struct('net', net, 'tr', tr);
        performances(n,:) = [treino_acuracia treino_espec treino_sens teste_acuracia teste_espec teste_sens];
        mses(n, 1) = tr.tperf(1, tr.best_epoch+1);
    end;

    %% Pega melhor rede por MSE do conjunto de teste
    [discard, melhor_rede] = min(mses);
    melhores{1,i}.melhor_mse_net = redes{1, melhor_rede}.net;
    melhores{1,i}.melhor_mse_tr  = redes{1, melhor_rede}.tr;
    melhores{1,i}.melhor_mse_perf = performances(melhor_rede,:);


    %% Pega melhor rede por similaridade com a da Alcione
    diferencas = performances - repmat(perf_alcione, [n_redes, 1]);
    similaridade = sum(diferencas.^2, 2);
    [discard, melhor_rede] = min(similaridade);
    melhores{1,i}.melhor_alcione_net = redes{1, melhor_rede}.net;
    melhores{1,i}.melhor_alcione_tr  = redes{1, melhor_rede}.tr;
    melhores{1,i}.melhor_alcione_perf = performances(melhor_rede,:);

    %% Mais estatisticas
    melhores{1,i}.mses = mses;
    melhores{1,i}.similaridades = similaridade;
    
    %% Cleanup
    clear redes performances mses discard
    clear melhor_rede diferencas similaridade perf_alcione 
    clear variaveis neuronios
    clear teste treino
end

clear i j n

save resultados melhores
