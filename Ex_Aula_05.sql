SET SERVEROUTPUT ON;

/* 
    Aula 13-03/2018
*/
DECLARE
    v_idade number := &Idade;
BEGIN
    IF v_idade < 18 THEN
        dbms_output.put_line('Menor de Idade');
    ELSE
        dbms_output.put_line('Maior de Idade');
    END IF;        
END;

--LOOP
DECLARE
    v_cont number := 0;
BEGIN
    LOOP
        v_cont := v_cont + 1;
        dbms_output.put_line(v_cont);
        EXIT WHEN v_cont > 20;
        END LOOP;
END;

--For
DECLARE

BEGIN
    FOR x IN 1..21 LOOP
    dbms_output.put_line(x);
    END LOOP;
END;

DECLARE

BEGIN
    FOR x IN 1..21 LOOP
    dbms_output.put_line(x);
    END LOOP;
END;

/*

Desenvolva um bloco anônimo que exiba 365 dias (1 ano) após a entrada de uma data. Após a solicitação da entrada do campo data, exiba sequencialmente a data e o dia da semana que representa essa data. Utilize o comando loop para realizar essa tarefa. Utilize o pacote DBMS_OUTPUT para exibir esses valores
Solução:


Desenvolva um bloco anônimo que receba um número positivo, que seja maior que 5, e traga todos os números ímpares do intervalo entre o número 1 e o valor recebido.



Desenvolva um script que vai receber como parâmetro o código do proprietário e retornar o código do proprietário, o nome do proprietário e o tipo de proprietário (Pessoa Jurídica ou Pessoa Física). A coluna tp_proprietario irá informar qual é o tipo de proprietário. (P ou J). Converta esse valor para P (Pessoa Física) e J para (Pessoa Jurídica) ** Utilize o comando IF para realizar essa tarefa.

** Faça o acesso a tabela LOC_PROPRIETARIO pela clausula SELECT...INTO.....

Utilize o pacote DBMS_OUTPUT.PUT_LINE para exibir o texto conforme abaixo :

'O proprietário ' || <cd_proprietario>> || ' - ' || <<nm_proprietário>> ||  ' é  ' || <<tp_proprietario(pessoa física ou pessoa jurídica>>.

Caso o código do proprietário não esteja cadastrado na  tabela, retornar a mensagem  “NÃO EXISTE DADOS DE PROPRIETARIO CADASTRADO !!”:
Solução:

*/
