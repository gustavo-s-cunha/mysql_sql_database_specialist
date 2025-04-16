
-- ===================================
-- UPDATE 
-- ===================================

-- Início da transação para atualizações em lote
START TRANSACTION;

-- Atualizar valor de todos os produtos da categoria 'Eletrônicos', aplicando reajuste de 10%
UPDATE produto
SET Valor = Valor * 2.50
WHERE Categoria = 'Eletrônicos';

-- Atualizar prioridade dos pedidos da cidade 'São Paulo' para 'Alta'
UPDATE pedido p
JOIN endereco e ON p.idCliente = e.idCliente
SET p.Prioridade = 'Alta'
WHERE e.cidade = 'São Paulo';

-- Excluir pedidos com status de produto 'sem estoque'
DELETE p
FROM pedido p
JOIN produto_pedido pp ON p.idPedido = pp.Pedido_idPedido
WHERE pp.Status = 'sem estoque';

-- Confirmar mudanças
COMMIT;
