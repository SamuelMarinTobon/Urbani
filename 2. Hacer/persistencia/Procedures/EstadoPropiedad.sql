-- Función para Insertar un Estado de Propiedad
CREATE OR REPLACE FUNCTION InsertarEstadoPropiedad(p_nombre VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "EstadoPropiedad" ("Nombre")
    VALUES (p_nombre)
    RETURNING "IdEstadoPropiedad" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Estado de Propiedad
CREATE OR REPLACE FUNCTION EliminarEstadoPropiedadLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "EstadoPropiedad"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdEstadoPropiedad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Estado de Propiedad
CREATE OR REPLACE FUNCTION EliminarEstadoPropiedad(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "EstadoPropiedad"
    WHERE "IdEstadoPropiedad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Estado de Propiedad
CREATE OR REPLACE FUNCTION ActualizarEstadoPropiedad(p_id UUID, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "EstadoPropiedad"
    SET "Nombre" = p_nombre, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdEstadoPropiedad" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Estados de Propiedad Activos
CREATE OR REPLACE FUNCTION SeleccionarEstadosPropiedad()
RETURNS TABLE("IdEstadoPropiedad" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT ep."IdEstadoPropiedad", ep."Nombre", ep."Activo", ep."Actualiza"
    FROM "EstadoPropiedad" ep
    WHERE ep."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Estado de Propiedad por Id
CREATE OR REPLACE FUNCTION SeleccionarEstadoPropiedadPorId(p_id UUID)
RETURNS TABLE("IdEstadoPropiedad" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT ep."IdEstadoPropiedad", ep."Nombre", ep."Activo", ep."Actualiza"
    FROM "EstadoPropiedad" ep
    WHERE ep."IdEstadoPropiedad" = p_id AND ep."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
