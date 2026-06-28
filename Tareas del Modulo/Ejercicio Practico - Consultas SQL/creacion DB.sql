-- 1. Creacion de Tablas
Create Table facturas
	(
	id serial primary key,
	rut_comprador varchar(12) not null,
	rut_vendedor varchar(12) not null
	);

Create Table productos
	(
	id serial PRIMARY KEY,
	nombre varchar(255) not null,
	descripcion varchar(255)	
	);
	
Create Table existencias
	(
	id serial PRIMARY KEY,
	id_producto integer unique not null,
	cantidad integer not null,
	precio integer not null,
	pesoKg integer default 0,
	constraint fk_productos
		foreign key (id)
		references productos(id)
	);

Create Table detalle_facturas --crear en orden, tablas con FK al final
	(
	id serial primary key,
	id_producto integer not null,
	id_factura integer not null,
	constraint fk_productos
		foreign key (id_producto)
		references productos(id),
	constraint fk_factura
		foreign key (id_factura)
		references facturas(id)
	);