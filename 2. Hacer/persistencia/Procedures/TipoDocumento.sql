-- Función para Insertar un Tipo de Documento
CREATE OR REPLACE FUNCTION InsertarTipoDocumento(p_documento VARCHAR, p_numero_documento VARCHAR)
RETURNS UUID AS $$
DECLARE
    nuevo_id UUID;
BEGIN
    INSERT INTO "TipoDocumento" ("Documento", "NumeroDocumento")
    VALUES (p_documento, p_numero_documento)
    RETURNING "IdTipoDocumento" INTO nuevo_id;

    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar Lógicamente un Tipo de Documento
CREATE OR REPLACE FUNCTION EliminarTipoDocumentoLogico(p_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoDocumento"
    SET "Activo" = B'0', "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoDocumento" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Eliminar un Tipo de Documento
CREATE OR REPLACE FUNCTION EliminarTipoDocumento(p_id UUID)
RETURNS VOID AS $$
BEGIN
    DELETE FROM "TipoDocumento"
    WHERE "IdTipoDocumento" = p_id AND "Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Actualizar un Tipo de Documento
CREATE OR REPLACE FUNCTION ActualizarTipoDocumento(p_id UUID, p_documento VARCHAR, p_numero_documento VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE "TipoDocumento"
    SET "Documento" = p_documento, "NumeroDocumento" = p_numero_documento, "Actualiza" = CURRENT_TIMESTAMP
    WHERE "IdTipoDocumento" = p_id;
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar Todos los Tipos de Documento Activos
CREATE OR REPLACE FUNCTION SeleccionarTiposDocumento()
RETURNS TABLE("IdTipoDocumento" UUID, "Documento" VARCHAR, "NumeroDocumento" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT td."IdTipoDocumento", td."Documento", td."NumeroDocumento", td."Activo", td."Actualiza"
    FROM "TipoDocumento" td
    WHERE td."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;

-- Función para Seleccionar un Tipo de Documento por Id
CREATE OR REPLACE FUNCTION SeleccionarTipoDocumentoPorId(p_id UUID)
RETURNS TABLE("IdTipoDocumento" UUID, "Documento" VARCHAR, "NumeroDocumento" VARCHAR, "Activo" BIT, "Actualiza" TIMESTAMP) AS $$
BEGIN
    RETURN QUERY
    SELECT td."IdTipoDocumento", td."Documento", td."NumeroDocumento", td."Activo", td."Actualiza"
    FROM "TipoDocumento" td
    WHERE td."IdTipoDocumento" = p_id AND td."Activo" = B'1';
END;
$$ LANGUAGE plpgsql;
