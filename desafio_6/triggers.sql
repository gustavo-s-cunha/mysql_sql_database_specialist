-- ===================================
-- PARTE 2 - CRIANDO GATILHOS PARA CENÁRIO DE E-COMMERCE 
-- ===================================

-- Gatilho BEFORE DELETE para salvar log de exclusão de cliente
CREATE TABLE IF NOT EXISTS cliente_excluido (
  idCliente INT,
  Nome_completo VARCHAR(45),
  contato CHAR(10),
  perfil VARCHAR(45),
  data_exclusao DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER \\

CREATE TRIGGER trg_before_delete_cliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
  INSERT INTO cliente_excluido (idCliente, Nome_completo, contato, perfil)
  VALUES (OLD.idCliente, OLD.Nome_completo, OLD.contato, OLD.perfil);
END \\

DELIMITER ;


-- Gatilho BEFORE UPDATE para colaboradores (simulando alteração de salário base)
CREATE TABLE IF NOT EXISTS historico_colaborador (
  idResponsavel INT,
  Nome VARCHAR(45),
  Cargo_anterior VARCHAR(45),
  Cargo_atual VARCHAR(45),
  data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER \\

CREATE TRIGGER trg_before_update_responsavel
BEFORE UPDATE ON responsavel
FOR EACH ROW
BEGIN
  IF OLD.Cargo != NEW.Cargo THEN
    INSERT INTO historico_colaborador (idResponsavel, Nome, Cargo_anterior, Cargo_atual)
    VALUES (OLD.idResponsavel, OLD.Nome, OLD.Cargo, NEW.Cargo);
  END IF;
END \\

DELIMITER ;
