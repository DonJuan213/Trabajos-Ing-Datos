create database parcial2;
use parcial2;

CREATE TABLE Departamento (
id_departamento INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);
CREATE TABLE Empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
id_departamento INT,
fecha_ingreso DATE,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Proyecto (
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
fecha_inicio DATE,
presupuesto DECIMAL(12,2),
id_departamento INT,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Asignacion (
id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
id_empleado INT,
id_proyecto INT,
horas_trabajadas INT CHECK (horas_trabajadas >= 0),
FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);
CREATE TABLE HistorialPresupuesto(
id_historial_presupuesto int auto_increment primary key,
id_proyecto int,
presupuesto_anterior int,
presupuesto_nuevo int
);

insert into departamento
values(" ", "VENTAS", 10000000), 
	(" ", "IT", 25000000),
    (" ", "MARKETING", 20000000);
    
insert into empleado
values(" ", "PEPE", "GERENTE", 1500000, 1, NOW()),
	(" ", "PEPA", "MANAGER", 2000000, 1, NOW()),
    (" ", "FRANCISCO", "OPERADOR", 3000000, 1, NOW()),
    (" ", "MARIANA", "SENIOR DEV", 1000000, 2, NOW()),
    (" ", "MARTA", "PROGRAMADORA", 2450000, 2, NOW()),
    (" ", "TOMAS", "UI", 3450000, 3, NOW());
    
insert into proyecto
values(" ", "proyecto1", now(), 75000000, 1),
	(" ", "proyecto2", now(), 100000000, 2),
    (" ", "proyecto3", now(), 150000000, 3);

insert into asignacion
values(" ", 1, 1, 100),
(" ", 2, 1, 150),
(" ", 3, 1, 200),
(" ", 4, 1, 230),
(" ", 5, 2, 130),
(" ", 6, 3, 50);

select * from departamento;
select * from empleado;
select * from proyecto;
select * from asignacion;
    
/*TRIGGER*/
delimiter $$
create trigger historialPresupuesto
before update on proyecto
for each row
begin
    insert into historialPresupuesto (id_proyecto, presupuesto_anterior, presupuesto_nuevo)
    values (id_proyecto, old.presupuesto, new.presupuesto);
end $$
delimiter ;
select * from historialPresupuesto;


/*FUNCION*/
delimiter $$ 
create function TotalEmpleadosProyecto(id_proyecto int) 
returns int 
deterministic 
begin 
    declare numEmpleadosProyecto int; 
    select count(id_empleado) 
    into numEmpleadosProyecto 
    from Asignacion 
    where asignacion.id_proyecto = id_proyecto;
    return numEmpleadosProyecto; 
end $$ 
delimiter ;
drop function TotalEmpleadosProyecto;
select TotalEmpleadosProyecto(1) as EmpleadosProyecto;

/*PROCEDIMIENTO*/
DELIMITER $$
create procedure ReducirPresupuestoProyecto(
	in id_proyecto int)
begin
declare numEmpleadosProyecto int; 
select count(id_empleado) 
into numEmpleadosProyecto 
from Asignacion 
where asignacion.id_proyecto = id_proyecto;
	IF numEmpleadosProyecto > 3 then
		update proyecto set presupuesto = presupuesto*0.95 where proyecto.id_proyecto = id_proyecto;
    ELSE
		select ("El proyecto no cuenta con la minima cantidad de miembros para realizar una reduccion") as mensaje;
    end if;
end $$
DELIMITER ;
drop procedure reducirpresupuestoproyecto;
call ReducirPresupuestoProyecto(1);
select * from proyecto;



