-- Función para Insertar un Registro en la Tabla Pais
CREATE OR REPLACE FUNCTION InsertarPais(p_nombre VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Pais" ("Nombre")
    VALUES (p_nombre)
    RETURNING "IdPais" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Registro (Soft Delete)
CREATE OR REPLACE FUNCTION EliminarLogicoPais(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Pais"
    SET "Activo" = '0',
        "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdPais" = p_id
      AND "Activo" = '1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Registros Activos
CREATE OR REPLACE FUNCTION SeleccionarPaises()
RETURNS TABLE("IdPais" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT p."IdPais", p."Nombre", p."Activo", p."Actualiza"
    FROM "Pais" p
    WHERE p."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Físicamente un Registro
CREATE OR REPLACE FUNCTION EliminarPais(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Pais"
    WHERE "IdPais" = p_id
      AND "Activo" = '1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Registro por IdPais
CREATE OR REPLACE FUNCTION SeleccionarPaisPorId(p_id UUID)
RETURNS TABLE("IdPais" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT p."IdPais", p."Nombre", p."Activo", p."Actualiza"
    FROM "Pais" p
    WHERE p."IdPais" = p_id
      AND p."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Registro
CREATE OR REPLACE FUNCTION ActualizarPais(p_id UUID, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Pais"
    SET "Nombre" = p_nombre,
        "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdPais" = p_id;
END;
$$ LANGUAGE plpgsql;
