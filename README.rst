Análises Projeto TB
===================

This repository is for the task force for data analysis and training of neural
models for the ProjetoTB_, at LPS_-COPPE_-UFRJ_.

.. _ProjetoTB: http://www.projetotb.lps.ufrj.br/
.. _LPS: http://www.lps.ufrj.br/
.. _COPPE: http://www.coppe.ufrj.br/
.. _UFRJ: http://www.ufrj.br/

If you don't know whats this about, send an e-mail to the owner of the
repository, as the rest of the documentation will be in Portuguese.

Estrutura de diretórios
-----------------------

Os arquivos para análise estão dispostos da seguinte forma:

- ``data/`` - Dados que alimentam as análises. Podem ser brutos ou resultados
  de alguma análise, que mereçam ser salvos.

- ``lib/`` - Rotinas genéricas que podem ser usada pelas tarefas de análise.
  Esse diretório deve estar no PATH.

- ``task_*/`` - Tarefas de análise. Ver o README de cada diretório para mais
  detalhes.

Dependências
------------

Alguns dos scripts dependem do toolbox FastNET_.

.. _FastNET: http://github.com/rctorres/fastnet/
