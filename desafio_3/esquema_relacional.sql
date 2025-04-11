-- criacão do banco de dados para o cenário de E-commerce 

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecomerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecomerce` ;

-- -----------------------------------------------------
-- Schema ecomerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecomerce` DEFAULT CHARACTER SET utf8 ;
USE `ecomerce` ;


-- -----------------------------------------------------
-- Table `ecomerce`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`cliente` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome_completo` VARCHAR(45) NULL,
  `contato` CHAR(10) NULL,
  `perfil` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Nome_completo_UNIQUE` (`Nome_completo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`endereco` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(45) NULL,
  `numero` VARCHAR(5) NULL,
  `complemento` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecomerce`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ecomerce`.`estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`estoque` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`fornecedor` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(45) NULL,
  `CNPJ` CHAR(15) NOT NULL,
  `contato` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `ecomerce`.`responsavel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`responsavel` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`responsavel` (
  `idResponsavel` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Setor` VARCHAR(45) NULL,
  `Codigo` VARCHAR(45) NULL,
  `Cargo` VARCHAR(45) NULL,
  PRIMARY KEY (`idResponsavel`),
  UNIQUE INDEX `Codigo_UNIQUE` (`Codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`pagamento` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`pagamento` (
  `idpagamento` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('Cartão', 'Boleto', 'Pix') NULL,
  `detalhes` VARCHAR(150) NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `data_vencimento` DATE NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idpagamento`),
  INDEX `fk_pagamento_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecomerce`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`pedido` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `Descricao` VARCHAR(255) NULL,
  `Título_pedido` VARCHAR(45) NULL,
  `Tipo_problema` VARCHAR(50) NULL,
  `Prioridade` ENUM('Baixa', 'Média', 'Alta') NULL DEFAULT 'Baixa',
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cliente2_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente2`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecomerce`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`pedido_gerado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`pedido_gerado` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`pedido_gerado` (
  `Pedido_idPedido` INT NOT NULL,
  `Responsavel_idResponsavel` INT NOT NULL,
  `Setor_responsavel` VARCHAR(45) NULL DEFAULT 'Help desk',
  `Descricao` VARCHAR(500) NULL,
  `Setor_encaminhado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Responsavel_idResponsavel`),
  INDEX `fk_Pedido_has_Responsavel_Responsavel1_idx` (`Responsavel_idResponsavel` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Responsavel_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Responsavel_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `ecomerce`.`pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Responsavel_Responsavel1`
    FOREIGN KEY (`Responsavel_idResponsavel`)
    REFERENCES `ecomerce`.`responsavel` (`idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`ordem_servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`ordem_servico` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`ordem_servico` (
  `idOrdemServico` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Prioridade` VARCHAR(45) NULL,
  `Pedido_has_Responsavel_Pedido_idPedido` INT NOT NULL,
  `Pedido_has_Responsavel_Responsavel_idResponsavel` INT NOT NULL,
  PRIMARY KEY (`idOrdemServico`),
  INDEX `fk_Ordem de Servico_Pedido_has_Responsavel1_idx` (`Pedido_has_Responsavel_Pedido_idPedido` ASC, `Pedido_has_Responsavel_Responsavel_idResponsavel` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Servico_Pedido_has_Responsavel1`
    FOREIGN KEY (`Pedido_has_Responsavel_Pedido_idPedido` , `Pedido_has_Responsavel_Responsavel_idResponsavel`)
    REFERENCES `ecomerce`.`pedido_gerado` (`Pedido_idPedido` , `Responsavel_idResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`produto` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` DOUBLE NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`produto_estoque_local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`produto_estoque_local` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`produto_estoque_local` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Localizacao` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecomerce`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `ecomerce`.`estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`produto_fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`produto_fornecedor` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`produto_fornecedor` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` DOUBLE NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `ecomerce`.`fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecomerce`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`produto_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`produto_pedido` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`produto_pedido` (
  `idProdutoPedido` INT NOT NULL AUTO_INCREMENT,
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` VARCHAR(45) NOT NULL,
  `Status` ENUM('disponível', 'sem estoque') NULL DEFAULT 'disponível',
  PRIMARY KEY (`idProdutoPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecomerce`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `ecomerce`.`pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ecomerce`.`entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`entrega` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`entrega` (
  `identrega` INT NOT NULL,
  `codigo_rastreio` VARCHAR(100) NOT NULL,
  `situacao` ENUM('Processando', 'Enviado', 'Entregue') NULL,
  `idPedido` INT NOT NULL,
  `idEndereco` INT NOT NULL,
  PRIMARY KEY (`identrega`, `idEndereco`, `idPedido`),
  INDEX `fk_entrega_Pedido1_idx` (`idPedido` ASC) VISIBLE,
  INDEX `fk_entrega_endereco1_idx` (`idEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_Pedido1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `ecomerce`.`pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entrega_endereco1`
    FOREIGN KEY (`idEndereco`)
    REFERENCES `ecomerce`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`vendedor_terceiro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`vendedor_terceiro` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`vendedor_terceiro` (
  `idTerceiro_Vendedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(45) NOT NULL COMMENT 'constrain',
  `Local` VARCHAR(45) NULL,
  `Nome_Fantasia` VARCHAR(45) NULL,
  `CNPJ` CHAR(15) NULL,
  `CPF` CHAR(9) NULL,
  PRIMARY KEY (`idTerceiro_Vendedor`),
  UNIQUE INDEX `Razao_Social_UNIQUE` (`Razao_Social` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecomerce`.`produto_vendedor_terceiro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecomerce`.`produto_vendedor_terceiro` ;

CREATE TABLE IF NOT EXISTS `ecomerce`.`produto_vendedor_terceiro` (
  `idPseller` INT NOT NULL AUTO_INCREMENT,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`idPseller`),
  INDEX `fk_Terceiro_Vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1_idx` (`idPseller` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1`
    FOREIGN KEY (`idPseller`)
    REFERENCES `ecomerce`.`vendedor_terceiro` (`idTerceiro_Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `ecomerce`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
