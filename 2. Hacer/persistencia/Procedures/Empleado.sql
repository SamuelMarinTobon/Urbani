-- Función para Insertar un Empleado
CREATE OR REPLACE FUNCTION InsertarEmpleado(p_idsede UUID, p_idtipoempleado UUID, p_nombre VARCHAR, p_telefono VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Empleado" ("IdSede", "IdTipoEmpleado", "Nombre", "Telefono")
    VALUES (p_idsede, p_idtipoempleado, p_nombre, p_telefono)
    RETURNING "IdEmpleado" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Empleado
CREATE OR REPLACE FUNCTION EliminarEmpleadoLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Empleado"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdEmpleado" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Empleado
CREATE OR REPLACE FUNCTION EliminarEmpleado(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Empleado"
    WHERE "IdEmpleado" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Empleado
CREATE OR REPLACE FUNCTION ActualizarEmpleado(p_id UUID, p_idsede UUID, p_idtipoempleado UUID, p_nombre VARCHAR, p_telefono VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Empleado"
    SET "IdSede" = p_idsede, "IdTipoEmpleado" = p_idtipoempleado, "Nombre" = p_nombre, "Telefono" = p_telefono, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdEmpleado" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Empleados Activos
CREATE OR REPLACE FUNCTION SeleccionarEmpleados()
RETURNS TABLE("IdEmpleado" UUID, "IdSede" UUID, "IdTipoEmpleado" UUID, "Nombre" VARCHAR, "Telefono" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT e."IdEmpleado", e."IdSede", e."IdTipoEmpleado", e."Nombre", e."Telefono", e."Activo", e."Actualiza"
    FROM "Empleado" e
    WHERE e."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Empleado por Id
CREATE OR REPLACE FUNCTION SeleccionarEmpleadoPorId(p_id UUID)
RETURNS TABLE("IdEmpleado" UUID, "IdSede" UUID, "IdTipoEmpleado" UUID, "Nombre" VARCHAR, "Telefono" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT e."IdEmpleado", e."IdSede", e."IdTipoEmpleado", e."Nombre", e."Telefono", e."Activo", e."Actualiza"
    FROM "Empleado" e
    WHERE e."IdEmpleado" = p_id AND e."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
