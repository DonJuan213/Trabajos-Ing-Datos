create database RetoClase4;
use RetoClase4;

drop table empleados;
drop table departamento;

create table empleados(
idEmpleado int auto_increment primary key,
idDepartamentoFK int unique,
nombreEmpleado varchar(100) not null,
fechaNacimiento date not null,
salarioEmpleado decimal(40,3) not null,
foreign key(idDepartamentoFK) references departamento(idDepartamento)
);

create table departamento(
idDepartamento int auto_increment primary key,
nombreDepartamento varchar(100) not null,
fechaContratacion date not null
);

insert into empleados values 
(" ", 1, "Martin", "1967/03/23", 4200.00),
(" ", 2, "Joaquin", "1984/12/18", 3000.00),
(" ", 3, "Mariana", "1967/03/23", 4520.00),
(" ", 4, "Pedro", "1999/06/23", 2000.00),
(" ", 5, "Mario", "1984/10/04", 5500.00),
(" ", 6, "Juliana", "1970/09/27", 6500.00),
(" ", 7, "Marta", "2001/09/11", 4600.00);

insert into departamento values
(" ", "Recursos Humanos", "2025/05/13"),
(" ", "IT", "2022/06/13"),
(" ", "Marketing", "2019/02/28"),
(" ", "IT", "2017/12/07"),
(" ", "Recursos Humanos", "2023/03/30"),
(" ", "Ventas", "2019/12/30"),
(" ", "Ventas", "2023,07,08");

select * from departamento;
select * from empleados;

select * from empleados; #1
select * from empleados where salarioEmpleado > 4000.00; #2
select * from departamento where nombreDepartamento="Ventas"; #3
select * from empleados; #4
select * from departamento where fechaContratacion > "2022/01/01";#5
select count(*) as empleados from empleados; #6
select avg(salarioEmpleado) as PromedioSalarios from empleados; #7
select nombreEmpleado from empleados where nombreEmpleado like "A%" or "C%"; #8
select nombreEmpleado from empleados where idDepartamentoFK in (select idDepartamento from departamento where nombreDepartamento != "IT");#9
select nombreEmpleado, salarioEmpleado from empleados where salarioEmpleado=(select max(salarioEmpleado) from empleados);#10


/*Subconsultas y consultas multitablas
------Subconsultas-------
primero se ejecuta la subconsulta y luego la consulta principal.
Existen 3 tipos:
1. Escalares que devuelven un unico valor
2. De fila que devuelven un registro(fila) completa
3. de tabla que devuelven varios registros(varias filas)
*/
select nombreEmpleado from empleados where idDepartamentoFK in (select idDepartamento from departamento where nombreDepartamento = "Ventas");


/*
Multitablas
Inner join devuelve todas las filas que esten en AMBAS tablas
left join devuelve todas las filas de la izquierda que no tengan coincidencia con la derecha
right join devuelve todas las filas de la derecha que no tengan coincidencia con la izquierda
Full outer join devuelve todas las filas (no existe en MySQL)
*/
select e.nombreEmpleado as "empleado", d.nombreDepartamento as "departamento" from empleados e inner join departamento d on e.idDepartamentoFK=d.idDepartamento;

#Consultar empleado cuyo salario sea mayor al promedio de la empresa
select nombreEmpleado, salarioEmpleado from empleados where salarioEmpleado > (select avg(salarioEmpleado)as promedioSalario from empleados);
#Encuentre el nombre del empleado con el segundo salario mas alto-subconsulta
select nombreEmpleado from empleados where salarioEmpleado = (select max(salarioEmpleados) as salarioMaximo from (select nombreEmpleado, salarioEmpleado from empleados where salarioEmpleado not in (select max(salarioEmpleado) from empleados)));
#Usando left join muestre los departamentos que no tienen empleados asignados
select e.nombreEmpleado as "empleado", d.nombreDepartamento as "departamento" from empleados e left join departamento d on e.idDepartamentoFK=d.idDepartamento;
#muestre el total de empleados por cada departamento
select d.nombreDepartamento, count(e.idEmpleado) as totalEmpleados from departamento d left join empleados e on d.idDepartamentoFK = idDepartamento group by d.nombreDepartamento;
