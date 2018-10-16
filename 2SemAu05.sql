create or replace package PKG_EXERC1 is
  function fnc_soma (p_n1 number, p_n2 number) return number;
  function fnc_mult (p_txt varchar2) return number;
  procedure pcc_insere_locddd (p_seq_ddd loc_ddd.seq_ddd%type, p_estado_ddd loc_ddd.estado_ddd%type, 
  p_cidade_ddd loc_ddd.cidade_ddd%type);
end;

create or replace package body PKG_EXERC1 is

  function fnc_soma (p_n1 number, p_n2 number) return number is
  begin
    return mod(p_n1, p_n2);
  exception
    when others then
      raise_application_error(-20002, 'Erro ao retornar a divisao');
  end;
  
  function fnc_mult (p_txt varchar2) return number is
  begin
    return length(p_txt);
  exception
    when others then
      raise_application_error(00001, 'Erro ao contar');
    end;
    
  procedure pcc_insere_locddd (p_seq_ddd loc_ddd.seq_ddd%type, p_estado_ddd loc_ddd.estado_ddd%type, 
  p_cidade_ddd loc_ddd.cidade_ddd%type) is
    seqNext  number;
  begin
    SELECT MAX(cd_ddd)+1 INTO seqNext FROM LOC_DDD;
    insert into loc_ddd(cd_ddd, seq_ddd, estado_ddd, cidade_ddd) values (seqNext, p_seq_ddd, p_estado_ddd, p_cidade_ddd);
  exception
    when others then
      raise_application_error(00001, 'Chave ja utilizada, tente novamente');
  end;
  
end;
