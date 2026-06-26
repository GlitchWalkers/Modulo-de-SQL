CREATE TABLE Clientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
edad INT CHECK (edad BETWEEN 18 AND 85) NOT NULL
);

CREATE TABLE Cuentas (
id_cuenta INT PRIMARY KEY,
id_cliente INT NOT NULL,
saldo NUMERIC(10, 2) CHECK (saldo BETWEEN -5000.00 AND 100000.00) NOT NULL,
CONSTRAINT fk_cliente
FOREIGN KEY (id_cliente)
REFERENCES Clientes(id_cliente)
ON DELETE CASCADE -- Si se borra un cliente, sus cuentas se borran (Integridad Referencial)
ON UPDATE CASCADE -- Si se actualiza el id_cliente, se actualiza en Cuentas
);

CREATE SEQUENCE seq_cliente_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cuenta_id START WITH 1 INCREMENT BY 1;

INSERT INTO Clientes (id_cliente, nombre, edad)
	VALUES (1, 'Ana García', 78);
INSERT INTO Clientes (id_cliente, nombre, edad) 
	VALUES (2, 'Luis Pérez', 25);
INSERT INTO Clientes (id_cliente, nombre, edad) 
	VALUES (3, 'Maria Soto', 40);
INSERT INTO Clientes (id_cliente, nombre, edad) 
	VALUES (4, 'Carlos Ruiz', 80); -- Cliente con más edad
INSERT INTO Clientes (id_cliente, nombre, edad)
	VALUES (5, 'Elena Torres', 32);

-- Cuentas para Cliente 1 (Ana): 3 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (101, 1, 50000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (102, 1, -1200.50); -- Saldo Negativo
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (103, 1, 100.00);
-- Cuentas para Cliente 2 (Luis): 2 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (201, 2, 850.75);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (202, 2, -500.00); -- Saldo Negativo
-- Cuentas para Cliente 3 (Maria): 4 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (301, 3, 15000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (302, 3, 200.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (303, 3, -4999.99); -- Saldo Negativo
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (304, 3, 75000.00);
-- Cuentas para Cliente 4 (Carlos - Cliente con más edad): 3 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (401, 4, 1000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (402, 4, 2000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (403, 4, 3000.00);
-- Cuentas para Cliente 5 (Elena): 3 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (501, 5, 50.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (502, 5, 120.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES (503, 5, 900.00);

-- 3. Listar el saldo de cada cuenta del cliente con más años de edad.
Select cli.edad, cli.nombre, cuen.saldo
from Clientes as cli, Cuentas as cuen
where 
	edad = (select max(edad) from Clientes)
and
	cli.id_cliente = cuen.id_cliente;
	
-- 4. Listar el promedio de edad de los clientes con saldo negativo.
Select avg(cuen.saldo)
from Clientes as cli, Cuentas as cuen
where 
	saldo < 0
and
	cli.id_cliente = cuen.id_cliente;

-- 5. Listar el nombre y cantidad de cuentas de quienes tienen más de una.
Select cli.nombre, count(cuen.saldo) as "Numero de Cuentas"
from Clientes as cli, Cuentas as cuen
where 
	cli.id_cliente = cuen.id_cliente
group by cli.nombre
having count(cuen.saldo) > 1

-- 6. Listar el saldo combinado (suma) de cada cliente con más de una cuenta.
Select cli.nombre, sum(cuen.saldo) as "Saldo en Cuentas"
from Clientes as cli, Cuentas as cuen
where 
	cli.id_cliente = cuen.id_cliente
group by cli.nombre;

-- 7. Listar todos los clientes y su saldo combinado de todos aquellos clientes que tengan al menos una cuenta con saldo negativo.
Select cli.nombre, sum(cuen.saldo) as "Saldo en Cuentas"
from Clientes as cli join Cuentas as cuen
on
	cli.id_cliente = cuen.id_cliente
where exists 
	(select * from Cuentas as cuen where cli.id_cliente = cuen.id_cliente and cuen.saldo < 0)
group by cli.nombre, cli.id_cliente



-- Creacion de Nuevo y Cuentas

INSERT INTO Clientes (id_cliente, nombre, edad)
	VALUES (6, 'Pablo Aspee', 38);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) 
	VALUES(601, 6, 45000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo)
VALUES(602, 6, -5000.00);

-- 3. Update
update Cuentas
set saldo = 0
where id_cliente = 6

-- 3. Delete
delete from Cuentas
where 	id_cliente = 6
	and
		id_cuenta = 602

select * from cuentas as cuen join clientes as cli on cuen.id_cliente = cli.id_cliente