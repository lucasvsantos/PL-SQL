set serveroutput on
declare
    v_data  date := to_date('&Data','dd/mm/yyyy');
    v_cont  number := 1;
begin
    loop
        dbms_output.put_line (to_char(v_data,'dd/mm/yyyy day'));
        v_cont := v_cont + 1;
        v_data := v_data + 1;
        exit when v_cont = 365;
    end loop;
end;


declare
    v_numero number := &Numero_maior_que_5;
begin
    if v_numero < 5 then
        dbms_output.put_line ('Número inválido.');
    else
        for x in 1..v_numero loop
            if mod(x,2)<>0 then
                dbms_output.put_line ('N(Impar)=>' || x);
            end if;
        end loop;
    end if;
end;





select * from loc_proprietario


declare
    v_cd_proprietario   loc_proprietario.cd_proprietario%type := &Cod_proprietario;
    v_nome_proprietario   loc_proprietario.nome_proprietario%type;
    v_tp_proprietario   loc_proprietario.tp_proprietario%type;
    v_retorno   number;
    v_tipo_prop varchar2(100);
begin
    select count(1) 
      into v_retorno
      from loc_proprietario
     where cd_proprietario = v_cd_proprietario;
    
    if v_retorno = 0 then
        dbms_output.put_line ('NÃO EXISTE DADOS DE PROPRIETARIO CADASTRADO !!');
    else
        select nome_proprietario, tp_proprietario
          into v_nome_proprietario, v_tp_proprietario
          from loc_proprietario
        where cd_proprietario = v_cd_proprietario;
        
        if v_tp_proprietario ='F' then
            v_tipo_prop := 'Pessoa Física';
        elsif v_tp_proprietario = 'J' then
            v_tipo_prop := 'Pessoa Jurídica';
        end if;
        
        dbms_output.put_line ('O proprietário ' || v_cd_proprietario 
        || ' - ' || v_nome_proprietario ||  ' é  ' || v_tipo_prop );
    end if;
end;

select * from loc_grupo

declare
    v_cd_grupo   loc_grupo.cd_grupo%type := &Cod_grupo;
    v_ds_grupo   loc_grupo.ds_grupo%type;
    v_cont       number;
begin
    select count(1) 
      into v_cont
      from loc_grupo
     where cd_grupo = v_cd_grupo;
    
    if v_cont = 0 then
        dbms_output.put_line ('NÃO EXISTE DADOS DE GRUPO DE VEÍCULO CADASTRADO !!');
    else
        select ds_grupo
          into v_ds_grupo
          from loc_grupo
         where cd_grupo = v_cd_grupo;
         
         dbms_output.put_line ('O código do grupo de veículo ' || v_cd_grupo
         || '  tem a sua descrição como ' || v_ds_grupo);
    end if;
end;









select * from loc_proprietario

select p.nome_proprietario, v.nr_placa, v.modelo, v.cor 
  from loc_veiculo v, loc_proprietario p
 where v.cd_proprietario = p.cd_proprietario;
 
 
 
declare
    v_nr_placa  loc_veiculo.nr_placa%type := '&Placa';
    v_modelo    loc_veiculo.modelo%type;
    v_cor       loc_veiculo.cor%type;
    v_nome_prop loc_proprietario.nome_proprietario%type;
    v_cont      number;
begin
    select count(1)
      into v_cont
      from loc_veiculo v, loc_proprietario p
     where nr_placa = v_nr_placa
       and v.cd_proprietario = p.cd_proprietario;
    if v_cont = 0 then
        dbms_output.put_line ('NÃO EXISTE DADOS DE VEÍCULO CADASTRADO !!');
    else
        select p.nome_proprietario, v.nr_placa, v.modelo, v.cor 
          into v_nome_prop, v_nr_placa, v_modelo, v_cor
          from loc_veiculo v, loc_proprietario p
         where v.cd_proprietario = p.cd_proprietario
           and v.nr_placa = v_nr_placa;
        
        dbms_output.put_line ('O veículo de placa' || v_nr_placa || 
        '  pertence ao proprietário ' || v_nome_prop ||  
        '  é do modelo ' || v_modelo || ' e tem a cor' || v_cor);
    end if;
end;
