alter session set "_oracle_script" = true;
create user proyecto identified by 2802;
grant dba to proyecto;
-- NOTA: Despues de ejecutar las anteriores lineas, crear una conexion con el usuario creado y ejecutor el codigo restante

---------------------------------Eliminacion de tablas para tener el espacio de trabajo limpio

drop table haceCompra;
DROP TABLE venta;
drop table atiende;
drop table aloja;
drop table mascota;
drop table empleado;
drop table producto;
drop table duenio;
drop table residencia;

---------------------------------------------------CREACION DE TABLAS DE LA BASE DE DATOS DE LA TIENDA DE MASCOTAS

create table Residencia(
idResidencia number not null,
numResidentesMax int not null,
constraint pk_residencia primary key(idResidencia)
);
Alter table residencia  add tipoResidencia varchar2(30) not null; 
alter table residencia add constraint ckc_tiporesidencia check(tipoResidencia in('Reptiliario Grande','Reptiliario Pequenio','Terrario','Casa Perro','Casa Gato','Acuario','Jaula'));

insert into residencia values (1,1,'Reptiliario Grande');
insert into residencia values (2,1,'Reptiliario Pequenio');
insert into residencia values (3,2,'Terrario');
insert into residencia values (4,2,'Casa Perro');
insert into residencia values (5,2,'Casa Gato');
insert into residencia values (6,10,'Acuario');
insert into residencia values (7,1,'Jaula');
insert into residencia values (8,2,'Casa Perro');
create table Duenio(
cedulaDuenio number not null,
nombreDuenio varchar2(40) not null,
numTelefonoDuenio number not null,
constraint pk_duenio primary key(cedulaDuenio)
);
insert into Duenio values(1001,'Samuel',3123456789);
insert into Duenio values(1002,'Ruben',1235677489);
insert into Duenio values(1003,'Juan',7778889991);
insert into Duenio values(1004,'Alejandro',1112223334);
insert into Duenio values(1005,'Guillermo',4445556667);
insert into Duenio values(1006,'Miguel',9991112223);
insert into Duenio values(1007,'Hernandez',3334445556);
create table Empleado(
codEmpleado number not null,
nombreEmpleado varchar2(25) not null,
apellidoEmpleado varchar2(40) not null,
cargoEmpleado varchar2(25) not null,
fechaIngreso date not null,
salarioEmpleado integer not null,
constraint pk_empleado primary key(codEmpleado),
constraint ckc_cargoEmpleado check(cargoEmpleado in('Veterinario','Auxiliar','Gerente','Vendedor'))
);
insert into Empleado values(100,'Raul','Alvarez','Gerente','28/02/2019',500000);
insert into Empleado values(200,'Sara','Moledo','Veterinario','05/03/2019',400000);
insert into Empleado values(300,'Oswaldo','Palacios','Veterinario','25/04/2019',400000);
insert into Empleado values(400,'Juan','Guarnizo','Auxiliar','12/05/2019',350000);
insert into Empleado values(500,'Aroia','Garcia','Vendedor','28/02/2019',300000);
create table Producto(
serialProducto number not null,
nombreProducto varchar2(30) not null,
precioProducto integer not null,
tipoProducto varchar2(25) not null,
constraint pk_producto primary key(serialProducto),
constraint ckc_tipoProducto check(tipoProducto in('Alimento','Medicamento','Juguete','Accesorio','Hogar'))
);
insert into producto values(7000,'Cama Perro',1000,'Hogar');
insert into producto values(7001,'Pastilla contra Pulgas',500,'Medicamento');
insert into producto values(7002,'Nutre Can Bulto',700,'Alimento');
insert into producto values(7003,'Collar para Perro de cadena',1000,'Accesorio');
insert into producto values(7004,'Hueso Chillon',1000,'Juguete');
create table Mascota(
idMascota number not null,
nombreMascota varchar2(30) not null,
tipoMascota varchar2(20) not null,
especieMascota varchar2(30) not null,
generoMascota varchar2(30) not null,
cedulaDuenio number not null,
constraint pk_mascota primary key(idMascota),
constraint fk_duemasco foreign key (cedulaDuenio) references Duenio(cedulaDuenio) on delete cascade
);
alter table mascota add constraint ckc_generoMascota check(generoMascota in('Macho','Hembra'));
alter table mascota add constraint ckc_tipomascota check(tipoMascota in('Reptil','Perro','Gato','Anfibio','Pez','Roedor'));

