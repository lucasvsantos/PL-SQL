dss nalter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

set serveroutput on
declare
    v_usuario   varchar2(100);
    v_data      date;
begin
    select user, sysdate
      into v_usuario, v_data
      from dual;
    
    dbms_output.put_line(v_usuario|| ' ' ||  v_data);
end;

select * from pf0064.cliente_erp

declare
    v_soma number;
begin
    select sum(pontuacao)
      into v_soma
      from pf0064.cliente_erp;
 dbms_output.put_line(v_soma);
end;

declare
    v_qtd   number;
begin
    select sum(length(cd_cliente||nm_cliente||pontuacao))
      into v_qtd
      from pf0064.cliente_erp;
    
    dbms_output.put_line ('Qtd de caracteres '|| v_qtd);
end;

