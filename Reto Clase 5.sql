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


insert into mascotas 
values(" ", "Maximiliano", "Golden retriever", "Masculino", "Perro", "2025/12/12"); #Forma corta de hacer un registro

insert into mascotas 
values("Pepe", "Siames", "Femenina", "Gato"), #forma de realizar varios registros simultaneos.
("pepa", "Gato Pelon", "Masculino", "Gato"),
("Mariana", "razaPerro1", "Masculino", "Perro"),
("Maximilian", "razaGato2", "Masculino", "Gato");

describe mascotas;

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

/*
Las funciones agregadas son un calculo que se realiza en un grupo de registros para no tener que hacer un campo
Se puede mostrar el resultado sin tenerlo registrado en al base de datos
Generalmente se usa para realizar analitica de datos, estadistica y demas

Count() - Cuenta registros
Sum() - Sumar valores UNICAMENTE numericos
avg() - Calcula el promedio
min() - calcula el valor minimo de los registros seleccionados para la funcion agrupada
max() - calcula el valor maximo de los registros seleccionados para la funcion agrupada

SIEMPRE van a devolver un valor UNICO agrupado
*/

/*
PARA COUNT  ----
select count(campoContar) as nombreAlias from tabla;
*/
select count(*) as "numero mascotas" from mascotas;
select max(idMascota) as "mascotaMayor" from mascotas;
select min(idMascota) as "mascotaMenor"from mascotas;
select sum(idMascota) as "sumaIdMascotas" from mascotas;

select * from mascotas; #consulta a la tabla mascotas;

select avg(idMascota) as "promedio mascotas" from mascotas; 

/* campo1, avg(campo) as "nombreAlias"
from tabla
group by campoAgrupar
having avg(campo)>200; #Mostraria entonces todos los promedio de los campos que tengan mas de 200 
*/
#WHERE ANTES DE AGRUPAR HAVING DESPUES DE AGRUPAR

select categoria, avg(precio) as "promedioProducto"
from productos
group by categoria
having avg(precio)>200;

/*
Para realizar una modificacion a la data se utiliza la sentencia 
Update nombreTabla set campo1=valor1 campo2=valor2 where condicion (todas las modificaciones deben tener parametros-reestricciones)
(si no esta ese)
*/
describe mascotas;
select * from mascotas;

update mascotas set nombre="papo" where idMascota=1;
update mascotas set nombre="julian" where idMascota=1 or idMascota=2;
update mascotas set genero="bulldog Frances", nombre="pollo" where idMascota=1;
#1 un campo se cambie en varios registros ---> condicion
#2 en un registro se cambien varios campos ---> despues del set
#PREGUNTA PARCIAL el campo con primary key se puede cambiar? Si pero no se deberia. EN LAS TABLAS NO SE CAMBIAN LLAVES PRIMARIAS NI FORANEAS

/*
SENTENCIA DELETE (ojito)
SIEMPRE se debe hacer un delete con un where, de lo contrario todos los registros se eliminarian causando asi la perdida de la informacion total
*/
select * from mascotas;
delete from mascotas where idMascota=1;
/*
Principios 
A = atomicidad, todas las operaciones se cumplen o todas no se cumplen
C = siempre pasa de un estado a otro
I = Las transacciones no interfieren unas con otras
D =
Begin/Rollback/Commit  
*/
start transaction;
delete from mascotas where idMascota=3;
rollback;
#show variables like "autocommit"; --> muestra la transaccion que tiene un commit (basciamente los guarda)
#show processlist; --> muestra todos los procesos que estan siendo ejecutados;
#select * from information_schema_innodb_trx;
show variables like 'autocommit';
select * from information_schema_innodb_trx;

/*
VIEWS - TRIGGERS - PROCEDIMIENTOS ALMACENADOS
funciones views - Procesos temporales (maquinas virtuales) que permiten realizar un proceso sin necesidad de ejecutar ninguna sentencia
create view nombreVista as select campos from nombreTabla where condicion;
select * from nombreVista
*/

create view nomVista as select nombre as "Nombre Mascotas" from mascotas;
select * from nomVista;

#mostrar los datos del cliente y el nombre de la mascota asociada con la mascota (CLIENTE - MASCOTA)
select nombre1 as "nombreCliente", cedula as "cedulaCliente", apellido1 as "apellidoCliente" from clientes LEFT JOIN mascotas on idMascota=idMascotaFK;

;
alter table clientes add idMascotaFK int;
alter table clientes
add constraint FKclienteMascota
foreign key (idMascotaFK)
references mascotas(idMascota);

describe mascotas;
describe clientes;
