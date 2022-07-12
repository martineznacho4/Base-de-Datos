# SELECT y GROUP BY

# 1. Listar las canciones cuya duración sea mayor a 2 minutos.

SELECT *
FROM musimundos.canciones
WHERE milisegundos > 120000;

# 2. Listar las canciones cuyo nombre comience con una vocal.

SELECT *
FROM musimundos.canciones
WHERE nombre LIKE 'a%' OR nombre LIKE 'e%' OR nombre LIKE 'i%' OR nombre LIKE 'o%' OR nombre LIKE 'u%';

# 3. Listar las canciones ordenadas por compositor en forma descendente.
# Luego, por nombre en forma ascendente. Incluir únicamente aquellas
# canciones que tengan compositor.

SELECT *
FROM musimundos.canciones
ORDER BY compositor DESC;

SELECT *
FROM musimundos.canciones
WHERE compositor != ''
ORDER BY nombre;

# 4. 
# a) Listar la cantidad de canciones de cada compositor.
# b) Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones.

SELECT compositor, COUNT(id) AS cantidadCanciones
FROM musimundos.canciones
WHERE coalesce(compositor, '') != ''
GROUP BY compositor;

SELECT compositor, COUNT(id) AS cantidadCanciones
FROM musimundos.canciones
WHERE coalesce(compositor, '') != ''
GROUP BY compositor
HAVING COUNT(id) > 10;

# 5. 
# a) Listar el total facturado agrupado por ciudad.
# b) Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
# c) Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
# d) Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.

SELECT ciudad_de_facturacion, SUM(total) AS Total
FROM musimundos.facturas
GROUP BY facturas.ciudad_de_facturacion;

SELECT ciudad_de_facturacion, SUM(total) AS Total
FROM musimundos.facturas
WHERE pais_de_facturacion = 'Canadá'
GROUP BY facturas.ciudad_de_facturacion;

SELECT ciudad_de_facturacion, SUM(total) AS Total
FROM musimundos.facturas
GROUP BY facturas.ciudad_de_facturacion
HAVING Total > 38;

SELECT pais_de_facturacion,ciudad_de_facturacion, SUM(total) AS Total
FROM musimundos.facturas
GROUP BY facturas.pais_de_facturacion, facturas.ciudad_de_facturacion
ORDER BY facturas.pais_de_facturacion, facturas.ciudad_de_facturacion;

# 6. 
# a) Listar la duración mínima, máxima y promedio de las canciones.

SELECT 
    MIN(canciones.milisegundos) AS minimaCancion,
    MAX(canciones.milisegundos) AS maximaCancion,
    AVG(canciones.milisegundos) AS promedio
    
FROM
    musimundos.canciones;
    
# b) Modificar el punto (a) mostrando la información agrupada por género.

SELECT 
    id_genero,
    MIN(canciones.milisegundos) AS minimaCancion,
    MAX(canciones.milisegundos) AS maximaCancion,
    AVG(canciones.milisegundos) AS promedio
FROM
    musimundos.canciones
GROUP BY id_genero