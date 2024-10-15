const swaggerJSDoc = require('swagger-jsdoc');

const options ={
	definition:{
		openapi:'3.0.0',
		info:{
			title:'Producto API',
			version:'1.0.0',
			description:'Producto API'
		}
	},
	apis:['./application/object/producto/*.js']
};

const swaggerSpec = swaggerJSDoc(options);
module.exports = swaggerSpec;