DELIMITER $$

CREATE PROCEDURE SP_CrearPedido (
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_precio_producto DECIMAL(10,2);
    DECLARE v_id_pedido INT;

    -- 1. Verificar stock disponible
    SELECT stock INTO v_stock_actual
    FROM productos
    WHERE id = p_id_producto;

    IF v_stock_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Producto no encontrado.';
    END IF;

    IF v_stock_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Stock insuficiente.';
    END IF;

    -- 2. Insertar nuevo pedido
    INSERT INTO pedidos (cliente_id, estado, total)
    VALUES (p_id_cliente, 'pendiente', 0.00);

    SET v_id_pedido = LAST_INSERT_ID();

    -- 3. Obtener precio del producto
    SELECT precio INTO v_precio_producto
    FROM productos
    WHERE id = p_id_producto;

    -- 4. Insertar detalle del pedido
    INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario)
    VALUES (v_id_pedido, p_id_producto, p_cantidad, v_precio_producto);

    -- 5. Actualizar stock del producto
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id = p_id_producto;
    
END$$

DELIMITER ;
