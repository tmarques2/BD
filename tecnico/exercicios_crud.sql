-- exercicios
-- SELECT
SELECT titulo, descricao FROM livro WHERE id_livro = 3;

-- INSERT
ALTER TABLE livro ADD edicao VARCHAR(255);
ALTER TABLE livro ADD data_publicacao DATE;

INSERT INTO livro (titulo, ISBN, data_publicacao, edicao) VALUES
('Python', '1718502702', '2023-04-24', '3ª edição');
SELECT id_livro FROM livro WHERE ISBN = 1718502702;

INSERT INTO autor (nome) VALUES ('Eric Matthes');
SELECT id_autor FROM autor WHERE nome = 'Eric Matthes';
INSERT INTO livro_autor (id_livro, id_autor) VALUES (11,11);

INSERT INTO categoria (nome) VALUES ('Técnico');
INSERT INTO livro_categoria (id_livro, id_categoria) VALUES (11,11);

-- UPDATE
-- 1
SELECT * FROM usuario;
UPDATE usuario SET email = 'teste@email.com' WHERE id_usuario = 1;
-- 2
UPDATE livro SET titulo = 'Curso Intensivo de Python: uma Introdução Prática e Baseada em Projetos à Programação' WHERE id_livro = 11;
SELECT * FROM livro;
-- 3
ALTER TABLE livro ADD status VARCHAR(255);
INSERT INTO livro (titulo, ISBN, edicao, data_publicacao)
VALUES ('Banco de Dados', '0000000001', '1ª edição', '1999-05-10');
UPDATE livro SET status = 'inativo' WHERE data_publicacao < '2000-01-01';

SET SQL_SAFE_UPDATES = 0;


-- DELETE
-- 1
DELETE FROM livro_autor WHERE id_livro = 2;
DELETE FROM livro_categoria WHERE id_livro = 2;
DELETE FROM emprestimo WHERE id_livro = 2;
DELETE FROM livro WHERE id_livro = 2;

-- 2
INSERT INTO usuario (nome, numero_identificacao, email, data_cadastro, id_nivel)
VALUES ('Teste Testador', 9999, 'teste@testador.com', '2025-01-01', 1);

DELETE FROM usuario WHERE nome = 'Teste Testador';

-- 3
UPDATE livro SET status = 'danificado' WHERE id_livro IN (3, 5, 7);
DELETE FROM livro_autor WHERE id_livro IN (3, 5, 7);
DELETE FROM livro_categoria WHERE id_livro IN (3, 5, 7);
DELETE FROM emprestimo WHERE id_livro IN (3, 5, 7);
DELETE FROM livro WHERE status = 'danificado';

-- 4
INSERT INTO emprestimo (data_emprestimo, data_devolucao, data_devolucao_limite, id_livro, id_usuario)
VALUES ('2020-06-01', '2020-06-10', '2020-06-15', 1, 1);
SELECT * FROM emprestimo;
DELETE FROM emprestimo WHERE YEAR(data_emprestimo) = 2020