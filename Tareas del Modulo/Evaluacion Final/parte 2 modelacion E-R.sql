-- 2. Creacion de tablas mejoradas
CREATE TABLE actores
(
    id_actor serial primary key, 
	nombre character varying(255) NOT NULL
);

CREATE TABLE teleseries
(
    id_teleserie serial primary key,
	nombre character varying(255) NOT NULL
);

CREATE TABLE reparto_actores
(
    id serial primary key, 
	id_teleserie integer,
	id_actor integer,
	protagonista boolean,
	sueldo integer,
	capitulos integer,
	temporadas integer,
	constraint fk_actores
		foreign key (id_teleserie)
		references teleseries(id_teleserie),
	constraint fk_teleseries
		foreign key (id_actor)
		references actores(id_actor)
);

insert into teleseries (nombre)
values
	('Soltera otra vez'),
	('Papi Ricky');

insert into actores (nombre)
values
	('Alejandro Trejo'),
	('Antonella Orsini'),
	('Aranzazu Yankovic'),
	('Belen Soto'),
	('Catalina Guerra'),
	('Cristian Arriagada'),
	('Cesar Caillet'),
	('Grimanesa Jimenez'),
	('Hector Morales'),
	('Ignacio Garmendia'),
	('Jorge Zabaleta'),
	('Jose Tomas Guzman'),
	('Josefina Montana'),
	('Juan Falcon'),
	('Julio Gonzalez'),
	('Leonardo Perucci'),
	('Lorena Bosch'),
	('Loreto Aravena'),
	('Luis Gnecco'),
	('Manuel Aguirre'),
	('Maria Elena Swett'),
	('Maria Paz Grandjean'),
	('Nicolas Poblete'),
	('Pablo Macaya'),
	('Paz Bascunan'),
	('Remigio Remedy'),
	('Silvia Santelices'),
	('Solange Lackington'),
	('Tamara Acosta'),
	('Teresita Reyes');

insert into reparto_actores (id_teleserie, id_actor, protagonista, sueldo, capitulos, temporadas)
values
	(1,	25, true, 100, null, 3),
	(1,	24,	true, 100, null, 3),
	(1,	6, true, 95, null, 3),
	(1,	13, true, 90, null, 2),
	(1,	18, true, 95, null, 3),
	(1,	17, true, 90, null, 2),
	(1,	23, true, 85, null, 2),
	(1,	9, true, 80, null, 3),
	(1,	3, true, 80, null, 2),
	(1,	19, true, 95, null, 3),
	(1,	5, true, 90, null, 3),
	(1,	28, true, 70, null, 2),
	(1,	10, true, 70, null, 2),
	(1,	15, true, 75, null, 3),
	(1,	2, true, 70, null, 3),
	(1,	29, false, 60, null, 1),
	(1,	27, false, 55, null, 1),
	(1,	1, false, 55, null, 1),
	(1,	8, false, 60, null, 1),
	(2,	11, true, 100, 135, null),
	(2,	4, true, 100, 135, null),
	(2,	29, true, 100, 135, null),
	(2,	21, true, 100, 135, null),
	(2,	14, true, 95, 135, null),
	(2,	27, true, 85, 135, null),
	(2,	16, true, 85, 135, null),
	(2,	30, true, 80, 135, null),
	(2,	19, true, 75, 135, null),
	(2,	1, true, 65, 135, null),
	(2,	8, true, 60, 135, null),
	(2,	26, true, 60, 135, null),
	(2,	22, true, 55, 135, null),
	(2,	9, true, 50, 135, null),
	(2,	7, true, 40, 135, null),
	(2,	12, true, 25, 135, null),
	(2,	20, true, 30, 135, null);


-- 3. Mostrar todas las teleseries y los actores de reparto que sean protagonistas.
select ts.nombre as "Teleserie", actores.nombre as "Actores de Reparto"
from teleseries as "ts"
join reparto_actores as ra
	on ts.id_teleserie = ra.id_teleserie
join actores
	on ra.id_actor = actores.id_actor
where ra.protagonista = true