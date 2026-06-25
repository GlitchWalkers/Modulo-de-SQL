-- 1. A quien le debe mas dinero y Cuanto
SELECT 		nombre, le_debo
FROM 		finanzas_personales
order by	le_debo desc
limit		1

-- 2. Quien le debe mas dinero a usted y cuanto
SELECT		nombre, me_debe
FROM		finanzas_personales
order by 	me_debe desc
limit 		1

-- 3. Cuanto dinero debe en total
SELECT 		sum(le_debo) as "Deuda Total"
FROM		finanzas_personales

-- 4. Cuanto dinero debe en promedio
SELECT 		avg(le_debo) as "Deuda Promedio"
FROM		finanzas_personales

-- 5. Cuantos meses demora en pagar todo, con una cuota mensual
SELECT 		sum(cuotas_pagar) as "Meses Restantes"
FROM		finanzas_personales

-- 6. Cobrando todo un mismo dia.
-- Cuanto seria la deuda reducida 
-- Cuanto deberia pagar en promedio mensualmente

SELECT 		sum(le_debo - me_debe) as "Deuda Actualizada", sum(le_debo - me_debe)/sum(cuotas_pagar) as "Promedio de pago"
FROM		finanzas_personales

-- 7. Insertar nuevo registro
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('pareja', 0, 0, 50000, 1);

Select *
from finanzas_personales

-- 8. Valor cuota mes
SELECT 		sum(le_debo/cuotas_pagar) "Valor cuota actualizado"
FROM		finanzas_personales
where le_debo > 0

-- 9. Update Tabla
UPDATE finanzas_personales
SET cuotas_pagar = 13
where cuotas_pagar = 2;

-- 10. Nuevo valor de cuota
SELECT 		sum(le_debo/cuotas_pagar) "Valor cuota actualizado"
FROM		finanzas_personales
where le_debo > 0