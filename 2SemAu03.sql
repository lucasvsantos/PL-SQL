--Exercicio Dois
create or replace procedure prc_insere_proprietario (nome_proprietario in varchar2, tp_proprietario in char, telefone in varchar2, nr_cpf in number, nr_cgc in number, ds_email in varchar2)
as
begin
insert into loc_proprietario(cd_proprietario, nome_proprietario, tp_proprietario, telefone, nr_cpf, nr_cgc, ds_email) values 
((select max(cd_proprietario) from loc_proprietario)+1, nome_proprietario, tp_proprietario, telefone, nr_cpf, nr_cgc, ds_email);
exception
when others then
dbms_output.put_line(sqlerrm);
end;

set serveroutput on;
declare
begin
prc_insere_proprietario('Joaozain', 'J', '43456018', '43370943', '222233', 'JOAOZIN@gemenet.net');
end;

select * from loc_proprietario;
--Exercicio Dois

--Ex 3
create or replace procedure fun_nome_grupo (cd_grupo in number, nome_grupo out varchar2)
as
begin
SELECT UNIQUE cs.ds_grupo into nome_grupo FROM LOC_GRUPO cs WHERE cd_grupo = cd_grupo;
exception
when NO_DATA_FOUND then
nome_grupo := 'Informe um valor valido';
when others then
dbms_output.put_line(sqlerrm);
end;

declare
mensagem varchar2(100);
begin
fun_nome_grupo('1', mensagem);
dbms_output.put_line(mensagem);
end;
