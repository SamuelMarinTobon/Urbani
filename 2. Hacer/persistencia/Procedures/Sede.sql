-- Función para Insertar una Sede
CREATE OR REPLACE FUNCTION InsertarSede(p_nombre VARCHAR, p_idagencia UUID)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Sede" ("Nombre", "IdAgencia")
    VALUES (p_nombre, p_idagencia)
    RETURNING "IdSede" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente una Sede
CREATE OR REPLACE FUNCTION EliminarSedeLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Sede"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdSede" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar una Sede
CREATE OR REPLACE FUNCTION EliminarSede(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Sede"
    WHERE "IdSede" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar una Sede
CREATE OR REPLACE FUNCTION ActualizarSede(p_id UUID, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Sede"
    SET "Nombre" = p_nombre, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdSede" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todas las Sedes Activas
CREATE OR REPLACE FUNCTION SeleccionarSedes()
RETURNS TABLE("IdSede" UUID, "IdAgencia" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT s."IdSede", s."IdAgencia", s."Nombre", s."Activo", s."Actualiza"
    FROM "Sede" s
    WHERE s."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar una Sede por Id
CREATE OR REPLACE FUNCTION SeleccionarSedePorId(p_id UUID)
RETURNS TABLE("IdSede" UUID, "IdAgencia" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT s."IdSede", s."IdAgencia", s."Nombre", s."Activo", s."Actualiza"
    FROM "Sede" s
    WHERE s."IdSede" = p_id AND s."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

