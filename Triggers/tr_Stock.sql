DELIMITER $$

DROP TRIGGER if EXISTS tr_detalle_pedido_before_insert$$
CREATE TRIGGER tr_detalle_pedido_before_insert
BEFORE INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE v_stock_actual INT;
    
    -- Verificar stock
    SELECT stock INTO v_stock_actual
    FROM productos
    WHERE id = NEW.producto_id;
    
    IF v_stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Stock insuficiente';
    END IF;
END $$
DELIMITER ;