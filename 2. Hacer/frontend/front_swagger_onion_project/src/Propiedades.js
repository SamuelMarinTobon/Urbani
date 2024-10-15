
// src/Ubicaciones.js

import React, { useEffect, useState } from 'react';

const Propiedades = () => {
  const [propiedades, setPropiedades] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('http://localhost:3000/operaciongetproducto') 
      .then((response) => response.json())
      .then((data) => {
        setPropiedades(data);
        setLoading(false);
      })
      .catch((error) => {
        console.error('Error al cargar datos:', error);
        setLoading(false);
      });
  }, []);

  if (loading) return <p>Cargando datos...</p>;

  return (
    <div>
      <table>
        <thead>
          <tr>
			<th>_id</th>
            <th>Precio</th>
            <th>IdPropiedad</th>
            <th>TipoPropiedad</th>
            <th>EstadoPropiedad</th>
 
          </tr>
        </thead>
        <tbody>
          {propiedades.map((propiedad) => (
            <tr key={propiedad._id}>
			  <td>{propiedad._id}</td>
              <td>{propiedad.Precio}</td>
              <td>{propiedad.IdPropiedad}</td>
              <td>{propiedad.TipoPropiedad}</td>
              <td>{propiedad.EstadoPropiedad}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Propiedades;