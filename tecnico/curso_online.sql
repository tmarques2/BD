CREATE DATABASE Cursos_Online;
USE Cursos_Online;

CREATE TABLE Professor (
	id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    data_nasc DATE
);

CREATE TABLE Papel_Professor (
	id_papel_professor INT AUTO_INCREMENT PRIMARY KEY,
    papel VARCHAR(255),
    id_professor INT,
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor) 
);

CREATE TABLE Curso (
	id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    id_papel_professor INT,
    FOREIGN KEY (id_papel_professor) REFERENCES Papel_Professor(id_papel_professor)
);

CREATE TABLE Professor_Curso (
	id_professor_curso INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT,
    id_curso INT,
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Modulo (
	id_modulo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    ordem INT,
    carga_horaria TIME,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Perfil_Aluno (
	id_perfil_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    foto BLOB,
    bio TEXT,
    data_nascimento DATE
);

CREATE TABLE Plano (
	id_plano INT AUTO_INCREMENT PRIMARY KEY,
    plano VARCHAR(255),
	beneficios TEXT
);

CREATE TABLE Aluno (
	id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    id_perfil_aluno INT,
    id_plano INT,
    FOREIGN KEY (id_perfil_aluno) REFERENCES Perfil_Aluno(id_perfil_aluno),
    FOREIGN KEY (id_plano) REFERENCES Plano(id_plano)
);

CREATE TABLE Situacao_Inscricao (
	id_situacao_inscricao INT AUTO_INCREMENT PRIMARY KEY,
    situacao VARCHAR(255)
);

CREATE TABLE Inscricao (
	id_inscricao INT AUTO_INCREMENT PRIMARY KEY,
    data_inscricao DATETIME,
    id_curso INT,
    id_aluno INT,
    id_situacao_inscricao INT,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    FOREIGN KEY (id_situacao_inscricao) REFERENCES Situacao_Inscricao(id_situacao_inscricao)
);


INSERT INTO Professor (nome, email, data_nasc) VALUES
('Carlos Silva', 'carlos.silva@cursos.com', '1980-05-12'),
('Mariana Souza', 'mariana.souza@cursos.com', '1985-09-23'),
('João Pereira', 'joao.pereira@cursos.com', '1978-02-14');

INSERT INTO Papel_Professor (papel, id_professor) VALUES
('Instrutor', 1),
('Coordenador', 2),
('Tutor', 3);

INSERT INTO Curso (nome, id_papel_professor) VALUES
('Introdução à Programação', 1),
('Banco de Dados Avançado', 2),
('Desenvolvimento Web', 3);

INSERT INTO Professor_Curso (id_professor, id_curso) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Modulo (titulo, ordem, carga_horaria, id_curso) VALUES
('Fundamentos de Lógica', 1, '02:00:00', 1),
('Modelagem de Dados', 1, '03:00:00', 2),
('HTML e CSS', 1, '01:30:00', 3);

INSERT INTO Perfil_Aluno (nome, foto, bio, data_nascimento) VALUES
('Ana Lima', NULL, 'Estudante dedicada à tecnologia.', '2000-07-15'),
('Bruno Costa', NULL, 'Apaixonado por desenvolvimento web.', '1998-11-30'),
('Clara Oliveira', NULL, 'Interessada em análise de dados.', '2001-03-22');

INSERT INTO Plano (plano, beneficios) VALUES
('Básico', 'Acesso a 5 cursos por mês'),
('Premium', 'Acesso ilimitado a cursos + certificados'),
('Profissional', 'Acesso ilimitado + mentorias individuais');

INSERT INTO Aluno (nome, email, id_perfil_aluno, id_plano) VALUES
('Ana Lima', 'ana.lima@aluno.com', 1, 1),
('Bruno Costa', 'bruno.costa@aluno.com', 2, 2),
('Clara Oliveira', 'clara.oliveira@aluno.com', 3, 3);

INSERT INTO Situacao_Inscricao (situacao) VALUES
('Ativa'),
('Pendente'),
('Cancelada');

INSERT INTO Inscricao (data_inscricao, id_curso, id_aluno, id_situacao_inscricao) VALUES
('2025-09-01 10:00:00', 1, 1, 1),
('2025-09-02 14:30:00', 2, 2, 2),
('2025-09-03 18:45:00', 3, 3, 3);


SELECT * FROM Professor;
SELECT * FROM Papel_Professor;
SELECT * FROM Professor_Curso;
SELECT * FROM Curso;
SELECT * FROM Modulo;
SELECT * FROM Perfil_Aluno;
SELECT * FROM Plano;
SELECT * FROM Aluno;
SELECT * FROM Situacao_Inscricao;
SELECT * FROM Inscricao;