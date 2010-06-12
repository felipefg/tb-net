function [ treino, validacao ] = sorteia_treino_validacao(dados)

[treino, validacao, ~, ~, ~, ~] = dividerand(dados', 0.5, 0.5, 0.0);

treino = treino';
validacao = validacao';
end
