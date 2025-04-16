# PARTE 1 – TRANSAÇÕES 

#### Objetivo 1:  
Neste desafio você irá lidar com transações para executar modificações na base de dados.  

### CODE 1
- queries_insert.sql  
- queries_select.sql  
  
#### Objetivo 2:  
Executar statements de consultas e modificações de dados persistidos no banco de dados via transações.  

### CODE 2
- queries_update.sql  


# PARTE 2 - TRANSAÇÃO COM PROCEDURE 

Você deverá criar outra transação, contudo, esta será definida dentro de uma procedure.  
Neste caso, deverá haver uma verificação de erro.  
Essa verificação irá acarretar um ROLLBACK, total ou parcial (SAVEPOINT).  

### CODE 3
- procedure_transaction.sql
  

# PARTE 3 – BACKUP E RECOVERY 

#### Objetivo: 

Neste etapa do desafio, você irá executar o backup do banco de dados e-commerce.  
Realize o backup e recovery do banco de dados; 

- Utilize o mysqldump para realizar o backup e recovery do banco de dados e-commerce; 
- Realize o backup e inseria os recursos como: procedures, eventos e outros. 

### CODE 3
- mysqldump -uroot -proot --no-data --databases ecomerce > dump_ecomerce_schema.sql  
- mysqldump -uroot -proot --databases ecomerce > dump_ecomerce.sql
- mysqldump -uroot -proot --routines --triggers --events --no-tablespaces --databases ecomerce > dump_ecomerce_completo.sql

