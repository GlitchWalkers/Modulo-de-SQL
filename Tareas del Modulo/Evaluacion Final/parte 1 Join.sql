DROP TABLE IF EXISTS reparto_soltera_otra_vez;
CREATE TABLE reparto_soltera_otra_vez
(
    nombre character varying(255) NOT NULL,
    temporadas integer,
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (nombre)
);

insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Paz Bascu��n', 3, true, 100);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Pablo Macaya', 3, true, 100);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Cristi�n Arriagada', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Josefina Montan�', 2, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Loreto Aravena', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Lorena Bosch', 2, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Nicol�s Poblete', 2, true, 85);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('H�ctor Morales', 3, true, 80);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Aranzaz� Yankovic', 2, true, 80);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Luis Gnecco', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Catalina Guerra', 3, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Solange Lackington', 2, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Ignacio Garmendia', 2, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Julio Gonz�lez', 3, true, 75);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Antonella Orsini', 3, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Tamara Acosta', 1, false, 60);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Silvia Santelices', 1, false, 55);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Alejandro Trejo', 1, false, 55);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Grimanesa Jim�nez', 1, false, 60);

DROP TABLE IF EXISTS reparto_papi_ricky;
CREATE TABLE reparto_papi_ricky
(
    nombre character varying(255) NOT NULL,
    capitulos integer,
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (nombre)
);

insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Jorge Zabaleta', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Bel�n Soto', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Tamara Acosta', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Mar�a Elena Swett', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Juan Falc�n', 135, true, 95);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Silvia Santelices', 135, true, 85);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Leonardo Perucci', 135, true, 85);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Teresita Reyes', 135, true, 80);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Luis Gnecco', 135, true, 75);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Alejandro Trejo', 135, true, 65);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Grimanesa Jim�nez', 135, true, 60);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Remigio Remedy', 135, true, 60);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Mar�a Paz Grandjean', 135, true, 55);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('H�ctor Morales', 135, true, 50);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('C�sar Caillet', 135, true, 40);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Jos� Tom�s Guzm�n', 135, true, 25);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Manuel Aguirre', 135, true, 30);

select *
from reparto_soltera_otra_vez
order by sueldo desc

select *
from reparto_papi_ricky

-- 1. Consulta para sueldos de actores que participaron en ambas teleseries
select sov.nombre, sov.sueldo as "Sueldo Soltera", pr.sueldo as "Sueldo Papi", (sov.sueldo+pr.sueldo) as "Sueldo Total"
from reparto_soltera_otra_vez as sov
join reparto_papi_ricky as pr
	on	sov.nombre = pr.nombre
order by nombre asc

-- 2. Consulta para actores solo en soltera otra vez con sueldo mayor a 90
select sov.nombre, sov.sueldo
from reparto_soltera_otra_vez as sov
where sueldo < 90

-- 3. Consulta para los actores con sueldo menor a 85, pero que no se repitieran en ninguna de las dos
select coalesce (sov.nombre, pr.nombre) --coalesce si en la primera tabla el valor es nulo, pasa al valor de la segunda
from reparto_soltera_otra_vez as sov
full outer join reparto_papi_ricky as pr
	on	sov.nombre = pr.nombre
where (sov.sueldo+pr.sueldo) is null --join devuelve null a sueldos de actores que no se repiten, si la suma es null el actor solo salio en una
order by sov.nombre asc