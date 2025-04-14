-- =======================================================
-- PARTE 1 - PERSONALIZANDO ACESSOS COM VIEWS 
-- =======================================================

-- VIEW 1: Número de responsáveis por setor
CREATE OR REPLACE VIEW vw_responsaveis_por_setor AS
SELECT  Setor,
        COUNT(idResponsavel) AS total_responsaveis
FROM responsavel
GROUP BY Setor;


-- VIEW 2: Lista de ordens de serviço por setor
CREATE OR REPLACE VIEW vw_ordens_por_setor AS
SELECT  pg.Setor_responsavel,
        os.idOrdemServico,
        os.Descricao,
        os.Prioridade
FROM ordem_servico os
  JOIN pedido_gerado pg 
    ON os.Pedido_has_Responsavel_Pedido_idPedido = pg.Pedido_idPedido
      AND os.Pedido_has_Responsavel_Responsavel_idResponsavel = pg.Responsavel_idResponsavel;


-- VIEW 3: Número de pedidos por endereço e setor
CREATE OR REPLACE VIEW vw_pedidos_por_endereco_setor AS
SELECT  e.cidade,
        pg.Setor_responsavel AS setor,
        COUNT(p.idPedido) AS total_pedidos
FROM pedido p
  JOIN endereco e ON p.idCliente = e.idCliente
  JOIN pedido_gerado pg ON p.idPedido = pg.Pedido_idPedido
GROUP BY e.cidade, pg.Setor_responsavel
ORDER BY pg.Setor_responsavel ASC;


-- VIEW 4: Lista de produtos, local de estoque e fornecedor
CREATE OR REPLACE VIEW vw_produto_estoque_fornecedor AS
SELECT  pr.Descricao AS produto,
        es.Local AS local_estoque,
        f.Razao_Social AS fornecedor
FROM produto pr
  JOIN produto_fornecedor pf ON pr.idProduto = pf.Produto_idProduto
  JOIN fornecedor f ON pf.Fornecedor_idFornecedor = f.idFornecedor
  LEFT JOIN produto_estoque_local pel ON pr.idProduto = pel.Produto_idProduto
  LEFT JOIN estoque es ON pel.Estoque_idEstoque = es.idEstoque;
ORDER BY pr.Descricao ASC;


-- VIEW 5: Produtos com maior número de pedidos
CREATE OR REPLACE VIEW vw_top_produtos_pedidos AS
SELECT  pr.Descricao,
        COUNT(pp.idProdutoPedido) AS total_pedidos
FROM produto pr
  JOIN produto_pedido pp ON pr.idProduto = pp.Produto_idProduto
GROUP BY pr.idProduto
ORDER BY total_pedidos DESC;
