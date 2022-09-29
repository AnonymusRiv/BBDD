--practica 3

--ejercicio 1
select nombrecompleto "nombre"
from votantes
where substr(dni, - length(localidad + 1)) LIKE localidad + 1;

--ejercicio 2
select v.nombrecompleto, l.nombre
from votantes v, localidades l
where l.idlocalidad LIKE decode(v.localidad, 1, 9, 2, 9, 3, 9, v.localidad);

--ejercicio 3
SELECT p.siglas
from partidos p, eventos_resultados er
where p.idpartido=er.partido
group by p.siglas
having count(er.partido) = (select max(count (er.partido))
from partidos p, eventos_resultados er
where p.idpartido=er.partido
group by p.siglas);

--ejercicio 4
select v.dni
from votantes v
where v.fechanacimiento=(
select min(v.fechanacimiento) from votantes v where v.fechanacimiento>(
select min(v.fechanacimiento) from votantes v));

--ejercicio 5
select v.dni, count(c.votante) "conteo"
from votantes v
left join consultas c on v.dni=c.votante
group by v.dni
order by count(c.votante) desc;

--ejercicio 6
select v.dni, count(c.votante) "conteo"
from votantes v
left join consultas c on v.dni=c.votante
group by v.dni
having count(c.votante)>(select avg(count(c.votante)) from consultas c group by c.votante)
order by count(c.votante) desc;

--ejercicio 7
select v.nombrecompleto
from votantes v
left join consultas c on v.dni=c.votante
group by v.nombrecompleto
having count(c.votante)>(select avg(count(c.votante)) from consultas c group by c.votante);

--ejercicio 8
select v.dni, count(c.evento) as "COUNT(VOTANTE)"
from votantes v, consultas c
where v.dni = c.votante
and dni not like 
(select dni from votantes where fechanacimiento = 
    (select min(fechanacimiento) from votantes v where fechanacimiento >
    (select min(fechanacimiento) from votantes v))
)
group by v.dni
order by count(c.evento) desc;