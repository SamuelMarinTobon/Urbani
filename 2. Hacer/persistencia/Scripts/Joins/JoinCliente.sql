/*SELECT 
    c."IdCliente",
    c."Nombre",
    c."Email",
    c."Telefono",
    tg."Genero",
    td."Documento",
    td."NumeroDocumento"
FROM 
    "Cliente" c
JOIN 
    "TipoGenero" tg ON c."IdTipoGenero" = tg."IdTipoGenero"
JOIN 
    "TipoDocumento" td ON c."IdTipoDocumento" = td."IdTipoDocumento"
WHERE 
    c."Activo" = '1' AND
    tg."Activo" = '1' AND
    td."Activo" = '1';
*/


SELECT jsonb_build_object(
    'IdCliente', c."IdCliente",
    'Nombre', c."Nombre",
    'Email', c."Email",
    'Telefono', c."Telefono",
    'Genero', tg."Genero",
    'TipoDocumento', td."Documento",
    'NumeroDocumento', td."NumeroDocumento"
) as Cliente
FROM 
    "Cliente" c
JOIN 
    "TipoGenero" tg ON c."IdTipoGenero" = tg."IdTipoGenero"
JOIN 
    "TipoDocumento" td ON c."IdTipoDocumento" = td."IdTipoDocumento"
WHERE 
    c."Activo" = '1' AND
    tg."Activo" = '1' AND
    td."Activo" = '1';
