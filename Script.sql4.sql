
CREATE TABLE precios_historicos (
    id_producto INT,
    fecha DATE,
    precio DECIMAL(10,2)
);

INSERT INTO precios_historicos VALUES 
(1001, '2025-01-01', 19.99),
(1001, '2025-04-15', 59.99),
(1001, '2025-06-08', 79.99),
(2002, '2025-04-17', 39.99),
(2002, '2025-05-19', 59.99);

WITH UltimosPrecios AS (
    SELECT *, 
           ROW_NUMBER() OVER(PARTITION BY id_producto ORDER BY fecha DESC) as posicion
    FROM precios_historicos
)
SELECT id_producto, fecha, precio
FROM UltimosPrecios
WHERE posicion = 1;
-- --- EJERCICIO 1: Precios de demanda ---
CREATE TABLE precios_historicos (
    id_producto INT,
    fecha DATE,
    precio DECIMAL(10,2)
);

INSERT INTO precios_historicos (id_producto, fecha, precio) VALUES 
(1001, '2025-01-01', 19.99),
(1001, '2025-04-15', 59.99),
(1001, '2025-06-08', 79.99),
(2002, '2025-04-17', 39.99),
(2002, '2025-05-19', 59.99);


-- --- EJERCICIO 2: Promedio de ventas mensuales ---
CREATE TABLE ventas_estados (
    id_orden INT PRIMARY KEY,
    id_cliente INT,
    fecha DATE,
    total INT,
    estado VARCHAR(10)
);

INSERT INTO ventas_estados (id_orden, id_cliente, fecha, total, estado) VALUES 
(1, 1001, '2025-01-01', 100, 'JAL'),
(2, 1001, '2025-01-01', 150, 'JAL'),
(3, 1001, '2025-01-01', 75, 'JAL'),
(4, 1001, '2025-02-01', 100, 'JAL'),
(5, 1001, '2025-03-01', 100, 'JAL'),
(6, 2002, '2025-02-01', 75, 'JAL'),
(7, 2002, '2025-02-01', 150, 'JAL'),
(8, 3003, '2025-01-01', 100, 'CDMX'),
(9, 3003, '2025-02-01', 100, 'CDMX'),
(10, 3003, '2025-03-01', 100, 'CDMX'),
(11, 4004, '2025-04-01', 100, 'CDMX'),
(12, 4004, '2025-05-01', 50, 'CDMX'),
(13, 4004, '2025-05-01', 100, 'CDMX');


CREATE TABLE registros_log (
    proceso VARCHAR(20),
    mensaje VARCHAR(100),
    ocurrencia INT
);

INSERT INTO registros_log (proceso, mensaje, ocurrencia) VALUES 
('Web', 'Error: No se puede dividir por 0', 3),
('RestAPI', 'Error: Fallo la conversión', 5),
('App', 'Error: Fallo la conversión', 7),
('RestAPI', 'Error: Error sin identificar', 9),
('Web', 'Error: Error sin identificar', 1),
('App', 'Error: Error sin identificar', 10),
('Web', 'Estado Completado', 8),



CREATE TABLE ventas_estados (
    id_orden INT,
    id_cliente INT,
    fecha DATE,
    total INT,
    estado VARCHAR(10)
);

INSERT INTO ventas_estados VALUES 
(1, 1001, '2025-01-01', 100, 'JAL'), (2, 1001, '2025-01-01', 150, 'JAL'),
(3, 1001, '2025-01-01', 75, 'JAL'),  (4, 1001, '2025-02-01', 100, 'JAL'),
(5, 1001, '2025-03-01', 100, 'JAL'), (6, 2002, '2025-02-01', 75, 'JAL'),
(7, 2002, '2025-02-01', 150, 'JAL'), (8, 3003, '2025-01-01', 100, 'CDMX'),
(9, 3003, '2025-02-01', 100, 'CDMX'),(10, 3003, '2025-03-01', 100, 'CDMX'),
(11, 4004, '2025-04-01', 100, 'CDMX'),(12, 4004, '2025-05-01', 50, 'CDMX'),
(13, 4004, '2025-05-01', 100, 'CDMX');

WITH PromediosMensuales AS (
    SELECT estado, id_cliente, 
           MONTH(fecha) as mes, 
           AVG(total) as promedio_mensual
    FROM ventas_estados
    GROUP BY estado, id_cliente, MONTH(fecha)
)
SELECT estado
FROM PromediosMensuales
GROUP BY estado
HAVING MIN(promedio_mensual) > 100;



CREATE TABLE registros_log (
    proceso VARCHAR(20),
    mensaje VARCHAR(100),
    ocurrencia INT
);

INSERT INTO registros_log VALUES 
('Web', 'Error: No se puede dividir por 0', 3),
('RestAPI', 'Error: Fallo la conversión', 5),
('App', 'Error: Fallo la conversión', 7),
('RestAPI', 'Error: Error sin identificar', 9),
('Web', 'Error: Error sin identificar', 1),
('App', 'Error: Error sin identificar', 10),
('Web', 'Estado Completado', 8),
('RestAPI', 'Estado Completado', 6);


WITH RankingMensajes AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY mensaje ORDER BY ocurrencia DESC) as ranking
    FROM registros_log
)
SELECT proceso, mensaje, ocurrencia
FROM RankingMensajes
WHERE ranking = 1;