-- 2. Ingreso de Productos
insert into productos (nombre, descripcion)
	values 
	('Teclado Mecanico RGB' , 'Teclado con interruptores mecanicos e iluminacion RGB personalizable'),
	('Mouse Inalambrico Ergonomico' , 'Mouse inalambrico con diseno ergonomico y batería recargable'),
	('Monitor LED 24" Full HD' , 'Monitor de 24 pulgadas con resolución Full HD y panel IPS'),
	('Disco SSD 1 TB' , 'Unidad de estado sólido de alta velocidad con capacidad de 1 TB'),
	('Memoria RAM DDR4 16 GB' , 'Módulo de memoria DDR4 de 16 GB para mejorar el rendimiento del equipo'),
	('Webcam HD 1080p' , 'Cámara web con resolución Full HD y micrófono integrado'),
	('Router Wi-Fi 6' , 'Router de alta velocidad compatible con el estándar Wi-Fi 6'),
	('Audífonos Gamer USB' , 'Audífonos con sonido envolvente, micrófono y conexión USB'),
	('Impresora Multifuncional' , 'Impresora con funciones de impresión, escaneo y copiado'),
	('Notebook 15.6"' , 'Computador portatil con pantalla de 15.6 pulgadas y procesador de ultima generación');

-- 3. Ingreso de existencias
insert into existencias (id_producto, cantidad, precio, pesoKg) --el id se asigna automatico, no debo ingresarlo
	values
	(202601,10,20000,1.2),
	(202602,20,12500,0.180),
	(202603,30,150000,3.8),
	(202604,40,65000,.300),
	(202605,50,99999,0.100),
	(202606,60,35000,0.45),
	(202607,70,45990,1),
	(202608,80,9900,0.25),
	(202609,90,185000,3.2),
	(2026010,100,950000,4.5);

-- 4. Insertar 5 facturas
insert into facturas (rut_comprador, rut_vendedor)
	values
	('17.059.402-9' , '16.834.871-1'),
	('19.213.325-8' , '16.834.871-1'),
	('7.635.715-5' , '16.834.871-1'),
	('10.595.150-8' , '16.834.871-1'),
	('9.132.321-1' , '16.834.871-1');

-- 5. Insertar el detalle para todas las facturas (entre 3 y 5 productos por factura)
insert into detalle_facturas (id_producto, id_factura)
	values
	(3,1), --Factura 1
	(5,1),
	(6,1),
	(4,1),
	(5,2), --Factura 2
	(5,2),
	(6,2),
	(1,3), --Factura 3
	(2,3),
	(2,3),
	(9,3),
	(10,3),
	(1,4), --Factura 4
	(2,4),
	(2,4),
	(9,4),
	(6,5), --Factura 5
	(6,5),
	(4,5);
	
-- 6. Actualizar todas las existencias con cantidad 10
update existencias
	set cantidad = 10

-- 7. Agregar la columna fecha a facturas
alter table facturas
	add fecha date

-- 8. Actualizar el nuevo campo fecha con diferentes datos para cada factura
update facturas
	set fecha = ('2025-12-23') where id =1;
update facturas	
	set fecha = ('2026-01-26') where id =2;
update facturas	
	set fecha = ('2026-03-30') where id =3;
update facturas	
	set fecha = ('2026-05-15') where id =4;
update facturas	
	set fecha = ('2026-06-23') where id =5;

-- 9. Eliminar la columna pesoKg de existencias
alter table existencias
	drop column pesoKg;
	
-- 10. Consultar una factura en particular junto a su detalle, el nombre de cada producto y su precio
select id_factura as "Numero de Factura", nombre, precio --si son unicos y uno las tablas no tengo que usar alias o nombre de la tabla
from detalle_facturas as DF
join facturas
	on facturas.id = DF.id_factura
join productos as prod
	on prod.id = DF.id_producto
join existencias as exis
	on exis.id = prod.id
where facturas.id = 1


-- 11. Consultar el valor final de una factura
select detalle_facturas.id_factura as "Numero de Factura", count(detalle_facturas.id_producto) as "Items", sum(precio) as "Total Factura"
from detalle_facturas, existencias
where 	detalle_facturas.id_factura = 1
	and
		detalle_facturas.id_producto = existencias.id --relacionar segun los PKFK id_producto de la factura esta linkeado al id de existencias no a su id_producto
group by detalle_facturas.id_factura

-- 12. Eliminar todos los productos

truncate table productos cascade