-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS gestion_ecommerce;
USE gestion_ecommerce;

-- Eliminar tablas si existen
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS detalles_pedido;


-- Crear tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT ,
    precio DECIMAL(4,2),
    categoria_id INT,
    stock INT,    
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Crear tabla categorias
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Crear Tabla de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(25),
    direccion VARCHAR(50)
);
-- Tabla de pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20),
    total DECIMAL(4,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabla de detalles de pedido
CREATE TABLE detalles_pedido (
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    PRIMARY KEY (pedido_id, producto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla para el trigger tr_RegistroHistorico
CREATE TABLE historial_precios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    usuario VARCHAR(50) NOT NULL,
    operacion VARCHAR(20) NOT NULL,
    precio_anterior DECIMAL(4,2),
    precio_nuevo DECIMAL(4,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla para el trigger tr_NotificacionStockBajo
CREATE TABLE alertas_stock_bajo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    stock_actual INT,
    mensaje VARCHAR(255),
    fecha_alerta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);



-- Insertar datos en productos
INSERT INTO productos (nombre, descripcion, precio, categoria_id, stock) VALUES
('Auriculares Bluetooth', 'Auriculares inalámbricos con micrófono', 29.99, 1, 100),
('Camiseta', 'Camiseta de algodón, talla M', 12.50, 2, 50),
('Caja de cereales', 'Cereal integral de avena', 3.75, 3, 200);

-- Insertar datos en categorias
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Dispositivos electrónicos'),
('Ropa', 'Vestimenta para todas las edades'),
('Alimentos', 'Comestibles y productos perecederos');

-- Insertar datos en clientes
INSERT INTO clientes (nombre, email, telefono, direccion) VALUES
('Carlos Pérez', 'carlos@example.com', '555-1234', 'Av. Siempre Viva 123'),
('Laura Gómez', 'laura@example.com', '555-5678', 'Calle Luna 45');


-- Insertar datos en pedidos
INSERT INTO pedidos (cliente_id, estado, total) VALUES
(1, 'pendiente', 42.49),
(2, 'completado', 3.75);

-- Insertar datos en detalles_pedido
INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 29.99),  
(1, 2, 1, 12.50),  
(2, 3, 1, 3.75);   

-- Comentarios explicativos
/*
Este script crea:
1. Una base de datos para gestionar un sistema de comercio electrónico.
2. Las tablas necesarias para representar productos, clientes, pedidos y categorías.
3. Relaciones entre las tablas mediante claves foráneas para asegurar integridad referencial.
4. Triggers previstos para control histórico de precios y notificaciones de stock bajo.
5. Datos de ejemplo suficientes para probar la lógica de inserciones y relaciones.

Tablas principales:
- productos: Contiene el catálogo de productos con nombre, descripción, precio, stock y categoría.
- categorias: Define las categorías de los productos (como Electrónica, Ropa, Alimentos).
- clientes: Guarda los datos personales y de contacto de los clientes.
- pedidos: Registra cada pedido realizado por los clientes, incluyendo estado y total.
- detalles_pedido: Desglosa cada producto incluido en un pedido, con cantidad y precio unitario.

Tablas auxiliares para futura automatización:
- historial_precios: Está diseñada para almacenar los cambios de precio de un producto, quién lo hizo y cuándo.
- alertas_stock_bajo: Pensada para registrar alertas cuando el stock de un producto baja de cierto umbral.

Los datos de ejemplo incluyen:
- 3 productos de distintas categorías
- 3 categorías con descripciones
- 2 clientes con información de contacto
- 2 pedidos (uno pendiente y otro completado)
- Detalles de productos incluidos en cada pedido

Este diseño permite:
- Consultar productos por categoría
- Ver los pedidos realizados por cada cliente
- Calcular el total de cada pedido y su detalle
- Implementar fácilmente triggers para auditoría de precios y alertas de stock
*/

