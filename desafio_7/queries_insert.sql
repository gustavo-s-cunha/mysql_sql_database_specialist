-- ===================================
-- INSERTS 
-- ===================================

-- Início da transação
START TRANSACTION;

-- Inserção na tabela fornecedor
INSERT INTO fornecedor (Razao_Social, CNPJ, contato) VALUES
  ('Fornecedor A Ltda', '123456789012345', 'contato@fornecedorA.com'),
  ('Fornecedor B EIRELI', '987654321098765', 'contato@fornecedorB.com');

-- Inserção na tabela produto
INSERT INTO produto (Categoria, Descricao, Valor) VALUES 
  ('Eletrônicos', 'Smartphone 128GB', '1200.00'),
  ('Informática', 'Notebook i5 8GB RAM', '3500.00');

-- Inserir responsável
INSERT INTO responsavel (Nome, Setor, Matrícula, Cargo)
VALUES ('Iron Man', 'Suporte Técnico', 'MT1234', 'Técnico');

INSERT INTO responsavel (Nome, Setor, Matrícula, Cargo)
VALUES ('Hulk', 'Suporte Hardware', 'MT1234', 'Técnico');
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

-- Commit da transação
COMMIT;


-- Início da transação
START TRANSACTION;

-- Inserir novo cliente
INSERT INTO cliente (Nome_completo, contato, perfil)
VALUES ('Clark Kent', '1199111222', 'Premium');

-- Inserir endereço do cliente
INSERT INTO endereco (rua, numero, complemento, cidade, estado, cep, idCliente)
VALUES ('Rua Metrópolis', '101', 'Apto 12', 'Metrópolis', 'NY', '12345-678', LAST_INSERT_ID());

-- Inserir produto
INSERT INTO produto (Categoria, Descricao, Valor)
VALUES ('Acessórios', 'Cinto Kryptoniano', 850.00);

-- Inserir fornecedor
INSERT INTO fornecedor (Razao_Social, CNPJ, contato)
VALUES ('Fortaleza da Solidão Supplies', '12345678900001', 'krypton@fsupplies.com');

-- Associar produto ao fornecedor
INSERT INTO produto_fornecedor (Fornecedor_idFornecedor, Produto_idProduto, Quantidade)
VALUES (LAST_INSERT_ID() - 1, LAST_INSERT_ID(), 10);

-- Commit da transação
COMMIT;
