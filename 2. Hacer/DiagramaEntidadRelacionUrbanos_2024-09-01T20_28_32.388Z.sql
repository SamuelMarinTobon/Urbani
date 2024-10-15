CREATE TABLE "Pais" (
	"IdPais" UUID NOT NULL UNIQUE,
	"Nombre" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdPais")
);


CREATE TABLE "Departamento" (
	"IdDepartamento" UUID NOT NULL UNIQUE,
	"IdPais" UUID,
	"Nombre" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdDepartamento")
);


CREATE TABLE "Ciudad" (
	"IdCiudad" UUID NOT NULL UNIQUE,
	"IdDepartamento" UUID,
	"Nombre" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdCiudad")
);


CREATE TABLE "Sede" (
	"IdSede" UUID NOT NULL UNIQUE,
	"IdAgencia" UUID,
	"Nombre" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdSede")
);


CREATE TABLE "Agencia" (
	"IdAgencia" UUID NOT NULL UNIQUE,
	"NIT" VARCHAR,
	"Nombre" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdAgencia")
);


CREATE TABLE "Empleado" (
	"IdEmpleado" UUID NOT NULL UNIQUE,
	"IdSede" UUID,
	"IdTipoEmpleado" UUID,
	"Nombre" VARCHAR,
	"Telefono" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdEmpleado")
);


CREATE TABLE "Cliente" (
	"IdCliente" UUID NOT NULL UNIQUE,
	"IdTipoDoucmento" UUID,
	"IdTipoGenero" UUID,
	"Nombre" VARCHAR,
	"Email" VARCHAR,
	"Telefono" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdCliente")
);


CREATE TABLE "TipoGenero" (
	"IdTipoGenero" UUID NOT NULL UNIQUE,
	"Genero" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdTipoGenero")
);


CREATE TABLE "TipoDocumento" (
	"IdTipoDocumentio" UUID NOT NULL UNIQUE,
	"Documento" VARCHAR,
	"NumeroDocumento" VARCHAR,
	"Actvo" UUID,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdTipoDocumentio")
);


CREATE TABLE "TipoEmpleado" (
	"IdTipoEmpleado" UUID NOT NULL UNIQUE,
	"TipoEmpleado" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdTipoEmpleado")
);


CREATE TABLE "Propiedad" (
	"IdPropiedad" UUID NOT NULL UNIQUE,
	"IdTipoPropiedad" UUID,
	"IdEstadoPropiedad" UUID,
	"Precio" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdPropiedad")
);


CREATE TABLE "TipoPropiedad" (
	"IdTipoPropiedad" UUID NOT NULL UNIQUE,
	"Tipo" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdTipoPropiedad")
);


CREATE TABLE "EstadoPropiedad" (
	"IdEstadoPropiedad" UUID NOT NULL UNIQUE,
	"Estado" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdEstadoPropiedad")
);


CREATE TABLE "Venta" (
	"IdVenta" UUID NOT NULL UNIQUE,
	"IdCiudad" UUID,
	"IdEmpleado" UUID,
	"IdCliente" UUID,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdVenta")
);


CREATE TABLE "EstadoVenta" (
	"IdEstadoVenta" UUID NOT NULL UNIQUE,
	"Estado" VARCHAR,
	"Activo" UUID,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdEstadoVenta")
);


CREATE TABLE "DetalleVenta" (
	"IdDetalleVenta" UUID NOT NULL UNIQUE,
	"IdEstadoVenta" UUID,
	"IdVenta" UUID,
	"IdPropiedad" UUID,
	"TotalVenta" VARCHAR,
	"Cantidad" VARCHAR,
	"Activo" BIT,
	"Actualiza" TIMESTAMP,
	PRIMARY KEY("IdDetalleVenta")
);


ALTER TABLE "Pais"
ADD FOREIGN KEY("IdPais") REFERENCES "Departamento"("IdPais")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Departamento"
ADD FOREIGN KEY("IdDepartamento") REFERENCES "Ciudad"("IdDepartamento")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Agencia"
ADD FOREIGN KEY("IdAgencia") REFERENCES "Sede"("IdAgencia")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "EstadoPropiedad"
ADD FOREIGN KEY("IdEstadoPropiedad") REFERENCES "Propiedad"("IdEstadoPropiedad")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "TipoPropiedad"
ADD FOREIGN KEY("IdTipoPropiedad") REFERENCES "Propiedad"("IdTipoPropiedad")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "TipoGenero"
ADD FOREIGN KEY("IdTipoGenero") REFERENCES "Cliente"("IdTipoGenero")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "TipoDocumento"
ADD FOREIGN KEY("IdTipoDocumentio") REFERENCES "Cliente"("IdTipoDoucmento")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Sede"
ADD FOREIGN KEY("IdSede") REFERENCES "Empleado"("IdSede")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "TipoEmpleado"
ADD FOREIGN KEY("IdTipoEmpleado") REFERENCES "Empleado"("IdTipoEmpleado")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "EstadoVenta"
ADD FOREIGN KEY("IdEstadoVenta") REFERENCES "DetalleVenta"("IdEstadoVenta")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Venta"
ADD FOREIGN KEY("IdVenta") REFERENCES "DetalleVenta"("IdVenta")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Propiedad"
ADD FOREIGN KEY("IdPropiedad") REFERENCES "DetalleVenta"("IdPropiedad")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Cliente"
ADD FOREIGN KEY("IdCliente") REFERENCES "Venta"("IdCliente")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Empleado"
ADD FOREIGN KEY("IdEmpleado") REFERENCES "Venta"("IdEmpleado")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "Ciudad"
ADD FOREIGN KEY("IdCiudad") REFERENCES "Venta"("IdCiudad")
ON UPDATE NO ACTION ON DELETE NO ACTION;