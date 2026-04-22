SELECT 
    Flujo,
    CASE 
        
        WHEN COUNT(DISTINCT Estado) > 1 AND SUM(CASE WHEN Estado = 'Error' THEN 1 ELSE 0 END) > 0 
            THEN 'Indeterminado'
        
        WHEN COUNT(DISTINCT Estado) > 1 AND SUM(CASE WHEN Estado = 'Error' THEN 1 ELSE 0 END) = 0 
            THEN 'Corriendo'
        --
        ELSE MAX(Estado)
    END AS Estado_General
FROM Procesos
GROUP BY Flujo;


SELECT 
    GROUP_CONCAT(Sintaxis ORDER BY Secuencia SEPARATOR ' ') AS Sintaxis_Completa
FROM Instrucciones;


SELECT 
    CASE WHEN JugadorA < JugadorB THEN JugadorA ELSE JugadorB END AS Player1,
    CASE WHEN JugadorA < JugadorB THEN JugadorB ELSE JugadorA END AS Player2,
    SUM(Puntuacion) AS Marcador
FROM Partidas
GROUP BY Player1, Player2;

CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Costo_Unitario DECIMAL(10, 2)
);

CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY,
    ID_Producto INT,
    Cantidad INT,
    Precio_Venta DECIMAL(10, 2),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

INSERT INTO Productos VALUES (10, 'Laptop', 5000), (20, 'Mouse', 150), (30, 'Monitor', 2000);
INSERT INTO Ventas VALUES (1, 10, 1, 7500), (2, 20, 2, 300), (3, 10, 1, 7200);