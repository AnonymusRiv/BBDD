--Practica 4

--ejercicio 1
set serveroutput on;
BEGIN
DBMS_OUTPUT.PUT_LINE('Hola mundo, hoy es el dia '||sysdate);
END;

--ejercicio 2
set serveroutput on;
DECLARE
v_correo votantes.email%type;
v_nombre votantes.nombrecompleto%type;
buscar number:= 30983712;
BEGIN
select nombrecompleto, email into v_nombre, v_correo from votantes where DNI=buscar;
DBMS_OUTPUT.PUT_LINE(v_nombre ||' con correo: '||v_correo);
END;

--ejercicio 3
set serveroutput on;
DECLARE
v_correo votantes.email%type;
v_nombre votantes.nombrecompleto%type;
buscar number:= 30983712;
BEGIN
select email into v_correo from votantes where DNI=buscar;
select substr(nombrecompleto,1,instr(nombrecompleto, ' ')) into v_nombre from votantes where DNI=buscar;
DBMS_OUTPUT.PUT_LINE(v_nombre ||' con correo: '||v_correo);
END;

--ejercicio 4
set serveroutput on;
DECLARE
v_nombre votantes.nombrecompleto%type;
buscar number:= 30983712;
BEGIN
select ('Pepe'||substr(nombrecompleto, instr(nombrecompleto,' '))) into v_nombre from votantes where DNI=buscar;
DBMS_OUTPUT.PUT_LINE(v_nombre);
END;

--ejercicio 5
set serveroutput on;
DECLARE
v_dni votantes.dni%type;
v_nombre votantes.nombrecompleto%type;
BEGIN
select nombrecompleto, dni into v_nombre, v_dni from votantes where fechanacimiento=(select min(fechanacimiento) from votantes);
DBMS_OUTPUT.PUT_LINE('El señor '||v_nombre||' con dni '||v_dni||' es el votante mas longevo');
END;

--ejercicio 6
set serveroutput on
declare
nombre1 votantes.nombrecompleto%type;
correo1 votantes.email%type;
nombre2 votantes.nombrecompleto%type;
correo2 votantes.email%type;
begin 
select nombrecompleto,substr(email,1,instr(email, '@')) into nombre1,correo1 
from votantes where fechanacimiento = (select min(fechanacimiento) from votantes);
dbms_output.put_line(nombre1 || '-- Email: ' || correo1 || 'uco.es');
select nombrecompleto,substr(email,1,instr(email, '@')) into nombre2,correo2
from votantes where fechanacimiento = (select max(fechanacimiento) from votantes);
dbms_output.put_line(nombre2 || '-- Email: ' || correo2 || 'uco.es');
end;

--ejercicio 7
set serveroutput on
declare
apellido2 votantes.nombrecompleto%type;
apellido1 votantes.nombrecompleto%type;
begin
select substr(nombrecompleto,instr(nombrecompleto,' '),8) into apellido2
from votantes where fechanacimiento = (select max(fechanacimiento) from votantes);
select substr(nombrecompleto,instr(nombrecompleto,' '),5) into apellido1
from votantes where fechanacimiento = (select max(fechanacimiento) from votantes
where fechanacimiento < (select max(fechanacimiento) from votantes));
dbms_output.put_line('El hijo se llama Juan ' || apellido1 || apellido2);
end;

--ejercicio 8
set serveroutput on
declare
id1 localidades.idlocalidad%type;
nhabitantes1 INTEGER:= 0;
nhabitantes2 INTEGER := 0;
totalhabitantes INTEGER:= 0;
nciudades INTEGER:=0;
begin
select idlocalidad,numerohabitantes into id1,nhabitantes1 from localidades 
where idlocalidad = (select min(idlocalidad) from localidades);
select numerohabitantes into nhabitantes2 from localidades 
where idlocalidad = id1+1;
totalhabitantes := nhabitantes1 + nhabitantes2;
select count(idlocalidad) into nciudades from localidades where numerohabitantes > totalhabitantes;
dbms_output.put_line('Hay ' || nciudades || ' con mas de '|| totalhabitantes 
|| ' habitantes, que es la suma de las dos localidades con IDs mas pequeños' );
end;