--PREPARACAO
DROP TABLE LOG_EVENTOS;
CREATE TABLE LOG_EVENTOS (ID NUMBER, EVENTO VARCHAR2(4000), OSUSER VARCHAR2(100), ORACLEUSER VARCHAR2(100), DATA DATE);

--TRIGGER
create or replace trigger TRG_GRUPO_BFUP
  after update on LOC_GRUPO for each row
declare
  contextt  VARCHAR2(100);
  usuario VARCHAR2(100);
  alteracoes VARCHAR2(4000);
  idTabela number;
begin
    
  if :NEW.cd_grupo != :OLD.cd_grupo then
    alteracoes := 'CD_GRUPO Anterior: ' || :OLD.cd_grupo || ' - CD_GRUPO Novo: ' || :NEW.cd_grupo || ' | ';
  end if;
  
  if :NEW.ds_grupo != :OLD.ds_grupo then
    alteracoes := alteracoes || 'DS_GRUPO Anterior: ' || :OLD.ds_grupo || ' - DS_GRUPO Novo: ' || :NEW.ds_grupo || ' | ';
  end if;
  
  if :NEW.vl_locacao_diaria != :OLD.vl_locacao_diaria then
    alteracoes := alteracoes || 'VL_LOCACAO_DIARIA Anterior: ' || :OLD.vl_locacao_diaria || ' - VL_LOCACAO_DIARIA Novo: ' || :NEW.vl_locacao_diaria;
  end if;

  SELECT SYS_CONTEXT ('USERENV', 'OS_USER') into contextt from dual;  
  SELECT USER into usuario FROM DUAL;
  SELECT MAX(Id) INTO idTabela FROM LOG_EVENTOS;
  
  if idTabela IS null then
    idTabela := 1;
  else 
    idTabela := idTabela + 1;
  end if;

  INSERT INTO LOG_EVENTOS VALUES (idTabela, alteracoes, contextt, usuario, (SELECT SYSDATE FROM DUAL));
end;


-- Exercicio 2
CREATE OR REPLACE TRIGGER TRG_LOCACAO_UPDT
BEFORE UPDATE OF VL_LOCACAO_DIARIA ON LOC_GRUPO
for each row
begin
  if :new.vl_locacao_diaria > :old.vl_locacao_diaria then
    raise_application_error(-20001, 'Não foi possivel inserir, o valor a ser inserido é maior que o valor anterior');
  elsif :new.vl_locacao_diaria = :old.vl_locacao_diaria then
    raise_application_error(-20002, 'Não foi possivel inserir, o valor a ser inserido é igual ao valor anterior');
  end if;
  exception
    when others then
      dbms_output.put_line('Ocorreu um erro ao fazer o update');
end;