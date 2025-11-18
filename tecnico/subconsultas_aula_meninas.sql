-- 1. Criação do banco
CREATE DATABASE lojaMarcia;
USE lojaMarcia;

-- 2. Tabelas
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50)
);
 
CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100),
    pais VARCHAR(50)
);
 
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2),
    id_categoria INT,
    id_fornecedor INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);
 
-- 3. Inserção dos dados
INSERT INTO categorias (nome_categoria) VALUES
('Eletrônicos'), ('Roupas'), ('Livros'), ('Esportes');
 
INSERT INTO fornecedores (nome_fornecedor, pais) VALUES
('TechGlobal', 'EUA'), ('ModaBrasil', 'Brasil'), ('BookWorld', 'EUA'), ('SportsInc', 'Brasil'), ('Fornecedor Fantasma', 'Japão');
 
INSERT INTO produtos (nome_produto, preco, id_categoria, id_fornecedor) VALUES
('Notebook', 3500.00, 1, 1),      -- Eletrônicos, TechGlobal
('Smartphone', 1500.00, 1, 1),   -- Eletrônicos, TechGlobal
('Camiseta', 80.00, 2, 2),       -- Roupas, ModaBrasil
('Calça Jeans', 120.00, 2, 2),     -- Roupas, ModaBrasil
('O Gene Egoísta', 50.00, 3, 3),   -- Livros, BookWorld
('Bola de Futebol', 100.00, 4, 4); -- Esportes, SportsInc

-- WHERE
SELECT Nome_Produto, Preco
FROM Produtos
WHERE ID_Categoria = (
	SELECT ID_Categoria
    FROM categorias
    WHERE nome_categoria = "Eletrônicos"
);

-- IN
SELECT Nome_Produto, Preco
FROM Produtos
WHERE ID_Fornecedor IN (
	SELECT ID_Fornecedor
    FROM fornecedores
    WHERE pais = "EUA"
);

-- NOT IN
SELECT Nome_Produto, Preco
FROM Produtos
WHERE ID_Fornecedor NOT IN (
	SELECT ID_Fornecedor
    FROM fornecedores
    WHERE pais = "EUA"
);

-- ANY
SELECT Nome_Produto, Preco
FROM Produtos
WHERE Preco > ANY (
	SELECT Preco FROM Produtos
    WHERE ID_Categoria = 2
);

-- ALL
SELECT Nome_Produto, Preco
FROM Produtos
WHERE Preco > ALL (
	SELECT Preco FROM Produtos
    WHERE ID_Categoria = 2
);

-- EXISTS
SELECT Nome_Categoria
FROM categorias
WHERE EXISTS (
	SELECT * 
    FROM produtos
    WHERE produtos.id_categoria = categorias.id_categoria
);

-- NOT EXISTS
SELECT Nome_Fornecedor
FROM fornecedores
WHERE NOT EXISTS (
	SELECT 1
    FROM produtos
    WHERE produtos.id_fornecedor = fornecedores.id_fornecedor
);

-- FROM
SELECT Nome_Categoria, Media_Preco_Categoria
FROM (
	SELECT
    C.Nome_Categoria,
    AVG(P.Preco) AS Media_Preco_Categoria
    FROM Produtos AS P
    JOIN categorias AS C ON P.id_categoria = C.id_categoria
    GROUP BY C.nome_categoria
) AS Tabela_Medias
WHERE Media_Preco_Categoria > 100;

-- SELECT
SELECT
Nome_Categoria,
(
	SELECT COUNT(*)
	FROM produtos
	WHERE produtos.id_categoria = categorias.id_categoria
) AS quantidade_produtos
FROM Categorias;