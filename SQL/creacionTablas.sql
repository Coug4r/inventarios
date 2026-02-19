drop table if exists categorias;
drop table if exists detalle_pedido;
drop table if exists historial_stock;
drop table if exists detalle_ventas;
drop table if exists cavecera_ventas;
drop table if exists productos;
drop table if exists cabezera_pedido;
drop table if exists estados_pedido;
drop table if exists proveedores;
drop table if exists unidades_medida;
drop table if exists categorias_unidad_medida;
drop table if exists tipo_documentos;
create table categorias (
	codigo_cat serial not null,
	nombre varchar(100) not null,
	categoria_padre int,
	constraint categorias_pk primary key (codigo_cat),
	constraint categorias_fk foreign key (categoria_padre)
	references categorias(codigo_cat)
);

insert into categorias(nombre,categoria_padre)
values('Materia Prima',null);
insert into categorias(nombre,categoria_padre)
values('Proteina',1);
insert into categorias(nombre,categoria_padre)
values('Salsas',1);
insert into categorias(nombre,categoria_padre)
values('Punto de venta',null);
insert into categorias(nombre,categoria_padre)
values('Bebidas',4);
insert into categorias(nombre,categoria_padre)
values('Con Alcohol',5);
insert into categorias(nombre,categoria_padre)
values('Sin Alcohol',5);

create table categorias_unidad_medida (
	codigo_udm varChar(1) not null,
	nombre varChar(100) not null,
	constraint categorias_unidad_medida_pk primary key (codigo_udm)
);

insert into categorias_unidad_medida(codigo_udm,nombre)
values('U','Unidades');
insert into categorias_unidad_medida(codigo_udm,nombre)
values('V','Volumen');
insert into categorias_unidad_medida(codigo_udm,nombre)
values('P','Peso');


create table unidades_medida(
	codigo_udm serial not null,
	nombre varChar(2) not null,
	descripcion varChar(100) not null,
	categoria_udm char(1) not null,
	constraint unidades_medida_pk primary key(nombre),
	constraint categorias_unidad_medida_fk foreign key (categoria_udm)
	references categorias_unidad_medida(codigo_udm)
);

insert into unidades_medida(nombre,descripcion,categoria_udm)
values('ml','mililitros','V');
insert into unidades_medida(nombre,descripcion,categoria_udm)
values('l','litros','V');
insert into unidades_medida(nombre,descripcion,categoria_udm)
values('u','unidad','U');
insert into unidades_medida(nombre,descripcion,categoria_udm)
values('d','docena','U');
insert into unidades_medida(nombre,descripcion,categoria_udm)
values('g','gramos','P');
insert into unidades_medida(nombre,descripcion,categoria_udm)
values('kg','kilogramos','P');
insert into unidades_medida(nombre,descripcion,categoria_udm)
values('lb','libras','P');

create table productos(
	codigo_producto int not null,
	nombre varChar(100) not null,
	UDM char(2) not null,
	precio_venta money not null,
	tiene_iva boolean not null,
	coste money not null,
	categoria int not null,
	stock int not null,
	constraint productos_pk primary key(codigo_producto),
	constraint unidades_medida_fk foreign key (UDM)
	references unidades_medida(nombre)
);
insert into productos(codigo_producto,nombre,UDM,precio_venta,tiene_iva,coste,categoria,stock)
values(1,'Coca cola pequeña','u',money(0.5804),true,money(0.3729),7,105);
insert into productos(codigo_producto,nombre,UDM,precio_venta,tiene_iva,coste,categoria,stock)
values(2,'Salsa de tomate','kg',money(0.95),true,money(0.8736),3,0);
insert into productos(codigo_producto,nombre,UDM,precio_venta,tiene_iva,coste,categoria,stock)
values(3,'Mostaza','kg',money(0.95),true,money(0.89),3,0);
insert into productos(codigo_producto,nombre,UDM,precio_venta,tiene_iva,coste,categoria,stock)
values(4,'Fuze tea','u',money(0.8),true,money(0.7),7,49);

create table tipo_documentos(
	codigo char(1) not null,
	descripcion varChar(50) not null,
	constraint tipo_documentos_pk primary key(codigo)
);
insert into tipo_documentos(codigo,descripcion)
values('C','CEDULA');
insert into tipo_documentos(codigo,descripcion)
values('R','RUC');


