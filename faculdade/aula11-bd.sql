create database estoque;
use estoque;

CREATE TABLE produtos (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
quantidade INT 
); 


CREATE TABLE log_estoque (
id_log INT AUTO_INCREMENT PRIMARY KEY,
id_produto INT,
quantidade_antiga INT,
quantidade_nova INT,
data_alteracao DATETIME
);

INSERT INTO produtos (nome, quantidade) VALUES
('Smartphone Samsung', 25),
('Fone Bluetooth', 40),
('Notebook Acer', 10),
('Cadeira Ergonômica', 5),
('Monitor LG', 15);


-- Trigger
delimiter $$
create trigger trg_atualizar_qnt
after update on produtos
for each row
begin
	insert into log_estoque(id_produto, quantidade_antiga, quantidade_nova, data_alteracao)
	values (old.id, old.quantidade, new.quantidade, now());
end $$
delimiter ;

update produtos set quantidade = 30 where id = 1;
select * from log_estoque

-- Função
delimiter $$
create function get_quantidade_produto(prod_id int)
returns int
deterministic
reads sql data
begin
	declare quantidade int;
    select quantidade into quantidade from produtos
    where id = prod_id;
    
    return quantidade;
end $$
delimiter ;

-- Procedure
delimiter $$
create procedure atualiza_quantidade(p_id int, p_nova_quantidade int)
begin
    update produtos
    set quantidade = p_nova_quantidade
    where id = p_id;

    select 'Produto atualizado com sucesso' as mensagem;
end $$
delimiter ;