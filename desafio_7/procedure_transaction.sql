DELIMITER \\

CREATE PROCEDURE sp_transacao_pedido (
    IN p_idCliente INT,
    IN p_idProduto INT,
    IN p_qtd VARCHAR(45)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Se ocorrer erro, desfaz toda a transação
        ROLLBACK;
        SELECT 'Erro detectado. Transação revertida.' AS mensagem;
    END;

    START TRANSACTION;

    -- Inserir pedido
    INSERT INTO pedido (idCliente, Descricao, Título_pedido, Tipo_problema, Prioridade)
    VALUES (p_idCliente, 'Pedido via procedure', 'Auto Pedido', 'Hardware', 'Média');

    -- Criar ponto de controle
    SAVEPOINT sp1;

    -- Inserir produto no pedido
    INSERT INTO produto_pedido (Produto_idProduto, Pedido_idPedido, Quantidade, Status)
    VALUES (p_idProduto, LAST_INSERT_ID(), p_qtd, 'disponível');

    -- Se tudo der certo
    COMMIT;
    SELECT 'Transação finalizada com sucesso' AS mensagem;
END \\

DELIMITER ;


-- ===================================
-- CHAMADA
-- ===================================

CALL sp_transacao_pedido(1, 2, '2');
