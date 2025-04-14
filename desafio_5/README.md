# Parte 1 – Criando índices em Banco de Dados 

Criação de índices para consultas para o cenário de company com as perguntas (queries sql) para recuperação de informações.

Sendo assim, dentro do script será criado os índices com base na consulta SQL.  

- O que será levado em consideração para criação dos índices? 
  - Quais os dados mais acessados 
  - Quais os dados mais relevantes no contexto 
Lembre-se da função do índice... ele impacta diretamente na velocidade da buca pelas informações no SGBD.
 
#### A criação do índice pode ser criada via ALTER TABLE ou CREATE Statement 

- ALTER TABLE **table_name** ADD UNIQUE **index_name(field)**; 
- CREATE INDEX **index_name_hash** ON **table(field)** USING HASH; 

### Perguntas:  
- Qual o Setor com maior número de pedidos? 
- Relação de responsaveis por setor 
- Quais são as 3 cidades (Endereços) com maior número de entrega?
- Quais os 3 vendedores com maior número de pedidos? 

### Entregável: 
- Crie as queries para responder essas perguntas 
- Crie o índice para cada tabela envolvida (de acordo com a necessidade) 
- Tipo de indice utilizado e motivo da escolha (via comentário no script ou readme) 

# Parte 2 - Utilização de procedures para manipulação de dados em Banco de Dados 

#### Objetivo:  
- Criar uma procedure que possua as instruções de inserção, remoção e atualização de dados no banco de dados.
- As instruções devem estar dentro de estruturas condicionais (como CASE ou IF).
- Além das variáveis de recebimento das informações, a procedure deverá possuir uma variável de controle.
- Essa variável de controle irá determinar a ação a ser executada.
  - Ex: opção 1 – select, 2 – update, 3 – delete. 

### Entregável: 
Script SQL com a procedure criada e chamada para manipular os dados de e-commerce.
