const modelproducto =[];
class ModelProducto{
	constructor(Precio,
				IdPropiedad,
				TipoPropiedad,
				EstadoPropiedad
				){
		this.Precio=Precio;
		this.IdPropiedad=IdPropiedad;
		this.TipoPropiedad=TipoPropiedad;
		this.EstadoPropiedad=EstadoPropiedad;
		
	}
}

module.exports ={ModelProducto,modelproducto}
