arquivos = dir('../data/alcione/12v/');

for i = 1:size(arquivos,1),
    if findstr('ANT', arquivos(i).name),
        continue;
    end
    if findstr('txt', arquivos(i).name),
        dados = load(sprintf('../data/alcione/12v/%s', arquivos(i).name));
        [ acu, esp, sen ] = avaliar(dados);
        fprintf('%-15s: Acuracia: %6.2f%% Sensibilidade %6.2f%% Especificidade %6.2f%% \n', arquivos(i).name(1:end-4), 100*acu, 100*sen, 100*esp);
    end
end
