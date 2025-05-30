DELIMITER $$

CREATE PROCEDURE SP_CalcularTotalPedido (
IN p_id_pedido INT,
OUT p_total DECIMAL(10,2)
)
BEGIN
DECLARE v_total DECIMAL(10,2);

-- Calcular el total: SUM(cantidad × precio_unitario)
SELECT SUM(cantidad * precio_unitario)
INTO v_total
FROM detalles_pedido
WHERE pedido_id = p_id_pedido;

-- Verificar si el pedido existe
IF v_total IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Pedido no encontrado o sin detalles.';
END IF;

-- Actualizar el total en la tabla pedidos
UPDATE pedidos
SET total = v_total
WHERE id = p_id_pedido;

-- Asignar a parámetro OUT
SET p_total = v_total;
END $$

DELIMITER ;