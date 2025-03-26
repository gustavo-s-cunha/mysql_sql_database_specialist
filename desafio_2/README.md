# Projeto de Ordens de serviço

# Objetivo do desafio
Cria o esquema conceitual para o contexto de oficina com base na narrativa fornecida


## Narrativa:
- Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica
- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas
- Cada veículo é designado a uma equipe de mecânicos que identificam os serviços a serem executados e preenche uma OS com data de entrega.
- A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra
- O valor de cada peça também irá compor a OSO cliente autoriza a execução dos serviços
- A mesma equipe avalia e executa os serviços
- Os mecânicos possuem código, nome, endereço e especialidade
- Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.



## Narrativa - Cliente
- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas
- Oficina registra dados do cliente


## Narrativa - Veículo
- Veículos pertencentem aos Clientes


## Narrativa - Mecânico
- Mecânicos que trabalham na oficina
- - ID, nome, endereço e especialidade


## Narrativa - Serviços
- Mecânicos identificam os serviços a serem executados
- - ID, nome, valor, descrição


## Narrativa - Peças
- Mecânicos que identifica as peças a serem utilizadas
- - ID, nome, valor, descrição


## Narrativa - Ordem de Serviço
- ID, data de emissão, um valor, situacao, data para conclusão
- Uma ordem de serviços pode utilizar várias peças e serviços


