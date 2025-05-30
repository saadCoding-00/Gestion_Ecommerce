CREATE VIEW V_ClientesPreferenciales AS
SELECT 
    c.id AS cliente_id,
    c.nombre,
    c.email,
    COUNT(p.id) AS cantidad_pedidos,
    SUM(p.total) AS total_gastado
FROM 
    clientes c
JOIN 
    pedidos p ON c.id = p.cliente_id
GROUP BY 
    c.id, c.nombre, c.email
HAVING 
    SUM(p.total) > 10;  
