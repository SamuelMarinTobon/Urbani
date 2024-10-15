-- Función para Insertar una Agencia
CREATE OR REPLACE FUNCTION InsertarAgencia(p_nit VARCHAR, p_nombre VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Agencia" ("NIT", "Nombre")
    VALUES (p_nit, p_nombre)
    RETURNING "IdAgencia" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente una Agencia
CREATE OR REPLACE FUNCTION EliminarAgenciaLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Agencia"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdAgencia" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar una Agencia
CREATE OR REPLACE FUNCTION EliminarAgencia(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Agencia"
    WHERE "IdAgencia" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar una Agencia
CREATE OR REPLACE FUNCTION ActualizarAgencia(p_id UUID, p_nit VARCHAR, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Agencia"
    SET "NIT" = p_nit, "Nombre" = p_nombre, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdAgencia" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todas las Agencias Activas
CREATE OR REPLACE FUNCTION SeleccionarAgencias()
RETURNS TABLE("IdAgencia" UUID, "NIT" VARCHAR, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT a."IdAgencia", a."NIT", a."Nombre", a."Activo", a."Actualiza"
    FROM "Agencia" a
    WHERE a."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar una Agencia por Id
CREATE OR REPLACE FUNCTION SeleccionarAgenciaPorId(p_id UUID)
RETURNS TABLE("IdAgencia" UUID, "NIT" VARCHAR, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT a."IdAgencia", a."NIT", a."Nombre", a."Activo", a."Actualiza"
    FROM "Agencia" a
    WHERE a."IdAgencia" = p_id AND a."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
