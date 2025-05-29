DELIMITER $$

CREATE PROCEDURE SP_ActualizarStock (
IN p_id_producto INT,
IN p_cantidad INT
)
BEGIN
DECLARE v_stock_actual INT;
DECLARE v_nuevo_stock INT;
-- 1. Verificar existencia del producto y obtener su stock actual
SELECT stock INTO v_stock_actual
FROM productos
WHERE id = p_id_producto;

IF v_stock_actual IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Producto no encontrado.';
END IF;

-- 2. Calcular nuevo stock
SET v_nuevo_stock = v_stock_actual + p_cantidad;

-- 3. Validar que el stock no quede negativo
IF v_nuevo_stock < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El stock no puede ser negativo.';
END IF;

-- 4. Actualizar el stock
UPDATE productos
SET stock = v_nuevo_stock
WHERE id = p_id_producto;

END$$

DELIMITER ;