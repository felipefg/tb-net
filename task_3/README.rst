Tarefa 3
========

Treinar rede neural usando 8 variáveis de Guadalupe, e avaliar seu desempenho.

Dados
-----

8 variáveis de guadalupe:

1. Idade
2. Tosse
3. Hemoptoico e/ou Hemoptise
4. Sudorese Noturna
5. Febre
6. Emagrecimento
7. Dispneia
8. SIDA
9. Diagnostico (target)

Parâmetros de Treinamento
-------------------------

- Normalização:

  - Idade:centralizar e dividir pelo máximo

- Validação cruzada:

  - DivideRand 50% pra treino, 50% pra validação, sem teste.
  - TODO: Utilizar 50%/50%

- Inicialização dos pesos: Nguyen-Widrow (Default do Matlab)

- Algoritmo: RPROP

- Critério de Parada: MSE
