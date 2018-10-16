set serveroutput on;
TRUNCATE TABLE custos_depto;
declare
    cursor c_depto_funcionario is SELECT D.CD_DEPTO, D.NM_DEPTO, SUM(VL_SALARIO) E FROM LOC_FUNCIONARIO F, LOC_DEPTO D WHERE F.CD_DEPTO = D.CD_DEPTO GROUP BY D.NM_DEPTO, D.CD_DEPTO;
    v_departamento c_depto_funcionario%rowtype;
    v_valor_anual number := 0;
begin
    open c_depto_funcionario;
    loop
        fetch c_depto_funcionario into v_departamento;
        exit when c_depto_funcionario%notfound;
        v_valor_anual := v_departamento.E * 12;
            begin
                INSERT INTO custos_depto (id_depto, nm_depto, VL_SALARIO_ANO, VL_SALARIO_MES, DATA_CARGA) VALUES (v_departamento.cd_depto, v_departamento.nm_depto, v_valor_anual, v_departamento.E, SYSDATE);
            exception
                when DUP_VAL_ON_INDEX then
                UPDATE custos_depto d set d.nm_depto = v_departamento.nm_depto, vl_salario_ano = v_valor_anual, vl_salario_mes = v_departamento.E, data_carga = SYSDATE WHERE id_depto = v_departamento.cd_depto;
                when others then
                dbms_output.put_line('Erro ao inserir dados.');
            end;
    end loop;
    close c_depto_funcionario;   
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('NAO EXISTE DADOS NA TABELA.');
    when others then 
        dbms_output.put_line('ERRO INESPERADO.');
end;
