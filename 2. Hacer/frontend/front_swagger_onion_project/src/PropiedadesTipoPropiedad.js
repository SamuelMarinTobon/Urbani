import React, { useState } from 'react';

const PropiedadesTipoPropiedad = () => {
  const [tipoPropiedad, setTipoPropiedad] = useState(''); 
  const [propiedades, setPropiedades] = useState([]);    
  const [loading, setLoading] = useState(false);       

  const buscarpropiedadPorTipo = () => {
    setLoading(true);

    fetch(`http://localhost:3000/operaciongetproductotipopropiedad/${tipoPropiedad}`)  
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
        value={tipoPropiedad}
        onChange={(e) => setTipoPropiedad(e.target.value)}
        
      />
      <button onClick={buscarpropiedadPorTipo}>Buscar</button>

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

export default PropiedadesTipoPropiedad;
