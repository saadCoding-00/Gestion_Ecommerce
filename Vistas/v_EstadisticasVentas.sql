CREATE VIEW V_EstadisticasVentas AS
SELECT 
    DATE(fecha_pedido) AS fecha,
    COUNT(id) AS cantidad_pedidos,
    SUM(total) AS total_vendido
FROM 
    pedidos
GROUP BY 
    DATE(fecha_pedido)
ORDER BY 
    fecha DESC;
