const controller = {};
controller.list = (req, res) => {
  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM customer', (err, customers) => {
      if (err) {
        res.json(err);
      }
      res.render('customers', {
        data: customers
      });
    });
  });
};

controller.save = (req, res) => {
  const data = req.body;
  req.getConnection((err, conn) => {
    conn.query('INSERT INTO customer SET ?', [data], (err, customer) => {
      res.redirect('/customer');
    });
  });
};

controller.delete = (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    conn.query('DELETE FROM customer WHERE id = ?', [id], (err, customer) => {
      res.redirect('/customer');
    });
  });
};

controller.edit = (req, res) => {
  const id = req.params.id;
  req.getConnection((err, conn) => {
    conn.query('SELECT * FROM customer WHERE id = ?', [id], (err, customers) => {
      if (err) {
        res.json(err);
      }
      res.render('/customer_edit', {
        data: customers[0] 
      });
    });
  });
};
controller.update = (req, res) => {
  const { id } = req.params;
  const newCustomer = req.body;
  req.getConnection((err, conn) => {
    conn.query('UPDATE customer SET ? WHERE id = ?', [newCustomer, id], (err, customer) => {
      res.redirect('/customer');
    });
  });
};

module.exports = controller;
 




