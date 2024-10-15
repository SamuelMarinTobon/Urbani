-- Función para Insertar una Venta
CREATE OR REPLACE FUNCTION InsertarVenta(p_idciudad UUID, p_idempleado UUID, p_idcliente UUID)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "Venta" ("IdCiudad", "IdEmpleado", "IdCliente")
    VALUES (p_idciudad, p_idempleado, p_idcliente)
    RETURNING "IdVenta" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente una Venta
CREATE OR REPLACE FUNCTION EliminarVentaLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Venta"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdVenta" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar una Venta
CREATE OR REPLACE FUNCTION EliminarVenta(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "Venta"
    WHERE "IdVenta" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar una Venta
CREATE OR REPLACE FUNCTION ActualizarVenta(p_id UUID, p_idciudad UUID, p_idempleado UUID, p_idcliente UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "Venta"
    SET "IdCiudad" = p_idciudad, "IdEmpleado" = p_idempleado, "IdCliente" = p_idcliente, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdVenta" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todas las Ventas Activas
CREATE OR REPLACE FUNCTION SeleccionarVentas()
RETURNS TABLE("IdVenta" UUID, "IdCiudad" UUID, "IdEmpleado" UUID, "IdCliente" UUID, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT v."IdVenta", v."IdCiudad", v."IdEmpleado", v."IdCliente", v."Activo", v."Actualiza"
    FROM "Venta" v
    WHERE v."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar una Venta por Id
CREATE OR REPLACE FUNCTION SeleccionarVentaPorId(p_id UUID)
RETURNS TABLE("IdVenta" UUID, "IdCiudad" UUID, "IdEmpleado" UUID, "IdCliente" UUID, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT v."IdVenta", v."IdCiudad", v."IdEmpleado", v."IdCliente", v."Activo", v."Actualiza"
    FROM "Venta" v
    WHERE v."IdVenta" = p_id AND v."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
