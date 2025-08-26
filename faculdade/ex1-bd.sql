create database sistemaAcademico;
use sistemaAcademico;
create table curso (
	CodCurso	char(3) not null,
	Nome		varchar(40) not null,
	Mensalidade	numeric(10,2),
	primary key (CodCurso)
	);
alter table aluno modify Nome varchar(50);

create table aluno (
    RA			char(9) not null primary key,
    RG			char(9) not null,
    Nome		varchar(30),
    CodCurso	char(3),
    foreign key(CodCurso) references curso (CodCurso)
    );
    
create table disciplina (
	CodDisc		char(5) not null,
    Nome		char(40),
    CodCurso	char(3),
    NroCreditos int(11),
    primary key(CodDisc),
    foreign key(CodCurso) references curso(CodCurso)
	);
    
create table boletim (
	RA	char(9) not null,
    CodDisc	char(5) not null,
    Nota decimal(10,2),
    primary key (RA,CodDisc),
    foreign key(RA) references aluno(RA),
    foreign key(CodDisc) references disciplina(CodDisc)
	);

INSERT INTO aluno VALUES 
('123','12345','BIANCA MARIA PEDROSA','AS'),
('212','21234','TATIANE CITTON','AS'),
('221','22145','ALEXANDRE PEDROSA','CC'),
('231','23144','ALEXANDRE MONTEIRO','CC'),
('321','32111','MARCIA RIBEIRO','CC'),
('661','66123','JUSSARA MARANDOLA','SI'),
('765','76512','WALTER RODRIGUES','SI');

insert into curso values
('AS','Análise de Sistemas',100);
insert into curso values
('CC','Ciência da Computação', 950);
insert into curso values
('SI','Sistemas de Informação', 800);

insert into disciplina values
('BD','Banco de Dados', 'CC',4);
insert into disciplina values
('BDA','Banco de Dados Avançados','CC',6);
insert into disciplina values
('BDOO','Banco de Dados o Objetos','SI',4);
insert into disciplina values
('BDS','Sistemas de Banco de Dados','SI',4);
insert into disciplina values
('DBD','Desenvolvimento Banco de Dados','SI',6);
insert into disciplina values
('IBD', 'Introdução ao Banco de Dados','AS',2);

insert into boletim values ('123','BDS',10);
insert into boletim values ('212','IBD',7.5);
insert into boletim values ('231','BD',9);
insert into boletim values ('231','BDA',9.6);
insert into boletim values ('661','DBD',8);
insert into boletim values ('765','DBD',6);

select * from aluno;
select * from curso;
select * from disciplina;
select * from boletim;