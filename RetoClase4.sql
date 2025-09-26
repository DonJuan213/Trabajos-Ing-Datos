create database RetoClase4;
use RetoClase4;

create table empleados(
idEmpleado int auto_increment primary key,
nombreEmpleado varchar(100) not null,
edadEmpleado int not null,
salarioEmpleado decimal(40,3) not null
);

create table departamento(
idDepartamento int auto_increment primary key,
idEmpleadoFK int unique,
nombreDepartamento varchar(100) not null,
fechaContratacion date not null,
foreign key(idEmpleadoFK) references empleados(idEmpleado) ##forma de realizar una relacion dentro de una tabla. Se usa la llave 
);

describe departamento;

insert into empleados values 
(" ", "Martin", "39", 4200.00),
(" ", "Joaquin", "42", 3000.00),
(" ", "Mariana", "23", 4520.00),
(" ", "Pedro", "19", 2000.00),
(" ", "Mario", "47", 5500.00),
(" ", "Juliana", "44", 6500.00),
(" ", "Marta", "37", 4600.00);

insert into departamento values
(" ", 1, "Recursos Humanos", "2025/05/13"),
(" ", 2, "IT", "2022/06/13"),
(" ", 3, "Marketing", "2019/02/28"),
(" ", 4, "IT", "2017/12/07"),
(" ", 5, "Recursos Humanos", "2023/03/30"),
(" ", 6, "IT", "2019/12/30");
(" ", 7, "Ventas", "2023,07,08");

select * from departamento;

select * from empleados; #1
select * from empleados where salarioEmpleado > 4000.00; #2
select * from empleado where idEmpleado IN (select * from departamento where nombreDepartamento = "Ventas");
