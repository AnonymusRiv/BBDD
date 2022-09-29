--Practica 5

--ejercicio 1
set serveroutput on;
declare
cont number :=0;
cursor c is select * from votantes where substr(dni, - length(localidad+1), length(localidad+1)) like localidad+1;
begin
for num_row in c loop
dbms_output.put_line(num_row.nombrecompleto);
cont := cont + 1;
end loop;
dbms_output.put_line('Hay un total de '||cont||' votantes');
end;

--ejercicio 2
set serveroutput on
declare
cursor c is select nombrecompleto from votantes where substr(dni,length(dni),length(dni)) = localidad+1;
fila c%rowtype;
numero number:=0;
begin
open c;
loop
FETCH c into fila;
exit when c%notfound;
numero := numero + 1;
dbms_output.put_line(fila.nombrecompleto);
end loop;
dbms_output.put_line('Hay un total de ' || numero || ' votantes');
end;

--ejercicio 3
set serveroutput on
declare
cursor c is select nombrecompleto from votantes 
where substr(dni, length(dni),length(dni)) = localidad+1;
numero INTEGER:=0;
fila c%rowtype;
begin
open c;
fetch c into fila;
while c%found loop
numero := numero +1;
dbms_output.put_line(fila.nombrecompleto);
fetch c into fila;
end loop;
dbms_output.put_line('Hay un total de '|| numero || ' votantes');
end;

--ejercicio 4
set serveroutput on;
declare
cursor c is select nombrecompleto, nombre from votantes, localidades where localidades.idlocalidad like decode(votantes.localidad, 1, 9, 2, 9, 3, 9, votantes.localidad);
cont number := 0;
begin
for num_row in c loop
     DBMS_OUTPUT.PUT_LINE(num_row.nombrecompleto ||' es de ' || num_row.nombre);
     if num_row.nombre like 'Madrid' then
        cont := cont+1;
     END IF;
END LOOP;
 DBMS_OUTPUT.PUT_LINE('Hay un total de ' || cont ||' votantes de Madrid');
END;

--ejercicio 5
set serveroutput on;
declare
cursor c is select dni from votantes order by dni desc;
dni2 votantes.dni%type;
begin
for num_row in c loop
    if dni2 is null then
    dni2 := num_row.dni;
    else
    DBMS_OUTPUT.PUT_LINE(dni2 || ' va antes que ' || num_row.dni);
    dni2 := num_row.dni;
    end if;
end loop;
    DBMS_OUTPUT.PUT_LINE(dni2 || ' es el más pequeño');
end;

--ejercicio 6
set serveroutput on;
declare
cursor c is select dni, count(votante) nveces from votantes left join consultas on votantes.dni = consultas.votante group by dni
having count(votante) >(select avg(count(votante)) from consultas group by votante) order by count(votante)desc;
begin
for num_row in c loop
    DBMS_OUTPUT.PUT_LINE(num_row.dni ||' ha participado '||num_row.nveces);
end loop;
end;

--ejercicio 7
create table votantesAntiguos(
dni number(8,0),
nombreCompleto varchar(255),
);
set serveroutput on;
declare
cursor c is select * from votantes where fechanacimiento < '01/01/1980';
cont number :=0;
begin
for num_row in c loop
if num_row.situacionlaboral like 'Activo' then
    DBMS_OUTPUT.PUT_LINE(num_row.nombreCompleto);
    insert into votantesAntiguos
    values (num_row.dni, num_row.nombreCompleto, num_row.estudiosSuperiores, num_row.situacionLaboral, num_row.email, num_row.localidad, num_row.fechanacimiento, num_row.telefono, 1500);
    cont := cont+1;
else
    DBMS_OUTPUT.PUT_LINE(num_row.nombreCompleto);
    insert into votantesAntiguos
    values (num_row.dni, num_row.nombreCompleto, num_row.estudiosSuperiores, num_row.situacionLaboral, num_row.email, num_row.localidad, num_row.fechanacimiento, num_row.telefono, 0);
    cont := cont+1;
end if;
end loop;
    DBMS_OUTPUT.PUT_LINE('Se han insertado '||cont||' votantes');
end;

--ejercicio 8
set serveroutput on
declare
numero integer:=0;
cursor c is select substr(nombrecompleto,1,instr(nombrecompleto,' ')) as nombre,
length(substr(nombrecompleto,1,instr(nombrecompleto,' ')))-1 as longitudNombre 
from votantesAntiguos;
begin
for linea in c loop
dbms_output.put_line(linea.nombre || ' tiene ' || linea.longitudNombre || ' letras');
numero := numero + linea.longitudNombre;
end loop;
dbms_output.put_line('En total hay ' || numero || ' letras');
end;

--ejecicio 9
set serveroutput on
declare
contador integer:=0;
cursor c is select nombrecompleto,fechanacimiento, length(substr(nombrecompleto,1,instr(nombrecompleto,' '))) 
as letras from votantesAntiguos order by fechanacimiento asc;
cursor c2 is select nombrecompleto,fechanacimiento, length(substr(nombrecompleto,1,instr(nombrecompleto,' '))) 
as letras from votantesAntiguos order by fechanacimiento asc;
begin
for linea in c loop
dbms_output.put_line(linea.nombrecompleto || ' tienes mas letras que los siguientes jovenes: ');
for linea2 in c2 loop
    if (linea.fechanacimiento < linea2.fechanacimiento) and (linea.letras > linea2.letras) then
        dbms_output.put_line(linea2.nombrecompleto);
        contador:= contador+1;
    end if;
end loop;
if contador=0 then dbms_output.put_line('Nadie cumple esta condicion');
end if;
contador:=0;
dbms_output.put_line(' ');
end loop;
end;