insert into mascota values (1,'Tomy','Perro','Criollo','Macho',1001);
insert into mascota values (2,'Gertrudis','Reptil','Camaleon','Hembra',1002);
insert into mascota values (3,'Nucita','Roedor','Conejiillo','Hembra',1003);
insert into mascota values (4,'Agata','Gato','Mestizo','Hembra',1004);
insert into mascota values (5,'Nemo','Pez','Pez Payaso','Macho',1005);
insert into mascota values (6,'Sally','Anfibio','Anaconda','Macho',1006);
insert into mascota values (7,'Nieve','Perro','Criollo','Hembra',1007);
create table Aloja (
idAloja number generated always as identity not null,
idResidencia number not null,
idMascota number not null,
fechaInicioAlojamiento timestamp not null,
fechaFinAlojamiento timestamp not null,
constraint pk_aloja primary key(idAloja),
constraint fk_resialoj foreign key(idResidencia) references Residencia(idResidencia) on delete cascade,
constraint fk_mascoaloj foreign key(idMascota) references Mascota(idMascota) on delete cascade,
constraint uq_fechaini unique(fechaInicioAlojamiento) 
);
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (4,1,to_date('02/05/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('08/05/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'));
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (2,2,to_date('14/05/2020 18:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('28/05/2020 18:45:00','DD/MM/YYYY HH24:MI:SS'));
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (7,3,to_date('25/07/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('02/08/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'));
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (5,4,to_date('16/08/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('20/08/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'));
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (6,5,to_date('17/08/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('30/08/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'));
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (1,6,to_date('23/09/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('30/09/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'));
insert into aloja(IDRESIDENCIA,IDMASCOTA,FECHAINICIOALOJAMIENTO,FECHAFINALOJAMIENTO) values (8,7,to_date('1/10/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'),to_date('12/10/2020 14:45:00','DD/MM/YYYY HH24:MI:SS'));



create table atiende(
idAtencion number generated always as identity not null,
codEmpleado number not null,
idMascota number not null,
tipoAtencion varchar2(30) not null,
fechaAtencion date not null,
costoAtencion varchar2(25) not null,
descriptcion varchar2(50),
constraint pk_atiende primary key(idAtencion),
constraint fk_empatiende foreign key(codEmpleado) references Empleado(codEmpleado) on delete cascade,
constraint fk_mascoatiende foreign key(idMascota) references Mascota(idMascota) on delete cascade,
constraint ckc_tipoAtencion check(tipoAtencion in('Medica','Limpieza','Consulta')) 
);


create table venta(
idVenta number generated always as identity not null,
idProducto number not null,
idEmpleado number not null,
numProducto number not null,
fechaVenta timestamp not null,
valorVenta integer not null,
constraint pk_venta primary key(idVenta),
constraint fk_prodvent foreign key(idProducto) references Producto(serialProducto) on delete cascade,
constraint fk_empvent foreign key(idEmpleado) references Empleado(codEmpleado) on delete cascade
);


create table haceCompra(
idCliente number not null,
idVenta number not null,
constraint pk_haceCompra primary key(idCliente,idVenta),
constraint fk_clihaComp foreign key(idCliente) references Duenio(cedulaDuenio) on delete cascade,
constraint fk_venthaComp foreign key(idVenta) references Venta(idVenta) on delete cascade
);

---------------------------------CONSULTAR TODAS LAS TABLAS
select * from duenio;
select * from residencia;
select * from empleado;
select * from aloja;
select * from producto;
select * from atiende;
select * from hacecompra;
select * from venta;
select * from mascota;

--------------------------MODIFICACION DE FORMATOS DE FECHAS 
alter session set nls_timestamp_format = 'DD/MM/YYYY HH24:MI:SS';
ALTER session set NLS_DATE_FORMAT='DD/MM/YYYY';