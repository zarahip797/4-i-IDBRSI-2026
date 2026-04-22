SELECT 
    NTILE(2) OVER (ORDER BY Marcador DESC) AS Categoria,
    Id_jugador,
    Marcador
FROM Jugadores
ORDER BY Categoria ASC, Marcador DESC;


SELECT 
    Id_orden, 
    Id_cliente, 
    Fecha, 
    Cantidad, 
    Estado
FROM Ordenes
ORDER BY Id_orden
OFFSET 4 ROWS FETCH NEXT 6 ROWS ONLY;


WITH ConteoPedidos AS (
    SELECT 
        Id_cliente, 
        Proveedor, 
        COUNT(*) as Total,
        ROW_NUMBER() OVER (PARTITION BY Id_cliente ORDER BY COUNT(*) DESC) as Ranking
    FROM Compras
    GROUP BY Id_cliente, Proveedor
)
SELECT 
    Id_cliente, 
    Proveedor
FROM ConteoPedidos
WHERE Ranking = 1;

CREATE TABLE Jugadores (
    Id_jugador INT PRIMARY KEY,
    Marcador INT
);

INSERT INTO Jugadores VALUES (1001, 2343), (2002, 9432), (3003, 6548), (4004, 1054), (5005, 6832);

CREATE TABLE Ordenes (
    Id_orden INT PRIMARY KEY,
    Id_cliente INT,
    Fecha DATE,
    Cantidad VARCHAR(10),
    Estado VARCHAR(10)
);

INSERT INTO Ordenes VALUES 
(1, 1001, '2025-01-01', '$100', 'JAL'), (2, 3003, '2025-01-01', '$100', 'COL'),
(3, 1001, '2025-01-03', '$100', 'JAL'), (4, 2002, '2025-01-02', '$150', 'JAL'),
(5, 1001, '2025-01-02', '$100', 'JAL'), (6, 4004, '2025-01-05', '$50', 'COL'),
(7, 1001, '2025-01-01', '$150', 'JAL'), (8, 3003, '2025-01-03', '$100', 'COL'),
(9, 4004, '2025-01-04', '$100', 'COL'), (10, 1001, '2025-01-01', '$75', 'JAL'),
(11, 2002, '2025-01-02', '$75', 'JAL'), (12, 3003, '2025-01-02', '$100', 'COL'),
(13, 4004, '2025-01-05', '$100', 'COL');


CREATE TABLE Compras (
    Id_orden INT PRIMARY KEY,
    Id_cliente INT,
    Cantidad INT,
    Proveedor VARCHAR(50)
);

INSERT INTO Compras VALUES 
(1, 1001, 12, 'IBM'), (2, 1001, 54, 'IBM'), (3, 1001, 32, 'Amazon'),
(4, 2002, 7, 'Amazon'), (5, 2002, 16, 'Amazon'), (6, 2002, 5, 'IBM');

SELECT 
    NTILE(2) OVER (ORDER BY Marcador DESC) AS Categoria,
    Id_jugador,
    Marcador
FROM Jugadores
ORDER BY Categoria;

---


SELECT *
FROM Ordenes
ORDER BY Id_orden
OFFSET 4 ROWS FETCH NEXT 6 ROWS ONLY;

---


WITH RankingProveedores AS (
    SELECT 
        Id_cliente, 
        Proveedor, 
        COUNT(*) as Total_Pedidos,
        ROW_NUMBER() OVER (PARTITION BY Id_cliente ORDER BY COUNT(*) DESC) as Posicion
    FROM Compras
    GROUP BY Id_cliente, Proveedor
)
SELECT Id_cliente, Proveedor
FROM RankingProveedores
WHERE Posicion = 1;