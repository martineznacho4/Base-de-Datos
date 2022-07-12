# 1. Utilizando la base de datos de movies, queremos conocer, por un lado, los
# títulos y el nombre del género de todas las series de la base de datos.

SELECT series.title AS Serie, genres.name AS Genero
FROM movies_db.series
INNER JOIN movies_db.genres ON series.genre_id = genres.id;

# 2. Por otro, necesitamos listar los títulos de los episodios junto con el nombre y
# apellido de los actores que trabajan en cada uno de ellos.

SELECT episodes.title AS Episodio, concat(actors.first_name, ' ', actors.last_name) AS Actor
FROM episodes
INNER JOIN actor_episode ON episodes.id = actor_episode.episode_id
INNER JOIN actors ON actors.id = actor_episode.actor_id;

# 3. Para nuestro próximo desafío, necesitamos obtener a todos los actores o
# actrices (mostrar nombre y apellido) que han trabajado en cualquier película
# de la saga de La Guerra de las galaxias.

SELECT DISTINCT concat(actors.first_name, ' ', actors.last_name) AS Actores
FROM movies_db.actors
INNER JOIN actor_movie ON actors.id = actor_movie.actor_id
INNER JOIN movies ON movies.id = actor_movie.movie_id
WHERE movies.title LIKE '%La Guerra de las galaxias%';

# 4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la
# cantidad de películas por nombre de género.

SELECT genres.name, COUNT(movies.id)
FROM movies
INNER JOIN genres ON movies.genre_id = genres.id
GROUP BY genres.name


