import React from 'react';
import './App.css';
import Propiedades from './Propiedades';
import PropiedadesID from './PropiedadesID';
import PropiedadesTipoPropiedad from './PropiedadesTipoPropiedad';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>Consulta de Propiedades</h1>
        <Propiedades />
		
		<h1>Consulta de Propiedades por Id</h1>
        <PropiedadesID />
		
		<h1>Consulta de Propiedades por Tipo</h1>
        <PropiedadesTipoPropiedad />


      </header>
    </div>
  );
}

export default App;
