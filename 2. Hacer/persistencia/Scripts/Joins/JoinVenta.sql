/*
SELECT 
    v."IdVenta",
    dv."IdDetalleVenta",
    dv."TotalVenta",
    dv."Cantidad",
    ev."Estado" AS "EstadoVenta"
FROM 
    "Venta" v
JOIN 
    "DetalleVenta" dv ON v."IdVenta" = dv."IdVenta"
JOIN 
    "EstadoVenta" ev ON dv."IdEstadoVenta" = ev."IdEstadoVenta"
WHERE 
    v."Activo" = '1' AND
    dv."Activo" = '1' AND
    ev."Activo" = '1';

*/
SELECT 
    jsonb_build_object(
        'IdVenta', v."IdVenta",
        'IdDetalleVenta', dv."IdDetalleVenta",
        'TotalVenta', dv."TotalVenta",
        'Cantidad', dv."Cantidad",
        'EstadoVenta', ev."Estado"
    ) AS Venta
FROM 
    "Venta" v
JOIN 
    "DetalleVenta" dv ON v."IdVenta" = dv."IdVenta"
JOIN 
    "EstadoVenta" ev ON dv."IdEstadoVenta" = ev."IdEstadoVenta"
WHERE 
    v."Activo" = '1' AND
    dv."Activo" = '1' AND
    ev."Activo" = '1';
