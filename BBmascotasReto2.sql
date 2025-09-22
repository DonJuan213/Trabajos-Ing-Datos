create database ejercicioMascotas;
drop database ejercicioMascotas;
use ejercicioMascotas; 

create table Mascotas(
idMascota int primary key auto_increment,
nombreMascota varchar(60) not null, 
raza varchar(25) not null,
generoMascota varchar(25) not null, 
tipoMascota varchar(25) not null, 
fechaRegistro timestamp default current_timestamp
);


insert into mascotas (idMascota, nombreMascota, raza, generoMascota, tipoMascota, fechaRegistro)
values(" ", "Max", "Bulldog Frances", "Masculino", "Perro", "2025/07/08"); ##forma larga de hacer un registro

insert into mascotas 
values(" ", "Maximiliano", "Golden retriever", "Masculino", "Perro", "2025/12/12"); ##Forma corta de hacer un registro

insert into mascotas 
values(" ", "Pepe", "Siames", "Femenina", "Gato", "2025/11/06"), ##forma de realizar varios registros simultaneos.
(" ", "pepa", "Gato Pelon", "Masculino", "Gato", "2025/02/12"),
(" ", "Mariana", "razaPerro1", "Masculino", "Perro", "2025/12/10"),
(" ", "Maximilian", "razaGato2", "Masculino", "Gato", "2025/12/12");

/*
select * from nombreTabla
*/

select * from mascotas; ##Se usa select para realizar una consulta;

create table producto (
idProducto int auto_increment primary key,
codigoBarras CHAR(13) NOT NULL,
nombre VARCHAR(100) NOT NULL,
marca VARCHAR(60) NULL,
precio DECIMAL(10,2) NOT NULL
);

alter table producto add idProducto int auto_increment primary key;
describe producto
  
  
insert into producto
values(" ", "a", "nombre1", "Pantene",1000,00), ##forma de realizar varios registros simultaneos.
(" ", "i", "nombre2", "Colgate", 5000,00),
(" ", "u", "", "nombre3", "Saltin", 75000,00),
(" ", "e", "nombre4", "rexona", "Gato", 14500,00),
(" ", "o", "nombre5", "festival", 7800,00);
  
CREATE TABLE vacuna (
codigo        VARCHAR(20)  NOT NULL,
nombre        VARCHAR(100) NOT NULL,
dosis         VARCHAR(30)  NOT NULL,
enfermedad    VARCHAR(100) NULL
);

CREATE TABLE cliente (
  cedula VARCHAR(15)  NOT NULL,
  nombres VARCHAR(80)  NOT NULL,
  apellidos VARCHAR(80)  NOT NULL,
  direccion VARCHAR(120) NULL,
  telefono VARCHAR(20)  NULL,
  CONSTRAINT pkCliente PRIMARY KEY (cedula)
);

/* insert into (nombreTable) (campos) values (valor1, valor2, valor3, valor4)
intert into (nombreTable) values (valor1, valor2, valor3, valor4) */

insert into cliente 

