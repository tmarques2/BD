-- Criação do banco de dados empresa_eletro
create database empresa_eletro;
use empresa_eletro;

-- Tabela dos fornecedores
CREATE TABLE Fornecedores (
ID INT PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(100),
Contato VARCHAR(100)
);

-- Tabela do estoque
CREATE TABLE Estoque (
ID INT PRIMARY KEY AUTO_INCREMENT,
Produto VARCHAR(100),
Quantidade INT,
ID_Fornecedor INT,
FOREIGN KEY (ID_Fornecedor) REFERENCES
Fornecedores(ID)
);

-- Tabela dos clientes
CREATE TABLE Clientes (
ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(100),
Email VARCHAR(100)
);

-- Tabela dos pedidos
CREATE TABLE Pedidos (
ID INT PRIMARY KEY,
Produto VARCHAR(100),
Quantidade INT,
ID_Cliente INT,
Status VARCHAR(50) DEFAULT 'Pendente',
DataPedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabela do histórico de pedidos
CREATE TABLE Historico_Pedidos (
ID INT PRIMARY KEY,
Produto VARCHAR(100),
Quantidade INT,
ID_Cliente INT,
Status VARCHAR(50),
DataPedido TIMESTAMP,
FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

SELECT * FROM Clientes;
select * FROM historico_pedidos;

-- Inserindo fornecedores
INSERT INTO Fornecedores (Nome, Contato) VALUES
('EletroTech', 'contato@eletrotech.com'),
('Power Supply', 'support@powersupply.com'),
('EnergyMax', 'info@energymax.com');

-- Inserindo estoque
INSERT INTO Estoque (Produto, Quantidade, ID_Fornecedor) VALUES
('Bateria 12V', 50, 1),
('Gerador Portátil', 20, 2),
('Painel Solar 100W', 35, 3);

-- Inserindo clientes
INSERT INTO Clientes (Nome, Email) VALUES
('João Silva', 'joao.silva@email.com'),
('Maria Souza', 'maria.souza@email.com'),
('Carlos Pereira', 'carlos.pereira@email.com');

-- Inserindo pedidos
INSERT INTO Pedidos (ID, Produto, Quantidade, ID_Cliente, Status) VALUES
(1, 'Bateria 12V', 2, 1, 'Pendente'),
(2, 'Painel Solar 100W', 1, 2, 'Finalizado'),
(3, 'Gerador Portátil', 3, 3, 'Em processamento');


-- Criação da view para rastrear os fornecedores dos produtos
CREATE VIEW vw_Fornecedores AS
SELECT f.ID, f.Nome, f.Contato, e.Produto, e.Quantidade
FROM Fornecedores f
JOIN Estoque e ON f.ID = e.ID_Fornecedor;
-- Visualizar view
SELECT * FROM vw_Fornecedores;

-- Criação da procedure de armazenar compradores
DELIMITER $$
CREATE PROCEDURE AdicionarCliente(IN nome VARCHAR(100), IN email VARCHAR(100))
BEGIN
    INSERT INTO Clientes (Nome, Email)
    VALUES (nome, email);
END $$
DELIMITER ;
-- Teste da procedure
CALL AdicionarCliente('Carlos Silva', 'carlos@email.com');
SELECT * FROM Clientes;


-- Criação da trigger para atualizar tabela histórico de pedidos
delimiter $$
CREATE TRIGGER trg_historico_pedidos
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
	INSERT INTO historico_pedidos(ID, Produto, Quantidade, ID_Cliente, Status, DataPedido)
	VALUES (OLD.ID, NEW.Produto, NEW.Quantidade, NEW.ID_Cliente, NEW.Status, NOW());
END $$
delimiter ;
-- Teste da Trigger
UPDATE Pedidos
SET Quantidade = 20
WHERE ID = 3;

select * from historico_pedidos;