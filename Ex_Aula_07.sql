--set serveroutput on
--select * from loc_cliente where TP_CLIENTE = 'F';  

declare
    cursor c_dados is
       select * from loc_cliente where TP_CLIENTE = 'F';  
    
    v_dados     c_dados%rowtype;
begin
    open c_dados;
    loop
        fetch c_dados into v_dados;
        exit when c_dados%notfound;
        
        dbms_output.put_line (v_dados.nm_cliente || ' - ' || v_dados.telefone);
    end loop;
    close c_dados;
exception
    when others then
        dbms_output.put_line (sqlerrm);
end;
