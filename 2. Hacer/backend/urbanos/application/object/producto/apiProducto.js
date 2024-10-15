const express = require('express');
const {ModelProducto,modelproducto}= require ('../../../domain/object/producto/modelproducto');
const {CoreProducto}=require('../../../core/object/producto/coreproducto')

var router = express.Router();

// GET
/**
 * @swagger
 * /operaciongetproducto:
 *   get:
 *     summary: Get all ModelProducto
 *     responses:
 *       200:
 *         description: List of ModelProducto
 */
router.get("/operaciongetproducto", async(req, res) => {
	try{
	const coreproducto =new CoreProducto();
	const respuestacoreproducto = await coreproducto.consultarproducto();
	res.status(200).json(respuestacoreproducto);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});

// Get by Parametro
/**
 * @swagger
 * /operaciongetproductoid/{id}:
 *   get:
 *     summary: Get ModelProducto by Id
 *     parameters:
 *       - name: id
 *         in: path
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: A Item of ModelProducto
 */
router.get('/operaciongetproductoid/:id', async(req, res) => {
	try {
		const { id } = req.params;
		const coreproducto = new CoreProducto();
		const respuestacoreproducto = await coreproducto.consultarproductoid(id);
		res.status(200).json(respuestacoreproducto);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
	
});

// Get by TIPO
/**
 * @swagger
 * /operaciongetproductotipopropiedad/{tipopropiedad}:
 *   get:
 *     summary: Get ModelProducto by TipoPropiedad
 *     parameters:
 *       - name: tipopropiedad
 *         in: path
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: A Item of ModelProducto
 */
router.get('/operaciongetproductotipopropiedad/:tipopropiedad', async (req, res) => {
	try {
		const { tipopropiedad } = req.params;
		const coreproducto = new CoreProducto();
		const respuestacoreproducto = await coreproducto.consultarproductotipopropiedad(tipopropiedad);
		res.status(200).json(respuestacoreproducto);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
});


// POST
/**
 * @swagger
 * /operacionpostproducto:
 *	 post: 
 *     summary: Create a new ModelProducto
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               precio:
 *                 type: string
 *               IdPropiedad:
 *                 type: string
 *               TipoPropiedad:
 *                 type: string
 *               EstadoPropiedad:
 *                 type: string 
 *     responses:
 *       201:
 *         description: ModelProducto created
 */
router.post('/operacionpostproducto', (req, res) => {
	const {Precio,IdPropiedad,TipoPropiedad,EstadoPropiedad} = req.body;
	const newModeloProducto = new ModelProducto(Precio,IdPropiedad,TipoPropiedad,EstadoPropiedad);
	modelproducto.push(newModeloProducto);
	res.status(201).json(newModeloProducto);	
});

// PUT
/**
 * @swagger
 * /operacionputproducto/{parametro}: 
 *   put:
 *     summary: Update an existing ModelProducto
 *     parameters:
 *       - IdPropiedad: parametro
 *         in: path
 *         required: true
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               precio:
 *                 type: string
 *               IdPropiedad:
 *                 type: string
 *               TipoPropiedad:
 *                 type: string
 *               EstadoPropiedad:
 *                 type: string  
 *     responses:
 *       200:
 *         description: ModelProducto updated
 */
router.put('/operacionputproducto/:parametro', (req, res) => {
    const { Precio,IdPropiedad,TipoPropiedad,EstadoPropiedad } = req.body;
	const newModeloProducto = new ModelProducto(Precio,IdPropiedad,TipoPropiedad,EstadoPropiedad);
	
    newModeloProducto.IdPropiedad = req.params.parametro;
	
    newModeloProducto.Precio = Precio;
	newModeloProducto.TipoPropiedad = TipoPropiedad;
	newModeloProducto.EstadoPropiedad = EstadoPropiedad;
	res.status(201).json(newModeloProducto);
});

// DELETE a user
/**
 * @swagger
 * /operaciondeleteproductoparametro/{parametro}:
 *   delete:
 *     summary: Delete a ModelProducto
 *     parameters:
 *       - IdPropiedad: parametro
 *         in: path
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       204:
 *         description: ModelProducto deleted
 */
router.delete('/operaciondeleteproductoparametro/:parametro', (req, res) => {	
	//const { parametro } = req.params;
	const Parametro = req.params.parametro;
	let Respuesta = ["Esto", "Es", "Una", "Prueba", "Delete", "Con", "Parametro:", Parametro];

	//res.status(200).json(Respuesta);
	res.status(200).json({ Message: 'Eliminado: ' + Parametro });	
});

module.exports = router;