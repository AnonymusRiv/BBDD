--practica 6
create table audit_table(datos varchar2(100 BYTE), tabla varchar2(100 BYTE))

create or replace trigger trigger_2_lunes_ej1 after update on eventos
for each row
begin
    insert into audit_table (datos, tabla) values (:old.nombre || ' ' || new.nombre , 'eventos');
end;

update eventos set nombres='Sevilla 2021' where idevento=9;


select * from eventos;

select * from audit_table;

--ejercicio 2
create or replace trigger trigger_2_ej2_ before update on localidades
for each row
begin
    if :new.numerohabitantes <1 or :new.numerohabitantes > 4000000 then
        :new.numerohabitantes := :old.numerohabitantes;
    end if;
end;

update localidades set numerohabitantes=-2 where idlocalidad=1;
select * from localidades;

update localidades set numerohabitantes=5000 where idlocalidad=1;
select * from localidades;

--ejercicio 3
create or replace trigger trigger_2_ej3_lunes before insert or update on consultas
for each row
begin
    if :new.fecha > sysdate then 
        insert into audit_table (datos, tabla) values ('la fecha ' || :new.fecha || ' se ha cambiado por ' || sysdate, 'consultas');
        :new.fecha := sysdate
    end if;
end;

--ejercicio 4
after table votantes add constraint cons_2_lunes_ej4 check(telefono >= 600000000 and telefono <= 799999999);

insert into votantes 

--ejercicio 5
after table eventos disable constraint ck_nombre;

after table eventos add constraint ck_ej5_2_lunes check();


set serveroutput on;
declare
    tipo varchar2(100);
    
begin
    tipo:='Holas';
    
    if substr(tipo, 1, 1)>='A' and substr(tipo, 1, 1)<='Z' and substr(tipo, -1, 1) like 's' then  --like '_%s'
    dbms_output.put_line('Entra');
    
    end if;
end;

insert into eventos values (25, 'mi evento', sysdate, 'Otra pruebas', 'Clase BD');

--ejercicio 6



--ejercicio 7
--cadena delante del arroba >0
--posicion del @ >1 (si es 0 no existe, si es un 1 es la primera posicion, si es mayor de un 1 esta en la n posicion (hay algo delante del @))
substr(correo, 1, instr(correo , '@')-1)like '_%';
alter table votantes add constraint check_correo_2_ej7 check(email like '_%@_%._%');

--ejercicio 8
alias like '%a%a%' and alias not like '%a%a%a%'

alter table votantes add constraint check_correo_2_ej8_ check(email like '%a%a%@hotmail._%' and email not like '%a%a%a%@hotmail._%')