create database empresavendas;
use empresavendas;

CREATE TABLE Cliente (
cliente_id INT PRIMARY KEY,
nome VARCHAR(100),
cpf CHAR(11),
email VARCHAR(100),
telefone VARCHAR(15)
);
CREATE TABLE Produto (
produto_id INT PRIMARY KEY,
nome VARCHAR(100),
preco DECIMAL(10,2),
estoque INT
);
CREATE TABLE Vendedor (
vendedor_id INT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100),
salario DECIMAL(10,2)
);
CREATE TABLE Venda (
venda_id INT PRIMARY KEY,
cliente_id INT,
vendedor_id INT,
data_venda DATE,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES
Cliente(cliente_id),
FOREIGN KEY (vendedor_id) REFERENCES
Vendedor(vendedor_id)
);

CREATE TABLE ItemVenda (
item_id INT PRIMARY KEY,
venda_id INT,
produto_id INT,
quantidade INT,
preco_unitario DECIMAL(10,2),
FOREIGN KEY (venda_id) REFERENCES
Venda(venda_id),
FOREIGN KEY (produto_id) REFERENCES
Produto(produto_id)
);

INSERT INTO Cliente (cliente_id, nome, cpf, email, telefone) VALUES
(1, 'Carlos Silva', '12345678901', 'carlos@email.com', '11987654321'),
(2, 'Ana Souza', '23456789012', 'ana@email.com', '11976543210'),
(3, 'Roberto Lima', '34567890123', 'roberto@email.com', '11965432109'),
(4, 'Mariana Costa', '45678901234', 'mariana@email.com', '11954321098'),
(5, 'Fernanda Oliveira', '56789012345', 'fernanda@email.com', '11943210987');

INSERT INTO Produto (produto_id, nome, preco, estoque) VALUES
(1, 'Notebook', 3500.00, 10),
(2, 'Smartphone', 2500.00, 15),
(3, 'Fone de Ouvido', 150.00, 30),
(4, 'Teclado Mecânico', 250.00, 20),
(5, 'Monitor 24"', 900.00, 12);

INSERT INTO Vendedor (vendedor_id, nome, email, salario) VALUES
(1, 'Pedro Henrique', 'pedro@email.com', 3500.00),
(2, 'Gabriela Nunes', 'gabriela@email.com', 3800.00),
(3, 'Lucas Alves', 'lucas@email.com', 4000.00),
(4, 'Juliana Ferreira', 'juliana@email.com', 4200.00),
(5, 'Fernando Mendes', 'fernando@email.com', 4500.00);

INSERT INTO Venda (venda_id, cliente_id, vendedor_id, data_venda, total) VALUES
(1, 1, 1, '2025-04-10', 6000.00),
(2, 2, 2, '2025-04-11', 3000.00),
(3, 3, 3, '2025-04-12', 150.00),
(4, 4, 4, '2025-04-13', 250.00),
(5, 5, 5, '2025-04-14', 900.00);

INSERT INTO ItemVenda (item_id, venda_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 2, 3000.00),
(2, 2, 2, 1, 2500.00),
(3, 3, 3, 1, 150.00),
(4, 4, 4, 1, 250.00),
(5, 5, 5, 1, 900.00);
