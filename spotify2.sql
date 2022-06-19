create database SpotifyDB;

use spotifyDB;

create table usuarios (

codigo int not null primary key auto_increment,
email varchar (255),
contrasenia_id int,
fechaNacimento date,
sexo char (2),
codigoPostal char (4),
pais_id varchar (200),
subscripcion_id int
);




create table usuarioXsubscripcion(
codigo int not null primary key auto_increment,
descripcion varchar (255)
);





create table contrasenias(
codigo int not null primary key auto_increment,
contrasenia varchar (255),
fechaModificacion datetime,
tiempoExpiracion TIMESTAMP
);


create table playlistXusuarios(
codigo int not null primary key auto_increment,
playlist_id int,
usuario_id int
);




create table playlist(
codigo int not null primary key auto_increment,
nombrePlaylist varchar (255),
cantidadCanciones int,
fechaCreacion date
);



create table playlistXCanciones(
codigo int not null primary key auto_increment,
canciones_id int,
playlist_id int
);

alter table playlistXCaciones 
add foreign key (canciones_id) references canciones(codigo),
add foreign key (playlist_id) references playlist(codigo);

create table canciones (
codigo int not null primary key auto_increment,
nombre varchar (255),
duracion time,
artista_id int,
album_id int
);




create table reproduccionesXusuarios(
usuarios_id int, 
canciones_id int,
reproducciones int
);



create table meGustaXusuarios(
usuario_id int, 
canciones_id int, 
meGusta int
);



create table playlistxEstado(
playlist_id int,
estado bool
);

alter table playlistxEstado
add foreign key (playlist_id) references playlist(codigo);


create table album(
codigo int not null primary key auto_increment,
titulo varchar (255),
anio_publicacion date,
imagenurl varchar (255),
discografica_id int
);



create table genero(
 codigo int not null primary key auto_increment,
 nombre varchar(255)
);

create table generoXcancion(
cancion_id int,
genero_id int
);




create table artista(
codigo int not null primary key auto_increment,
nombre varchar(255),
imagenulr varchar(255),
canciones_id int
);





create table discografica(
codigo int not null primary key auto_increment,
album_id int,
nombre varchar(255),
pais_id int
);

alter table discografica
add foreign key (album_id) references album(codigo);

create table pais(
codigo int not null primary key auto_increment,
nombre varchar (255)
);


alter table playlistXusuarios
add foreign key (playlist_id) references playlist(codigo),
add foreign key (usuario_id) references usuarios(codigo);


alter table discografica
add foreign key (album_id) references album(codigo);

alter table artista
add foreign key (canciones_id) references canciones(codigo);

alter table generoXcancion
add foreign key (cancion_id) references canciones(codigo),
add foreign key (genero_id) references generos(codigo);

alter table album
add foreign key (discogracia_id) references discografica(codigo);

alter table reproduccionesXusuarios
add foreign key (canciones_id) references canciones(codigo),
add foreign key (usuarios_id) references usuarios(codigo);

alter table playlistXusuarios
add foreign key (playlist_id) references playlist(codigo),
add foreign key (usuario_id) references usuarios(codigo);


alter table artista_id
add foreign key (artista_id) references artista(codigo),
add foreign key (album_id) references album(codigo);


alter table usuarios 
add foreign key (contrasenia_id) references contrasenias(codigo),
add foreign key (subscripcion_id) references usuarioXsubscripcion(codigo);

alter table meGustaXusuarios
add foreign key (canciones_id) references canciones(codigo),
add foreign key (usuarios_id) references usuarios(codigo);