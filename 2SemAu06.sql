--Ex 1
--Triggers

create or replace trigger trg_ver_dt_entrega
before insert or update on loc_item_locacao
for each row
declare
begin
  if :NEW.dt_retirada > :NEW.dt_entrega then
    raise_application_error(-20001, 'Voce nao pode alterar essa tabela');
  end if;
end;

insert into loc_item_locacao(dt_retirada, dt_entrega) values('26/01/10', '29/01/10') 
