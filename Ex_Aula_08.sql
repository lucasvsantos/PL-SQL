set serveroutput on

/* SELECT * FROM LOC_BANCO */
/* Primeiro Exercicio */
declare
    cd_banco_input number := &CDBanco;    
    v_nome varchar2(100);
begin
    SELECT nm_banco INTO v_nome FROM loc_banco WHERE cd_banco = cd_banco_input;
    dbms_output.put_line(v_nome);
exception
    when NO_DATA_FOUND then
        dbms_output.put_line ('Banco nao cadastrado.');
end;

/* SELECT * FROM LOC_ITEM_LOCACAO */
/* SELECT * FROM LOC_PEDIDO_LOCACAO */
/* Segundo Exercicio */
declare
    cursor c_item_locacao(p_nr_pedido number) is SELECT sum(vl_total) FROM LOC_ITEM_LOCACAO WHERE nr_pedido = p_nr_pedido;
    cursor c_pedido_locacao is SELECT vl_total, nr_pedido FROM LOC_PEDIDO_LOCACAO;

    v_item_locacao number;
    v_pedido_locacao c_pedido_locacao%rowtype;
begin

    open c_pedido_locacao;
    loop
        fetch c_pedido_locacao into v_pedido_locacao;
        exit when c_pedido_locacao%notfound;
        open c_item_locacao(v_pedido_locacao.nr_pedido);
        loop
            fetch c_item_locacao into v_item_locacao;
            exit when c_item_locacao%notfound;
                update LOC_PEDIDO_LOCACAO set vl_total = v_item_locacao where nr_pedido = v_pedido_locacao.nr_pedido;
        end loop;
        close c_item_locacao;
    end loop;
    close c_pedido_locacao;
    
exception
    when others then
        dbms_output.put_line(sqlerrm);
end;

/** Exercicio Tres */
declare
    in_cd_cliente number := &CDCliente; 
    cursor c_desc_cliente(in_cd_cliente number) is select cli.cd_cliente, cli.nm_cliente, lpl.dt_locacao, lpl.tp_pagto, lpl.vl_total from loc_pedido_locacao lpl join loc_cliente cli on cli.cd_cliente = lpl.cd_cliente where cli.CD_CLIENTE = in_cd_cliente and rownum = 1 order by lpl.dt_locacao DESC;
    v_desc_cliente c_desc_cliente%rowtype;
begin

    open c_desc_cliente(in_cd_cliente);
    loop
        fetch c_desc_cliente into v_desc_cliente;
        exit when c_desc_cliente%notfound;
        dbms_output.put_line('O cliente ID ' || v_desc_cliente.cd_cliente || ' - ' || v_desc_cliente.nm_cliente ||  ' fez a última locação em ' || v_desc_cliente.dt_locacao || ' e o pagamento realizado foi em ' || v_desc_cliente.tp_pagto || ' no valor de R$ '||to_char(v_desc_cliente.vl_total,'999G999D99'));
    end loop;
    
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('NÃO EXISTE DADOS DE CLIENTE CADASTRADO !');
end;
