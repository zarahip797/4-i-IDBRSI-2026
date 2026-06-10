
WITH RECURSIVE Permutaciones AS 
    SELECT 
        Caso AS Permutacion,
        Caso AS Senda,
        1 AS Nivel
    FROM TablaPrueba
    
    UNION ALL
    
   
    SELECT 
        p.Permutacion || ',' || t.Caso,
        p.Senda || t.Caso,
        p.Nivel + 1
    FROM Permutaciones p
    JOIN TablaPrueba t ON p.Senda NOT LIKE '%' || t.Caso || '%'
)
SELECT Permutacion 
FROM Permutaciones 
WHERE Nivel = (SELECT COUNT(*) FROM TablaPrueba);
CREATE TABLE TablaPrueba (
    Caso CHAR(1) PRIMARY KEY
);


CREATE TABLE TablaFlujo (
    Desarrollo VARCHAR(50),
    Terminacion DATE
);


CREATE TABLE TablaInventario (
    Fecha DATE PRIMARY KEY,
    Ajuste INT
);


SELECT 
    Desarrollo,
    AVG(DiasDiferencia) AS Promedio
FROM (
    SELECT 
        Desarrollo,
        Terminacion - LAG(Terminacion) OVER (PARTITION BY Desarrollo ORDER BY Terminacion) AS DiasDiferencia
    FROM TablaFlujo
) Subconsulta
WHERE DiasDiferencia IS NOT NULL
GROUP BY Desarrollo;
-- Datos Ejercicio 1
INSERT INTO TablaPrueba (Caso) VALUES ('A'), ('B'), ('C');

-- Datos Ejercicio 2
INSERT INTO TablaFlujo (Desarrollo, Terminacion) VALUES 
('RestAPI', '2024-01-06'), ('RestAPI', '2024-06-14'), ('RestAPI', '2024-06-15'),
('Web', '2024-01-06'), ('Web', '2024-02-06'), ('Web', '2024-06-19'),
('App', '2024-01-06'), ('App', '2024-05-15'), ('App', '2024-06-30');


INSERT INTO TablaInventario (Fecha, Ajuste) VALUES 
('2025-01-03', 100),
('2025-01-04', 75),
('2025-01-05', -150),
('2025-01-06', 50),
('2025-01-07', -70);

SELECT 
    Fecha,
    Ajuste,
    SUM(Ajuste) OVER (ORDER BY Fecha ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Inventario
FROM TablaInventario
ORDER BY Fecha;
SELECT 
    Desarrollo,
    AVG(DiasEntre) AS Promedio
FROM (
    SELECT 
        Desarrollo,
        Terminacion - LAG(Terminacion) OVER (PARTITION BY Desarrollo ORDER BY Terminacion) AS DiasEntre
    FROM TablaFlujo
) AS Sub
WHERE DiasEntre IS NOT NULL
GROUP BY Desarrollo;
