create database e_logware;
use e_logware;

create table armazenamento(
    id_armazenamento int primary key auto_increment,
    cap_total decimal(10, 2) not null,
    cap_utilizada decimal(10, 2) default 0
);

create table fornecedor(
    id_fornecedor int primary key auto_increment,
    nome_for varchar(50),
    contato_for int
);

create table produto(
    id_produto int primary key auto_increment,
    descricao varchar(60),
    qnt_estoque int,
    id_armazenamento int,
    id_fornecedor int,
    foreign key (id_armazenamento) references armazenamento(id_armazenamento),
    foreign key (id_fornecedor) references fornecedor(id_fornecedor)
);

create table cliente(
    id_cliente int primary key auto_increment,
    nome_cli varchar(60),
    contato_cli int,
    endereco varchar(100)
);

create table transportadora(
    id_transportadora int primary key auto_increment,
    nome_trans varchar(50),
    contato_trans int
);

create table pedido(
    id_pedido int primary key auto_increment,
    data_ped timestamp default current_timestamp,
    status_ped varchar(30) default 'pendente',
    id_cliente int,
    id_transportadora int,
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_transportadora) references transportadora(id_transportadora)
);

create table pedido_produto(
    id_pedido int,
    id_produto int,
    quantidade int,
    primary key (id_pedido, id_produto),
    foreign key (id_pedido) references pedido(id_pedido),
    foreign key (id_produto) references produto(id_produto)
);

-- Trigger para atualizar estoque automaticamente
DELIMITER $$
create trigger atualiza_estoque
after insert on pedido_produto
for each row 
begin
    update produto set qnt_estoque = qnt_estoque - NEW.quantidade
    where id_produto = NEW.id_produto;

    insert into historico_estoque (id_produto, quantidade, movimentacao, id_pedido) values
    (NEW.id_produto, NEW.quantidade, 'SAIDA', NEW.id_pedido);
END $$ 
DELIMITER ;

-- Procedure para alocação dinâmica
DELIMITER $$
create procedure alocar_armazenamento(
    in p_id_produto int,
    in p_quantidade int,
    in p_volume_uni decimal(10,2)
)
begin 
    declare v_id_armazem int;
    declare v_espaco_armazem decimal(10,2);
    set v_espaco_armazem = p_quantidade * p_volume_uni;
    
    select id_armazenamento into v_id_armazem from armazenamento 
    where (cap_total - cap_utilizada) >= v_espaco_armazem 
    limit 1;
    
    if v_id_armazem then
        update produto set id_armazenamento = v_id_armazem where id_produto = p_id_produto;
        update armazenamento set cap_utilizada = cap_utilizada + v_espaco_armazem 
        where id_armazenamento = v_id_armazem;
        select 'Ok' as status;
    else 
        select 'Armazenamento sem espaço' as status;
    end if;
end $$ 
DELIMITER ;

-- Views corrigidas
create view view_pedido as 
select 
    p.id_pedido, 
    p.data_ped, 
    p.status_ped,
    c.nome_cli as Cliente,
    t.nome_trans as Transportadora
from pedido p 
join cliente c on p.id_cliente = c.id_cliente
join transportadora t on p.id_transportadora = t.id_transportadora;

create view produtos_fornecedores as 
select 
    f.id_fornecedor,
    f.nome_for as Fornecedor, 
    f.contato_for,
    p.id_produto,
    p.descricao as Produto,
    p.qnt_estoque
from fornecedor f
left join produto p on f.id_fornecedor = p.id_fornecedor;

-- Consulta corrigida para disponibilidade de produtos
select 
    p.id_produto,
    p.descricao,
    p.qnt_estoque, 
    a.cap_total as armazenamento,
    f.nome_for as fornecedor
from produto p
join armazenamento a on p.id_armazenamento = a.id_armazenamento
join fornecedor f on p.id_fornecedor = f.id_fornecedor
where p.qnt_estoque < 10;