# Gestion_Ecommerce
Sistema de Gestión de Base de Datos para E-Commerce
1. Objetivos
Desarrollar un sistema completo de gestión de base de datos para una tienda online, implementando todas las funcionalidades necesarias mediante SQL, procedimientos almacenados, triggers y vistas.
2. Modelo de Datos
2.1 Tablas Principales
-Productos
Campo
ID_Producto
Nombre
Descripcion
Precio
ID_Categoria
Stock
-Categorias
Campo
ID_Categoria
Nombre
Descripcion
-Clientes
Campo
ID_Cliente
Nombre
Email
Telefono
Direccion
-Pedidos
Campo
ID_Pedido
ID_Cliente
Fecha_Pedido
Estado
Total
3. Requisitos de Implementación
3.1 Procedimientos Almacenados
SP_RegistrarCliente( IN p_nombre VARCHAR(100), IN p_email VARCHAR(100), IN p_telefono VARCHAR(15), IN p_direccion VARCHAR(200) )
SP_CrearPedido( IN p_id_cliente INT, IN p_id_producto INT, IN p_cantidad INT )
SP_ActualizarStock( IN p_id_producto INT, IN p_cantidad INT )
SP_CalcularTotalPedido( IN p_id_pedido INT, OUT p_total DECIMAL(10,2) )
SP_GenerarReporteVentas( IN p_fecha_inicio DATE, IN p_fecha_fin DATE )
3.2 Triggers
TRG_ControlStock: Verifica stock antes de insertar en Detalles_Pedido
TRG_ActualizarTotalPedido: Actualiza el total del pedido
TRG_RegistroHistorico: Registra cambios en precios de productos
TRG_NotificacionStockBajo: Genera alerta cuando el stock es bajo
3.3 Vistas
V_ProductosMasVendidos
V_ClientesPreferenciales
V_EstadisticasVentas
V_StockCritico
