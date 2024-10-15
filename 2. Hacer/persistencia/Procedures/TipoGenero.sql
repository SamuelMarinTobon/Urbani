-- Función para Insertar un Tipo de Género
CREATE OR REPLACE FUNCTION InsertarTipoGenero(p_genero VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "TipoGenero" ("Genero")
    VALUES (p_genero)
    RETURNING "IdTipoGenero" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Tipo de Género
CREATE OR REPLACE FUNCTION EliminarTipoGeneroLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoGenero"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoGenero" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Tipo de Género
CREATE OR REPLACE FUNCTION EliminarTipoGenero(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "TipoGenero"
    WHERE "IdTipoGenero" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Tipo de Género
CREATE OR REPLACE FUNCTION ActualizarTipoGenero(p_id UUID, p_genero VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoGenero"
    SET "Genero" = p_genero, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoGenero" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Tipos de Género Activos
CREATE OR REPLACE FUNCTION SeleccionarTiposGenero()
RETURNS TABLE("IdTipoGenero" UUID, "Genero" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT tg."IdTipoGenero", tg."Genero", tg."Activo", tg."Actualiza"
    FROM "TipoGenero" tg
    WHERE tg."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Tipo de Género por Id
CREATE OR REPLACE FUNCTION SeleccionarTipoGeneroPorId(p_id UUID)
RETURNS TABLE("IdTipoGenero" UUID, "Genero" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT tg."IdTipoGenero", tg."Genero", tg."Activo", tg."Actualiza"
    FROM "TipoGenero" tg
    WHERE tg."IdTipoGenero" = p_id AND tg."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
