-- Función para Insertar un Estado de Venta
CREATE OR REPLACE FUNCTION InsertarEstadoVenta(p_estado VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "EstadoVenta" ("Estado")
    VALUES (p_estado)
    RETURNING "IdEstadoVenta" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Estado de Venta
CREATE OR REPLACE FUNCTION EliminarEstadoVentaLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "EstadoVenta"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdEstadoVenta" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Estado de Venta
CREATE OR REPLACE FUNCTION EliminarEstadoVenta(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "EstadoVenta"
    WHERE "IdEstadoVenta" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Estado de Venta
CREATE OR REPLACE FUNCTION ActualizarEstadoVenta(p_id UUID, p_estado VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "EstadoVenta"
    SET "Estado" = p_estado, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdEstadoVenta" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Estados de Venta Activos
CREATE OR REPLACE FUNCTION SeleccionarEstadosVenta()
RETURNS TABLE("IdEstadoVenta" UUID, "Estado" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT ev."IdEstadoVenta", ev."Estado", ev."Activo", ev."Actualiza"
    FROM "EstadoVenta" ev
    WHERE ev."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Estado de Venta por Id
CREATE OR REPLACE FUNCTION SeleccionarEstadoVentaPorId(p_id UUID)
RETURNS TABLE("IdEstadoVenta" UUID, "Estado" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT ev."IdEstadoVenta", ev."Estado", ev."Activo", ev."Actualiza"
    FROM "EstadoVenta" ev
    WHERE ev."IdEstadoVenta" = p_id AND ev."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
