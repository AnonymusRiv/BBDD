--amapliacion practica 2

--ejercicio 1
select v.DNI
from votantes v
where v.telefono like '%6%6%' and v.telefono not like '%6%6%6%';

--ejercicio 2
select v.DNI
from votantes v
where v.telefono like '%6%6%6%' and v.telefono not like '%6%6%6%6%';

--ejercicio 3
select l.nombre "localidad", p.nombre "provincia"
from localidades l
join provincias p
on l.provincia=p.idprovincia
where substr(to_char(l.numerohabitantes),-1,1) like to_char(l.provincia);

--ejercicio 4
select v.nombreCompleto "nombre"
from votantes v
where substr(to_char(telefono),-1,1)like substr(to_char(dni),-1,1);

--ejercicio 5
select v.nombrecompleto "nombre" 
from votantes v
where v.nombrecompleto like '%s%' and v.fechanacimiento < '12/02/1990';

--ejercicio 6
select distinct c.votante
from consultas c
order by c.votante desc;

--ejercicio 7
select v.dni
from votantes v
join consultas c
on v.dni=c.votante
group by v.dni having count(c.evento)>3;

--ejercicio 8
select v.nombrecompleto "nombre", count(c.evento) "consultas"
from votantes v
join consultas c
on v.dni=c.votante
group by v.nombrecompleto having count(c.evento)>3 order by count(evento) asc;

--ejercicio 9
select v.nombrecompleto "nombre", l.nombre "localidad"
from votantes v
join localidades l
on v.localidad=l.idlocalidad
where l.numerohabitantes>300000;

--ejercicio 10
select p.nombrecompleto "partido", max(c.certidumbre) "certidumbre"
from partidos p
join consultas_datos c
on p.idpartido=c.partido
group by nombrecompleto; 

--ejercicio 11
select v.nombrecompleto "nombre", avg(cd.certidumbre) "certidumbre"
from votantes v
join consultas c
on v.dni=c.votante
join consultas_datos cd
on c.idconsulta=cd.consulta
where cd.respuesta='Si'
group by v.nombrecompleto;

--ejercicio 12
select v.nombrecompleto "nombre", avg(cd.certidumbre) "certidumbre"
from votantes v
join consultas c
on v.dni=c.votante
join consultas_datos cd
on c.idconsulta=cd.consulta
where cd.respuesta='Si' having avg(cd.certidumbre)>0.5 and avg(cd.certidumbre)<0.8
group by v.nombrecompleto;

--ejercicio 13
select p.nombrecompleto "partido", avg(cd.certidumbre) "certidumbre"
from partidos p, consultas_datos cd
where p.idpartido=cd.partido and cd.respuesta='No' having avg(cd.certidumbre)>0.6
group by p.nombrecompleto;