use bdsisg;

ALTER TABLE NotaVenta_Material
ADD COLUMN descuentoProducto DECIMAL(5, 2) DEFAULT 0.00 AFTER precioUnidad, -- Añade una columna para el descuento del producto (ej. 5.2 para 99.99%)
MODIFY COLUMN subtotal DECIMAL(10, 2) NOT NULL; -- Cambia subtotal a DECIMAL(10,2) para precisión monetaria

-- Modificación de la tabla NotaVenta para cambiar el tipo de dato de total y porcdescuento a DECIMAL
ALTER TABLE NotaVenta
MODIFY COLUMN total DECIMAL(10, 2) NOT NULL,
MODIFY COLUMN porcdescuento DECIMAL(5, 2) DEFAULT 0.00;

-- Modificación de la tabla Material para cambiar el tipo de dato de precioCompra y precioVenta a DECIMAL
ALTER TABLE Material
MODIFY COLUMN precioCompra DECIMAL(10, 2) NOT NULL,
MODIFY COLUMN precioVenta DECIMAL(10, 2) NOT NULL;