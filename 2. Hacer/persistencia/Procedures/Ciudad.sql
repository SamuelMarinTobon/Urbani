-- Función para Insertar una Ciudad
CREATE OR REPLACE FUNCTION InsertarCiudad(p_nombre VARCHAR, p_iddepartamento UUID)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Ciudad" ("Nombre", "IdDepartamento")
    VALUES (p_nombre, p_iddepartamento)
    RETURNING "IdCiudad" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente una Ciudad
CREATE OR REPLACE FUNCTION EliminarCiudadLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Ciudad"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdCiudad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar una Ciudad
CREATE OR REPLACE FUNCTION EliminarCiudad(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Ciudad"
    WHERE "IdCiudad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar una Ciudad
CREATE OR REPLACE FUNCTION ActualizarCiudad(p_id UUID, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Ciudad"
    SET "Nombre" = p_nombre, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdCiudad" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todas las Ciudades Activas
CREATE OR REPLACE FUNCTION SeleccionarCiudades()
RETURNS TABLE("IdCiudad" UUID, "IdDepartamento" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT c."IdCiudad", c."IdDepartamento", c."Nombre", c."Activo", c."Actualiza"
    FROM "Ciudad" c
    WHERE c."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar una Ciudad por Id
CREATE OR REPLACE FUNCTION SeleccionarCiudadPorId(p_id UUID)
RETURNS TABLE("IdCiudad" UUID, "IdDepartamento" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT c."IdCiudad", c."IdDepartamento", c."Nombre", c."Activo", c."Actualiza"
    FROM "Ciudad" c
    WHERE c."IdCiudad" = p_id AND c."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
