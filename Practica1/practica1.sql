--Practica 1

--ejercicio 1
--cargar votacion.sql

--ejercicio 2
select table_name
from user_tables

--ejercicio 3
describe consultas;
describe consultas_datos;
describe eventos;
describe eventos_resultados;
describe localidades;
describe partidos;
describe provincias;
describe votantes;

--ejercicio 4
drop table consultas CASCADE CONSTRAINTS;
drop table consultas_datos CASCADE CONSTRAINTS;
drop table eventos CASCADE CONSTRAINTS;
drop table eventos_resultados CASCADE CONSTRAINTS;
drop table localidades CASCADE CONSTRAINTS;
drop table partidos CASCADE CONSTRAINTS;
drop table provincias CASCADE CONSTRAINTS;
drop table votantes CASCADE CONSTRAINTS;

--ejercicio 5
insert into votantes
values (30653845, 'Maria Gonzalez Ramirez', 'Doctorado', 'Activo', 'goram@telefonica.es', 1, '21/08/1989', 677544822);

--ejercicio 6
select * 
from votantes;

--ejercicio 7
delete 
from votantes v 
where v.dni = 30653845;

--ejercicio 8
Realizar inserciones con:
INSERT INTO tabla
VALUES (dni, nombre, ...);

--ejercicio 9
SELECT nombre, tipo, fecha 
FROM eventos;

--ejercicio 10
select nombre||' de tipo '||tipo "convocatoria"
from eventos

--ejercicio 11
Concatenar columas
