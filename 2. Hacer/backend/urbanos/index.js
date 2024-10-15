const express = require('express');
const bodyParser = require('body-parser');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./swagger/object/producto/configProducto');
const cors =require('cors')
const productoApi = require('./application/object/producto/apiProducto');

var app = express();

app.use(cors());

app.use(bodyParser.json());

app.use('/api-docs',swaggerUi.serve,swaggerUi.setup(swaggerSpec));

app.use(productoApi);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});