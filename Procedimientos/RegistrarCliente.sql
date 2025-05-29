DELIMITER $$

CREATE PROCEDURE SP_RegistrarCliente (
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(200)
)
BEGIN
    INSERT INTO clientes (nombre, email, telefono, direccion)
    VALUES (p_nombre, p_email, p_telefono, p_direccion);
END $$

DELIMITER ;

CALL SP_RegistrarCliente('Juan Pérez', 'juan@example.com', '555-1234', 'Calle Falsa 123');
