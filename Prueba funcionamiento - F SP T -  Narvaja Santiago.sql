-- Prueba del funcionamiento de la function recategorizacion_rfm_clientes. Esta toma como parametro el id del cliente y analiza su ticket promedio para realizar la recategorizacion. 
-- La idea de este script es comparar el segmento anterior y cual seria la recategorizacion. Tambien se muestra el ticket promedio para ver como la recategorizacion impacta segun su valor.
USE sql_coderhouse_narvaja_santiago;
SELECT pc.id_cliente , pc.segmento_RFM , TRUNCATE( (vpc.ventas_por_cliente / vpc.cantidad_compras) , 3) AS ticket_promedio , recategorizacion_rfm_clientes(pc.id_cliente) AS recategorizacion 
FROM sql_coderhouse_narvaja_santiago.perfil_clientes AS pc
INNER JOIN sql_coderhouse_narvaja_santiago.ventas_por_clientes AS vpc ON pc.id_cliente = vpc.id_cliente;

-- Muestra del funcionamiento de la function donde_compra. Toma como parametro el id del cliente y concatena todas las sucursales donde realizo una compra. La fuente de informacion para esta function es la vista detalle_compras
-- Toma el id_clientes desde la tabla perfil_clientes y busca en detalle compra cuales fueron las sucursales donde realizaron la compra, si es que compraron. 
USE sql_coderhouse_narvaja_santiago;
SELECT id_cliente , donde_compra(id_cliente) AS sucursales
FROM sql_coderhouse_narvaja_santiago.perfil_clientes;


-- Prueba funcionamiento del SP basado en compras y orden descendente
USE sql_coderhouse_narvaja_santiago;
CALL rendimiento_sucursales('compras','d');

-- Prueba funcionamiento del SP basado en compras y orden ascendente
USE sql_coderhouse_narvaja_santiago;
CALL rendimiento_sucursales('compras','a');

-- Prueba funcionamiento del SP basado en clientes y orden descendente
USE sql_coderhouse_narvaja_santiago;
CALL rendimiento_sucursales('clientes','d');

-- Prueba funcionamiento del SP basado en clientes y orden ascendente
USE sql_coderhouse_narvaja_santiago;
CALL rendimiento_sucursales('clientes','a');

-- Prueba funcionamiento del SP basado en la sucrusal y orden descendente
USE sql_coderhouse_narvaja_santiago;
CALL rendimiento_sucursales('sucursal','d');

-- Prueba funcionamiento del SP basado en la sucrusal y orden ascendente
USE sql_coderhouse_narvaja_santiago;
CALL rendimiento_sucursales('sucursal','a');

-- Prueba funcionamiento del SP que inserta sucursales, agregando un ejemplo en el cual no exites region en los registros actuales
-- Muestra de tabla donde impacta el SP para control
USE sql_coderhouse_narvaja_santiago;
SELECT * FROM sql_coderhouse_narvaja_santiago.sucursales; 
-- Uso del SP
CALL update_suc('Sur','Patagonia');
SELECT * FROM sql_coderhouse_narvaja_santiago.sucursales; 

-- Prueba funcionamiento del SP que inserta sucursales, agregando un ejemplo en el cual existe la region en los registros actuales y se agrega una nueva sucrusal
-- Muestra de tabla donde impacta el SP para control
USE sql_coderhouse_narvaja_santiago;
SELECT * FROM sql_coderhouse_narvaja_santiago.sucursales; 
-- USo del SP
CALL update_suc('Centro','Rio IV');
SELECT * FROM sql_coderhouse_narvaja_santiago.sucursales; 

-- Muestra de las tablas donde impactan los TRIGGERS after y before update a la tabla ARTICULOS
SELECT * FROM sql_coderhouse_narvaja_santiago.bitacora_precio_articulos;
SELECT * FROM sql_coderhouse_narvaja_santiago.logs;

-- Prueba del funcionamiento del TRIGGER en la tabla ARTICULOS. En LOG registra el tipo de cambio y en BITACORA_PRECIO_ARTICULOS el precio anterior y el precio nuevo
UPDATE sql_coderhouse_narvaja_santiago.articulos
SET precio = 217
WHERE id_articulo = 117;

-- Muestra de las tablas donde impactan los TRIGGERS after y before update a la tabla ARTICULOS_EN_PROMOCION
SELECT * FROM sql_coderhouse_narvaja_santiago.bitacora_articulos_promo;
SELECT * FROM sql_coderhouse_narvaja_santiago.logs;

-- Prueba del funcionamineto del TRIGGER solo actualizando el porcentaje de descuento en la tabla ARTICULOS_EN_PROMOCION
UPDATE sql_coderhouse_narvaja_santiago.articulos_en_promocion
SET porcentaje_descuento = 0.3
WHERE id_articulo = 99410;

-- Muestra de que el TRIGGER registra la accion identificando cambio en el porcentaje de descuento y en el tope
UPDATE sql_coderhouse_narvaja_santiago.articulos_en_promocion
SET porcentaje_descuento = 0.3 , tope_descuento = 750
WHERE id_articulo = 469230;


