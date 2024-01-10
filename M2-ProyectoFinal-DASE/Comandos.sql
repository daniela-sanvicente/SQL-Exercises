-- DROP TABLE IF EXISTS Dulces;
CREATE TABLE Dulces (
	idDulce              INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombreDulce          VARCHAR (50)  NOT NULL UNIQUE DEFAULT "N/A",
	precio               DECIMAL(5,2)  NOT NULL DEFAULT 000.00 CHECK(precio >=  0.0),
	tema                 VARCHAR (100) NOT NULL DEFAULT "N/A" CHECK(LENGTH(tema) >= 1),
	tipo                 VARCHAR (50)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(tipo) >= 1),
	stock                INT           NOT NULL DEFAULT 0 CHECK(stock  >=  0),
  tiempoElaboracion    VARCHAR (100) NOT NULL DEFAULT "N/A" CHECK(LENGTH(tiempoElaboracion) >= 1)
);

-- DROP TABLE IF EXISTS Arreglos;
CREATE TABLE Arreglos (
  idArreglo            INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombreArreglo        VARCHAR (50)  NOT NULL UNIQUE DEFAULT "N/A",
	precio               DECIMAL(5,2)  NOT NULL DEFAULT 000.00 CHECK(precio >=  0.0),
	tema                 VARCHAR (100) NOT NULL DEFAULT "N/A" CHECK(LENGTH(tema) >= 1),
	tipo                 VARCHAR (50)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(tipo) >= 1),
	stock                INT           NOT NULL DEFAULT 0 CHECK(stock  >=  0),
  tiempoElaboracion    VARCHAR (100) NOT NULL DEFAULT "N/A" CHECK(LENGTH(tiempoElaboracion) >= 1),
  descripcion          VARCHAR (300) NOT NULL DEFAULT "N/A" CHECK(LENGTH(descripcion) >= 1)
);

-- DROP TABLE IF EXISTS ArregloDulces;
CREATE TABLE ArregloDulces (
	idArreglo    INT NOT NULL,
	idDulce 		 INT NOT NULL,
	cantidad 		 INT NOT NULL DEFAULT 0,
	
	CONSTRAINT PRIMARY KEY (idArreglo, idDulce),
	CONSTRAINT fkIdArreglo FOREIGN KEY (idArreglo) REFERENCES Arreglos (idArreglo),
  CONSTRAINT fkIdDulce FOREIGN KEY (idDulce) REFERENCES Dulces (idDulce)
);

-- DROP TABLE IF EXISTS Mesas;
CREATE TABLE Mesas (
  idMesa               INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombreMesa           VARCHAR (50)  NOT NULL UNIQUE DEFAULT "N/A",
	precio               DECIMAL(5,2)  NOT NULL DEFAULT 000.00 CHECK(precio >=  0.0),
	tema                 VARCHAR (100) NOT NULL DEFAULT "N/A" CHECK(LENGTH(tema) >= 1),
	tipo                 VARCHAR (50)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(tipo) >= 1),
	cotizacion           VARCHAR (250) NOT NULL DEFAULT "N/A" CHECK(LENGTH(cotizacion) >= 1),
  tiempoElaboracion    VARCHAR (100) NOT NULL DEFAULT "N/A" CHECK(LENGTH(tiempoElaboracion) >= 1),
  descripcion          VARCHAR (300) NOT NULL DEFAULT "N/A" CHECK(LENGTH(descripcion) >= 1)
);  

-- DROP TABLE IF EXISTS MesaDulces;
CREATE TABLE MesaDulces (
	idMesa    INT NOT NULL,
	idDulce 	INT NOT NULL,
	cantidad 	INT NOT NULL DEFAULT 0,
	
	CONSTRAINT PRIMARY KEY (idMesa, idDulce),
	CONSTRAINT fkIdMesa FOREIGN KEY (idMesa) REFERENCES Mesas (idMesa),
  CONSTRAINT fkIdDulce FOREIGN KEY (idDulce) REFERENCES Dulces (idDulce)
);

