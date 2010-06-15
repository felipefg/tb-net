Dados de Guadalupe
==================

- ``rede_joao.mat``: Rede neural 12-15-1 desenvolvida pelo João sobre os dados
  da Alcione. Ver task_2 para mais detalhes. A ordem das variáveis que essa
  rede espera são:

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
  13. Diagnostico (alvo)

- ``8v_alcione.txt``: Dados de Guadalupe, mas somente as 8 variáveis que têm
  correspondencia com as da tese da Alcione. Elas são:

  1. Idade
  2. Tosse
  3. Hemoptoico e/ou Hemoptise
  4. Sudorese Noturna
  5. Febre
  6. Emagrecimento
  7. Dispneia
  8. SIDA
  9. Diagnostico (alvo)

- ``10v.txt``: Dados de Guadalupe, com as 8 variáveis da tese da Alcione e as
  duas do modelo do Rafael:

  1. Idade
  2. Tosse
  3. Hemoptoico e/ou Hemoptise
  4. Sudorese Noturna
  5. Febre
  6. Emagrecimento
  7. Dispneia
  8. SIDA
  9. Sexo (-1 homem, 1 mulher)
  10. Dor toracica
  11. Diagnostico (alvo)

Bases alternativas
------------------

- ``alternativa_109.txt`` e ``alternativa_107.txt``: Idênticas a ``10v.txt`` e
  ``8v_alcione.txt``, mas sem a variável SIDA.
