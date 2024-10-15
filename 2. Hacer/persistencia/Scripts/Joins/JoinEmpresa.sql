
/*SELECT 
    e."IdEmpleado", 
    e."Nombre" AS "EmpleadoNombre", 
    te."TipoEmpleado", 
    s."Nombre" AS "SedeNombre", 
    a."Nombre" AS "AgenciaNombre"
FROM 
    "Empleado" e
JOIN 
    "TipoEmpleado" te ON e."IdTipoEmpleado" = te."IdTipoEmpleado"
JOIN 
    "Sede" s ON e."IdSede" = s."IdSede"
JOIN 
    "Agencia" a ON s."IdAgencia" = a."IdAgencia" WHERE 
    
		"te"."Activo" = '1'
	AND
		"e"."Activo" = '1'
	AND
		"s"."Activo" = '1'
	AND
		"a"."Activo" = '1'	;
		
		*/
		

SELECT jsonb_build_object(
    'IdEmpleado', e."IdEmpleado", 
    'EmpleadoNombre', e."Nombre", 
    'TipoEmpleado', te."TipoEmpleado", 
    'SedeNombre', s."Nombre", 
    'AgenciaNombre', a."Nombre"
) as Empresa
FROM 
    "Empleado" e
JOIN 
    "TipoEmpleado" te ON e."IdTipoEmpleado" = te."IdTipoEmpleado"
JOIN 
    "Sede" s ON e."IdSede" = s."IdSede"
JOIN 
    "Agencia" a ON s."IdAgencia" = a."IdAgencia"
WHERE 
    te."Activo" = '1' AND
    e."Activo" = '1' AND
    s."Activo" = '1' AND
    a."Activo" = '1';
