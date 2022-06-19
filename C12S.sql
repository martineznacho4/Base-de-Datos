-- Realizar los siguientes informes:
SELECT * FROM spotify.cancion;


-- Listar las canciones que poseen la letra “z” en su título.
SELECT * FROM spotify.cancion WHERE titulo LIKE '%z%';

-- Listar las canciones que poseen como segundo carácter la letra “a” y como último, la letra “s”.
SELECT * FROM spotify.cancion WHERE titulo LIKE '_a%s';

-- Mostrar la playlist que tiene más canciones, renombrando las columnas poniendo mayúsculas en la primera letra, los tildes correspondientes y agregar los espacios entre palabras.
SELECT titulo AS Titulo, cantcanciones AS 'Cantidad de canciones'  FROM spotify.playlist  ORDER BY cantcanciones LIMIT 1;

-- En otro momento se obtuvo un listado con los 5 usuarios más jóvenes, obtener un listado de los 10 siguientes.
SELECT * FROM spotify.usuario ORDER BY fecha_nac DESC LIMIT 10 OFFSET 5;

-- Listar las 5 canciones con más reproducciones, ordenadas descendentemente.
SELECT * FROM spotify.cancion ORDER BY cantreproduccion DESC;

-- Generar un reporte de todos los álbumes ordenados alfabéticamente.
SELECT * FROM spotify.album ORDER BY titulo;

-- Listar todos los álbumes que no tengan imagen, ordenados alfabéticamente.
SELECT * FROM spotify.album WHERE imagenportada IS NULL ORDER BY titulo;

-- Insertar un usuario nuevo con los siguientes datos (tener en cuenta las relaciones):
-- a) nombreusuario: nuevousuariodespotify@gmail.com
-- b) Nombre y apellido: Elmer Gomez
-- c) password: S4321m
-- d) Fecha de nacimiento: 15/11/1991
-- e) Sexo: Masculino
-- f) Código Postal: B4129ATF
-- g) País: Colombia

SELECT * FROM spotify.usuario;
INSERT INTO spotify.usuario (idUsuario,nombreusuario, nyap, password, fecha_nac, sexo, CP, Pais_idPais) VALUES (20,'nuevousuariodespotify@gmail.com','Elmer Gomez', 'S4321m', '1991-11-15', 'M', 'B4129ATF', 2);

-- Eliminar todas las canciones de género “pop”.
SELECT * FROM spotify.cancion;
DELETE FROM spotify.generoxcancion WHERE IdGenero = 9;

-- Editar todos los artistas que no tengan una imagen cargada y cargarles el texto “Imagen faltante” en la columna de imagen.

SELECT * FROM spotify.artista;

UPDATE spotify.artista
SET imagen = 'Imagen faltante'
WHERE imagen IS NULL AND idArtista != 0;

-- UPDATE customers SET countryCode = 'USA'
--     WHERE country = 'USA';               -- which gives the error, you just write:

-- UPDATE customers SET countryCode = 'USA'
--     WHERE (country = 'USA' AND customerNumber <> 0); -- Because customerNumber is a primary key you got no error 1175 any more.

