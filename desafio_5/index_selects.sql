-- =======================================================
-- PARTE 1 - CRIAÇÃO DE ÍNDICES E CONSULTAS OTIMIZADAS
-- =======================================================

-- 1. Qual o Setor com maior número de pedidos? (setor do responsável)
-- Índice: setor dos responsáveis (usado em agrupamento/filtro)
CREATE INDEX idx_responsavel_setor ON responsavel(Setor);

-- Consulta:
SELECT  r.Setor,
        COUNT(pg.Pedido_idPedido) AS total_pedidos
FROM pedido_gerado pg
  JOIN responsavel r ON pg.Responsavel_idResponsavel = r.idResponsavel
GROUP BY r.Setor
ORDER BY total_pedidos DESC
LIMIT 1;


-- 2. Relação de responsáveis por setor
-- Índice já aproveitado: idx_responsavel_setor
-- Consulta:
SELECT  Setor,
        COUNT(idResponsavel) AS total_responsaveis
FROM responsavel
GROUP BY Setor;


-- 3. Quais são as 3 cidades (Endereços) com maior número de entrega?
-- Índice: cidade da tabela endereco e idEndereco para join
CREATE INDEX idx_endereco_cidade ON endereco(cidade);
CREATE INDEX idx_entrega_idEndereco ON entrega(idEndereco);

-- Consulta:
SELECT  e.cidade,
        COUNT(en.identrega) AS total_entregas
FROM entrega en
  JOIN endereco e ON en.idEndereco = e.idendereco
GROUP BY e.cidade
ORDER BY total_entregas DESC
LIMIT 3;


-- 4. Quais os 3 vendedores com maior número de pedidos?
-- Assumindo "vendedor_terceiro" relacionado a "produto_pedido"
-- Índices: idTerceiro_Vendedor em produto_vendedor_terceiro
CREATE INDEX idx_vendedor_produto ON produto_vendedor_terceiro(Produto_idProduto);

-- Consulta:
SELECT  vt.Nome_Fantasia,
        COUNT(pp.idProdutoPedido) AS total_pedidos
FROM produto_pedido pp
  JOIN produto_vendedor_terceiro pvt ON pp.Produto_idProduto = pvt.Produto_idProduto
  JOIN vendedor_terceiro vt ON pvt.idPseller = vt.idTerceiro_Vendedor
GROUP BY vt.idTerceiro_Vendedor
ORDER BY total_pedidos DESC
LIMIT 3;

