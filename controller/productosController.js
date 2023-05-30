const controller = {};

controller.list = (req, res) => {
  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM productos', (err, productos) => {
      if (err) {
        res.json(err);
      }
      res.render('productos', { data: productos });
    });
  });
};

controller.save = (req, res) => {
  const data = req.body;
  req.getConnection((err, conn) => {
    conn.query('INSERT INTO productos SET ?', [data], (err, producto) => {
      res.redirect('/productos');
    });
  });
};

controller.edit = (req, res) => {
  const id = req.params.id;
  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM productos WHERE id = ?', [id], (err, productos) => {
      if (err) {
        res.json(err);
      }
      res.render('/productos_edit', {
        data: productos[0],
      });
    });
  });
};

controller.update = (req, res) => {
  const id = req.params.id;
  const newProducto = req.body;
  req.getConnection((err, conn) => {
    conn.query('UPDATE productos SET ? WHERE id = ?', [newProducto, id], (err, rows) => {
      res.redirect('/productos');
    });
  });
};

controller.delete = (req, res) => {
  req.getConnection((err, conn) => {
    const id = req.params.id;
    conn.query('DELETE FROM productos WHERE id = ?', [id], (err, rows) => {
      res.redirect('/productos');
    });
  });
};

module.exports = controller;
