create database empresax;
use empresax;

create table departamentos (
	iddep int not null,
    nome varchar(40) not null,
    localizacao varchar(60),
	primary key(iddep)
);

CREATE TABLE funcionarios (
    idfun INT NOT NULL,
    nomefun VARCHAR(60) NOT NULL,
    cargo VARCHAR(20),
    salario DECIMAL(10,2),
    DataContratacao DATE,
    iddep int,
    primary key(idfun),
    foreign key(iddep) references departamentos (iddep)
);

insert into departamentos values
('123', 'Manufatura', '1º andar'),
('456', 'Qualidade', '2º andar'),
('789', 'TI', '3º andar');

INSERT INTO funcionarios VALUES
('001', 'José da Silva', 'Operador', 3500, '2015-10-05', '123'),
('002', 'Lucas Marques', 'Gestor', 6000, '2020-11-02', '456'),
('003', 'Julia Facioli', 'Des. front-end', 11000, '2020-12-12', '789');

-- select * from funcionarios;
-- select * from departamentos;
-- SELECT * FROM funcionarios WHERE salario BETWEEN 3000 AND 6000;

-- 1
DELIMITER $$
CREATE PROCEDURE ListarFuncionarios()
BEGIN
    SELECT nomefun from funcionarios;
END $$
DELIMITER ;

call ListarFuncionarios();

-- 2
DELIMITER $$
CREATE FUNCTION SalarioAnual(salario DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN salario * 12;
END $$
DELIMITER ;

SELECT nomefun, cargo, SalarioAnual(salario) AS SalarioAnual
FROM funcionarios;

-- 3
DELIMITER $$
CREATE PROCEDURE InserirFuncionario(
    IN p_idfun INT,
    IN p_nomefun VARCHAR(60),
    IN p_cargo VARCHAR(20),
    IN p_salario DECIMAL(10,2),
    IN p_DataContratacao DATE,
    IN p_iddep INT
)
BEGIN
    INSERT INTO funcionarios (idfun, nomefun, cargo, salario, DataContratacao, iddep)
    VALUES (p_idfun, p_nomefun, p_cargo, p_salario, p_DataContratacao, p_iddep);
END $$
DELIMITER ;

CALL InserirFuncionario(4, 'Ana Oliveira', 'Analista', 4500.00, '2022-05-15', 789);
SELECT*FROM funcionarios;

-- 4
CREATE VIEW funcionarios_salarios AS 
SELECT nomefun, salario
FROM funcionarios
where salario > 1000.00;

select * from funcionarios_salarios;
