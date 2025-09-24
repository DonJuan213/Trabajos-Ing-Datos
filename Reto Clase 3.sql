create database ejercicioMascotas;
#drop database mascotas;

use ejercicioMascotas;
create table Mascotas (
	nombre varchar(80) not null,
    genero char(80) not null,
    raza varchar(50) null,
    idMascota int auto_increment primary key
);

create table Ventas(
	idVenta int primary key,
    fecha datetime not null,
    costoTotal decimal(40,2) not null,
    cedula varchar(10) not null,
    foreign key(cedula) references clientes(cedula)
);

create table MascotasTipo(
	tipo varchar(20) not null,
	idMascota int not null primary key,
    foreign key(idMascota) references Mascotas(idMascota)
);

create table Clientes (
	cedula varchar(10) primary key,
    nombre1 varchar(20) not null,
    nombre2 varchar(20) null,
    apellido1 varchar(20) not null,
    apellido2 varchar(20) not null
);


create table clientesDireccion(
	direccion varchar(50) not null,
    cedula varchar(10) not null,
    foreign key(cedula) references Clientes(cedula)
);

create table clientesTelefonos(
	telefono varchar(15) not null,
    cedula varchar(10) not null,
    foreign key(cedula) references Clientes(cedula)
);
  
create table mascotasCompradas(
	idMascota int not null,
    cedula varchar(10) not null,
    costo decimal(40,3) not null,
    foreign key(cedula) references Clientes(cedula),
    foreign key(idMascota) references mascotas(idMascota)
);

create table ventasDetalle(
	cantidad int not null,
    codigoBarras char(100) not null,
    idVenta int not null,
    foreign key(codigoBarras) references Productos(codigoBarras),
    foreign key(idVenta) references ventas(idVenta)
);

create table Vacunas(
	nombre varchar(20) not null,
    dosis int not null,
    enfermedad varchar(20) not null,
    idVacuna int not null primary key
);

create table vacunasAplicadas(
	idVacuna int not null,
    idMascota int not null,
    foreign key(idVacuna) references Vacunas(idVacuna),
    foreign key(idMascota) references Mascotas(idMascota)
);

create table productos(
	nombre varchar(20) not null,
    marca varchar(20) not null,
    precio decimal(40,2) not null,
    codigoBarras char(100) primary key
);

/* insert into (nombreTable) (campos) values (valor1, valor2, valor3, valor4)
intert into (nombreTable) values (valor1, valor2, valor3, valor4) */


/*
select * from nombreTabla para realizar consultas debidas
*/

insert into mascotas (idMascota, nombreMascota, raza, generoMascota, tipoMascota, fechaRegistro) #forma larga de hacer un registro
values(" ", "Max", "Bulldog Frances", "Masculino", "Perro", "2025/07/08"); 

insert into mascotas 
values(" ", "Maximiliano", "Golden retriever", "Masculino", "Perro", "2025/12/12"); #Forma corta de hacer un registro

insert into mascotas 
values(" ", "Pepe", "Siames", "Femenina", "Gato", "2025/11/06"), #forma de realizar varios registros simultaneos.
(" ", "pepa", "Gato Pelon", "Masculino", "Gato", "2025/02/12"),
(" ", "Mariana", "razaPerro1", "Masculino", "Perro", "2025/12/10"),
(" ", "Maximilian", "razaGato2", "Masculino", "Gato", "2025/12/12");


select * from estudiantes order by semestre asc;
/*
TODAS LAS FUNCIONES CALCULADAS
count() contar
sum() sumar
avg() promedio
max() maximo
min() minimo
*/

#select * from columnaAgrupada nomFuncionAgregacion() from nomTabla group by campo
#select * from estudiantes group by carrera (si no tiene una funcion unicamente se agrupa por el campo dado, en este caso por la carrera)
#select * from estudiantes group by semestre (en este caso se agrupa por el num de semestre)

/*
Se acompaña con una funcion de agregacion para asi tener la cantidad de estudiantes que estan siendo agrupados!
*/

select * from Mascotas;
select nombre, raza, genero from Mascotas;
select nombre as NombreMascota, genero as Sexo from Mascotas;
select nombre, raza from Mascotas order by nombre asc;
select nombre, raza from Mascotas order by nombre desc;
select * from Clientes where apellido1 = 'Perez';
select * from Ventas where fecha between '2025-01-01' and '2025-12-31';
select * from Mascotas where genero = 'Masculino' and raza = 'Golden retriever';
select nombre from Mascotas where nombre like 'Ma%';
select nombre from Mascotas where nombre like '%a';
select nombre from Mascotas where nombre like '%xim%';
select nombre from Mascotas where nombre not like '%Max%';

/* ---------------- FUNCIONES DE AGREGACION ---------------- */

select count(*) as TotalMascotas from Mascotas;
select max(fecha) as UltimoRegistro from Ventas;
select min(fecha) as PrimerRegistro from Ventas;
select avg(costoTotal) as PromedioVentas from Ventas;
select sum(costoTotal) as TotalIngresos from Ventas;

/* ---------------- AGRUPAMIENTO ---------------- */

select cedula, count(idMascota) as MascotasCompradas
from mascotasCompradas
group by cedula;

select genero, count(*) as Cantidad
from Mascotas
group by genero;

