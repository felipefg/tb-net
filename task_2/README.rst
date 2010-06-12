Tarefa 2
========

Utilizando a rede treinada pelo grupo do João com os dados da Alcione,
reproduzir seus bons resultados de sensibilidade e especificidade.

O script "testa_todos" mede o desempenho da rede para todos os aquivos txt do
diretório. Os melhores resultados devem ser encontrados para os arquivos
treina12_clus.txt e testa12_clus.txt. Esses arquivos correspondem ao conjunto de
treinamento e teste montados a partir da rede ART, e foram os usados para
treinar a rede em questão.

Resultado para esses arquivos::

  teste12_clus.txt : Acuracia:  88.24% Sensibilidade 100.00% Especificidade  80.00%
  treina12_clus.txt: Acuracia:  89.22% Sensibilidade  82.22% Especificidade  94.74%

Outros resultados interessantes::

  todos_alcione.txt: Acuracia:  88.97% Sensibilidade  86.44% Especificidade  90.91%

Dados de Guadalupe
------------------

Dados retirados de ScoreTB_RNeural_set06_jul07Banco_Final_jan2010casos.xls,
adaptados por Cascão. ::

  guadalupe.txt: Acuracia:  44.34% Sensibilidade  64.61% Especificidade  38.90%

Ordem das variáveis para a rede neural
--------------------------------------

1. Idade
2. Tosse
3. Hemoptoico e/ou Hemoptise
4. Sudorese Noturna
5. Febre
6. Emagrecimento
7. Dispneia
8. Anorexia
9. Fuma atual
10. TB extrapulm
11. Intern. Hospitalar
12. SIDA
13. Diagnostico (target)

