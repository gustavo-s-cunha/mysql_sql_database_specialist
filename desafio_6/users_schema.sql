-- Criação de usuários (gerente e employee)
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha123';

CREATE USER 'employee'@'localhost' IDENTIFIED BY 'senha123';

-- Permissões para GERENTE (acesso total às views)
GRANT SELECT ON ecomerce.vw_responsaveis_por_setor TO 'gerente'@'localhost';

GRANT SELECT ON ecomerce.vw_ordens_por_setor TO 'gerente'@'localhost';

GRANT SELECT ON ecomerce.vw_pedidos_por_endereco_setor TO 'gerente'@'localhost';

GRANT SELECT ON ecomerce.vw_produto_estoque_fornecedor TO 'gerente'@'localhost';

GRANT SELECT ON ecomerce.vw_top_produtos_pedidos TO 'gerente'@'localhost';


-- Permissões para EMPLOYEE (restrito apenas a produtos e estoque)
GRANT SELECT ON ecomerce.vw_produto_estoque_fornecedor TO 'employee'@'localhost';

GRANT SELECT ON ecomerce.vw_top_produtos_pedidos TO 'employee'@'localhost';

-- Recarregar privilégios
FLUSH PRIVILEGES;
