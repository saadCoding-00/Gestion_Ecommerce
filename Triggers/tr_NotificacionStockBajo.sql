DELIMITER $$

CREATE TRIGGER TRG_NotificacionStockBajo
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.stock <= 10 AND OLD.stock > 10 THEN
        INSERT INTO alertas_stock_bajo (
            producto_id,
            stock_actual,
            mensaje,
            fecha_alerta
        )
        VALUES (
            NEW.id,
            NEW.stock,
            CONCAT('Alerta de stock: solo quedan ', NEW.stock, ' unidades.'),
            NOW()
        );
    END IF;
END$$

DELIMITER ;
