-- Función para Insertar un Departamento
CREATE OR REPLACE FUNCTION InsertarDepartamento(p_nombre VARCHAR, p_idpais UUID)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Departamento" ("Nombre", "IdPais")
    VALUES (p_nombre, p_idpais)
    RETURNING "IdDepartamento" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Departamento
CREATE OR REPLACE FUNCTION EliminarDepartamentoLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Departamento"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdDepartamento" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Departamento
CREATE OR REPLACE FUNCTION EliminarDepartamento(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Departamento"
    WHERE "IdDepartamento" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Departamento
CREATE OR REPLACE FUNCTION ActualizarDepartamento(p_id UUID, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Departamento"
    SET "Nombre" = p_nombre, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdDepartamento" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Departamentos Activos
CREATE OR REPLACE FUNCTION SeleccionarDepartamentos()
RETURNS TABLE("IdDepartamento" UUID, "IdPais" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT d."IdDepartamento", d."IdPais", d."Nombre", d."Activo", d."Actualiza"
    FROM "Departamento" d
    WHERE d."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Departamento por Id
CREATE OR REPLACE FUNCTION SeleccionarDepartamentoPorId(p_id UUID)
RETURNS TABLE("IdDepartamento" UUID, "IdPais" UUID, "Nombre" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT d."IdDepartamento", d."IdPais", d."Nombre", d."Activo", d."Actualiza"
    FROM "Departamento" d
    WHERE d."IdDepartamento" = p_id AND d."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
