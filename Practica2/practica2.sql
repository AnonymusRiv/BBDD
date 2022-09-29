--practica 2

--ejercicio 1
select l.nombrecompleto "nombre"
from votantes l
where l.nombrecompleto like'%n';

--ejercicio 2
select v.DNI
from votantes v
where v.dni like '%5%5%5%';

--ejercicio 3
select v.nombrecompleto "nombre", v.fechanacimiento "fecha"
FROM votantes v
where v.fechanacimiento > '01/01/90';

--ejercicio 4
select v.nombrecompleto "nombre", l.provincia "localidad"
FROM votantes v, localidades l
where v.localidad= l.idlocalidad and l.numerohabitantes > '300000';

--ejercicio 5
select v.nombrecompleto "nombre", p.comunidad "comunidad"
FROM votantes v, provincias p, localidades l
where v.localidad= l.idlocalidad and l.provincia= p.idprovincia and l.numerohabitantes > '300000';

--ejercicio 6
select p.idpartido "partido", count (c.partido) "conteo"
from consultas_datos c, partidos p
where c.partido= p.idpartido
group by partido;

--ejercicio 7
select p.idpartido "partido", count (c.partido) "conteo"
from consultas_datos c, partidos p
where c.partido= p.idpartido
group by partido;

--ejercicio 8
select p.nombrecompleto "partido"
from consultas_datos c, partidos p, consultas t
where c.partido= p.idpartido and c.consulta=t.idconsulta
group by nombrecompleto
having count(partido)>10;

--ejercicio 9
select p.nombrecompleto "partido", count(partido) "conteo"
from consultas_datos c, partidos p, consultas t
where c.partido= p.idpartido and c.consulta=t.idconsulta
group by nombrecompleto
having count(partido)>10;

--ejercicio 10
select p.nombrecompleto "partido", count(partido) "conteo"
from consultas_datos c, partidos p
where c.partido= p.idpartido and c.respuesta='Si' and c.certidumbre>0.8
group by nombrecompleto;