DELIMITER $$

CREATE PROCEDURE SP_GenerarReporteVentas (
IN p_fecha_inicio DATE,
IN p_fecha_fin DATE
)
BEGIN
-- Selección del reporte de ventas por producto
SELECT
dp.producto_id,
pr.nombre AS nombre_producto,
SUM(dp.cantidad) AS total_vendido,
SUM(dp.cantidad * dp.precio_unitario) AS total_ingresos
FROM pedidos p
INNER JOIN detalles_pedido dp ON p.id = dp.pedido_id
INNER JOIN productos pr ON pr.id = dp.producto_id
WHERE p.fecha_pedido BETWEEN p_fecha_inicio AND p_fecha_fin
AND p.estado = 'completado' -- opcional: solo pedidos finalizados
GROUP BY dp.producto_id, pr.nombre
ORDER BY total_ingresos DESC;
END $$

DELIMITER ;