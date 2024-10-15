-- Función para Insertar un Tipo de Empleado
CREATE OR REPLACE FUNCTION InsertarTipoEmpleado(p_tipoempleado VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "TipoEmpleado" ("TipoEmpleado")
    VALUES (p_tipoempleado)
    RETURNING "IdTipoEmpleado" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Tipo de Empleado
CREATE OR REPLACE FUNCTION EliminarTipoEmpleadoLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoEmpleado"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoEmpleado" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Tipo de Empleado
CREATE OR REPLACE FUNCTION EliminarTipoEmpleado(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "TipoEmpleado"
    WHERE "IdTipoEmpleado" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Tipo de Empleado
CREATE OR REPLACE FUNCTION ActualizarTipoEmpleado(p_id UUID, p_tipoempleado VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoEmpleado"
    SET "TipoEmpleado" = p_tipoempleado, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoEmpleado" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Tipos de Empleado Activos
CREATE OR REPLACE FUNCTION SeleccionarTiposEmpleado()
RETURNS TABLE("IdTipoEmpleado" UUID, "TipoEmpleado" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT te."IdTipoEmpleado", te."TipoEmpleado", te."Activo", te."Actualiza"
    FROM "TipoEmpleado" te
    WHERE te."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Tipo de Empleado por Id
CREATE OR REPLACE FUNCTION SeleccionarTipoEmpleadoPorId(p_id UUID)
RETURNS TABLE("IdTipoEmpleado" UUID, "TipoEmpleado" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT te."IdTipoEmpleado", te."TipoEmpleado", te."Activo", te."Actualiza"
    FROM "TipoEmpleado" te
    WHERE te."IdTipoEmpleado" = p_id AND te."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
