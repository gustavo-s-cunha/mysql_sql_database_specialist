# Projeto de E-commerce

## Narrativa - Produto
- Os produtos são vendidos por uma única plataforma online.
- - Contudo, estes podem ter vendedores distintos (terceiros)
- Cada produto possui um fornecedor
- Um ou mais produtos podem compor um pedido

## Narrativa - Cliente
- O cliente pode se cadastrar no site com seu CPF ou CNPJ
- O Endereço do cliente irá determinar o valor do frete
- Um cliente pode comprar mais de um pedido.
- - Este tem um período de carência para devolução do produto

## Narrativa - Pedido
- O pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega
- Um produto ou mais compoem o pedido
- O pedido pode ser cancelado

## Narrativa - Estoque
- Controla a localização dos produtos
- Controla a quantidade em estoque dos produtos


#
# Objetivo do desafio
Refine o modelo apresentado acrescentando os seguintes pontos:
- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
- Entrega – Possui status e código de rastreio;
- - Endereço da entrega
