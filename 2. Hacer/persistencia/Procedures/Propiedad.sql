-- Función para Insertar una Propiedad
CREATE OR REPLACE FUNCTION InsertarPropiedad(p_idtipopropiedad UUID, p_idestadopropiedad UUID, p_precio VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Propiedad" ("IdTipoPropiedad", "IdEstadoPropiedad", "Precio")
    VALUES (p_idtipopropiedad, p_idestadopropiedad, p_precio)
    RETURNING "IdPropiedad" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente una Propiedad
CREATE OR REPLACE FUNCTION EliminarPropiedadLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Propiedad"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdPropiedad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar una Propiedad
CREATE OR REPLACE FUNCTION EliminarPropiedad(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Propiedad"
    WHERE "IdPropiedad" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar una Propiedad
CREATE OR REPLACE FUNCTION ActualizarPropiedad(p_id UUID, p_idtipopropiedad UUID, p_idestadopropiedad UUID, p_precio VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "Propiedad"
    SET "IdTipoPropiedad" = p_idtipopropiedad, "IdEstadoPropiedad" = p_idestadopropiedad, "Precio" = p_precio, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdPropiedad" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todas las Propiedades Activas
CREATE OR REPLACE FUNCTION SeleccionarPropiedades()
RETURNS TABLE("IdPropiedad" UUID, "IdTipoPropiedad" UUID, "IdEstadoPropiedad" UUID, "Precio" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT p."IdPropiedad", p."IdTipoPropiedad", p."IdEstadoPropiedad", p."Precio", p."Activo", p."Actualiza"
    FROM "Propiedad" p
    WHERE p."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar una Propiedad por Id
CREATE OR REPLACE FUNCTION SeleccionarPropiedadPorId(p_id UUID)
RETURNS TABLE("IdPropiedad" UUID, "IdTipoPropiedad" UUID, "IdEstadoPropiedad" UUID, "Precio" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT p."IdPropiedad", p."IdTipoPropiedad", p."IdEstadoPropiedad", p."Precio", p."Activo", p."Actualiza"
    FROM "Propiedad" p
    WHERE p."IdPropiedad" = p_id AND p."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
