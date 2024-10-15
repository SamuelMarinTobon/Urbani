import React, { useState } from 'react';

const PropiedadesID = () => {
  const [idPropiedad, setIdPropiedad] = useState(''); 
  const [propiedades, setPropiedades] = useState([]);    
  const [loading, setLoading] = useState(false);       

  const buscarpropiedadPorId = () => {
    setLoading(true);

    fetch(`http://localhost:3000/operaciongetproductoid/${idPropiedad}`)  
      .then((response) => response.json())
      .then((data) => {
        setPropiedades(data);  
        setLoading(false);   
      })
      .catch((error) => {
        console.error('Error al cargar datos:', error);
        setLoading(false);
      });
  };

  if (loading) return <p>Cargando datos...</p>;

  return (
    <div>
      <input
        type="text"
        value={idPropiedad}
        onChange={(e) => setIdPropiedad(e.target.value)}
        
      />
      <button onClick={buscarpropiedadPorId}>Buscar</button>

      <div>
        <table>
          <thead>
            <tr>
              <th>Precio</th>
              <th>IdPropiedad</th>
              <th>TipoPropiedad</th>
              <th>EstadoPropiedad</th>
            </tr>
          </thead>
          <tbody>
            {propiedades.map((propiedad) => (
              <tr key={propiedad._id}>
                <td>{propiedad.Precio}</td>
                <td>{propiedad.IdPropiedad}</td>
                <td>{propiedad.TipoPropiedad}</td>
                <td>{propiedad.EstadoPropiedad}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default PropiedadesID;
