SELECt * FROM movies_db.movies;
 
SELECT first_name, last_name, rating from movies_db.actors;

SELECT title FROM movies_db.series; 

SELECT first_name, last_name, rating FROM movies_db.actors
WHERE rating > 7.5;

SELECT title, rating, awards FROM movies_db.movies WHERE rating > 7.5 AND awards > 2;

SELECT title, rating FROM movies_db.movies ORDER BY rating;

SELECT title, rating from movies_db.movies WHERE title LIKE "%Toy Story%";

SELECT * FROM movies_db.actors WHERE first_name LIKE "Sam%";

SELECT * from movies_db.movies WHERE release_date BETWEEN '2004-01-01' AND '2008-12-31';


SELECT title AS titulo FROM movies_db.series;

SELECT title FROM movies_db.movies WHERE rating > 3 AND awards > 1 AND (release_date BETWEEN '1988-01-01' AND '2009-12-31') ORDER BY rating DESC;

SELECT title FROM movies_db.movies WHERE rating > 3 AND awards > 1 AND (release_date BETWEEN '1988-01-01' AND '2009-12-31') ORDER BY rating DESC LIMIT 3 OFFSET 10;

SELECT title, rating FROM movies_db.movies ORDER BY rating LIMIT 3;

SELECT id, first_name AS nombre, last_name AS apellido, rating AS puntaje FROM movies_db.actors 
