-- Función para Insertar un Detalle de Venta
CREATE OR REPLACE FUNCTION InsertarDetalleVenta(p_idestadoventa UUID, p_idventa UUID, p_idpropiedad UUID, p_totalventa VARCHAR, p_cantidad VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "DetalleVenta" ("IdEstadoVenta", "IdVenta", "IdPropiedad", "TotalVenta", "Cantidad")
    VALUES (p_idestadoventa, p_idventa, p_idpropiedad, p_totalventa, p_cantidad)
    RETURNING "IdDetalleVenta" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Detalle de Venta
CREATE OR REPLACE FUNCTION EliminarDetalleVentaLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "DetalleVenta"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdDetalleVenta" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Detalle de Venta
CREATE OR REPLACE FUNCTION EliminarDetalleVenta(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "DetalleVenta"
    WHERE "IdDetalleVenta" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Detalle de Venta
CREATE OR REPLACE FUNCTION ActualizarDetalleVenta(p_id UUID, p_idestadoventa UUID, p_idventa UUID, p_idpropiedad UUID, p_totalventa VARCHAR, p_cantidad VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "DetalleVenta"
    SET "IdEstadoVenta" = p_idestadoventa, "IdVenta" = p_idventa, "IdPropiedad" = p_idpropiedad, "TotalVenta" = p_totalventa, "Cantidad" = p_cantidad, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdDetalleVenta" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Detalles de Venta Activos
CREATE OR REPLACE FUNCTION SeleccionarDetallesVenta()
RETURNS TABLE("IdDetalleVenta" UUID, "IdEstadoVenta" UUID, "IdVenta" UUID, "IdPropiedad" UUID, "TotalVenta" VARCHAR, "Cantidad" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT dv."IdDetalleVenta", dv."IdEstadoVenta", dv."IdVenta", dv."IdPropiedad", dv."TotalVenta", dv."Cantidad", dv."Activo", dv."Actualiza"
    FROM "DetalleVenta" dv
    WHERE dv."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Detalle de Venta por Id
CREATE OR REPLACE FUNCTION SeleccionarDetalleVentaPorId(p_id UUID)
RETURNS TABLE("IdDetalleVenta" UUID, "IdEstadoVenta" UUID, "IdVenta" UUID, "IdPropiedad" UUID, "TotalVenta" VARCHAR, "Cantidad" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT dv."IdDetalleVenta", dv."IdEstadoVenta", dv."IdVenta", dv."IdPropiedad", dv."TotalVenta", dv."Cantidad", dv."Activo", dv."Actualiza"
    FROM "DetalleVenta" dv
    WHERE dv."IdDetalleVenta" = p_id AND dv."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
