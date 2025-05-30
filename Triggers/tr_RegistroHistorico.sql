DELIMITER $$

DROP TRIGGER if EXISTS tr_productos_after_update$$
CREATE TRIGGER tr_productos_after_update
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio != NEW.precio THEN
        INSERT INTO historial_precios 
        (producto_id, usuario, operacion, precio_anterior, precio_anterior, fecha_cambio)
        VALUES
        (NEW.id, CURRENT_USER(), NOW(), 'UPDATE', OLD.precio, NEW.precio);
    END IF;
END $$

DROP TRIGGER if EXISTS tr_productos_before_update$$
CREATE TRIGGER tr_productos_before_update
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.precio IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Precio no puede ser 0';
    END IF;

END $$

DELIMITER ;