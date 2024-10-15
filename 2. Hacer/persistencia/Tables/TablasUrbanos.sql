CREATE TABLE "Pais" (
	"IdPais" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdPais")
);
COMMENT ON COLUMN "Pais"."IdPais" IS '';
COMMENT ON COLUMN "Pais"."Nombre" IS '';
COMMENT ON COLUMN "Pais"."Activo" IS '';
COMMENT ON COLUMN "Pais"."Actualiza" IS '';

CREATE TABLE "Departamento" (
	"IdDepartamento" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdPais" UUID NULL DEFAULT NULL,
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdDepartamento"),
	CONSTRAINT "FK_IdPais" FOREIGN KEY ("IdPais") REFERENCES "Pais" ("IdPais") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Departamento"."IdDepartamento" IS '';
COMMENT ON COLUMN "Departamento"."IdPais" IS '';
COMMENT ON COLUMN "Departamento"."Nombre" IS '';
COMMENT ON COLUMN "Departamento"."Activo" IS '';
COMMENT ON COLUMN "Departamento"."Actualiza" IS '';

CREATE TABLE "Ciudad" (
	"IdCiudad" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdDepartamento" UUID NULL DEFAULT NULL,
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdCiudad"),
	CONSTRAINT "FK_IdDepartamento" FOREIGN KEY ("IdDepartamento") REFERENCES "Departamento" ("IdDepartamento") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Ciudad"."IdCiudad" IS '';
COMMENT ON COLUMN "Ciudad"."IdDepartamento" IS '';
COMMENT ON COLUMN "Ciudad"."Nombre" IS '';
COMMENT ON COLUMN "Ciudad"."Activo" IS '';
COMMENT ON COLUMN "Ciudad"."Actualiza" IS '';

CREATE TABLE "Agencia" (
	"IdAgencia" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"NIT" VARCHAR NULL DEFAULT NULL,
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdAgencia")
);
COMMENT ON COLUMN "Agencia"."IdAgencia" IS '';
COMMENT ON COLUMN "Agencia"."NIT" IS '';
COMMENT ON COLUMN "Agencia"."Nombre" IS '';
COMMENT ON COLUMN "Agencia"."Activo" IS '';
COMMENT ON COLUMN "Agencia"."Actualiza" IS '';

CREATE TABLE "Sede" (
	"IdSede" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdAgencia" UUID NULL DEFAULT NULL,
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdSede"),
	CONSTRAINT "FK_IdAgencia" FOREIGN KEY ("IdAgencia") REFERENCES "Agencia" ("IdAgencia") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Sede"."IdSede" IS '';
COMMENT ON COLUMN "Sede"."IdAgencia" IS '';
COMMENT ON COLUMN "Sede"."Nombre" IS '';
COMMENT ON COLUMN "Sede"."Activo" IS '';
COMMENT ON COLUMN "Sede"."Actualiza" IS '';

CREATE TABLE "TipoEmpleado" (
	"IdTipoEmpleado" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"TipoEmpleado" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdTipoEmpleado")
);
COMMENT ON COLUMN "TipoEmpleado"."IdTipoEmpleado" IS '';
COMMENT ON COLUMN "TipoEmpleado"."TipoEmpleado" IS '';
COMMENT ON COLUMN "TipoEmpleado"."Activo" IS '';
COMMENT ON COLUMN "TipoEmpleado"."Actualiza" IS '';

CREATE TABLE "Empleado" (
	"IdEmpleado" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdSede" UUID NULL DEFAULT NULL,
	"IdTipoEmpleado" UUID NULL DEFAULT NULL,
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Telefono" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdEmpleado"),
	CONSTRAINT "FK_IdSede" FOREIGN KEY ("IdSede") REFERENCES "Sede" ("IdSede") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdTipoEmpleado" FOREIGN KEY ("IdTipoEmpleado") REFERENCES "TipoEmpleado" ("IdTipoEmpleado") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Empleado"."IdEmpleado" IS '';
COMMENT ON COLUMN "Empleado"."IdSede" IS '';
COMMENT ON COLUMN "Empleado"."IdTipoEmpleado" IS '';
COMMENT ON COLUMN "Empleado"."Nombre" IS '';
COMMENT ON COLUMN "Empleado"."Telefono" IS '';
COMMENT ON COLUMN "Empleado"."Activo" IS '';
COMMENT ON COLUMN "Empleado"."Actualiza" IS '';

CREATE TABLE "TipoGenero" (
	"IdTipoGenero" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"Genero" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdTipoGenero")
);
COMMENT ON COLUMN "TipoGenero"."IdTipoGenero" IS '';
COMMENT ON COLUMN "TipoGenero"."Genero" IS '';
COMMENT ON COLUMN "TipoGenero"."Activo" IS '';
COMMENT ON COLUMN "TipoGenero"."Actualiza" IS '';

CREATE TABLE "TipoDocumento" (
	"IdTipoDocumento" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"Documento" VARCHAR NULL DEFAULT NULL,
	"NumeroDocumento" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdTipoDocumento")
);
COMMENT ON COLUMN "TipoDocumento"."IdTipoDocumento" IS '';
COMMENT ON COLUMN "TipoDocumento"."Documento" IS '';
COMMENT ON COLUMN "TipoDocumento"."NumeroDocumento" IS '';
COMMENT ON COLUMN "TipoDocumento"."Activo" IS '';
COMMENT ON COLUMN "TipoDocumento"."Actualiza" IS '';

CREATE TABLE "Cliente" (
	"IdCliente" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdTipoDocumento" UUID NULL DEFAULT NULL,
	"IdTipoGenero" UUID NULL DEFAULT NULL,
	"Nombre" VARCHAR NULL DEFAULT NULL,
	"Email" VARCHAR NULL DEFAULT NULL,
	"Telefono" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdCliente"),
	CONSTRAINT "FK_IdTipoDocumento" FOREIGN KEY ("IdTipoDocumento") REFERENCES "TipoDocumento" ("IdTipoDocumento") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdTipoGenero" FOREIGN KEY ("IdTipoGenero") REFERENCES "TipoGenero" ("IdTipoGenero") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Cliente"."IdCliente" IS '';
COMMENT ON COLUMN "Cliente"."IdTipoDocumento" IS '';
COMMENT ON COLUMN "Cliente"."IdTipoGenero" IS '';
COMMENT ON COLUMN "Cliente"."Nombre" IS '';
COMMENT ON COLUMN "Cliente"."Email" IS '';
COMMENT ON COLUMN "Cliente"."Telefono" IS '';
COMMENT ON COLUMN "Cliente"."Activo" IS '';
COMMENT ON COLUMN "Cliente"."Actualiza" IS '';

CREATE TABLE "TipoPropiedad" (
	"IdTipoPropiedad" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"Tipo" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdTipoPropiedad")
);
COMMENT ON COLUMN "TipoPropiedad"."IdTipoPropiedad" IS '';
COMMENT ON COLUMN "TipoPropiedad"."Tipo" IS '';
COMMENT ON COLUMN "TipoPropiedad"."Activo" IS '';
COMMENT ON COLUMN "TipoPropiedad"."Actualiza" IS '';

CREATE TABLE "EstadoPropiedad" (
	"IdEstadoPropiedad" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"Estado" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdEstadoPropiedad")
);
COMMENT ON COLUMN "EstadoPropiedad"."IdEstadoPropiedad" IS '';
COMMENT ON COLUMN "EstadoPropiedad"."Estado" IS '';
COMMENT ON COLUMN "EstadoPropiedad"."Activo" IS '';
COMMENT ON COLUMN "EstadoPropiedad"."Actualiza" IS '';

CREATE TABLE "Propiedad" (
	"IdPropiedad" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdTipoPropiedad" UUID NULL DEFAULT NULL,
	"IdEstadoPropiedad" UUID NULL DEFAULT NULL,
	"Precio" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdPropiedad"),
	CONSTRAINT "FK_IdTipoPropiedad" FOREIGN KEY ("IdTipoPropiedad") REFERENCES "TipoPropiedad" ("IdTipoPropiedad") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdEstadoPropiedad" FOREIGN KEY ("IdEstadoPropiedad") REFERENCES "EstadoPropiedad" ("IdEstadoPropiedad") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Propiedad"."IdPropiedad" IS '';
COMMENT ON COLUMN "Propiedad"."IdTipoPropiedad" IS '';
COMMENT ON COLUMN "Propiedad"."IdEstadoPropiedad" IS '';
COMMENT ON COLUMN "Propiedad"."Precio" IS '';
COMMENT ON COLUMN "Propiedad"."Activo" IS '';
COMMENT ON COLUMN "Propiedad"."Actualiza" IS '';

CREATE TABLE "Venta" (
	"IdVenta" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdCiudad" UUID NULL DEFAULT NULL,
	"IdEmpleado" UUID NULL DEFAULT NULL,
	"IdCliente" UUID NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdVenta"),
	CONSTRAINT "FK_IdCiudad" FOREIGN KEY ("IdCiudad") REFERENCES "Ciudad" ("IdCiudad") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdEmpleado" FOREIGN KEY ("IdEmpleado") REFERENCES "Empleado" ("IdEmpleado") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdCliente" FOREIGN KEY ("IdCliente") REFERENCES "Cliente" ("IdCliente") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "Venta"."IdVenta" IS '';
COMMENT ON COLUMN "Venta"."IdCiudad" IS '';
COMMENT ON COLUMN "Venta"."IdEmpleado" IS '';
COMMENT ON COLUMN "Venta"."IdCliente" IS '';
COMMENT ON COLUMN "Venta"."Activo" IS '';
COMMENT ON COLUMN "Venta"."Actualiza" IS '';

CREATE TABLE "EstadoVenta" (
	"IdEstadoVenta" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"Estado" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdEstadoVenta")
);
COMMENT ON COLUMN "EstadoVenta"."IdEstadoVenta" IS '';
COMMENT ON COLUMN "EstadoVenta"."Estado" IS '';
COMMENT ON COLUMN "EstadoVenta"."Activo" IS '';
COMMENT ON COLUMN "EstadoVenta"."Actualiza" IS '';

CREATE TABLE "DetalleVenta" (
	"IdDetalleVenta" UUID NOT NULL DEFAULT uuid_generate_v4(),
	"IdEstadoVenta" UUID NULL DEFAULT NULL,
	"IdVenta" UUID NULL DEFAULT NULL,
	"IdPropiedad" UUID NULL DEFAULT NULL,
	"TotalVenta" VARCHAR NULL DEFAULT NULL,
	"Cantidad" VARCHAR NULL DEFAULT NULL,
	"Activo" BIT NOT NULL DEFAULT '1',
	"Actualiza" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ("IdDetalleVenta"),
	CONSTRAINT "FK_IdEstadoVenta" FOREIGN KEY ("IdEstadoVenta") REFERENCES "EstadoVenta" ("IdEstadoVenta") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdVenta" FOREIGN KEY ("IdVenta") REFERENCES "Venta" ("IdVenta") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "FK_IdPropiedad" FOREIGN KEY ("IdPropiedad") REFERENCES "Propiedad" ("IdPropiedad") ON UPDATE NO ACTION ON DELETE NO ACTION
);
COMMENT ON COLUMN "DetalleVenta"."IdDetalleVenta" IS '';
COMMENT ON COLUMN "DetalleVenta"."IdEstadoVenta" IS '';
COMMENT ON COLUMN "DetalleVenta"."IdVenta" IS '';
COMMENT ON COLUMN "DetalleVenta"."IdPropiedad" IS '';
COMMENT ON COLUMN "DetalleVenta"."TotalVenta" IS '';
COMMENT ON COLUMN "DetalleVenta"."Cantidad" IS '';
COMMENT ON COLUMN "DetalleVenta"."Activo" IS '';
COMMENT ON COLUMN "DetalleVenta"."Actualiza" IS '';
