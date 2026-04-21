
CREATE TABLE Departamentos (
    ID_Depto INT PRIMARY KEY,
    Nombre_Depto VARCHAR(50)
);

CREATE TABLE Empleados (
    ID_Emp INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Salario DECIMAL(10,2),
    ID_Depto INT
);


INSERT INTO Departamentos VALUES (1, 'Ventas'), (2, 'TI'), (3, 'Marketing');

INSERT INTO Empleados VALUES 
(10, 'Ana', 3000, 1),
(11, 'Luis', 2500, 1),
(12, 'Marta', 6000, 2),
(13, 'Pepe', 1500, 3);


SELECT 
    d.Nombre_Depto, 
    COUNT(e.ID_Emp) AS Total_Empleados, 
    SUM(e.Salario) AS Gasto_Total
FROM Departamentos d
JOIN Empleados e ON d.ID_Depto = e.ID_Depto
GROUP BY d.Nombre_Depto
HAVING SUM(e.Salario) > 5000;


CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY,
    Nombre_Producto VARCHAR(50),
    Precio_Unitario DECIMAL(10,2)
);

CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY,
    ID_Producto INT,
    Cantidad INT,
    Fecha_Venta DATE,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);


INSERT INTO Productos VALUES 
(501, 'Laptop', 800), 
(502, 'Mouse', 20), 
(503, 'Teclado', 50);

INSERT INTO Ventas VALUES 
(1, 501, 2, '2024-03-10'),
(2, 502, 5, '2024-03-15'),
(3, 501, 1, '2024-04-01'), 
(4, 503, 30, '2024-03-20'); 


SELECT 
    p.Nombre_Producto, 
    SUM(v.Cantidad * p.Precio_Unitario) AS Total_Ingresos
FROM Productos p
JOIN Ventas v ON p.ID_Producto = v.ID_Producto
WHERE v.Fecha_Venta BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY p.Nombre_Producto
HAVING SUM(v.Cantidad * p.Precio_Unitario) > 1000;
