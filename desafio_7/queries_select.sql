-- ===================================
-- QUERY 
-- ===================================

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

