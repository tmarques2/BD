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

describe funcionarios;

insert into departamentos values
('123', 'Manufatura', '1º andar'),
('456', 'Qualidade', '2º andar'),
('789', 'TI', '3º andar');

insert into funcionarios values
('001', 'José da Silva', 'Operador', '3500', '2015-10-05', '123'),
('002', 'Lucas Marques', 'Gestor', '6000', '2020-11-02', '456'),
('003', 'Julia Facioli', 'Des. front-end', '11000', '2020-12-12', '789');


select * from funcionarios;
select * from departamentos;
SELECT * FROM funcionarios WHERE salario BETWEEN 3000 AND 6000;

desc funcionarios;
desc departamentos;

