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