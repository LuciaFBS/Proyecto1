const express = require('express');
const router = express.Router();
const compraController = require('../controller/compraController');

// Ruta para realizar una compra
router.post('/realizar', compraController.realizarCompra);
// Ruta para obtener las compras recientes de un cliente
router.get('/customer/:id', compraController.obtenerComprasRecientes);

module.exports = router;
