-- Inserção na tabela fornecedor
INSERT INTO fornecedor (Razao_Social, CNPJ, contato) VALUES
  ('Fornecedor A Ltda', '123456789012345', 'contato@fornecedorA.com'),
  ('Fornecedor B EIRELI', '987654321098765', 'contato@fornecedorB.com');

-- Inserção na tabela produto
INSERT INTO produto (Categoria, Descricao, Valor) VALUES 
  ('Eletrônicos', 'Smartphone 128GB', '1200.00'),
  ('Informática', 'Notebook i5 8GB RAM', '3500.00');

-- Inserir responsável
INSERT INTO responsavel (Setor, Matrícula, Cargo)
VALUES ('Suporte Técnico', 'MT1234', 'Técnico');
-------------

-- Inserção do cliente: 1
INSERT INTO cliente (Nome_completo, contato, perfil)
VALUES ('Dino da Silva Sauro', '1199999999', 'Consumidor');
-- Inserção de endereço (usando o último idCliente gerado) 1
INSERT INTO endereco (rua, numero, complemento, cidade, estado, cep, idCliente)
VALUES ('Rua das Flores', '100', 'Apto 202', 'São Paulo', 'SP', '01234-567', LAST_INSERT_ID());


-- Inserção do cliente: 2
INSERT INTO cliente (Nome_completo, contato, perfil)
VALUES ('Homer Simpson', '1188888888', 'Consumidor');
-- Inserção de endereço (usando o último idCliente gerado): 2
INSERT INTO endereco (rua, numero, complemento, cidade, estado, cep, idCliente)
VALUES ('Rua Campo de primavera', '10', 'casa', 'Springfield', 'SP', '01234-789', LAST_INSERT_ID());

-------------

-- Pedido relacionado a cliente
INSERT INTO pedido (idCliente, Descricao, `Título_pedido`, `Tipo_problema`, Prioridade)
VALUES (1, 'Compra de notebook', 'Pedido Notebook', 'Hardware', 'Alta');

-- Produto_pedido (associando produto existente ao pedido criado)
INSERT INTO produto_pedido (Produto_idProduto, Pedido_idPedido, Quantidade, `Status`)
VALUES (2, 1, 1, 'disponível');


-- Pedido relacionado a cliente
INSERT INTO pedido (idCliente, Descricao, `Título_pedido`, `Tipo_problema`, Prioridade)
VALUES (2, 'Compra de Smartphone', 'Pedido Smartphone', 'Informática', 'Média');

-- Produto_pedido (associando produto existente ao pedido criado)
INSERT INTO produto_pedido (Produto_idProduto, Pedido_idPedido, Quantidade, `Status`)
VALUES (1, 2, 1, 'disponível');

-------------

-- Usar pedido existente (ex: idPedido = 1), associar ao responsável
INSERT INTO pedido_gerado (Pedido_idPedido, Responsavel_idResponsavel, Descricao, Setor_encaminhado)
VALUES (1, 1, 'Necessita verificação de hardware', 'Manutenção');

-- Ordem de serviço para esse relacionamento
INSERT INTO ordem_servico (`idOrdemServico`, Descricao, Prioridade, Pedido_has_Responsavel_Pedido_idPedido, Pedido_has_Responsavel_Responsavel_idResponsavel)
VALUES (1, 'Troca de HD', 'Alta', 1, 1);


------------------------------------------------------------------------------
------------------------------------------------------------------------------

SELECT * FROM cliente;
SELECT * FROM responsavel;

SELECT count(*) AS num_produtos FROM produto;

-------------

SELECT  c.Nome_completo,
        COUNT(p.idPedido) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente;

-------------

SELECT  c.Nome_completo AS cliente,
        p.idPedido,
        p.Título_pedido,
        p.Descricao AS descricao_pedido,
        pr.Descricao AS produto,
        pp.Quantidade,
        pp.Status
FROM pedido p
JOIN cliente c ON p.idCliente = c.idCliente
JOIN produto_pedido pp ON p.idPedido = pp.Pedido_idPedido
JOIN produto pr ON pp.Produto_idProduto = pr.idProduto;

-------------

SELECT  os.`idOrdemServico`,
        os.Descricao AS descricao_ordem,
        os.Prioridade AS prioridade_ordem,
        p.idPedido,
        c.Nome_completo AS cliente,
        pr.Descricao AS produto,
        pr.Descricao AS produto,
        r.Nome,
        r.Codigo,
        r.Setor
FROM ordem_servico os
JOIN pedido_gerado pg 
  ON os.Pedido_has_Responsavel_Pedido_idPedido = pg.Pedido_idPedido AND 
      os.Pedido_has_Responsavel_Responsavel_idResponsavel = pg.Responsavel_idResponsavel
JOIN pedido p ON pg.Pedido_idPedido = p.idPedido
JOIN cliente c ON p.idCliente = c.idCliente
JOIN produto_pedido pp ON p.idPedido = pp.Pedido_idPedido
JOIN produto pr ON pp.Produto_idProduto = pr.idProduto
JOIN responsavel r ON pg.Responsavel_idResponsavel = r.idResponsavel;


-------------
-- atributos derivados + ORDER BY
SELECT  c.Nome_completo,
        COUNT(p.idPedido) AS total_pedidos,
        SUM(CAST(pp.Quantidade AS UNSIGNED) * pr.Valor) AS valor_total_gasto
FROM cliente c
JOIN pedido p ON c.idCliente = p.idCliente
JOIN produto_pedido pp ON p.idPedido = pp.Pedido_idPedido
JOIN produto pr ON pp.Produto_idProduto = pr.idProduto
GROUP BY c.idCliente;
ORDER BY valor_total_gasto DESC;

-------------
-- HAVING
SELECT  c.Nome_completo,
        COUNT(p.idPedido) AS total_pedidos,
        SUM(CAST(pp.Quantidade AS UNSIGNED) * pr.Valor) AS valor_total_gasto
FROM cliente c
JOIN pedido p ON c.idCliente = p.idCliente
JOIN produto_pedido pp ON p.idPedido = pp.Pedido_idPedido
JOIN produto pr ON pp.Produto_idProduto = pr.idProduto
GROUP BY c.idCliente;
HAVING valor_total_gasto > 2000;


-------------
-- Junção complexa: cliente + pedido + produto + responsável pela ordem de serviço
SELECT  c.Nome_completo AS cliente,
        p.idPedido,
        p.Título_pedido,
        pr.Descricao AS produto,
        r.Nome AS responsavel,
        os.Descricao AS ordem_servico,
        os.Prioridade,
        CONCAT('Atendimento previsto: ', 
          CASE os.Prioridade
            WHEN 'Alta' THEN '2 dias'
            WHEN 'Média' THEN '5 dias'
            ELSE '7 dias'
          END
        ) AS prazo_estimado
FROM cliente c
JOIN pedido p ON c.idCliente = p.idCliente
JOIN produto_pedido pp ON p.idPedido = pp.Pedido_idPedido
JOIN produto pr ON pp.Produto_idProduto = pr.idProduto
JOIN pedido_gerado pg ON pg.Pedido_idPedido = p.idPedido
JOIN responsavel r ON pg.Responsavel_idResponsavel = r.idResponsavel
JOIN ordem_servico os
  ON os.Pedido_has_Responsavel_Pedido_idPedido = p.idPedido 
    AND os.Pedido_has_Responsavel_Responsavel_idResponsavel = r.idResponsavel;
ORDER BY os.idOrdemServico DESC;
