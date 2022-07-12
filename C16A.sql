# Reportes parte 1: 

SELECT 
    *
FROM
    sakila.actor;
# 1. Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar 
# alias para mostrar los nombres de las columnas en español. 

SELECT 
    actor.first_name AS Nombre, actor.last_name AS Apellido
FROM
    sakila.actor
LIMIT 5;

# 2. Obtener un listado que incluya nombre, apellido y correo electrónico de los 
# clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las 
# columnas en español. 

SELECT 
    customer.first_name AS Nombre,
    customer.last_name AS Apellido,
    customer.email
FROM
    sakila.customer
WHERE
    active = '0';

# 3. Obtener un listado de films incluyendo título, año y descripción de los films 
# que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de 
# mayor a menor. Utilizar alias para mostrar los nombres de las columnas en 
# español. 

SELECT 
    film.title, film.release_year, film.description
FROM
    sakila.film
WHERE
    film.rental_duration > 5
ORDER BY film.rental_duration DESC;

# 4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de 
# mayo de 2005, incluir en el resultado todas las columnas disponibles. 

SELECT 
    *
FROM
    sakila.rental
WHERE
    EXTRACT(MONTH FROM rental.rental_date) = 5
        AND EXTRACT(YEAR FROM rental.rental_date) = 2005;

SELECT 
    *
FROM
    sakila.rental
WHERE
    DATE(rental_date) BETWEEN '2005-05-01' AND '2005-05-31';

-- -------------------------------------------------------------------------------------------------


# 1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo en una columna llamada “cantidad”.

SELECT 
    COUNT(rental.rental_id) AS Cantidad
FROM
    sakila.rental; 

# 2. Obtener la suma TOTAL de todos los pagos (payments). 
# Utilizar un alias para mostrarlo en una columna llamada “total”, junto a una columna con la cantidad de alquileres con el alias “Cantidad” y una columna que indique el “Importe promedio” por alquiler. 

SELECT 
    SUM(payment.amount) AS Total,
    COUNT(payment.rental_id) AS Cantidad,
    AVG(payment.amount) AS 'Precio promedio'
FROM
    sakila.payment;

# 67416.51	16044	4.200667

SELECT 
    SUM(amount) AS TOTAL,
    COUNT(DISTINCT rental_id) AS CANTIDAD,
    SUM(amount) / COUNT(DISTINCT rental_id) AS 'Importe Promedio'
FROM
    payment;

# 67416.51	16044	4.201976

# 3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen? 

SELECT 
    payment.customer_id AS Cliente,
    COUNT(payment.rental_id) AS Cantidad
FROM
    sakila.payment
GROUP BY payment.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 10;

# 4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres. 

SELECT 
    payment.customer_id,
    COUNT(payment.rental_id) AS Cantidad,
    SUM(payment.amount) AS Total
FROM
    sakila.payment
GROUP BY payment.customer_id
HAVING SUM(payment.amount) > 150;

# 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental), la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el año de alquiler 2005 (rental_date de tabla rental). 

SELECT 
    MONTH(rental.rental_date) AS Mes,
    COUNT(rental.rental_id) AS Cantidad,
    SUM(payment.amount) AS Total
FROM
    sakila.rental
        INNER JOIN sakila.payment ON rental.rental_id = payment.rental_id
WHERE
    YEAR(rental.rental_date) = 2005
GROUP BY MONTH(rental.rental_date);

# 6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental). Para cada una de ellas indicar la cantidad de alquileres. 

SELECT rental.inventory_id, COUNT(rental.rental_id)
FROM sakila.rental
GROUP BY rental.inventory_id
ORDER BY COUNT(rental.rental_id) DESC
LIMIT 5;

-- ---------------------------------------------------------------------------------------------------------

-- Extra Join

# 1. Obtener los artistas que han actuado en una o más películas.

SELECT DISTINCT Concat(artista.nombre, ' ', artista.apellido)
FROM extra_joins.artista
INNER JOIN artista_x_pelicula ON artista_x_pelicula.artista_id = artista.id;

# 2. Obtener las películas donde han participado más de un artista según nuestra
# base de datos.

SELECT p.titulo
FROM artista_x_pelicula axp 
INNER JOIN pelicula p ON axp.pelicula_id = p.id
GROUP BY axp.pelicula_id
HAVING COUNT(axp.artista_id) > 1;

# 3. Obtener aquellos artistas que han actuado en alguna película, incluso
# aquellos que aún no lo han hecho, según nuestra base de datos.

SELECT DISTINCT Concat(artista.nombre, ' ', artista.apellido)
FROM artista
LEFT JOIN artista_x_pelicula axp ON axp.artista_id = artista.id;

# 4. Obtener las películas que no se le han asignado artistas en nuestra base de
# datos.

SELECT pelicula.titulo
FROM pelicula
LEFT JOIN artista_x_pelicula axp ON axp.pelicula_id = pelicula.id
WHERE axp.pelicula_id IS NULL;

# 5. Obtener aquellos artistas que no han actuado en alguna película, según
# nuestra base de datos.

SELECT DISTINCT Concat(artista.nombre, ' ', artista.apellido)
FROM artista
LEFT JOIN artista_x_pelicula axp ON axp.artista_id = artista.id
WHERE axp.artista_id IS NULL;

# 6. Obtener aquellos artistas que han actuado en dos o más películas según
# nuestra base de datos.

SELECT DISTINCT Concat(artista.nombre, ' ', artista.apellido)
FROM artista
INNER JOIN artista_x_pelicula axp ON axp.artista_id = artista.id
GROUP BY axp.artista_id
HAVING COUNT(axp.pelicula_id) >= 2;

# 7. Obtener aquellas películas que tengan asignado uno o más artistas, incluso
# aquellas que aún no le han asignado un artista en nuestra base de datos.

SELECT DISTINCT pelicula.titulo
FROM pelicula
LEFT JOIN artista_x_pelicula axp ON axp.pelicula_id = pelicula.id;
