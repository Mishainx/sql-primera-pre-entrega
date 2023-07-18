-- CURSO SQL
-- Primera Pre-Entrega de Proyecto Finall
-- Profesor: César Arena
-- Tutor: Juan Martín Almada Ortíz

CREATE DATABASE IF NOT EXISTS consultorio;

USE consultorio;

CREATE TABLE IF NOT EXISTS cobertura(
	id_cobertura INT NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
	tipo VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_cobertura),
    INDEX(nombre)
);

CREATE TABLE IF NOT EXISTS consultorio.profesionales(
	id_profesional INT NOT NULL UNIQUE AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    email VARCHAR (120) NOT NULL,
    cod_pais INT DEFAULT 54,
    telefono INT NOT NULL,
    tipo_documento VARCHAR(3) DEFAULT 'DNI',
    documento VARCHAR(14),
	PRIMARY KEY (id_profesional)
);

CREATE TABLE IF NOT EXISTS consultorio.profesionales_auxiliares(
	id_profesional INT NOT NULL UNIQUE AUTO_INCREMENT,
    especialidad VARCHAR(50) NOT NULL ,
	nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    email VARCHAR (120) NOT NULL,
    cod_pais INT DEFAULT 54 NOT NULL,
    telefono INT NOT NULL,
    tipo_documento VARCHAR(3) DEFAULT 'DNI',
    domicilio VARCHAR(100),
	PRIMARY KEY (id_profesional)
);

CREATE TABLE IF NOT EXISTS consultorio.proveedores(
	id_proveedor INT NOT NULL UNIQUE AUTO_INCREMENT,
    rubro VARCHAR(100) NOT NULL ,
	nombre VARCHAR(30) NOT NULL,
    email VARCHAR (120) NOT NULL,
    cod_pais INT DEFAULT 54 NOT NULL,
    telefono INT NOT NULL,
	cuit VARCHAR(13) NOT NULL,
    domicilio VARCHAR(100),
	PRIMARY KEY (id_proveedor),
    INDEX(nombre,cuit)
);

CREATE TABLE IF NOT EXISTS consultorio.titulos(
	id_titulo INT NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    institucion VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_titulo)
);

CREATE TABLE IF NOT EXISTS consultorio.tratamientos(
	id_tratamiento INT NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    duracion INT NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
	PRIMARY KEY (id_tratamiento),
    KEY (precio)
);

CREATE TABLE IF NOT EXISTS consultorio.metodo_pago(
	id_metodo INT NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_metodo)
);

CREATE TABLE IF NOT EXISTS consultorio.pacientes (
	id_paciente INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_cobertura INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    email VARCHAR (120) NOT NULL,
    cod_pais INT DEFAULT 54,
    telefono INT NOT NULL,
    tipo_documento VARCHAR(3) DEFAULT 'DNI',
    documento VARCHAR(14),
    PRIMARY KEY (id_paciente),
    CONSTRAINT FOREIGN KEY (id_cobertura) REFERENCES cobertura(id_cobertura)
);

CREATE TABLE IF NOT EXISTS consultorio.historia_clinica(
	id_hc INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    diagnostico VARCHAR(125),
    antecedentes VARCHAR(255),
    epicresis VARCHAR(255),
    PRIMARY KEY (id_hc),
	CONSTRAINT FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

CREATE TABLE IF NOT EXISTS consultorio.turnos(
	id_turno INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_paciente INT NOT NULL,
	id_tratamiento INT NOT NULL,
    id_profesional INT NOT NULL,
    fecha DATETIME NOT NULL,
	PRIMARY KEY (id_turno),
	CONSTRAINT FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
	CONSTRAINT FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento),
	CONSTRAINT FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional),
    INDEX(fecha)
);

CREATE TABLE IF NOT EXISTS consultorio.titulos_profesional(
	id_profesional INT NOT NULL,
    id_titulo INT NOT NULL,
	CONSTRAINT FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional),
	CONSTRAINT FOREIGN KEY (id_titulo) REFERENCES titulos(id_titulo)
);

CREATE TABLE IF NOT EXISTS consultorio.tratamientos_profesional(
	id_profesional INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_tratamiento INT NOT NULL,
	CONSTRAINT FOREIGN KEY (id_profesional) REFERENCES profesionales(id_profesional),
	CONSTRAINT FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento)
);

CREATE TABLE IF NOT EXISTS consultorio.factura(
	id_factura INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_tratamiento INT NOT NULL,
    id_metodo INT NOT NULL,
	PRIMARY KEY (id_factura),
	CONSTRAINT FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
	CONSTRAINT FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento),
	CONSTRAINT FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo)
);

CREATE TABLE IF NOT EXISTS consultorio.pedidos_proveedores(
	id_pedido INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_proveedor INT NOT NULL,
	producto VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
	PRIMARY KEY (id_pedido),
	CONSTRAINT FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

CREATE TABLE IF NOT EXISTS consultorio.sesiones(
	id_sesion INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_turno INT NOT NULL,
	id_hc INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_sesion),
	CONSTRAINT FOREIGN KEY (id_turno) REFERENCES turnos(id_turno),
	CONSTRAINT FOREIGN KEY (id_hc) REFERENCES historia_clinica(id_hc)
);
