WITH RECURSIVE Desagrupar AS (
    -- Caso base: Seleccionamos los productos con su cantidad original
    SELECT Producto, Cantidad, 1 AS Iteracion
    FROM Inventario
    UNION ALL
    -- Caso recursivo: Repetimos la fila restando 1 a la iteración
    SELECT Producto, Cantidad, Iteracion + 1
    FROM Desagrupar
    WHERE Iteracion < Cantidad
)
SELECT Producto, 1 AS Cantidad
FROM Desagrupar
ORDER BY Producto DESC;


SELECT 
    inicio + 1 AS espacio_inicio, 
    fin - 1 AS espacio_final,
    (fin - inicio - 1) AS disponibles
FROM (
    SELECT 
        num_asiento AS inicio, 
        LEAD(num_asiento) OVER (ORDER BY num_asiento) AS fin
    FROM asientos
) AS saltos
WHERE fin - inicio > 1;



WITH InicioGrupos AS (
    SELECT *,
           -- Si el inicio actual es mayor al máximo final anterior, es una nueva isla
           CASE WHEN Inicio > MAX(Final) OVER (ORDER BY Inicio ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
                THEN 1 ELSE 0 END AS es_nuevo_grupo
    FROM Periodos
),
IdentificadorGrupos AS (
    SELECT *,
           SUM(es_nuevo_grupo) OVER (ORDER BY Inicio) AS grupo_id
    FROM InicioGrupos
)
SELECT 
    MIN(Inicio) AS Inicio, 
    MAX(Final) AS Final
FROM IdentificadorGrupos
GROUP BY grupo_id;



CREATE TABLE Periodos (
    Inicio DATE,
    Final DATE);

INSERT INTO Periodos (Inicio, Final) VALUES 
('2025-01-01', '2025-01-05'),
('2025-01-03', '2025-01-09'),
('2025-01-10', '2025-01-11'),
('2025-01-12', '2025-01-16'),
('2025-01-15', '2025-01-19');

WITH MarcarInicios AS (
    SELECT 
        Inicio, 
        Final,
        
        CASE WHEN Inicio > MAX(Final) OVER (ORDER BY Inicio ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) 
             THEN 1 ELSE 0 END AS es_nuevo_grupo
    FROM Periodos
),
AgruparIslas AS (
    SELECT 
        Inicio, 
        Final,
        SUM(es_nuevo_grupo) OVER (ORDER BY Inicio) AS grupo_id
    FROM MarcarInicios
)
SELECT 
    MIN(Inicio) AS Inicio, 
    MAX(Final) AS Final
FROM AgruparIslas
GROUP BY grupo_id
ORDER BY Inicio;