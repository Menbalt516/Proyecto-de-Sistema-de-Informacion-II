use bdsisg;

DELIMITER //

CREATE TRIGGER tr_descontar_stock_venta
AFTER INSERT ON NotaVenta_Material
FOR EACH ROW
BEGIN
    -- Actualiza el stock del material restando la cantidad vendida
    UPDATE Material
    SET stock = stock - NEW.cant
    WHERE cod = NEW.Producto_cod;
END //

DELIMITER ;