create database if not exists veterinaria;
use veterinaria;

create table cliente (
    idCliente int primary key auto_increment,
    nombre varchar(50),
    apellido varchar(50),
    telefono varchar(20),
    correo varchar(100),
    fechaActualizacion date
);

create table mascota (
    idMascota int primary key auto_increment,
    nombre varchar(50),
    especie varchar(50),
    raza varchar(50),
    idCliente int,
    foreign key (idCliente) references cliente(idCliente)
);

create table vacuna (
    idVacuna int primary key auto_increment,
    nombre varchar(50),
    fechaVigencia date,
    idMascota int,
    foreign key (idMascota) references mascota(idMascota)
);

create table clientesEliminados (
    idCliente int,
    nombre varchar(50),
    apellido varchar(50),
    telefono varchar(20),
    correo varchar(100),
    fechaEliminacion date
);

insert into cliente (nombre, apellido, telefono, correo, fechaActualizacion)
values 
('Laura', 'Ramírez', '3214567890', 'laura@gmail.com', curdate()),
('Pedro', 'López', '3009876543', 'pedro@gmail.com', curdate()),
('Andrés', 'García', '3102233445', 'andres@gmail.com', curdate()),
('María', 'Torres', '3115566778', 'maria@gmail.com', curdate()),
('Camila', 'Suárez', '3129988776', 'camila@gmail.com', curdate());

insert into mascota (nombre, especie, raza, idCliente)
values 
('Rocky', 'Perro', 'Labrador', 1),
('Michi', 'Gato', 'Persa', 2),
('Toby', 'Perro', 'Poodle', 3),
('Nala', 'Gato', 'Siames', 4),
('Max', 'Perro', 'Golden Retriever', 5);

insert into vacuna (nombre, fechaVigencia, idMascota)
values 
('Antirrábica', '2026-05-10', 1),
('Triple Felina', '2024-11-01', 2),
('Parvovirosis', '2025-03-15', 3),
('Leucemia Felina', '2026-07-22', 4),
('Moquillo', '2025-09-30', 5);

delimiter $$
create function vacunaVigente(id int)
returns varchar(20)
deterministic
begin
    declare estado varchar(20);
    if (select fechaVigencia from vacuna where idVacuna = id) >= curdate() then
        set estado = 'Vigente';
    else
        set estado = 'Vencida';
    end if;
    return estado;
end $$
delimiter ;

delimiter $$
create function infoMascota(id int)
returns varchar(200)
deterministic
begin
    declare info varchar(200);
    select concat('Mascota: ', m.nombre, ', Raza: ', m.raza, ', Propietario: ', c.nombre, ' ', c.apellido)
    into info
    from mascota m
    join cliente c on m.idCliente = c.idCliente
    where m.idMascota = id;
    return info;
end $$
delimiter ;

delimiter $$
create trigger evitarEliminarCliente
before delete on cliente
for each row
begin
    if exists (select 1 from mascota where idCliente = old.idCliente) then
        signal sqlstate '45000'
        set message_text = 'No se puede eliminar este cliente: tiene una mascota a su nombre';
    end if;
end $$
delimiter ;


delimiter $$
create trigger guardarClienteEliminado
after delete on cliente
for each row
begin
    insert into clientesEliminados (idCliente, nombre, apellido, telefono, correo, fechaEliminacion)
    values (old.idCliente, old.nombre, old.apellido, old.telefono, old.correo, curdate());
end $$
delimiter ;

delimiter $$
create trigger actualizarFechaCliente
before update on cliente
for each row
begin
    set new.fechaActualizacion = curdate();
end $$
delimiter ;

select infoMascota(1) as informacionMascota;
select vacunaVigente(1) as estadoVacuna;

update cliente
set telefono = '3205550000'
where idCliente = 1;

select * from cliente where idCliente = 1;
delete from cliente where idCliente = 1;
delete from mascota where idCliente = 5;
delete from cliente where idCliente = 5;
select * from clientesEliminados;
