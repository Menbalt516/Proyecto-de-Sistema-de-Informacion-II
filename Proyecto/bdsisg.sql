CREATE DATABASE IF NOT EXISTS bdsisg;
USE bdsisg;

-- Tabla: Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    ci INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(120) NOT NULL,
    nit INT,
    nroCel INT,
    direccion VARCHAR(150)
);

-- Tabla: Vendedor
CREATE TABLE IF NOT EXISTS Vendedor (
    ci INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(120) NOT NULL,
    correo VARCHAR(50) UNIQUE,
    fechaVic DATE, -- Asumiendo que es una fecha simple (YYYY-MM-DD)
    nroCel INT,
    direccion VARCHAR(150)
);

-- Tabla: NotaVenta
CREATE TABLE IF NOT EXISTS NotaVenta (
    nro INT AUTO_INCREMENT PRIMARY KEY,
    fechaHora DATETIME NOT NULL,
    total FLOAT NOT NULL, -- FLOAT puede ser problemático para dinero, DECIMAL es mejor si la precisión es crítica
    porcdescuento FLOAT DEFAULT 0.0,
    Cliente_ci INT NOT NULL,
    Vendedor_ci INT NOT NULL,
    FOREIGN KEY (Cliente_ci) REFERENCES Cliente(ci),
    FOREIGN KEY (Vendedor_ci) REFERENCES Vendedor(ci)
);

-- Tabla: Clasificacion
CREATE TABLE IF NOT EXISTS Clasificacion (
    nro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla: Material
CREATE TABLE IF NOT EXISTS Material (
    cod INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    unidad VARCHAR(20),
    marca VARCHAR(30),
    industria VARCHAR(20),
    calidad VARCHAR(20),
    precioCompra FLOAT NOT NULL,
    precioVenta FLOAT NOT NULL,
    fechaVenc DATE, -- Fecha de vencimiento, puede ser NULL si no aplica
    stock INT NOT NULL DEFAULT 0,
    Clasificacion_nro INT,
    FOREIGN KEY (Clasificacion_nro) REFERENCES Clasificacion(nro)
);

-- Tabla: NotaVenta_Material (Tabla de relación muchos a muchos entre NotaVenta y Material)
CREATE TABLE IF NOT EXISTS NotaVenta_Material (
    notaventa_material INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria propia para la tabla de relación
    NotaVenta_nro INT NOT NULL, -- Clave foránea que referencia a NotaVenta
    Producto_cod INT NOT NULL, -- Clave foránea que referencia a Material
    cant INT NOT NULL,
    precioUnidad FLOAT NOT NULL,
    subtotal FLOAT NOT NULL,
    FOREIGN KEY (NotaVenta_nro) REFERENCES NotaVenta(nro) ON DELETE CASCADE,
    FOREIGN KEY (Producto_cod) REFERENCES Material(cod) ON DELETE CASCADE,
    UNIQUE (NotaVenta_nro, Producto_cod) -- Para asegurar que una combinación de NotaVenta y Material sea única
);

-- Tabla: DevolucionMaterial
CREATE TABLE IF NOT EXISTS DevolucionMaterial (
    nro INT AUTO_INCREMENT PRIMARY KEY,
    fechaHora DATETIME NOT NULL,
    motivo VARCHAR(255),
    NotaVenta_nro INT NOT NULL, -- Clave foránea que referencia a NotaVenta
    FOREIGN KEY (NotaVenta_nro) REFERENCES NotaVenta(nro)
);

-- Tabla: DevolucionMaterial_Producto (Tabla de relación muchos a muchos entre DevolucionMaterial y Material)
CREATE TABLE IF NOT EXISTS DevolucionMaterial_Producto (
    devolucionmaterial_producto INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria propia para la tabla de relación
    DevolucionMaterial_nro INT NOT NULL, -- Clave foránea que referencia a DevolucionMaterial
    Producto_cod INT NOT NULL, -- Clave foránea que referencia a Material
    cant INT NOT NULL,
    observacion VARCHAR(255),
    FOREIGN KEY (DevolucionMaterial_nro) REFERENCES DevolucionMaterial(nro) ON DELETE CASCADE,
    FOREIGN KEY (Producto_cod) REFERENCES Material(cod) ON DELETE CASCADE,
    UNIQUE (DevolucionMaterial_nro, Producto_cod) -- Para asegurar que una combinación de DevolucionMaterial y Material sea única
);