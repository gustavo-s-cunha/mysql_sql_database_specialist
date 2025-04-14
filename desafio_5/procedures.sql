-- ===================================
-- PARTE 2 - PROCEDURE DE CONTROLE
-- ===================================

DELIMITER \\

CREATE PROCEDURE sp_gerenciar_clientes(
  IN acao INT,
  IN p_idCliente INT,
  IN p_nome VARCHAR(45),
  IN p_contato CHAR(10),
  IN p_perfil VARCHAR(45)
)
BEGIN
  CASE 
    WHEN acao = 1 THEN -- Inserção
      INSERT INTO cliente (Nome_completo, contato, perfil)
      VALUES (p_nome, p_contato, p_perfil);

    WHEN acao = 2 THEN -- Atualização
      UPDATE cliente
      SET Nome_completo = p_nome,
          contato = p_contato,
          perfil = p_perfil
      WHERE idCliente = p_idCliente;

    WHEN acao = 3 THEN -- Remoção
      DELETE FROM cliente
      WHERE idCliente = p_idCliente;

    ELSE
      SELECT 'Ação inválida. Use 1 para INSERT, 2 para UPDATE, 3 para DELETE.' AS Mensagem;
  END CASE;
END \\

DELIMITER ;


-- Chamadas de exemplo:
-- Inserção
CALL sp_gerenciar_clientes(1, NULL, 'Bruce Wayne', '1122334455', 'Premium');

-- Atualização
CALL sp_gerenciar_clientes(2, 1, 'Bruce Wayne', '1100000000', 'VIP');

-- Remoção
CALL sp_gerenciar_clientes(3, 1, NULL, NULL, NULL);
