CREATE DATABASE partel;
USE partel; 

-- Tabla de Películas
CREATE TABLE Peliculas(
    idPelicula INT NOT NULL PRIMARY KEY,
    nombrePelicula VARCHAR(255) NOT NULL UNIQUE,
    genero VARCHAR(50) NOT NULL,
    clasificacion VARCHAR(20) NOT NULL,
    idioma VARCHAR(50) NOT NULL DEFAULT "español",
    premiosGanados INT NOT NULL DEFAULT 0
);


-- Tabla de Actores
CREATE TABLE Actores(
    idActor INT NOT NULL PRIMARY KEY,
    nombreCompletoActor VARCHAR(200) NOT NULL UNIQUE,
    nacionalidad VARCHAR(50) NOT NULL,
    edad INT NOT NULL  CHECK (edad >= 1),
    oscarGanados INT NOT NULL DEFAULT 0
);


-- Tabla de Repartos
CREATE TABLE Reparto (
    idReparto INT NOT NULL PRIMARY KEY,
    idPelicula INT NOT NULL,
    idActor INT NOT NULL,
    nombrePersonaje VARCHAR(200) NOT NULL,
    sueldoPagado DECIMAL(10, 2) NOT NULL CHECK (sueldoPagado >= 0),

    CONSTRAINT fk_RP FOREIGN KEY (idPelicula) REFERENCES Peliculas(idPelicula),
    CONSTRAINT fk_RA FOREIGN KEY (idActor) REFERENCES Actores(idActor)
);