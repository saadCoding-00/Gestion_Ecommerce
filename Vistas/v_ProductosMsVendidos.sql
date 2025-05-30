CREATE VIEW V_ProductosMasVendidos AS
SELECT 
    p.id AS producto_id,
    p.nombre,
    SUM(dp.cantidad) AS total_vendido
FROM 
    detalles_pedido dp
JOIN 
    productos p ON dp.producto_id = p.id
GROUP BY 
    p.id, p.nombre
ORDER BY 
    total_vendido DESC;
