/*SELECT 
    p."IdPropiedad",
    p."Precio",
    tp."Tipo" AS "TipoPropiedad",
    ep."Estado" AS "EstadoPropiedad"
FROM 
    "Propiedad" p
JOIN 
    "TipoPropiedad" tp ON p."IdTipoPropiedad" = tp."IdTipoPropiedad"
JOIN 
    "EstadoPropiedad" ep ON p."IdEstadoPropiedad" = ep."IdEstadoPropiedad"
WHERE 
    p."Activo" = '1' AND
    tp."Activo" = '1' AND
    ep."Activo" = '1';
*/

SELECT 
    jsonb_build_object(
        'IdPropiedad', p."IdPropiedad",
        'Precio', p."Precio",
        'TipoPropiedad', tp."Tipo",
        'EstadoPropiedad', ep."Estado"
    ) AS Propiedad
FROM 
    "Propiedad" p
JOIN 
    "TipoPropiedad" tp ON p."IdTipoPropiedad" = tp."IdTipoPropiedad"
JOIN 
    "EstadoPropiedad" ep ON p."IdEstadoPropiedad" = ep."IdEstadoPropiedad"
WHERE 
    p."Activo" = '1' AND
    tp."Activo" = '1' AND
    ep."Activo" = '1';
