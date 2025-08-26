CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE livro (
	id_livro INT auto_increment primary key,
    titulo VARCHAR(255),
    ISBN INT NOT NULL,
    descricao TEXT
);

CREATE TABLE autor (
	id_autor INT auto_increment primary key,
    nome VARCHAR(255)
);

CREATE TABLE livro_autor (
	id_livro_autor INT auto_increment primary key,
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    foreign key (id_livro) references livro (id_livro),
    foreign key (id_autor) references autor(id_autor)
);

CREATE TABLE categoria (
	id_categoria INT auto_increment primary key,
    nome VARCHAR(255)
);

CREATE TABLE livro_categoria (
	id_livro_categoria INT auto_increment primary key,
    id_livro INT NOT NULL,
    id_categoria INT NOT NULL,
    foreign key (id_livro) references livro (id_livro),
    foreign key (id_categoria) references categoria (id_categoria)
);

CREATE TABLE nivel_associacao (
	id_nivel INT auto_increment primary key,
    nome VARCHAR(50)
);

CREATE TABLE usuario (
	id_usuario INT auto_increment primary key,
    nome VARCHAR(255),
    numero_identificacao INT NOT NULL,
    email VARCHAR(255),
    data_cadastro DATE,
    id_nivel INT,
    foreign key (id_nivel) references nivel_associacao (id_nivel)
);

CREATE TABLE emprestimo (
	id_emprestimo INT auto_increment primary key,
    data_emprestimo DATE,
    data_devolucao DATE,
    data_devolucao_limite DATE,
    id_livro int,
    id_usuario int,
    foreign key (id_livro) references livro (id_livro),
    foreign key (id_usuario) references usuario (id_usuario)
);

-- LIVROS
INSERT INTO livro (titulo, ISBN, descricao) VALUES
('Dom Casmurro', 123456789, 'Clássico da literatura brasileira.'),
('Memórias Póstumas de Brás Cubas', 234567890, 'Obra de Machado de Assis.'),
('O Cortiço', 345678901, 'Romance naturalista de Aluísio Azevedo.'),
('Vidas Secas', 456789012, 'Obra de Graciliano Ramos.'),
('Grande Sertão: Veredas', 567890123, 'Romance de Guimarães Rosa.'),
('O Guarani', 678901234, 'Romance indianista de José de Alencar.'),
('Senhora', 789012345, 'Romance urbano de José de Alencar.'),
('Iracema', 890123456, 'Romance indianista.'),
('O Alienista', 901234567, 'Sátira de Machado de Assis.'),
('Capitães da Areia', 112233445, 'Obra de Jorge Amado.');

-- AUTORES
INSERT INTO autor (nome) VALUES
('Machado de Assis'),
('José de Alencar'),
('Jorge Amado'),
('Graciliano Ramos'),
('Guimarães Rosa'),
('Aluísio Azevedo'),
('Clarice Lispector'),
('Manuel Bandeira'),
('Cecília Meireles'),
('Carlos Drummond de Andrade');

-- RELAÇÃO LIVRO_AUTOR
INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 1),
(3, 6),
(4, 4),
(5, 5),
(6, 2),
(7, 2),
(8, 2),
(9, 1),
(10, 3);

-- CATEGORIAS
INSERT INTO categoria (nome) VALUES
('Romance'),
('Poesia'),
('Conto'),
('Ensaio'),
('Crônica'),
('Drama'),
('Ficção'),
('Biografia'),
('História'),
('Clássico Brasileiro');

-- RELAÇÃO LIVRO_CATEGORIA
INSERT INTO livro_categoria (id_livro, id_categoria) VALUES
(1, 10),
(2, 10),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 3),
(10, 10);

-- NÍVEIS DE ASSOCIAÇÃO
INSERT INTO nivel_associacao (nome) VALUES
('Básico'),
('Prata'),
('Ouro'),
('Platina'),
('Diamante'),
('Premium'),
('Estudante'),
('Professor'),
('Convidado'),
('Administrador');

-- USUÁRIOS
INSERT INTO usuario (nome, numero_identificacao, email, data_cadastro, id_nivel) VALUES
('Ana Souza', 1001, 'ana@email.com', '2024-01-10', 1),
('Bruno Lima', 1002, 'bruno@email.com', '2024-02-15', 2),
('Carlos Mendes', 1003, 'carlos@email.com', '2024-03-05', 3),
('Daniela Silva', 1004, 'daniela@email.com', '2024-04-20', 4),
('Eduardo Santos', 1005, 'eduardo@email.com', '2024-05-12', 5),
('Fernanda Costa', 1006, 'fernanda@email.com', '2024-06-18', 6),
('Gabriel Oliveira', 1007, 'gabriel@email.com', '2024-07-09', 7),
('Helena Castro', 1008, 'helena@email.com', '2024-08-21', 8),
('Igor Fernandes', 1009, 'igor@email.com', '2024-09-30', 9),
('Juliana Pereira', 1010, 'juliana@email.com', '2024-10-11', 10);

-- EMPRÉSTIMOS
INSERT INTO emprestimo (data_emprestimo, data_devolucao, data_devolucao_limite, id_livro, id_usuario) VALUES
('2025-01-10', '2025-01-20', '2025-01-25', 1, 1),
('2025-02-15', NULL, '2025-03-01', 2, 2),
('2025-03-05', '2025-03-15', '2025-03-20', 3, 3),
('2025-04-20', NULL, '2025-05-05', 4, 4),
('2025-05-12', '2025-05-25', '2025-05-30', 5, 5),
('2025-06-18', NULL, '2025-07-02', 6, 6),
('2025-07-09', '2025-07-18', '2025-07-23', 7, 7),
('2025-08-21', NULL, '2025-09-05', 8, 8),
('2025-09-30', '2025-10-10', '2025-10-15', 9, 9),
('2025-10-11', NULL, '2025-10-25', 10, 10);

select * FROM emprestimo;