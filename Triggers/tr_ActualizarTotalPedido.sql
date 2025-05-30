DELIMITER $$

CREATE TRIGGER TRG_ActualizarTotalPedido
AFTER INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(cantidad * precio_unitario)
    INTO v_total
    FROM detalles_pedido
    WHERE pedido_id = NEW.pedido_id;

    UPDATE pedidos
    SET total = v_total
    WHERE id = NEW.pedido_id;
END$$

DELIMITER ;
