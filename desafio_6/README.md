# Parte 1 – Personalizando acessos com views 
Neste desafio você irá criar views para os seguintes cenários 

- Número de responsaveis por setor
- Lista de ordens de serviço por setor 
- Número de pedidos por endereço e setor
- Lista de produtos, local de estoque e fornecedor
- Quais produtos com maior número de pedidos


Além disso, serão definidas as permissões de acesso as views de acordo com o tipo de conta de usuários.  
Lembre-se que as views ficam armazaneadas no banco de dados como uma “tabela”.  
Assim podemos definir permissão de acesso a este item do banco de dados.  
 
Você poderá criar um usuário gerente que terá acesso as informações de employee e departamento.  
Contudo, employee não terá acesso as informações relacionadas aos departamentos ou gerentes.  

  
# Parte 2 – Criando gatilhos para cenário de e-commerce 

## Objetivo: 

Sabemos que a criação de triggers está associadas a ações que podem ser tomadas em momento anterior ou posterior a inserção, ou atualização dos dados.  
Além disso, em casos de remoção podemos utilizar as triggers.  
Sendo assim, crie as seguintes triggers para o cenário de e-commerce. 

Exemplo de trigger para base.

### CODE 2:  
#### Entregável: 
Triggers de remoção: BEFORE DELETE  
Triggers de atualização: BEFORE UPDATE  

Remoção:
- Usuários podem excluir suas contas por algum motivo.  
- Dessa forma, para não perder as informações sobre estes usuários, crie um gatilho before remove  
  

### CODE 3:
#### Atualização:  
Inserção de novos colaboradores e atualização do salário base.  