-- DROP TABLE IF EXISTS MesaArreglos;
CREATE TABLE MesaArreglos (
	idMesa    INT NOT NULL,
	idArreglo INT NOT NULL,
	cantidad 	INT NOT NULL DEFAULT 0,
	
	CONSTRAINT PRIMARY KEY (idMesa, idArreglo),
	CONSTRAINT fkIdMesa FOREIGN KEY (idMesa) REFERENCES Mesas (idMesa),
  CONSTRAINT fkIdArreglo FOREIGN KEY (idArreglo) REFERENCES Arreglos (idArreglo)
);
-- DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
  idCliente            INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre               VARCHAR (30)  NOT NULL CHECK(LENGTH(nombre) >= 1),
  apellidos            VARCHAR (80)  NOT NULL CHECK(LENGTH(apellidos) >= 1),
	correo               VARCHAR (80)  NOT NULL UNIQUE DEFAULT "N/A" CHECK(LENGTH(correo) >= 1),
	telefonoCasa         VARCHAR (20)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(telefonoCasa) >= 12),
	whatsapp             VARCHAR (20)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(whatsapp) >= 12),
	direccion            VARCHAR (200) NOT NULL DEFAULT "N/A" CHECK(LENGTH(direccion) >= 10),
	tipo                 VARCHAR (50)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(tipo) >= 1),
	contrasena           VARCHAR (30)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(contrasena) >= 6)
);

-- DROP TABLE IF EXISTS Cupon;
CREATE TABLE Cupon (
  idCupon            	 INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombreCupon          VARCHAR (50)  NOT NULL UNIQUE CHECK(LENGTH(nombreCupon) >= 3),
  codigoCupon          VARCHAR (10)  NOT NULL UNIQUE CHECK(LENGTH(codigoCupon) >= 6),
	fechaInicio          DATETIME 		 NOT NULL DEFAULT NOW(),
	fechaExpiracion			 DATETIME 		 NOT NULL,
	activo 							 BOOLEAN 			 NOT NULL
);

-- DROP TABLE IF EXISTS Carrito;
-- No hay UNIQUE
CREATE TABLE Carrito (
	idCarrito                INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
	idCliente                INT           NOT NULL,
	idCupon                  INT           NOT NULL,
	idDulce                  INT           NOT NULL,
	idArreglo                INT           NOT NULL,
	idMesa                   INT           NOT NULL,
	cantidad                 INT           NOT NULL DEFAULT 0 CHECK(cantidad  >=  0),
  precio                   DECIMAL(6,2)  NOT NULL DEFAULT 0000.00 CHECK(precio >=  0.0),

	CONSTRAINT fkCarritoCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
	CONSTRAINT fkCarritoCupon FOREIGN KEY (idCupon) REFERENCES Cupon (idCupon),
	CONSTRAINT fkCarritoDulce FOREIGN KEY (idDulce) REFERENCES Dulces (idDulce),
	CONSTRAINT fkCarritoArreglo FOREIGN KEY (idArreglo) REFERENCES Arreglos (idArreglo),
	CONSTRAINT fkCarritoMesa FOREIGN KEY (idMesa) REFERENCES Mesas (idMesa)
);

-- DROP TABLE IF EXISTS Ordenes;
CREATE TABLE Ordenes (
	idOrden                  INT      		 NOT NULL AUTO_INCREMENT PRIMARY KEY,
	idCliente                INT      		 NOT NULL,
	idCarrito                INT      		 NOT NULL,
	idCupon                  INT      		 NOT NULL,
	tipoOrden                VARCHAR (50)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(tipoOrden) >= 1),
	estatus                  VARCHAR (50)  NOT NULL DEFAULT "N/A" CHECK(LENGTH(estatus) >= 1),
	direccionEntrega         VARCHAR (200) NOT NULL DEFAULT "N/A" CHECK(LENGTH(direccionEntrega) >= 1),
	anticipo                 DECIMAL(5,2)  NOT NULL DEFAULT 000.00 CHECK(anticipo >=  0.0),
	fechaPedido              DATETIME      NOT NULL DEFAULT NOW(),
	fechaEntrega             DATETIME      NOT NULL UNIQUE,
	descuento                DECIMAL(5,2)  NOT NULL DEFAULT 000.00 CHECK(descuento >=  0.0),
  precioTotal              DECIMAL(6,2)  NOT NULL DEFAULT 0000.00 CHECK(precioTotal >=  0.0),

	CONSTRAINT fkOrdenCliente FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
	CONSTRAINT fkOrdenCarrito FOREIGN KEY (idCarrito) REFERENCES Carrito (idCarrito),
	CONSTRAINT fkOrdenCupon FOREIGN KEY (idCupon) REFERENCES Cupon (idCupon)
);
