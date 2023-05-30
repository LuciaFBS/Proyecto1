const controller = {};

controller.realizarCompra = (req, res, db) => {
  const { fecha, id_customer, productos } = req.body;
  db.query('INSERT INTO compra (fecha, id_customer) VALUES (?, ?)', [fecha, id_customer], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: 'Error al realizar la compra' });
    }

    const compraId = result.insertId;
    let totalAmount = 0;

    productos.forEach((producto) => {
      const { id_producto, cantidad, precio } = producto;
      const subtotal = cantidad * precio;
      totalAmount += subtotal;

      db.query(
        'INSERT INTO productos_vendidos (id_producto, cantidad, precio, id_compra) VALUES (?, ?, ?, ?)',
        [id_producto, cantidad, precio, compraId],
        (err) => {
          if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Error al agregar los productos comprados' });
          }
        }
      );
    });

    res.status(201).json({ message: 'Compra realizada exitosamente', totalAmount });
  });
};

controller.obtenerComprasRecientes = (req, res, db) => {
  const customerId = req.params.id;

  db.query(
    'SELECT compra.fecha, customer.name AS cliente, SUM(productos_vendidos.cantidad * productos_vendidos.precio) AS monto_total FROM compra JOIN customer ON compra.id_customer = customer.id JOIN productos_vendidos ON compra.id = productos_vendidos.id_compra WHERE customer.id = ? GROUP BY compra.id ORDER BY compra.fecha DESC',
    [customerId],
    (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Error al obtener las compras' });
      }

      res.render('compras', { compras: results });
    }
  );
};

module.exports = controller;
