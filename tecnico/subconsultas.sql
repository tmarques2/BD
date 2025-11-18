USE lojaMarcia;

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