create database empresax;
use empresax;

DROP TABLE funcionarios;
CREATE TABLE funcionarios (
    idfun INT NOT NULL,
    nome VARCHAR(60) NOT NULL,
    cargo VARCHAR(20),
    salario DECIMAL(10,2),
    DataContratacao DATE,
    id int not null,
    primary key(idfun),
    foreign key(iddep) references departamentos (iddep)
);

create table departamentos (
	iddep int not null,
    nome varchar(40) not null,
    localizacao varchar(60),
	primary key(iddep)
)

