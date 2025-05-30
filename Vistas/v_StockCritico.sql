CREATE VIEW V_StockCritico AS
SELECT 
    id AS producto_id,
    nombre,
    stock
FROM 
    productos
WHERE 
    stock <= 5;
