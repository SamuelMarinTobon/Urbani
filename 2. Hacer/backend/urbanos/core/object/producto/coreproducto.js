const {ModelProducto,modelproducto}= require ('../../../domain/object/producto/modelproducto');
const { InfrastructureProducto } = require('../../../infraestructure/object/producto/infraestructureproducto'); 

class CoreProducto {
	
	constructor(){}

	async consultarproducto(){
		const infrastructureproducto = new InfrastructureProducto();	
		try {
            return await infrastructureproducto.consultarproducto();			
		} catch (err) {
			console.error(err.message);
		}
	}
	async consultarproductoid(id){
		const infrastructureproducto = new InfrastructureProducto();	
		try {
            return await infrastructureproducto.consultarproductoid(id);			
		} catch (err) {
			console.error(err.message);
		}
	}
	async consultarproductotipopropiedad(tipopropiedad){
		const infrastructureproducto = new InfrastructureProducto();	
		try {
            return await infrastructureproducto.consultarproductotipopropiedad(tipopropiedad);			
		} catch (err) {
			console.error(err.message);
		}
	}
}

module.exports = { CoreProducto };