create table proveedores(
	identificador varChar(13) not null,
	tipo_documento char(1) not null,
	nombre varChar(50) not null,
	telefono char(10) not null,
	correo varChar(50) not null,
	direccion varChar(100) not null,
	constraint proveedores_pk primary key(identificador),
	constraint tipo_documentos_fk foreign key(tipo_documento)
	references tipo_documentos(codigo)
);
insert into proveedores(identificador,tipo_documento,nombre,telefono,correo,direccion)
values('1792285747','C','SANTIAGO MOSQUERA','0992920306','zanty@gmail.com','Cumbayork');
insert into proveedores(identificador,tipo_documento,nombre,telefono,correo,direccion)
values('1792285747001','R','SNACKS SA','0992920398','snacks@gmail.com','La Tola');
insert into proveedores(identificador,tipo_documento,nombre,telefono,correo,direccion)
values('1102182266001','R','MAS MAQUINAS','0993168120','masmaq@gmail.com','Epoca');
create table estados_pedido(
	codigo char(1) not null,
	descripcion varChar(50) not null,
	constraint estados_pedido_pk primary key(codigo)
);
insert into estados_pedido(codigo,descripcion)
values('S','Solicitado');
insert into estados_pedido(codigo,descripcion)
values('R','Recibido');

create table cabezera_pedido(
	numero serial not null,
	proveedor varChar(13) not null,
	fecha Date not null,
	estado char(1) not null,
	constraint cabezera_pedido_pk primary key(numero),
	constraint proveedores_fk foreign key(proveedor)
	references proveedores(identificador),
	constraint estados_pedido_fk foreign key(estado)
	references estados_pedido(codigo)
);
insert into cabezera_pedido(proveedor,fecha,estado)
values('1792285747','20/11/2023','R');
insert into cabezera_pedido(proveedor,fecha,estado)
values('1792285747','20/11/2023','R');
insert into cabezera_pedido(proveedor,fecha,estado)
values('1102182266001','19/02/2023','R');

create table detalle_pedido(
	codigo serial not null,
	cabezera_pedido serial not null,
	producto int not null,
	cantidad_solicitada int not null,
	subtotal money not null,
	cantidad_recivida int not null,
	constraint detalle_pedido_pk primary key(codigo),
	constraint cabezera_pedido_fk foreign key(cabezera_pedido)
	references cabezera_pedido(numero),
	constraint productos_fk foreign key(producto)
	references productos(codigo_producto)
);
insert into detalle_pedido(producto,cantidad_solicitada,subtotal,cantidad_recivida)
values(1,100,money(37.29),100);
insert into detalle_pedido(producto,cantidad_solicitada,subtotal,cantidad_recivida)
values(4,50,money(11.8),50);
insert into detalle_pedido(producto,cantidad_solicitada,subtotal,cantidad_recivida)
values(1,10,money(37.29),10);

create table historial_stock(
	codigo serial not null,
	fecha TIMESTAMP  not null,
	referencia varChar(100) not null,
	producto int not null,
	cantidad int not null,
	constraint historial_stock_pk primary key(codigo),
	constraint producto_fk foreign key(producto)
	references productos(codigo_producto)
);
insert into historial_stock(fecha, referencia,producto,cantidad)
values('20/11/2023 19:59','PEDIDO 1',1,100);
insert into historial_stock(fecha, referencia,producto,cantidad)
values('20/11/2023 19:59','PEDIDO 1',4,50);
insert into historial_stock(fecha, referencia,producto,cantidad)
values('20/11/2023 19:59','PEDIDO 2',1,10);
insert into historial_stock(fecha, referencia,producto,cantidad)
values('20/11/2023 19:59','VENTA 1',1,-5);
insert into historial_stock(fecha, referencia,producto,cantidad)
values('20/11/2023 19:59','VENTA 1',4,-5);

create table cavecera_ventas(
	codigo serial not null,
	fecha TIMESTAMP not null,
	total_sin_iva money not null,
	iva money not null,
	total money not null,
	constraint cavecera_ventas_pk primary key(codigo)
);
insert into cavecera_ventas(fecha,total_sin_iva,iva,total)
values('20/11/2023 20:00',money(3.26),money(0.39),money(3.65));

create table detalle_ventas(
	codigo serial not null,
	cavecera_ventas int not null,
	producto int not null,
	cantidad int not null,
	precio_venta money not null,
	subTotal money not null,
	subTotal_con_iva money not null,
	constraint detalle_ventas_pk PRIMARY KEY(codigo),
	constraint cavecera_ventas_fk foreign key(cavecera_ventas)
	references cavecera_ventas(codigo),
	constraint producto_fk foreign key(producto)
	references productos(codigo_producto)
);
insert into detalle_ventas(cavecera_ventas,producto,cantidad,precio_venta,subTotal,subTotal_con_iva)
values(1,1,5,money(0.58),money(2.9),money(3.25));
insert into detalle_ventas(cavecera_ventas,producto,cantidad,precio_venta,subTotal,subTotal_con_iva)
values(1,4,1,money(0.36),money(0.36),money(0.4));

Select * from detalle_ventas