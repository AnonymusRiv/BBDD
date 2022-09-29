--practica 3 ampliacion

--ejercicio 1
SELECT SUBSTR(v.nombrecompleto, 1, INSTR(v.nombrecompleto,' ')) "nombrepila", l.nombre "nombrelocalidad", p.comunidad  "nombrecomunidad"
FROM votantes v, localidades l, provincias p
WHERE v.localidad = l.idlocalidad
AND l.provincia = p.idprovincia
AND v.localidad IN (1,3,9);

--ejercicio 2
SELECT
    a.nombre||' va antes que '||b.nombre "ordenacion"
FROM
    localidades  a,
    localidades  b
WHERE
    b.idlocalidad LIKE a.idlocalidad + 1;


--ejercicio3
select l.nombre from localidades l
where l.numerohabitantes >(
    select l.numerohabitantes from localidades l where l.idlocalidad=(
        select v.localidad from votantes v where v.fechanacimiento=(
            select min (v.fechanacimiento) from votantes v where v.fechanacimiento>(
                select min (v.fechanacimiento) from votantes v
            )
        )
    )
);

--ejercicio 4
SELECT nombrecompleto"Nombre", localidad"Localidad", DECODE(SIGN(18-((SYSDATE-fechanacimiento)/365.6)),1,'Menor de Edad','Mayor de Edad')"Mayoría edad"
FROM votantes
WHERE localidad IN (2,4,8);

--ejercicio 5
SELECT l.nombre "localidad", l.numerohabitantes "poblacion", p.comunidad "comunidad"
FROM provincias p, localidades l
WHERE p.idprovincia=l.provincia
AND p.idprovincia IN (1,2,3)
AND l.numerohabitantes > ANY (
  SELECT l.numerohabitantes
  FROM localidades l
  WHERE l.provincia = '4'
);

--ejercicio 6
SELECT v.nombrecompleto
FROM votantes v, consultas c
WHERE c.votante=v.dni
AND v.situacionlaboral = 'Activo'
GROUP BY v.nombrecompleto
HAVING COUNT(c.evento) > AVG(c.evento);
  
--ejercicio 7
SELECT l.nombre
FROM localidades l, votantes v
WHERE l.idlocalidad = v.localidad
GROUP BY l.nombre
ORDER BY AVG(DECODE(v.estudiossuperiores, 'Ninguno', 0, 'Basicos', 1, 'Superiores', 2, 'Doctorado', 3)) DESC;

--ejercicio 8
SELECT
    localidades.nombre "Nombre localidades"
FROM
    localidades,
    votantes
WHERE
    localidades.idlocalidad = votantes.localidad
HAVING
    AVG(decode(estudiossuperiores, 'Ninguno', 0, 'Basicos', 1,'Superiores', 2, 'Doctorado', 3)) > ALL (
        SELECT
            AVG(decode(estudiossuperiores, 'Ninguno', 0, 'Basicos', 1,'Superiores', 2, 'Doctorado', 3))
        FROM
            localidades,
            votantes
        WHERE
            localidades.idlocalidad = votantes.localidad
        GROUP BY
            localidades.provincia
    )
GROUP by localidades.nombre order by avg ( decode(estudiossuperiores, 'Ninguno', 0, 'Basicos', 1,'Superiores', 2, 'Doctorado', 3) ) desc;