-- Función para Insertar un Tipo de Propiedad
CREATE OR REPLACE FUNCTION InsertarTipoPropiedad(p_nombre VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "TipoPropiedad" ("Nombre")
    VALUES (p_nombre)
    RETURNING "IdTipoPropiedad" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Tipo de Propiedad
CREATE OR REPLACE FUNCTION EliminarTipoPropiedadLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoPropiedad"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoPropiedad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Tipo de Propiedad
CREATE OR REPLACE FUNCTION EliminarTipoPropiedad(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "TipoPropiedad"
    WHERE "IdTipoPropiedad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Tipo de Propiedad
CREATE OR REPLACE FUNCTION ActualizarTipoPropiedad(p_id UUID, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoPropiedad"
    SET "Nombre" = p_nombre, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoPropiedad" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Tipos de Propiedad Activos
CREATE OR REPLACE FUNCTION SeleccionarTiposPropiedad()
RETURNS TABLE("IdTipoPropiedad" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT tp."IdTipoPropiedad", tp."Nombre", tp."Activo", tp."Actualiza"
    FROM "TipoPropiedad" tp
    WHERE tp."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Tipo de Propiedad por Id
CREATE OR REPLACE FUNCTION SeleccionarTipoPropiedadPorId(p_id UUID)
RETURNS TABLE("IdTipoPropiedad" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT tp."IdTipoPropiedad", tp."Nombre", tp."Activo", tp."Actualiza"
    FROM "TipoPropiedad" tp
    WHERE tp."IdTipoPropiedad" = p_id AND tp."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
