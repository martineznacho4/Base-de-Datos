CREATE DATABASE Spotify;

USE Spotify;

CREATE TABLE Usuario(
 id INT AUTO_INCREMENT,
 nombre VARCHAR(50) NOT NULL,
 mail VARCHAR(45) NOT NULL,
 fecha_nacimiento DATE NOT NULL,
 sexo VARCHAR(10) NOT NULL,
 codigo_postal INT NOT NULL,
 pais VARCHAR(45) NOT NULL,
 
 PRIMARY KEY (id)
);

CREATE TABLE Contrasenia(
id INT AUTO_INCREMENT,
fecha_modificacion DATETIME NOT NULL,
id_usuario INT,

PRIMARY KEY(id),
FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE Playlist(
id INT AUTO_INCREMENT,
titulo VARCHAR(50) NOT NULL,
cantidad_canciones INT NOT NULL,
fecha_creacion DATETIME NOT NUll,
id_usuario INT,
eliminada TINYINT(1),
fecha_eliminacion DATETIME,

PRIMARY KEY (id),
FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

CREATE TABLE Artista(
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
foto VARCHAR(500) NOT NULL,

PRIMARY KEY (id)
);

CREATE TABLE Discografica(
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
pais VARCHAR(100) NOT NULL,

PRIMARY KEY (id)
);

CREATE TABLE Album(
id INT AUTO_INCREMENT,
titulo VARCHAR(50) NOT NULL,
id_artista INT,
anio_publicacion YEAR NOT NULL,
imagen_portada VARCHAR(500) NOT NULL,
id_discografica INT,

PRIMARY KEY (id),
FOREIGN KEY (id_artista) REFERENCES Artista(id),
FOREIGN KEY (id_discografica) REFERENCES Discografica(id)
);

CREATE TABLE Genero(
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,

PRIMARY KEY (id)
);


CREATE TABLE Cancion(
id INT AUTO_INCREMENT,
titulo VARCHAR(50) NOT NULL,
duracion INT NOT NULL,
reproducciones INT NOT NULL,
likes INT NOT NULL,
id_album INT,

PRIMARY KEY (id),
FOREIGN KEY (id_album) REFERENCES Album(id)
);

CREATE TABLE Cancion_Genero(
id INT AUTO_INCREMENT,
id_cancion INT,
id_genero INT,

PRIMARY KEY (id),
FOREIGN KEY (id_cancion) REFERENCES Cancion(id),
FOREIGN KEY (id_genero) REFERENCES Genero(id)
);


CREATE TABLE Cancion_Playlist(
id INT AUTO_INCREMENT,
id_cancion INT,
id_playlist INT,

PRIMARY KEY (id),
FOREIGN KEY (id_cancion) REFERENCES Cancion(id),
FOREIGN KEY (id_playlist) REFERENCES Playlist(id)
);






