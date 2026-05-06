WITH VentasAnuales AS (
    SELECT 
        Año, 
        SUM(Cantidad) as Total
    FROM (
        VALUES (2025, 352645), (2024, 165565), (2024, 254654), 
               (2023, 159521), (2023, 251696), (2023, 111894)
    ) AS Datos(Año, Cantidad)
    GROUP BY Año
)
SELECT 
    MAX(CASE WHEN Año = 2025 THEN Total END) AS "2025",
    MAX(CASE WHEN Año = 2024 THEN Total END) AS "2024",
    MAX(CASE WHEN Año = 2023 THEN Total END) AS "2023"
FROM VentasAnuales;
CREATE TABLE ventas_ejemplo (
    año INTEGER,
    cantidad INTEGER
);

INSERT INTO ventas_ejemplo (año, cantidad) VALUES 
(2025, 352645),
(2024, 165565),
(2024, 254654),
(2023, 159521),
(2023, 251696),
(2023, 111894);



SELECT DISTINCT valor 
FROM muestra;


WITH CTE AS (
    SELECT valor, 
           ROW_NUMBER() OVER (PARTITION BY valor ORDER BY valor) as rn
    FROM muestra
)
DELETE FROM CTE WHERE rn > 1;
CREATE TABLE muestra (
    valor INTEGER
);

INSERT INTO muestra (valor) VALUES 
(1), (1), (2), (3), (3), (4);


WITH Grupos AS (
    SELECT 
        Fila, 
        Aplicacion, 
        Estado,
        COUNT(Aplicacion) OVER (ORDER BY Fila) as GrpID
    FROM TablaSucia
)
SELECT 
    Fila, 
    FIRST_VALUE(Aplicacion) OVER (PARTITION BY GrpID ORDER BY Fila) as Aplicacion,
    Estado
FROM Grupos
ORDER BY Fila;
CREATE TABLE registros_apps (
    fila INTEGER PRIMARY KEY,
    aplicacion VARCHAR(50),
    estado VARCHAR(50)
);

INSERT INTO registros_apps (fila, aplicacion, estado) VALUES 
(1, 'Web', 'Aprobado'),
(2, NULL, 'Fallo'),
(3, NULL, 'Fallo'),
(4, NULL, 'Fallo'),
(5, 'App', 'Aprobado'),
(6, NULL, 'Fallo'),
(7, NULL, 'Fallo'),
(8, NULL, 'Aprobado'),
(9, NULL, 'Aprobado'),
(10, 'RESTAPI', 'Fallo'),
(11, NULL, 'Fallo'),
(12, NULL, 'Fallo');