-- Función para Insertar un Cliente
CREATE OR REPLACE FUNCTION InsertarCliente(p_idtipodocumento UUID, p_idtipogenero UUID, p_nombre VARCHAR, p_email VARCHAR, p_telefono VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Cliente" ("IdTipoDocumento", "IdTipoGenero", "Nombre", "Email", "Telefono")
    VALUES (p_idtipodocumento, p_idtipogenero, p_nombre, p_email, p_telefono)
    RETURNING "IdCliente" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Cliente
CREATE OR REPLACE FUNCTION EliminarClienteLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Cliente"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdCliente" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Cliente
CREATE OR REPLACE FUNCTION EliminarCliente(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Cliente"
    WHERE "IdCliente" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Cliente
CREATE OR REPLACE FUNCTION ActualizarCliente(p_id UUID, p_idtipodocumento UUID, p_idtipogenero UUID, p_nombre VARCHAR, p_email VARCHAR, p_telefono VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Cliente"
    SET "IdTipoDocumento" = p_idtipodocumento, "IdTipoGenero" = p_idtipogenero, "Nombre" = p_nombre, "Email" = p_email, "Telefono" = p_telefono, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdCliente" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Clientes Activos
CREATE OR REPLACE FUNCTION SeleccionarClientes()
RETURNS TABLE("IdCliente" UUID, "IdTipoDocumento" UUID, "IdTipoGenero" UUID, "Nombre" VARCHAR, "Email" VARCHAR, "Telefono" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT c."IdCliente", c."IdTipoDocumento", c."IdTipoGenero", c."Nombre", c."Email", c."Telefono", c."Activo", c."Actualiza"
    FROM "Cliente" c
    WHERE c."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Cliente por Id
CREATE OR REPLACE FUNCTION SeleccionarClientePorId(p_id UUID)
RETURNS TABLE("IdCliente" UUID, "IdTipoDocumento" UUID, "IdTipoGenero" UUID, "Nombre" VARCHAR, "Email" VARCHAR, "Telefono" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT c."IdCliente", c."IdTipoDocumento", c."IdTipoGenero", c."Nombre", c."Email", c."Telefono", c."Activo", c."Actualiza"
    FROM "Cliente" c
    WHERE c."IdCliente" = p_id AND c."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
