const {ModelProducto,modelproducto}= require ('../../../domain/object/producto/modelproducto');
const {MongoClient,ObjectId} = require('mongodb')

const uri = "mongodb+srv://dbaUsername:dbaPassword@cluster0.jtr9a.mongodb.net/dbaUrbanos?retryWrites=true&w=majority";


const dbName = 'dbaUrbanos';
const collectionName = 'Producto';

class InfrastructureProducto {
	
	constructor(){	
	}	
	
	async consultarproducto(){
		const client = new MongoClient(uri);
        const db = client.db(dbName);
        const col = db.collection(collectionName);	
		let results = [];
		try {
            results = await col.find().toArray();
            console.log('Documentos encontrados:', results.length);
			console.log(results);			
		} catch (err) {
			console.error(err);
			console.error(err.message);
		} finally {
			await client.close();
		}
		return results;	
	}
	
	async consultarproductoid(id){
		const client = new MongoClient(uri);
		const db = client.db(dbName);
		const col = db.collection(collectionName);
		let results = [];		
		try {
			results = await col.find({ "_id": new ObjectId(id) }).toArray();		
			console.log('Documentos encontrados:', results.length);
			console.log(results);			
		} catch (err) {
			console.error(err);
			console.error(err.message);
		} finally {
			await client.close();
		}
		return results;	
	}
	
	async consultarproductotipopropiedad(tipopropiedad){
		const client = new MongoClient(uri);
		const db = client.db(dbName);
		const col = db.collection(collectionName);
		let results = [];		
		try {
			results = await col.find({ "TipoPropiedad": tipopropiedad }).toArray();		
			console.log('Documentos encontrados:', results.length);
			console.log(results);			
		} catch (err) {
			console.error(err);
			console.error(err.message);
		} finally {
			await client.close();
		}
		return results;	
	}
	
	}


module.exports = { InfrastructureProducto };